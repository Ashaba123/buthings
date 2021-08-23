import 'package:buthings/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewRating extends StatelessWidget {
  final QueryDocumentSnapshot? rating;

  AdminViewRating({this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Order'),
      ),
      body: Center(
        child: ListView(shrinkWrap: true, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kDefaultPadding),
              Text(
                '${rating!.get('product')}',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              SizedBox(height: kDefaultPadding),
              RichText(
                text: TextSpan(
                    text: 'Comments from Client: \n',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    children: [
                      TextSpan(
                        text: ' ${rating!.get('comment')}',
                        style: TextStyle(fontSize: 18, color: kPrimaryColor),
                      )
                    ]),
              ),
              SizedBox(height: kDefaultPadding),
              Text(
                'Client: ${rating!.get('user')}',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
