import 'package:budget_app/features/widget/recent_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionListed extends StatelessWidget {
  TransactionListed(
      {super.key,
      required this.categorys,
      required this.monthYear,
      required this.type});
  
  final String categorys;
  final String monthYear;
  final String type;
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    Query query = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .where('type', isEqualTo: type);
    // if (categorys != 'All') {
    //   query = query.where('categorys', isEqualTo: categorys);
    // }
    return FutureBuilder<QuerySnapshot>(
        future: query.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Transaction found'));
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var dataCard = data[index];
                return TransactionCard(
                  data: dataCard,
                );
              });
        });
  }
}
