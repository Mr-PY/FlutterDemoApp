import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/screens/errorscreen.dart';

class UsersScreen extends StatelessWidget {
  Future _getDocuments() async {
    final QuerySnapshot usersArray =
        await FirebaseFirestore.instance.collection('users').get();
    return usersArray.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: FutureBuilder(
        future: _getDocuments(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data[index].data()['photo'],
                    ),
                  ),
                  title: Text(snapshot.data[index].data()['name']),
                  subtitle: Text(snapshot.data[index].data()['email']),
                );
              },
              separatorBuilder: (_, index) => Divider(),
            );
          } else if (snapshot.hasError) {
            return ErrorScreen();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
