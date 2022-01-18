import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<User>> getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user =
          User(name: u['name'], email: u['email'], username: u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('api'),
      ),
      body: Center(
          child: Card(
        child: FutureBuilder<List<User>>(
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return SizedBox();
              } else {
                List<User> users = snapshot.data!;
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].email));
                    },
                    itemCount: snapshot.data!.length);
              }
            },
            future: getUserData()),
      )),
    );
  }
}

class User {
  final String name, email, username;

  User({required this.name, required this.email, required this.username});
}
