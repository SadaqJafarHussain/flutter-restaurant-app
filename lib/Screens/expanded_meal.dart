import 'package:customer_app/Providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ExpandedMeal extends StatefulWidget {
  final dynamic meal;
  final int quantity;
  ExpandedMeal(this.meal,
      this.quantity);

  @override
  _ExpandedMealState createState() => _ExpandedMealState();
}

class _ExpandedMealState extends State<ExpandedMeal> {
  int qun=1;
  TextEditingController _controller1=TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller1.text=widget.meal.quantity.toString();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10,
              vertical: 10),
              width: 500,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2,2),
                    blurRadius: 6,
                  )
                ],
              ), 
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Center(
                      child: Hero(
                        tag: 'demo${widget.meal.id}${widget.meal.price}${widget.meal.quantity}',
                        child: SimpleShadow(
                          child: Image.network(widget.meal.image,
                            height: 200,),
                          opacity: 0.5,         // Default: 0.5
                          color:Colors.black,   // Default: Black
                          offset: Offset(5, 5), // Default: Offset(2, 2)
                          sigma: 7,             // Default: 2
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(widget.meal.name,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('${widget.meal.price} IQD',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 100,
                    width: 500,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child:  Row(
                        children: [
                          IconButton(onPressed: (){
                            if(widget.meal.quantity>1){
                              setState(() {
                                widget.meal.quantity--;
                                _controller1.text=widget.meal.quantity.toString();
                              });
                            }else if(_controller1.text!='0'){
                                _controller1.text='0';
                              Provider.of<MealsProvider>(context,listen: false).deleteMeal(widget.meal.id);
                            }

                          }, icon: Icon(Icons.remove_circle,
                          color: Colors.white,
                          size: 40,)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,
                            vertical: 15),
                            child: TextFormField(
                              style: TextStyle(
                                color: _controller1.text=='0'?Colors.red:Colors.black
                              ),
                              keyboardType: TextInputType.number,
                              controller: _controller1,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'اكتب الكمية التي تريد',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Cairo'
                                  ),
                                  hintTextDirection: TextDirection.rtl,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  )
                              ),
                            ),
                          )),
                          IconButton(onPressed: (){
                           setState(() {
                             widget.meal.quantity++;
                             _controller1.text=widget.meal.quantity.toString();
                           });
                          }, icon: Icon(Icons.add_circle,
                          color: Colors.white,
                          size: 40,)),
                          SizedBox(
                            width: 40,
                          ),
                          IconButton(onPressed: (){
                            Provider.of<MealsProvider>(context,listen: false).updateCart(widget.meal,int.parse(_controller1.text),widget.quantity);
                            Navigator.pop(context);
                          },
                            icon:Icon(Icons.add_shopping_cart_outlined),
                            color: Colors.deepOrange,
                          iconSize: 40,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
    );

  }
}
