import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:urbanization/pages/delivery.dart';
import 'dart:convert';

import 'package:urbanization/pages/navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data;
  Map<String, dynamic> databaseData;
  List<DocumentSnapshot> postsData = [];
  int numberOfPlants = 0;
  String postMessage;
  void getWeatherData()async{
    var res = await http.get(Uri.encodeFull("http://api.openweathermap.org/data/2.5/weather?q=Delhi&appid=9c4564963e97ce0b15880d1451139e7a"));
    if(res.statusCode == 200){
      Map<String, dynamic> jsonData = json.decode(res.body);
      data = jsonData;
      setState(() {
        
      });
    }else{
      print("No Internet/Something went wrong!");
    }
  }
  void getFirestoreData()async{
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot firestoreData = await Firestore.instance.collection("users").document(fUser.uid).get();
    databaseData = firestoreData.data;
    setState(() {
      
    });
  }
  void getTreesData()async{
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot fData = await Firestore.instance.collection("deliverySerivce").where("uid", isEqualTo: fUser.uid).getDocuments();
    List<DocumentSnapshot> docData = fData.documents;
    numberOfPlants = docData.length;
    setState(() {
      
    });
  }

  void loadPosts()async{
    QuerySnapshot fData = await Firestore.instance.collection("posts").getDocuments();
    List<DocumentSnapshot> docData = fData.documents;
    postsData = docData;
    print(postsData.length);
    setState(() {
      
    });
  }
  @override
  void initState() {
    try{
      getWeatherData();
      getFirestoreData();
    }catch(e){
      print("Error : "+e);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://mydigitalmate.com/wp-content/uploads/2017/08/shutterstock_499848517.jpg"),
                )
              ),
              accountEmail: Text("Role"),
              accountName: Text(databaseData['name'], style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Proxima Nova Bold"
              ),),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation()));
              },
              child: ListTile(
                title: Text("Navigation"),
                leading: Icon(Icons.navigation),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryService()));
              },
              child: ListTile(
                title: Text("Food/Logistics Delivery"),
                leading: Icon(Icons.directions_bike),
              ),
            ),
            InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut();
              },
              child: ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.outlined_flag),
              ),
            ),
          ],
        )
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()));
            },
            icon: Icon(Icons.shopping_cart),
          )
        ],
        title: Text("Urbanization", style: TextStyle(
                  fontFamily: 'Proxima Nova Bold',
                  fontSize: 20.0,
                ),),
      ),
      body: ListView(
        primary: true,
        shrinkWrap: false,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                databaseData == null ? Text("") : Text("Welcome back! - "+databaseData['name'], style: TextStyle(
                  fontFamily: 'Proxima Nova Bold',
                  fontSize: 20.0,
                ),),
                (data == null) ? Center(
                  child: CircularProgressIndicator(),
                ) : (data.isEmpty) ? Center(
                  child: CircularProgressIndicator(),
                ) : Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network("http://openweathermap.org/img/wn/"+data['weather'][0]['icon']+"@2x.png"),
                      Text((data['main']['temp']-273).toStringAsFixed(2) + " °C", style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      )),
                      Text(data['name']+", "+data['sys']['country'])
                    ],
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Text("You helped in planting : "+ numberOfPlants.toString()+" just with your Food/Logistics Orders", style: TextStyle(
                  fontFamily: "Proxima Nova Bold",
                  fontSize: 18.0,
                ),),

                SizedBox(
                  height: 10.0,
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      boxShadow: [BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.black38
                      )]
                    ),
                    alignment: Alignment.center,
                    height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.navigation, color: Colors.white,),
                        SizedBox(height: 10.0),
                        Text("Navigation", style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Proxima Nova Bold',
                        ),),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Wrap(
                  
                  children:<Widget> [GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryService()));
                        },
                        child: Card(
                          color: Colors.cyan,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.local_pizza, color: Colors.white,),
                              SizedBox(height: 10.0),
                              Text("Food Orders/Logistics", style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Proxima Nova Bold',
                              ),),
                            ],
                          ),
                        )
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation()));
                        },
                        child: Card(
                          color: Colors.grey,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.event_available, color: Colors.white,),
                              SizedBox(height: 10.0),
                              Text("Navigation", style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Proxima Nova Bold',
                              ),),
                            ],  
                          ),
                        )
                      ),
                    ],
                  ),]
                ),

                SizedBox(
                  height: 10.0,
                ),

                Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (String text){
                          setState(() {
                            postMessage = text;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Post any thing here",
                        ),
                      ),
                      RaisedButton(
                            color: Colors.blue,
                            onPressed: ()async{
                              FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
                              try{
                                Firestore.instance.collection("posts").document().setData({
                                  "uid": fUser.uid,
                                  "name" : databaseData['name'],
                                  "time": DateTime.now(),
                                  "text": postMessage,
                                }).then((E){
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text("Posted Successfully!"),
                                      actions: <Widget>[
                                        RaisedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          color: Colors.blue,
                                          child: Text("Okay!"),
                                        )
                                      ],
                                    );
                                  });
                                });
                              }catch(e){
                                print(e.message);
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Text("Post", style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Proxima Nova Bold"
                                ),),
                              ],
                            )
                          )
                    ],
                  ),
                ),

                // Container(
                //   height: MediaQuery.of(context).size.height,
                //   child: ListView.builder(
                //         primary: false,
                //         shrinkWrap: false,
                //         itemCount: postsData.length,
                //         itemBuilder: (context, i){
                //           return Card(
                //             child: ListTile(
                //               title: Text(postsData[i].data['text']),
                //             ),
                //           );
                //         },
                //       ),
                // )

                

              ],
            ),
          )
        ],
      )
    );
  }
}


class OrdersAcceptedData{
  String orderId, pickupAddress, pickupCommunityId, dropAddress, dropCommunityId, uid, paymentInfo, expectedDeliveyTime, deliverPersonName;
  bool foodIsPrepared, isPickedByDeliveryBoy, hadStartedDriving, reachedYOurCommunity, delivered; 

  OrdersAcceptedData({@required this.orderId, @required this.pickupAddress, @required this.dropAddress, @required this.dropCommunityId, @required this.uid, @required this.paymentInfo, @required this.pickupCommunityId, @required this.delivered, @required this.foodIsPrepared, @required this.hadStartedDriving, @required this.isPickedByDeliveryBoy, @required this.reachedYOurCommunity});
}


class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<OrdersAcceptedData> data = [];
  void getData()async{
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot fData = await Firestore.instance.collection("deliverySerivce").where("delivered", isEqualTo: false).where("uid", isEqualTo: fUser.uid).getDocuments();
    List<DocumentSnapshot> docData = fData.documents;
    for(int i=0; i<docData.length; i++){
      data.add(OrdersAcceptedData(orderId: docData[i].data['orderRequestId'], paymentInfo: docData[i].data['paymentInfo'], isPickedByDeliveryBoy: docData[i].data['isPickedByDeliveryBoy'], hadStartedDriving: docData[i].data['hadStartedDriving'], dropAddress: docData[i].data['dropAddress'], dropCommunityId: docData[i].data['dropCommunityId'], uid: docData[i].data['uid'], pickupAddress: docData[i].data['fromAddress'], pickupCommunityId: docData[i].data['fromCommunityId'], delivered: docData[i].data['delivered'], reachedYOurCommunity: docData[i].data['reachedYourCommunity'], foodIsPrepared: docData[i].data['foodIsPrepared']));
    }
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders", style: TextStyle(
          fontFamily: "Proxima Nova Bold",
          fontSize: 22.0,
        ),),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i){
            return Container(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data[i].orderId),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}