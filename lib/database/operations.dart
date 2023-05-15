import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/database/modal.dart';

class crud {
  additem(String todo, String date, String time, String ap) {
    var item = Item(id: "id", todo: todo, date: date, time: time, ap: ap);
    FirebaseFirestore.instance.collection("work").add(item.toJson());
  }

  deleteitem(String id) {
    FirebaseFirestore.instance.collection("work").doc(id).delete();
  }
}
