import 'package:customer_app/Modals/cart_modal.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/my_lists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealsProvider with ChangeNotifier {
  List<dynamic> _categoriesList = [];
  List<dynamic> _myList = burgers;
  List<Cart> _cart = [];
  Position _position;
  String categoryId='';
  String productId='';
  var totalPrice = 0.0;
  String _address="";
  int counter=0;

  get cart {
    return [..._cart];
  }

  get myList {
    return [..._myList];
  }

  get categoriesList {
    return [..._categoriesList];
  }

  getPosition(Position position){
    _position=position;
    notifyListeners();
  }

  getAddress(String address){
    _address=address;
    notifyListeners();
  }
 Future<void> getCounter()async{
    final orderNumber=await FirebaseFirestore.instance.collection('orders').orderBy("timeStamp").get();
    if(orderNumber.docs.length!=0){
      counter= orderNumber.docs.last.data()['orderNumber'];
      counter++;
      notifyListeners();
    }
    else{
      counter++;
      notifyListeners();
    }

  }

changeCategoryId(String id){
    categoryId=id;
    notifyListeners();
}
  changeProductId(String id){
    productId=id;
    notifyListeners();
  }

  selectedCategory(int index) {
    for (int i = 0; i < categoriesList.length; i++) {
      _categoriesList[i].isMain = false;
    }
    _categoriesList[index].isMain = true;
    notifyListeners();
  }
  selectedSubCategory(int index) {
    for (int i = 0; i < _myList.length; i++) {
      _myList[i].isMain = false;
    }
    _myList[index].isMain = true;
    notifyListeners();
  }

  addToCart(dynamic meal, int quantity) {
    final isExists = _cart.where((element) => element.id == meal.id);
    if (isExists.isNotEmpty) {
      isExists.first.quantity = isExists.first.quantity + quantity;
    }
    else {
      _cart.add(Cart(id:meal.id,
          name: meal.name,
          image: meal.image,
          price: meal.price,
          quantity: quantity));
    }
    totalPrice += (meal.price*quantity);
    notifyListeners();
  }

  deleteMeal(String id) {
    final index = _cart.indexWhere((element) => element.id == id);
    totalPrice =totalPrice - (_cart[index].price * _cart[index].quantity);
    _cart.removeAt(index);
    notifyListeners();
  }
  updateCart(dynamic meal, int quantity,int oldQuantity) async{
    final isExists = _cart.where((element) => element.id == meal.id);
    if (isExists.isNotEmpty) {
      totalPrice = totalPrice - (meal.price * oldQuantity);
      isExists.first.quantity = quantity;
      totalPrice+=(meal.price*quantity);
      notifyListeners();
    }
  }
  sendOrder()async {
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString("id");
    final user = await FirebaseFirestore.instance.collection('users')
        .doc(id)
        .get();
    final userOrders = await FirebaseFirestore.instance.collection('newUserOrders')
        .doc(id)
        .get();
    if(user.data().isNotEmpty) {

      if (!userOrders.exists) {
        await FirebaseFirestore.instance.collection('orderStatus').doc().set({
          "status":"waiting",
          "userId":user.id,
        });
        await FirebaseFirestore.instance.collection('newUserOrders')
            .doc(id)
            .set({
          "userName": user.data()['name'],
          "userId": id.toString(),
          "userPhone": user.data()['phone'],
          "timeStamp": DateTime.now(),
          "orderNumber": counter,
          "lat": _position != null ? _position.latitude : "",
          "long": _position != null ? _position.longitude : "",
          "price": totalPrice.toString(),
          "address": _address.isNotEmpty ? _address : "",

        })
            .then((_) async {
          for (var order in _cart) {
            await FirebaseFirestore.instance.collection('newOrders').doc().set({
              "userId": id.toString(),
              "orderName": order.name,
              "id": order.id,
              "image": order.image,
              "quantity": order.quantity,
              "price":order.price,
              "orderStatus":"witting"
            });
          }
          _position = null;
          _address = "";
          _cart.clear();
          notifyListeners();
        });
      }
      else {
        for (var order in _cart) {
          await FirebaseFirestore.instance.collection('newOrders').doc().set({
            "userId": id.toString(),
            "orderName": order.name,
            "id": order.id,
            "price": order.price,
            "image": order.image,
            "quantity": order.quantity,
            "orderStatus":"witting"
          });
        }
        _cart.clear();
        _position = null;
        _address = "";
        notifyListeners();
      }
    }
  }
}