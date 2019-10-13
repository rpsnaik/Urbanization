class Edge{
  int u, v;
  String communityName, communityId;

  Edge({this.u, this.v, this.communityId, this.communityName});
}

void main(){
  List<Edge> data = [];
  for(int i=0; i<10; i++){
    for(int j=0; j<10; j++){
      Edge(u: i, v: j, communityId: "500"+i.toString()+j.toString(), communityName: "Community"+i.toString()+j.toString());
    }
  }
  print(data);
}