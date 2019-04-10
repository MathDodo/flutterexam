import 'package:flutter/material.dart';
import 'Randomuserspage.dart';
import 'DataSystem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget 
{
  final Widget child;

  Homepage({Key key, this.child}) : super(key: key);

  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> 
{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("User core"), backgroundColor: Colors.purpleAccent,),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
            ),
            new ListTile(
              title: new Text("Random users"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () { 
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new RandomUsers()));
              },
            ),
            new ListTile(
              title: new Text("Data system"),
              trailing: new Icon(Icons.arrow_right),
               onTap: () { 
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new DataSystem()));
              },
            ),
             new ListTile(
              title: new Text("Cancel"),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('userdata').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
          {
            return Text('Loading...');
          }
          else
          {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data.documents[index]['name']);
                return ListTile(
                  leading: Text(snapshot.data.documents[index]['birthyear'].toString()),
                  title: Text(snapshot.data.documents[index]['name']),
                  subtitle: Text(snapshot.data.documents[index]['computer']),
                );
             },
            );
          }
        },
      ),
    );
  }
}