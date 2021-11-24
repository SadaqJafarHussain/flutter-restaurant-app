import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/Modals/categories_modal.dart';
import 'package:customer_app/Modals/main_meals.dart';
import 'package:customer_app/Providers/auth_provider.dart';
import 'package:customer_app/Providers/meals_provider.dart';
import 'package:customer_app/Screens/authintecation_screen.dart';
import 'package:customer_app/Screens/cart_screen.dart';
import 'package:customer_app/Screens/orders_state_Screen.dart';
import 'package:provider/provider.dart';
import '../Widgets/category_item.dart';
import '../Widgets/sub_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String category = ': بركر';
  bool isStop=true;
  bool loaded=true;

  final fireStore=FirebaseFirestore.instance;
  ScrollController _scrollController=ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).getUuid();
  }
  @override
  Widget build(BuildContext context) {
   final auth= Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(
                size: 30,
                color: Color(0xffFF334F),),
            elevation: 0.0,
            backgroundColor: Color(0xffFAFAFA),

          ),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
            ),
            child: Drawer(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("users").where("id",isEqualTo: auth.userId).snapshots(),
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          DocumentSnapshot doc=snapshot.data.docs.first;
                          return  Container(
                            height: 100,
                            width: 310,
                            color: Color(0xffFF334F),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                              child: ListTile(
                                leading:  Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    color: Colors.grey,
                                      ),
                                  child: Icon(Icons.person,
                                  size: 40,),
                                ),
                                title: Text(doc.data()["name"],
                                  style: TextStyle(color: Colors.white,
                                  fontFamily: "Cairo"),),
                                subtitle: Text(doc.data()["email"],
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: "Cairo"),),
                              ),
                            ),
                          );
                        }),

                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.edit),
                      ),
                      title: Text('تعديل المعلومات الشخصيه',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                      ),),
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrdersStatus()));
                      },
                      leading: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.shopping_basket),
                      ),
                      title: Text('الطلبات',
                        style: TextStyle(
                            fontFamily: 'Cairo'
                        ),),
                    ),
                    ListTile(
                      leading: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.location_on),
                      ),
                      title: Text('اضف موقع جغرافي للتوصيل',
                      style: TextStyle(
                        fontFamily: 'Cairo'
                      ),),
                    ),
                    ListTile(
                      leading: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.settings),
                      ),
                      title: Text('الضبط',
                        style: TextStyle(
                            fontFamily: 'Cairo'
                        ),),
                    ),
                    ListTile(
                      leading: IconButton(
                        onPressed: ()async{
                          await Provider.of<AuthProvider>(context,listen: false).signOut();
                          Navigator.push(context,
                          MaterialPageRoute(builder: (ctx)=>AuthenticationScreen()));
                        },
                        icon: Icon(Icons.exit_to_app),
                      ),
                      title: Text('تسجيل الخروج',
                        style: TextStyle(
                            fontFamily: 'Cairo'
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Color(0xffFAFAFA),
          floatingActionButton: FloatingActionButton(
            heroTag: 'main',
            backgroundColor: Color(0xffFF334F),
            child: Center(
              child: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => CartScreen()));
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: Image.asset('assets/images/splash_icon.png',
                       color: Color(0xffFF334F),
                       height: 80,
                     ),
                   ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Text(
                       'اختر ',
                       style: TextStyle(
                         fontFamily: 'Cairo',
                         fontSize: 23,
                       ),
                     ),
                     Text(
                       'الاكل الذي تحبه',
                       style: TextStyle(
                         fontFamily: 'Cairo',
                         fontSize: 25,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ],
                 )
                 ],
               ),

                SizedBox(
                  height: 30,
                ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(snapshot.data.docs.length==0){
                          return Center(
                            child: Text('لاتوجد اصناف طعام'),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount:snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc= snapshot.data.docs[index];
                            return InkWell(
                               onTap: (){
                                 Provider.of<MealsProvider>(context,listen:false).changeCategoryId(doc.data()['id'].toString());
                                 _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.easeOut);
                                },
                                child: CategoryItem(
                                category: Categories.fromSnapshot(doc),
                                ),
                            );
                            },
                          padding: EdgeInsets.all(10),
                          scrollDirection: Axis.horizontal,
                          addSemanticIndexes: true,
                        );
                      },
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: Provider.of<MealsProvider>(context).categoryId.isNotEmpty?fireStore.collection('products').where('categoryId',isEqualTo: Provider.of<MealsProvider>(context).categoryId).snapshots():fireStore.collection('products').snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if(snapshot.data.docs.length==0){
                        return Center(
                          child: Text('لاتوجد وجبات'),
                        );
                      }
                  return Container(
                      height: 400,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc=snapshot.data.docs[index];
                          return InkWell(
                              onTap: () {
                                Provider.of<MealsProvider>(context,listen:false).changeProductId(doc.id.toString());
                              },
                              child: SubCategory(
                                meal: Meals.fromSnapshot(doc),
                              ));
                        },
                        padding: EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                      ),
                   );
                })
                ],
              ),
            ),
          )),
    );
  }


}
