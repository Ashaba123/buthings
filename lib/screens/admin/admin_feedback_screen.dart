import 'package:buthings/constants.dart';
import 'package:buthings/provider/ratings_provider.dart';
import 'package:buthings/screens/admin/admin_view_a_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminFeedbackScreen extends StatelessWidget {
  const AdminFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FeedBack"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          StreamBuilder<List<QueryDocumentSnapshot>>(
            stream: context.read<RatingsProvider>().getAllRatings(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('error in ratings'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final rating = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminViewRating(
                                      rating: rating,
                                    )));
                      },
                      child: Card(
                        child: ListTile(
                          isThreeLine: true,
                          leading: CircleAvatar(
                            child: Icon(Icons.rate_review),
                          ),
                          title: Text('Product: ${rating.get('product')}'),
                          subtitle: Text('Client: ${rating.get('user')}'),
                          trailing: Text(
                            'Rating: ${rating.get('rating')}',
                            style:
                                TextStyle(fontSize: 16, color: kPrimaryColor),
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
