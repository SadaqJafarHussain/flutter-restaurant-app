import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  static final ID="id";
  static final CATEGORY="category";
   String categoryId;
   String name;

  Categories.fromSnapshot(DocumentSnapshot doc){
    categoryId=doc.data()[ID].toString();
    name=doc.data()[CATEGORY].toString();
  }
}