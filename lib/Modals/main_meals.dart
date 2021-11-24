import 'package:cloud_firestore/cloud_firestore.dart';

class Meals {
  static final ID="id";
  static final CATEGORYID="categoryId";
  static final IMAGE="image";
  static final PRICE="price";
  static final NAME="name";
  String categoryId;
  String name;
  String id;
  String image;
  int price;

  Meals.fromSnapshot(DocumentSnapshot doc){
    categoryId=doc.data()[CATEGORYID].toString();
    name=doc.data()[NAME].toString();
    id=doc.data()[ID].toString();
    image=doc.data()[IMAGE].toString();
    price=int.parse(doc.data()[PRICE]);
  }
}