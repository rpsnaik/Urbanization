import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersData{
  String orderId, phoneNumber, pickupAddress, pickupCommunityId, dropAddress, dropCommunityId, uid, paymentInfo;
  bool foodIsPrepared, isPickedByDeliveryBoy, hadStartedDriving, reachedYOurCommunity, delivered; 

  OrdersData({@required this.orderId, @required this.phoneNumber, @required this.pickupAddress, @required this.dropAddress, @required this.dropCommunityId, @required this.uid, @required this.paymentInfo, @required this.pickupCommunityId, @required this.delivered, @required this.foodIsPrepared, @required this.hadStartedDriving, @required this.isPickedByDeliveryBoy, @required this.reachedYOurCommunity});
}

List<OrdersData> ordersData = [];

class DeliveryService extends StatefulWidget {
  @override
  _DeliveryServiceState createState() => _DeliveryServiceState();
}

class _DeliveryServiceState extends State<DeliveryService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDetails()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Food/Logistics Delivery", style: TextStyle(
          fontFamily: 'Proxima Nova Bold',
          fontSize: 22.0,
        ),),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: ordersData.length,
          itemBuilder: (context, i){
            return InkWell(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 10.0,
                  child: ListTile(
                    title: Text(ordersData[i].orderId, style: TextStyle(
                      fontFamily: "Proxima Nova Bold",
                    ),),
                    subtitle: Text("Delivery to : "+ordersData[i].dropAddress.toString()),
                    trailing: RaisedButton(
                      color: Colors.black,
                      onPressed: ()async{
                        FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
                        try{
                          Firestore.instance.collection("ordersRequests").document().setData({
                            "orderId": ordersData[i].orderId,
                            "phoneNumber": ordersData[i].phoneNumber,
                            "pickupAddress": ordersData[i].pickupAddress,
                            "pickupCommuniyId": ordersData[i].pickupCommunityId,
                            "dropAddress": ordersData[i].dropAddress,
                            "dropCommunityId": ordersData[i].dropCommunityId,
                            "uid": fUser.uid,
                            "paymentInfo": ordersData[i].paymentInfo,
                            "foodIsPrepared": false,
                            "isPickedByDeleiveryBoy": false,
                            "hadStartedDriving": false,
                            "reachedYourCommunity": false,
                            "delivered": false
                          });
                          ordersData.removeAt(i);
                          setState(() {
                            
                          });
                        }catch(e){
                          print("Error : "+e.message);
                        }


                      },
                      child: Text("Confirm Delivery", style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Proxima Nova Bold",
                      ),),
                    ),
                  ),
                )
              ),
            );
          },
        )
      ),
    );
  }
}

class AddDetails extends StatefulWidget {
  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  String orderId, phoneNumber, pickupAddress, pickupCommunityId, dropAddress, dropCommunityId, paymentInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details", style: TextStyle(
          fontFamily: "Proxima Nova Bold",
          fontSize: 22.0,
        ),),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Order Id'
                    ),
                    onChanged: (String text){
                      orderId = text;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number'
                    ),
                    onChanged: (String text){
                      phoneNumber = text;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Pickup Address'
                    ),
                    onChanged: (String text){
                      pickupAddress = text;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Pickup Community ID'
                    ),
                    onChanged: (String text){
                      pickupCommunityId = text;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Drop Address'
                    ),
                    onChanged: (String text){
                      dropAddress = text;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Drop Community ID'
                    ),
                    onChanged: (String text){
                      dropCommunityId = text;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Payment Info'
                    ),
                    onChanged: (String text){
                      paymentInfo = text;
                    },
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: ()async{
                      FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
                      ordersData.add(OrdersData(orderId: orderId, phoneNumber: phoneNumber, pickupAddress: pickupAddress, pickupCommunityId: pickupCommunityId, dropAddress: dropAddress, dropCommunityId: dropCommunityId, paymentInfo: paymentInfo, delivered: false, isPickedByDeliveryBoy: false, hadStartedDriving: false, uid: fUser.uid, reachedYOurCommunity: false, foodIsPrepared: false));
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text('Add', style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Proxima Nova Bold",
                            fontSize: 18.0,
                          ),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}