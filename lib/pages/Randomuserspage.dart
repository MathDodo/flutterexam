import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usercore/Classes/RandomUser.dart';

class RandomUsers extends StatefulWidget {
  final Widget child;

  RandomUsers({Key key, this.child}) : super(key: key);

  _RandomUsersState createState() => _RandomUsersState();
}

class _RandomUsersState extends State<RandomUsers> {
  
  Future<List<RandomUser>> getUsers() async
  {
    var data = await http.get("https://randomuser.me/api/?results=50");

    var jsonData = json.decode(data.body);

    List<RandomUser> users = [];

    for(var u in jsonData["results"]){
      RandomUser user = RandomUser(u["picture"]["thumbnail"], u["name"]["first"], u["name"]["last"], u["phone"]);
      users.add(user);
    }

    return users;
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Random users"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null)
            {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            }
            else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[index].picture),
                  ),
                  title: Text(snapshot.data[index].firstName + " " + snapshot.data[index].lastName),
                  subtitle: Text(snapshot.data[index].phoneNumber),
                  );
              
              },
            
            );
            }
          },
        ),
      ),
    );
  }
}