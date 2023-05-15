import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:to_do_app/database/operations.dart';

import 'database/modal.dart';

class todo extends StatefulWidget {
  const todo({super.key});

  @override
  State<todo> createState() => _todoState();
}

List<Item> done = [];

class _todoState extends State<todo> {
  crud c = crud();
  TextEditingController _work = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _time = TextEditingController();
  TextEditingController _ap = TextEditingController();
  @override
  void initState() {
    fecthrecord();
    super.initState();
  }

  fecthrecord() async {
    var record = await FirebaseFirestore.instance.collection("works").get();
    FirebaseFirestore.instance.collection('works').snapshots().listen((record) {
      mapRecords(record);
    });
    //mapRecords(record);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((item) => Item(
            id: item.id,
            todo: item['todo'],
            date: item['date'],
            time: item['time'],
            ap: item['ap']))
        .toList();

    setState(() {
      done = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(189, 114, 182, 202),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 141, 203),
        actions: [TextButton(onPressed: () {}, child: Icon(Icons.logout))],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            diolog(context);
          },
          child: Icon(Icons.add)),
      body: ListView.builder(
          itemCount: done.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(done[index].todo),
              subtitle: Text(done[index].time),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            );
          }),
    );
  }

  Future<void> diolog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ADD ITEM'),
            content: Container(
              height: 250,
              child: Column(
                children: [
                  TextField(
                    controller: _work,
                    decoration: const InputDecoration(hintText: 'work to do'),
                  ),
                  TextField(
                    controller: _date,
                    decoration: const InputDecoration(hintText: 'date'),
                  ),
                  TextField(
                    controller: _time,
                    decoration: const InputDecoration(hintText: 'time'),
                  ),
                  TextField(
                    controller: _ap,
                    decoration: const InputDecoration(hintText: 'AM/PM'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    c.additem(_work.toString(), _date.toString(),
                        _time.toString(), _ap.toString());
                    _work.clear();
                    _date.clear();
                    _time.clear();
                    _ap.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }
}
