import 'package:flutter/material.dart';
import 'package:pathfinding/core/grid.dart';
import 'package:pathfinding/finders/jps.dart';

class Edge{
  int u, v;
  String communityName, communityId;

  Edge({this.u, this.v, this.communityId, this.communityName});
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Edge startingPoint;
  Edge endPoint;
  List<Widget> widgetsMap = [];
  List<Edge> data = [];
  List<Edge> searchResData = [];
  @override
  void initState() {
    for(int i=0; i<5; i++){
      for(int j=0; j<5; j++){
        data.add(Edge(u: i, v: j, communityId: "500"+i.toString()+j.toString(), communityName: "Community"+i.toString()+j.toString()));
        widgetsMap.add(Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("u : "+i.toString()+", v : "+j.toString()),
              Text("500"+i.toString()+j.toString())
            ],
          ),
        ));
      }
    }
    searchResData = data;
    print(data[0].communityName);
    super.initState();
  }
  PageController pctrl = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation", style: TextStyle(
          fontFamily: 'Proxima Nova Bold',
          fontSize: 22.0,
        ),),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pctrl,
        children: <Widget>[
          ListView(
            primary: true,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  onChanged: (String text){
                    if(text == null){
                      searchResData = data;
                    }else if(text.length == 0){
                      searchResData = data;
                    }else{
                      searchResData = [];
                      for(int i=0; i<data.length; i++){
                        if(data[i].communityName.toLowerCase().contains(text.toLowerCase())){
                          searchResData.add(data[i]);
                        }
                      }
                    }
                    setState(() {
                        
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Starting Point'
                  ),
                )
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                  primary: true,
                  shrinkWrap: true,
                  itemCount: searchResData.length,
                  itemBuilder: (context, i){
                    return InkWell(
                      child: Card(
                        elevation: 5.0,
                        child: ListTile(
                          title: Text(searchResData[i].communityName, style: TextStyle(
                            fontFamily: 'Proxima Nova Bold'
                          ),),
                          subtitle: Text("Community ID : "+searchResData[i].communityId),
                          trailing: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            color: Colors.black,
                            onPressed: (){
                              startingPoint = searchResData[i];
                              pctrl.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigateDirections(data: data, widgetsMap: widgetsMap,)));
                            },
                            child: Text("Navigate", style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Proxima Nova Bold',
                            ),),
                          )
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Container(
              //   color: Colors.black,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Container(
              //         child: GridView.count(
              //           shrinkWrap: true,
              //           primary: false,
              //           crossAxisCount: 5,
              //           children: widgetsMap,
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
          ListView(
        primary: true,
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              onChanged: (String text){
                if(text == null){
                  searchResData = data;
                }else if(text.length == 0){
                  searchResData = data;
                }else{
                  searchResData = [];
                  for(int i=0; i<data.length; i++){
                    if(data[i].communityName.toLowerCase().contains(text.toLowerCase())){
                      searchResData.add(data[i]);
                    }
                  }
                }
                setState(() {
                    
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Choose your Destination'
              ),
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.8,
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              primary: true,
              shrinkWrap: true,
              itemCount: searchResData.length,
              itemBuilder: (context, i){
                return InkWell(
                  child: Card(
                    elevation: 5.0,
                    child: ListTile(
                      title: Text(searchResData[i].communityName, style: TextStyle(
                        fontFamily: 'Proxima Nova Bold'
                      ),),
                      subtitle: Text("Community ID : "+searchResData[i].communityId),
                      trailing: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        color: Colors.black,
                        onPressed: (){
                          endPoint = searchResData[i];
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigateDirections(data: data, startingPoint: startingPoint, endPoint: endPoint,)));
                        },
                        child: Text("Navigate", style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Proxima Nova Bold',
                        ),),
                      )
                    ),
                  ),
                );
              },
            ),
          ),
          // Container(
          //   color: Colors.black,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Container(
          //         child: GridView.count(
          //           shrinkWrap: true,
          //           primary: false,
          //           crossAxisCount: 5,
          //           children: widgetsMap,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
        ],
      )
    );
  }
}


class NavigateDirections extends StatefulWidget {
  final List<Edge> data;
  final Edge startingPoint, endPoint;
  NavigateDirections({@required this.data, @required this.startingPoint, @required this.endPoint});
  @override
  _NavigateDirectionsState createState() => _NavigateDirectionsState();
}

class _NavigateDirectionsState extends State<NavigateDirections> {
  getRoute(){

      var grid = new Grid(5, 5, [
      [0, 0, 0, 0, 0], // 0 - walkable, 1 - not walkable
      [1, 0, 1, 0, 0],
      [0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ]);
    var jps = new JumpPointFinder();
    var path = jps.findPath(widget.startingPoint.u, widget.startingPoint.v, widget.endPoint.u, widget.endPoint.v, grid);
    print(path); 

    bool checkPresentInstance(int u, int v){
      for(int i = 0; i<path.length; i++){
        if(path[i][0] == u && path[i][1] == v){
          return true;
        }
      }
      return false;
    }


    for(int i=0; i<5; i++){
      for(int j=0; j<5; j++){
        widgetsMap.add(Card(
          color: checkPresentInstance(i, j) ? Colors.green : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("u : "+i.toString()+", v : "+j.toString()),
              Text("500"+i.toString()+j.toString())
            ],
          ),
        ));
      }
    }
  }
  List<Widget> widgetsMap = [];
  List<Edge> data = [];
  @override
  void initState() {
    getRoute();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Optimal Way", style: TextStyle(
          fontSize: 22.0,
          fontFamily: "Proxima Nova Bold",
        ),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),            
                  ),
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(widget.startingPoint.communityName, style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Proxima Nova Bold",
                          fontSize: 18.0
                        ),)
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white,),
                      Center(
                        child: Text(widget.endPoint.communityName, style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Proxima Nova Bold",
                          fontSize: 18.0
                        ),)
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisCount: 5,
                          children: widgetsMap,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}