import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  Future<List<User>> getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user =
          User(name: u['name'], email: u['email'], userName: u['userName']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: FutureBuilder<List<User>>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return SizedBox();
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].name),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }
            }),
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String userName;

  User({required this.name, required this.email, required this.userName});
}
