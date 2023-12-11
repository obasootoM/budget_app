import 'package:budget_app/features/widget/category_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AlertDialogs extends StatefulWidget {
  const AlertDialogs({super.key});

  @override
  State<AlertDialogs> createState() => _AlertDialogsState();
}

class _AlertDialogsState extends State<AlertDialogs> {
  final _key = GlobalKey<FormState>();
  final amountEditingcontroller = TextEditingController();
  final titleEditingcontroller = TextEditingController();
  var type = 'Credit';
  var categorys = 'music';
  var isLoading = false;
  var ui = Uuid();
  _submit() async {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final userId = FirebaseAuth.instance.currentUser;
      int timeStamp = DateTime.now().millisecondsSinceEpoch;
      var amount = int.parse(amountEditingcontroller.text);
      DateTime date = DateTime.now();
      var id = ui.v4();
      String monthYear = DateFormat('MMM  y').format(date);
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId!.uid)
          .get();
      int remainingAmount = userDoc['remainingAmount'];
      int totalCredit = userDoc['totalCredit'];
      int totalDebit = userDoc['totalDebit'];
      if (type == 'credit') {
        remainingAmount += amount;
        totalCredit += amount;
      } else {
        remainingAmount -= amount;
        totalDebit += amount;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId!.uid)
          .update({
        'remainingAmount': remainingAmount,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
        'updatedAt': timeStamp
      });
      var data = {
        'id': id,
        'title': titleEditingcontroller.text,
        'amount': amount,
        'remainingAmount': remainingAmount,
        'totalCredit': totalCredit,
        'timeStamp': timeStamp,
        'totalDebit': totalDebit,
        'type': type,
        'categorys': categorys,
        'monthYear': monthYear
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId!.uid)
          .collection('transactions')
          .doc(id)
          .set(data);
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  String? validateCheck(value) {
    if (value!.isEmpty) {
      return 'Enter your details';
    }
    return null;
  }

  @override
  void dispose() {
    titleEditingcontroller.dispose();
    amountEditingcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: titleEditingcontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateCheck,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                controller: amountEditingcontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateCheck,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              CategoryItem(
                item: categorys,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      categorys = value;
                    });
                  }
                },
              ),
              DropdownButtonFormField(
                  value: 'credit',
                  items: const [
                    DropdownMenuItem(value: 'credit', child: Text('credit')),
                    DropdownMenuItem(value: 'debit', child: Text('debit')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        type = value;
                      });
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (isLoading == false) {
                      _submit();
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Add Transaction'))
            ],
          )),
    );
  }
}
