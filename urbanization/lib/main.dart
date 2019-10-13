import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanization/pages/auth.dart';
import 'package:urbanization/pages/home.dart';

void main(){
  runApp(MaterialApp(
    title: 'Urbanization',
    home: SplashScreen(),
    theme: ThemeData(
      fontFamily: 'Proxima Nova'
    ),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void whattoDo()async{
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    if(fUser == null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthPage()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    }
  }
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), (){
      whattoDo();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Urbanization", style: TextStyle(
            color: Colors.black,
            fontFamily: 'Proxima Nova Bold',
            fontSize: 25.0,
          ),),
        ),
      ),
    );
  }
}