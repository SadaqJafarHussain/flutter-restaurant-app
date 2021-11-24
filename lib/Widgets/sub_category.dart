import 'package:customer_app/Modals/main_meals.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/Providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
class SubCategory extends StatefulWidget {

  final Meals meal;

  SubCategory({
   this.meal,
});

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
int qun=1;
  TextEditingController _controller=TextEditingController();
   @override
  Widget build(BuildContext context) {
     final provid=Provider.of<MealsProvider>(context);
     _controller.text=qun.toString();
    return  SizedBox(
      height: 300,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 230,
            height:280,
            decoration: BoxDecoration(
              color: provid.productId==widget.meal.id?Color(0xffFF334F):Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: Offset(7,7),
                  spreadRadius: 10,
                )
              ],
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(widget.meal.name,
                    style: TextStyle(
                      color: provid.productId==widget.meal.id?Colors.white:Colors.black,
                        fontFamily: 'Cairo',
                        fontSize: 23,
                    ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,
                vertical: 10),
                child: Text('${widget.meal.price} IQD',
                  style: TextStyle(
                    color: Color(0xffFF334F),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: provid.productId==widget.meal.id?250:240,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade800,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),)
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        if(qun>1){
                          setState(() {
                            _controller.text=(qun--).toString();
                          });
                        }
                      },
                      icon: Icon(Icons.remove_circle,
                      color: Colors.white,),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                      ),
                    )),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          _controller.text=(qun++).toString();
                        });
                      },
                      icon: Icon(Icons.add_circle,
                        color: Colors.white,),
                    ),
                    IconButton(onPressed: (){
                      Provider.of<MealsProvider>(context,listen: false).addToCart(widget.meal,_controller.text.isEmpty?1: int.parse(_controller.text.trim()));
                    },
                      icon:Icon(Icons.add_shopping_cart_outlined),
                    color: Colors.green,),
                  ],
                ),
              ),
            ],
              ),
        ),
          ),
          Positioned(
            top: -10,
            left: -10,
            child: SimpleShadow(
              child: widget.meal.image==null?Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
              ):Image.network(widget.meal.image??"pizza.png",
                height: 190,),
              opacity: 0.5,         // Default: 0.5
              color:Colors.black,   // Default: Black
              offset: Offset(5, 5), // Default: Offset(2, 2)
              sigma: 7, // Default: 2
            ),
          ),
       ]
      ),
    );
  }
}
