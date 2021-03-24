import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PageRefreshDemo extends StatefulWidget {
  PageRefreshDemo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PageRefreshDemoState createState() => _PageRefreshDemoState();

}

class _PageRefreshDemoState extends State<PageRefreshDemo> {
  Future<List<User>> _getUsers() async {
    var data = await http.get("XXXXX");
    if (data.statusCode == 200) {
      print('Status Code 200: Ok!');
      var jsonData = json.decode(data.body);
      List<User> users = [];
      for (var k in jsonData.keys) {
        var u = jsonData[k];
        //print(u["pubdate"]);
        User user = User(u["id"], u["source"], u["desc"], u["link"], u["title"], u["img"], u["pubdate"]);
        users.add(user);
      }
      print(users.length);
      return users;
    } else {
      throw Exception('Failed to load json');
    }
  }


  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _getUsers();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Page refresher"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: FutureBuilder(

          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){

              return Center(
                child: CircularProgressIndicator(),
              );

            } else {


              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int id){

                  return ListTile(

                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data[id].img
                        ),
                      ),

                      title: Text(snapshot.data[id].title),
                      subtitle: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                snapshot.data[id].source,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              Spacer(),
                              Text(snapshot.data[id].pubdate),
                            ],
                          ),
                        ],
                      )
                  );
                },
              );

            }

          },

        ),
        onRefresh: refreshList,
      ),

    );
  }
}

class User {

  final int id;
  final String source;
  final String desc;
  final String link;
  final String title;
  final String img;
  final String pubdate;

  User(this.id, this.source, this.desc, this.link, this.title, this.img, this.pubdate);


}