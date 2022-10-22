import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget {
  const DataFromAPI({Key? key}) : super(key: key);


  @override
  State<DataFromAPI> createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future getUserData() async {
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com','users'));
   var jsonData=jsonDecode(response.body) ;
  List<User> users=[];
   for(var d in jsonData){
     User user=User(d['name'], d['email'], d['userName']);
     users.add(user);
   }
   return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User's Information"),
        backgroundColor: Colors.black26,
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future:getUserData() ,
            builder:(context,snapshot)
          {
            if(snapshot.data==200){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder:(context,i) {
                    return ListTile(
                      title:Text(snapshot.data[i].name),
                      subtitle:Text(snapshot.data[i].email),

                    );


                  });

            }
            else
              return Container(
                child:Center(
                child: Text("ITS LOADING...."),
            )
            );


          }),
        )
      ),

    );
  }
}

class User {
  final String name, email, userName;

  User(this.name, this.email, this.userName);
}
