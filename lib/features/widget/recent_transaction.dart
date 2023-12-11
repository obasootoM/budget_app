import 'package:budget_app/utilis/app_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RecentTransaction extends StatelessWidget {
  RecentTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(15.0),
      child: Column(
        children: [
           Row(
            children: [
              Text(
                'Recent Transaction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          TransactionList()
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('timeStamp', descending: true)
        .limit(20)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
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

class TransactionCard extends StatelessWidget {
  TransactionCard({
    super.key,
    required this.data,
  });

  final appicon = AppIcon();
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(data['timeStamp']);
    String formatDate = DateFormat('d MMM hh:mma').format(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                  offset: const Offset(0, 10),
                  color: Colors.grey.withOpacity(0.09),
                  blurRadius: 10.0,
                  spreadRadius: 4.0)
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: data['type'] == 'credit' ? Colors.green.withOpacity(0.2) 
            : Colors.red.withOpacity(0.2),
            child: FaIcon(
              color : data['type'] == 'credit' ? Colors.green
            : Colors.red,
              appicon.categoryItem('${data['categorys']}')),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Text('${data['title']}')),
              Text(
                "${data['type'] == 'credit'? '+' : '-'}N ${data['amount']}",
                style: TextStyle(color: data['type'] == 'credit' ? Colors.green
            : Colors.red,),
              )
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Expanded(
                    child: Text(
                  'Balance',
                  style: TextStyle(fontSize: 13),
                )),
                Text('N ${data['remainingAmount']}',
                    style: const TextStyle(fontSize: 13))
              ]),
              Text(
                formatDate,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
