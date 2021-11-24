import 'package:customer_app/Providers/meals_provider.dart';
import 'package:customer_app/Screens/expanded_meal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartWidget extends StatelessWidget {
  final dynamic meal;
  CartWidget({
   this.meal,
});
  @override
  Widget build(BuildContext context) {
    int quantity=meal.quantity;
    return Container(
      margin: EdgeInsets.symmetric(horizontal:5,vertical: 10),
      height: 80,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            offset: Offset(3,3),
            spreadRadius: 5
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Hero(
            tag: 'demo${meal.id}${meal.price}${meal.quantity}',
            child: Image.network(meal.image,
            height: 30,)),
    title: Text(meal.name,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),),
    subtitle: Row(
children: [
   Expanded(child: Text("الكميه : ${meal.quantity}")),
  SizedBox(
    width: 10,
  ),
  Expanded(
    child: Text("  السعر : IQD ${meal.price}  ",
    textDirection: TextDirection.rtl,),
  ),
],
    ),
    trailing: Container(
      width: 80,
      child: Row(
        children: [
          Expanded(
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ExpandedMeal(meal,quantity)));
            }, icon: Icon(Icons.playlist_add_outlined,
            color: Colors.green,
            size: 30,)),
          ),
          Expanded(
            child: IconButton(onPressed: (){
              Provider.of<MealsProvider>(context,listen: false).deleteMeal(meal.id);
            }, icon: Icon(Icons.delete,
            color: Color(0xffFF334F),
            size: 30,)),
          ),
        ],
      ),
    ),
    onTap: (){},
    ),
    );
  }
}
