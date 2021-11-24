 import 'package:customer_app/Modals/categories_modal.dart';
import 'package:customer_app/Providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget{
  final Categories category;
  CategoryItem({
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<MealsProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: category.categoryId==provider.categoryId?Colors.deepOrange.withOpacity(0.5):Colors.grey,
            offset: Offset(2,2),
            spreadRadius: 0.0,
            blurRadius: 6,
          )
        ],
        color: category.categoryId==provider.categoryId?Color(0xffFF334F):Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 3,
          color:  category.categoryId==provider.categoryId?Colors.deepOrange:Colors.transparent,
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(category.name,
          style: TextStyle(
            color:category.categoryId==provider.categoryId?Colors.white:Colors.grey,
              fontFamily: 'Cairo',
              fontSize: 18,

          ),)
        ],
      ),
    );
  }
}
