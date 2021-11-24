import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/Providers/auth_provider.dart';
import 'package:customer_app/Widgets/status.dart' as st;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersStatus extends StatefulWidget {
  @override
  _OrdersStatusState createState() => _OrdersStatusState();
}

class _OrdersStatusState extends State<OrdersStatus> {

  bool isPrevious=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar:AppBar(
        iconTheme: IconThemeData(
          color: Colors.black45
        ),
        backgroundColor: Color(0xffFAFAFA),
        title: Text("حالة الطلب",
        style: TextStyle(
          color: Colors.black45,
          fontFamily: "Cairo",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),

        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    isPrevious=true;
                  });
                },
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft:  Radius.circular(10),
                    ),
                    color: isPrevious?Color(0xffFF334F):Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Text('الطلبات السابقه',
                    style: TextStyle(
                      color: isPrevious?Colors.white:Colors.black45,
                      fontFamily: "Cairo",
                      fontSize: 18,
                    ),),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isPrevious=false;
                  });
                },
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                    ),
                    color: isPrevious?Colors.grey.shade200:Color(0xffFF334F),
                  ),
                  child: Center(
                    child: Text('الطلبات الحاليه',
                      style: TextStyle(
                        color: isPrevious?Colors.black45:Colors.white,
                        fontFamily: "Cairo",
                        fontSize: 18,
                      ),),
                  ),
                ),
              ),
            ],
          ),
         !isPrevious?current():previous(),
        ],
      ),
    );
  }
  Widget current(){
    final auth=Provider.of<AuthProvider>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("orderStatus").where("userId",isEqualTo: auth.userId).snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }if(snapshot.data.docs.length==0||snapshot.data.docs.first.data()["status"]=="delivered"){
            return Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Image.asset("images/no-results.png",
                ),
              ),
            );
          }
          return Container(
            height: 600,
            child: Column(
              children: [
                Expanded(child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index){
                  return st.Status(status: snapshot.data.docs.first.data()["status"],);
                })),
              ],
            ),
          );
        });
  }
  
  Widget previous(){
    final auth=Provider.of<AuthProvider>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("orderStatus").where("userId",isEqualTo: auth.userId).snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }if(snapshot.data.docs.length==0||snapshot.data.docs.first.data()["status"]!="delivered"){
            return Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Image.asset("images/no-results.png",
                ),
              ),
            );
          }
          return Container(
            height: 600,
            child: Column(
              children: [
                Expanded(child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index){
                      return st.Status(status: snapshot.data.docs.first.data()["status"],);
                    })),
              ],
            ),
          );
        });
  }

}
