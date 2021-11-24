import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  final String status;
  Status({
    this.status,
});
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("في الانتظار",
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 10,
                ),),
                Text("في المطبخ",
                  style: TextStyle(
                      fontFamily: "Cairo",
                    fontSize: 10,
                  ),),
                Text("جاري التوصيل",
                  style: TextStyle(
                      fontFamily: "Cairo",
                    fontSize: 10,
                  ),),
                Text("تم التوصيل",
                  style: TextStyle(
                    fontSize: 10,
                      fontFamily: "Cairo"
                  ),),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:widget.status=="waiting"||widget.status=="cooking"||widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,
                ),
              ),
              child: Stack(children:[ Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.cloud_download)),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.check_circle_rounded,
                    size: 20,
                    color: widget.status=="waiting"||widget.status=="cooking"||widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,),
                )
              ]),
            ),
            Container(
              height: 5,
              width: 40,
              color: widget.status=="cooking"||widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.status=="cooking"||widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,
                ),
              ),
              child: Stack(children:[ Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.home)),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.check_circle_rounded,
                    size: 20,
                    color: widget.status=="cooking"||widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,),
                )
              ]),
            ),
            Container(
              height: 5,
              width: 40,
              color: widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,
                ),
              ),
              child: Stack(children:[ Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.directions_bike_outlined)),
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.check_circle_rounded,
                size: 20,
                color: widget.status=="delivering"||widget.status=="delivered"? Colors.green:Colors.grey,),
              )
              ]),
            ),
              Container(
                height: 5,
                width: 40,
                color: widget.status=="delivered"? Colors.green:Colors.grey,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.status=="delivered"? Colors.green:Colors.grey,
                  ),
                ),
                child: Stack(children:[ Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.receipt_long)),
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.check_circle_rounded,
                      size: 20,
                      color: widget.status=="delivered"? Colors.green:Colors.grey,),
                  )
                ]),
              ),
          ],),
        ],
      ),
    );
  }

}
