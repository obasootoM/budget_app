import 'package:budget_app/features/auth/auth_service/auth_service.dart';
import 'package:budget_app/features/auth/auth_service/db.dart';
import 'package:budget_app/features/screen/sing_in.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var obScure = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
    super.dispose();
  }

  var db = DB();
  var authService = AuthService();
  var isLoading = false;
  void _submit() {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var data = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passController.text,
        'remainingAmount': 0,
        'totalCredit': 0,
        'totalDebit': 0
      };
      authService.createService(context, data);
      print('hello');
      db.addUser(data, context);
      print('hello');
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Signup success')));
      setState(() {
        isLoading = false;
      });
    }
  }

  String? validatePhone(value) {
    if (value!.isEmpty) {
      return 'please Enter your phone number';
    }
    if (value.length != 10) {
      return 'number must be 10';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return 'please Enter your password';
    }
    if (value.length != 10) {
      return 'number must be 10';
    }
    return null;
  }

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: height * 0.15,
              ),
              const Text(
                'Create New Account',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please do Enter your name';
                    }
                    return null;
                  },
                  decoration: parameter('name')),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Enter your Email';
                    }
                    RegExp email = RegExp(r'^[\w-\.] +@([\w-]+\.)+[\w-]{2,4}$');
                    if (email.hasMatch(value)) {
                      return 'please return a valid email';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: parameter('email')),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: phoneController,
                  validator: validatePhone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: parameter('phone number')),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: passController,
                validator: validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                decoration: parameter('password'),
                obscureText: obScure,
                onChanged: (value) {
                  setState(() {
                    obScure = !obScure;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: height * 0.05,
                width: width * 1,
                child: ElevatedButton(
                  onPressed: () {
                    isLoading ? print('isloading') : _submit();
                  },
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Don\'t hava an account?  ',
                    style: const TextStyle(fontSize: 20),
                    children: [
                      TextSpan(
                          text: '  Login',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            })
                    ])
              ]))
            ]),
          ),
        ),
      ),
    );
  }

  InputDecoration parameter(String params) {
    return InputDecoration(
        fillColor: Colors.black87,
        filled: true,
        labelText: params,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)));
  }
}
