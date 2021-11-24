 import 'package:customer_app/Providers/meals_provider.dart';
import 'package:customer_app/Widgets/cart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import 'orders_state_Screen.dart';
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool myLocation=true;
  bool newLocation=false;
  final _formKey=GlobalKey<FormState>();

  TextEditingController _address=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<MealsProvider>(context,listen: true);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'cart',
          onPressed: (){
            showSheet(context);
          },
          backgroundColor:Color(0xffFF334F),
          child: Icon(Icons.shopping_bag_rounded,
            color: Colors.white,
            size: 30,),
        ),
        backgroundColor: Color(0xffFAFAFA),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black45,
          ),
          title: Text('الوجبات المختاره',
            style: TextStyle(
              color: Colors.black45,
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
          elevation: 0.0,
          backgroundColor: Color(0xffFAFAFA),
          centerTitle: true,
        ),
        body:provider.cart.length==0? Center(
          child: Image.asset("images/no-talab.png"),
        ): Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: provider.cart.length,
                itemBuilder: (context,index){
                  return CartWidget(meal: provider.cart[index],);
                },),
            ),
             Container(
               child: Row(
                 children: [
                   SizedBox(
                     width: 10,
                   ),
                   Text("${provider.totalPrice} IQD",
                   style: TextStyle(color: Color(0xffFF334F),
                   fontSize: 20,
                   fontWeight: FontWeight.bold),),
                   Text("    : المبلغ الكلي  ",
                     style: TextStyle(color: Colors.black45,
                         fontSize: 20,
                         fontWeight: FontWeight.bold),),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }
  showSheet(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
        context: context, builder: (ctx){
      final provider=Provider.of<MealsProvider>(ctx,listen: true);
      return StatefulBuilder(
        builder:(BuildContext context, StateSetter setModalState ) {
          return provider.cart.length>0? Container(
            height: MediaQuery.of(context).viewInsets.bottom>0.0?700:400,
            decoration: BoxDecoration(
              color: Color(0xffFAFAFA),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffFF334F),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text('قم باختيار مكان للتوصيل',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cairo',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_location_outlined,
                    size: 40,
                  ),
                  title: Text('موقعي الحالي',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  trailing: IconButton(
                    onPressed: (){
                      setModalState((){
                        myLocation=true;
                        newLocation=false;
                      });
                    },
                    icon: Icon( myLocation?Icons.radio_button_checked:Icons.radio_button_unchecked,
                      color: Color(0xffFF334F),),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.post_add_rounded,
                    size: 40,
                  ),
                  title: Text('اكتب عنوان جديد',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  trailing: IconButton(
                    onPressed: (){
                      setModalState((){
                        myLocation=false;
                        newLocation=true;
                      });
                    },
                    icon: Icon( newLocation?Icons.radio_button_checked:Icons.radio_button_unchecked,
                      color: Color(0xffFF334F),),
                  ),
                ),
                newLocation? Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _address,
                      validator: (value){
                        if(value.isEmpty||value.length<5){
                          return "اكتب عنوان مناسب";
                        }
                        return null;
                      },
                       decoration: InputDecoration(
                         filled: true,
                         fillColor: Colors.white,
                         hintText: "اكتب عنوانك",
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                         )
                       ),
                     ),
                  ),
                ):Text(""),
                 Padding(
                   padding: const EdgeInsets.only(left: 20.0,top: 10),
                   child: SizedBox(
                     width: 130,
                     child: RaisedButton
                      (
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)
                       ),
                        color: Color(0xffFF334F),
                        onPressed: ()async{
                         if(myLocation){
                           Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                           Provider.of<MealsProvider>(context,listen: false).getPosition(position);
                           Provider.of<MealsProvider>(context,listen: false).getCounter().then((_) {
                             Navigator.pop(context);
                             showdialog(context);
                           });
                         }
                         else if(newLocation&&_formKey.currentState.validate()){
                           Provider.of<MealsProvider>(context,listen: false).getAddress(_address.text.trim());
                           Provider.of<MealsProvider>(context,listen: false).getCounter().then((_) {
                             Navigator.pop(context);
                             showdialog(context);
                           });
                         }
                },
                       child: Text('طلب',style: TextStyle(
                         color: Colors.white,
                         fontFamily: 'Cairo',
                         fontSize: 18,
                       ),),
                     ),
                   ),
                 ),
              ],
            ),
          ):Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text('لم تقم باختيار اي وجبه ',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Cairo',
                    color: Colors.grey
                ),),
            ),
          );
        }
      );
    });
  }
  showdialog(BuildContext context){
   showDialog(context: context,
   builder: (context){
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 250),
       child: AlertDialog(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(30),
         ),
         elevation: 6.2,
         backgroundColor:   Colors.white,

       content: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Center(
             child: Text('سوف يتم ارسال الطلب للمطعم هل انت متأكد؟',
             textAlign: TextAlign.center,
             style: TextStyle(
               fontFamily: 'Cairo',
               fontSize: 15,
               fontWeight: FontWeight.bold
             ),),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
             RaisedButton(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20)
                 ),
                 onPressed: (){
                 Provider.of<MealsProvider>(context,listen: false).sendOrder();
                 Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrdersStatus()));
             },
                 color: Colors.green,
                 child: Text('نعم',
                 style: TextStyle(
                   color: Colors.white,
                   fontFamily: 'Cairo'
                 ),)),
             RaisedButton(
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20)
                 ),
                 onPressed: (){
               Navigator.pop(context);
             },
                 color: Color(0xffFF334F),
                 child: Text('الغاء',
                   style: TextStyle(
                       color: Colors.white,
                       fontFamily: 'Cairo'
                   ),)),
           ],),
         ],
       ),
       ),
     );
   });

  }
}
