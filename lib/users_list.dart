import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  Firestore firestore = Firestore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Users List'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 40.0),
          child: StreamBuilder<QuerySnapshot>(
            //to get the snapshot of the documents
            stream: firestore.collection("users").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.documents);
                //  return  Text('hello harsh');

                return Column(
                    children: snapshot.data.documents
                        .map(
                          (doc) => Card(
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                        top: 20.0,
                                      ),
                                      child: Text(
                                        doc.data['name'],
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      )),
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                    ),
                                    child: Text(
                                      doc.data['email'],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList());
              } else {
                return SizedBox();
              }
              // print(snapshot.data.documents);
              // return  Text('hello harsh');
            },
          ),
        ),
      ),
    );
  }
}
