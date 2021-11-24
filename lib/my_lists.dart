import 'package:customer_app/Modals/burger_modal.dart';
import 'package:customer_app/Modals/categories_modal.dart';
import 'Modals/drinks_modal.dart';
import 'Modals/pizza_modal.dart';

List<Burger> burgers=[
  Burger(id: 01, image: 'images/b.png', price: '12', name: 'بركر دجاج',
  isMain: false),
  Burger(id: 02, image: 'images/bz.png', price: '15', name: 'بركر لحم',
  isMain: true),
];



List<Drinks> drinks=[
  Drinks(id: 09, price: '2', name: 'كولا', image: 'images/coola.png', isMain: false),
  Drinks(id: 010, price: '5', name: 'كوكتيل مشروبات غازية', image: 'images/cocktel.png', isMain: true),
];