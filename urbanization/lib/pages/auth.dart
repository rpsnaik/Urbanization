import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanization/pages/home.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Urbanization", style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Proxima Nova Bold',
              ),),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Welcome Back!", style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Proxima Nova Bold",
                      fontSize: 30.0,
                    ),),
                    Text("Community the Sprit of giving back", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17.0,
                    ),),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onChanged: (String text){
                        setState(() {
                          email = text;
                        });
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onChanged: (String text){
                        setState(() {
                          password = text;
                        });
                      },
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                      },
                      child: Text("Don't have an account!", style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                  ],
                ),
              ),

              RaisedButton(
                padding: EdgeInsets.all(20.0),
                color: Colors.blue.withOpacity(0.8),
                onPressed: ()async{
                  try{
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  }catch(e){
                    print("Error : "+e.message);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text("SIGN IN", style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email, password, name, address;
  String communityId, workingCommunityId;
  DateTime dob;

  void signup()async{
    if((email != null) || (password != null) || (name != null) || (address != null) || (communityId != null) || (workingCommunityId != null) || (dob != null)){
      try{
        FirebaseUser fUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        Firestore.instance.collection("users").document(fUser.uid).setData({
          "uid": fUser.uid,
          "email": fUser.email,
          "name": name,
          "dateofBirth": dob,
          "commumnityId": communityId.trim(),
          "workingCommunityId": workingCommunityId.trim(),
          "address": address,
          "role": "user"
        }).then((E){
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        });
      }catch(e){
        print(e.message);
      }
    }else{
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Enter all the Details Properly!"),
            actions: <Widget>[
              RaisedButton(
                color: Colors.blue,
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Okay"),
              )
            ],
          );
        }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Urbanization - Signup", style: TextStyle(
                fontFamily: 'Proxima Nova Bold',
                fontSize: 23.0,
                color: Colors.black
              ),),
      ),
      body: ListView(
        children: <Widget>[
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Container(),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Please Signup!", style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Proxima Nova Bold",
                          fontSize: 30.0,
                        ),),
                        Text("Community the Sprit of giving back", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),),
                        SizedBox(
                          height: 20.0,
                        ),
                        
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          onChanged: (String text){
                            setState(() {
                              name = text;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Community ID',
                          ),
                          onChanged: (String text){
                            setState(() {
                              communityId = text;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Working Community ID',
                          ),
                          onChanged: (String text){
                            setState(() {
                              workingCommunityId = text;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 1.0, spreadRadius: 1.0)],
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Select your Date of Birth : \n"+dob.toString(), style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Proxima Nova Bold',
                              ),),
                            ),
                            onTap: ()async{
                              print(dob);
                              dob = await showDatePicker(context: context, firstDate: DateTime.utc(1970, 1), initialDate: DateTime.now(), lastDate: DateTime.now());
                              setState(() {
                                
                              });
                            },
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Address',
                          ),
                          onChanged: (String text){
                            setState(() {
                              address = text;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username/Email',
                          ),
                          onChanged: (String text){
                            setState(() {
                              email = text;
                            });
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          onChanged: (String text){
                            setState(() {
                              password = text;
                            });
                          },
                        ),
                        
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("Already! Have an Account", style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.blue.withOpacity(0.8),
                    onPressed: ()async{
                      signup();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text("SIGN UP", style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}