import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataSystem extends StatefulWidget 
{
  final Widget child;

  DataSystem({Key key, this.child}) : super(key: key);

  _DataSystem createState() => _DataSystem();
}

class _DataSystem extends State<DataSystem>
{
  final _formKey = GlobalKey<FormState>();
  String _name, _computerInfo;
  int _birthyear;

  bool containsNumber(String value)
  {
    for(int i = 0; i < value.length; i++)
    {
      if(double.tryParse(value[i]) != null)
      {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert data"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Write a name'
              ),
              validator: (value) {                
                if(containsNumber(value) || value.length == 0){
                  return 'No numbers in name and data is needed';
                }       

                _name = value;         
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Birth year'
              ),
              validator: (value) {                
                if(int.tryParse(value) == null || value.length != 4){
                  return 'Your birth year is a number of 4 characters';
                }    

                _birthyear = int.parse(value);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Computer info'
              ),              
              validator: (value) {     
                if(value.length == 0) {
                  return 'Data is needed';
                }
                _computerInfo = value; 
              },
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                Firestore.instance.collection('userdata').document().setData({'name' : _name, 'birthyear' : _birthyear, 'computer' : _computerInfo});
                Navigator.of(context).pop();
              }
            },
            child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

