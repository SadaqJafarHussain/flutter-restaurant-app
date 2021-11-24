
import 'package:customer_app/Providers/auth_provider.dart';
import 'package:customer_app/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AuthenticationScreen extends StatefulWidget {

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _key=GlobalKey<FormState>();
  bool isLogin=true;
  bool isVisible=false;
  TextEditingController _email=TextEditingController();
  TextEditingController _name=TextEditingController();
  TextEditingController _pass=TextEditingController();
  TextEditingController _phone=TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/m.jpg'),
                  fit: BoxFit.fill
              )
          ),
          child: CustomPaint(
            painter: CustomBackground(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 90,),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,
                          vertical: 20),
                      margin: EdgeInsets.only(top: 25),
                      height:isLogin? 480:600,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isLogin=true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:isLogin? Color(0xff0FF334F):Colors.transparent,
                                  ),
                                  height: 40,
                                  width: 150,
                                  child: Center(
                                    child: Text('Login' ,style: TextStyle(
                                      color:isLogin?Colors.white:Color(0xff0FF334F),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isLogin=false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: isLogin?Colors.transparent:Color(0xff0FF334F),
                                  ),
                                  height: 40,
                                  width: 150,
                                  child: Center(
                                    child: Text('Sign Up' ,style: TextStyle(
                                      color: isLogin?Color(0xff0FF334F):Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _key,
                            child: Column(
                              children: [
                                if(!isLogin)TextFormField(
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'الاسم لايمكن ان يكون فارغ';
                                    }
                                    return null;
                                  },
                                  controller: _name,
                                  decoration: InputDecoration(
                                      labelText: 'ادحل الاسم '
                                  ),
                                ),
                                TextFormField(
                                  validator: (value){
                                    if (value != null) {
                                      if (value.isEmpty) {
                                        return 'البريد الالكتلروني لايمكن ان يكون فارغ';
                                      } else if (!value.contains(RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                        return 'ادخل بريد الكتلروني صالح';
                                      }
                                    }
                                    return null;
                                  },
                                  controller: _email,
                                  decoration: InputDecoration(
                                      labelText: 'ادخل البريد الالكتروني'
                                  ),
                                ),
                                TextFormField(
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'اكتب كلمة السر';
                                    }
                                    return null;
                                  },
                                  controller: _pass,
                                  obscureText: isVisible?false:true,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            isVisible=!isVisible;
                                          });
                                        },
                                        icon: isVisible?Icon(Icons.visibility):Icon(Icons.visibility_off),
                                      ),
                                      labelText: 'كلمة السر'
                                  ),
                                ),
                                isLogin?SizedBox(
                                  height: 59,
                                ): TextFormField(
                                  controller: _phone,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'اكتب رقم الهاتف';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'رقم الهاتف'
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            child: Ink(
                              child: InkWell(
                                onTap: ()async{
                                  final submit=_key.currentState.validate();
                                  if(submit){
                                    isLogin? await auth.signIn(_email.text.trim(), _pass.text.trim()):
                                    await auth.signUp(_email.text.trim(), _pass.text.trim(),_phone.text.trim(),_name.text.trim());
                                    Navigator.push(context,
                                    MaterialPageRoute(builder:(ctx)=>DashBoardScreen()));
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xff0FF334F),
                                  ),
                                  child: Center(
                                    child: Text('Login' ,style: TextStyle(
                                      color:Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('OR',style: TextStyle(
                            color: Colors.grey,

                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/face.png',
                                height: 30,),
                              SizedBox(width: 20,),
                              Image.asset('images/google.png',
                                height: 30,),
                              SizedBox(width: 10,),
                              Image.asset('images/twitter.png',
                                height: 40,),
                            ],)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset('images/veg.png',
                      height: 100,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  _submit(){

  }
}
class CustomBackground extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final width=size.width;
    final height=size.height;
    final paint=Paint();
    final circlePath=Path()..moveTo(0, height*.25);
    circlePath.quadraticBezierTo(width*.25, height*.35,width*.60 , height*.31);
    circlePath.quadraticBezierTo(width*.9, height*.27, width, height*.15);
    circlePath.lineTo(width, 0);
    circlePath.lineTo(0, 0);
    paint.color=Color(0xffFF334F).withOpacity(0.8);
    canvas.drawPath(circlePath, paint);
    circlePath.close();
    final mainPath=Path()..moveTo(0, height*.25);
    mainPath.quadraticBezierTo(width*.25, height*.35,width*.60 , height*.31);
    mainPath.quadraticBezierTo(width*.9, height*.27, width, height*.15);
    mainPath.lineTo(width, height);
    mainPath.lineTo(0, height);
    paint.color=Color(0xffD5E2F0);
    canvas.drawPath(mainPath, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}
