import 'package:customer_app/Providers/auth_provider.dart';
import 'package:customer_app/Providers/meals_provider.dart';
import 'package:customer_app/Screens/authintecation_screen.dart';
import 'package:provider/provider.dart';
import 'Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create: (ctx)=>AuthProvider(),),
        ChangeNotifierProvider(
        create: (ctx)=>MealsProvider(),),
        ],
        child: MaterialApp(
          theme: ThemeData(
            canvasColor: Colors.transparent,
                primaryColor: Colors.black,
            accentColor: Colors.black,

          ),
          debugShowCheckedModeBanner: false,
          home: LandingScreen(),
        ),
    );
  }
}
class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).authenticating();
  }
  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthProvider>(context);
    if(auth.status==Status.Unauthenticated)
      return AuthenticationScreen();
    else
      return DashBoardScreen();
    }
  }



