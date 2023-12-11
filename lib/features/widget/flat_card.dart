import 'package:budget_app/features/widget/card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FlatCard extends StatelessWidget {
  FlatCard({
    super.key,
    required this.userId,
  });
  final String userId;
  
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('document does not exist');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;
        return  Cards(data: data,);
      },
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({
    super.key, required this.data,
  });
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Total Balance',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'N ${data['remainingAmount']}',
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 245, 242, 242)),
          ),
        ),
        Container(
          decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)))),
          child:  Row(
            children: [
              Expanded(
                child: cardItem(
                color: Colors.green,
                cash: 'credit',
                num: '${data['totalCredit']}',
               
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: cardItem(
                color: Colors.red,
                cash: 'debit',
                num: '${data['totalDebit']}',
              ))
            ],
          ),
        )
      ]),
    );
  }
}
