import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/constants.dart';
import 'package:salon_app/screens/auth/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  void login() {
    setState(() {
      loading = true;
    });
    auth.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text}",
      verificationCompleted: (_) {
        setState(() {
          loading = false;
        });
      },
      verificationFailed: (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() {
          loading = false;
        });
      },
      codeSent: (String verificationId, int? token) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => OtpScreen(
              verificationId: verificationId,
            ),
          ),
        );
        setState(() {
          loading = false;
        });
      },
      codeAutoRetrievalTimeout: (e) {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: pinkColor,
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/images/logo.png")),
                const SizedBox(height: 10),
                Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.numbers),
                              Text(
                                " Mobile Number",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Number";
                              } else if (value.length < 10) {
                                return "Enter 10 digit number";
                              }
                              return null;
                            },
                            controller: _phoneController,
                            decoration: InputDecoration(
                              prefix: Text(
                                "+91 ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.6),
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                              ),
                              hintText: "Enter Mobile Number",
                              suffixIcon: Icon(
                                Icons.phone,
                                color: Colors.grey.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(size.width * 0.8, size.height * 0.055),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Continue"),
                      ),
                      const SizedBox(height: 20),
                      const Text("By continuing you are agree to our"),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Terms & Conditions ",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("and "),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
