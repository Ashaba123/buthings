import 'package:buthings/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminViewUsers extends StatefulWidget {
  const AdminViewUsers({Key? key}) : super(key: key);

  @override
  _AdminViewUsersState createState() => _AdminViewUsersState();
}

class _AdminViewUsersState extends State<AdminViewUsers> {
  @override
  Widget build(BuildContext context) {
    final _usersStream = Provider.of<UserProvider>(context).getAllUsers();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Registered Users'),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot>>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(data.get('email')),
                  subtitle: Text("Phone: ${data.get('phone')}"),
                  trailing: Text('Role: ${data.get('role')}'),
                );
              });
        },
      ),
    );
  }
}
