import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataSystem extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert data"),
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

// Firestore.instance.collection('userdata').add({'name' : 'Mathias', 'birthyear' : 1994, 'computer' : 'Alienware'})
