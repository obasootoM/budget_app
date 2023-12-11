import 'package:budget_app/features/auth/auth_service/auth_service.dart';
import 'package:budget_app/features/screen/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var obScure = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _key = GlobalKey<FormState>();
  var isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  var authService = AuthService();
  void _submit() {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var data = {
        'email': emailController.text,
        'password': passController.text
      };
      authService.login(context, data);
      setState(() {
        isLoading = false;
      });
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Login success')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _key,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email';
                    }
                    RegExp email = RegExp(r'^[\w-\.] +@([\w-]+\.)+[\w-]{2,4}$');
                    if (email.hasMatch(value)) {
                      return 'please return a valid email';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: decoration_field('email'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: obScure,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    if (value.length != 10) {
                      return 'Enter a minimun of 10';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  controller: passController,
                  keyboardType: TextInputType.visiblePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: decoration_field('password'),
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
                  height: 15,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Already hava an account?  ',
                      style: const TextStyle(fontSize: 20),
                      children: [
                        TextSpan(
                            text: ' Sign up',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp())))
                      ])
                ]))
              ],
            )),
      ),
    );
  }

  InputDecoration decoration_field(String parameter) {
    return InputDecoration(
        labelText: parameter,
        filled: true,
        fillColor: Colors.black,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)));
  }
}
