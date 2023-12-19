import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:salon_app/screens/home/bottomNavBar.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  void verifyOtp() async {
    setState(() {
      loading = true;
    });
    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: _otpController.text,
    );
    try {
      await auth.signInWithCredential(credential);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const Navigation(),
        ),
      );
      setState(() {
        loading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        loading = false;
      });
    }
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
                                " OTP",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: _formKey,
                          child: PinCodeTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "OTP is empty";
                              } else if (value.length < 6) {
                                return "Enter 6 digits";
                              }
                              return null;
                            },
                            controller: _otpController,
                            appContext: context,
                            length: 6,
                            pinTheme: PinTheme(
                              selectedColor: pinkColor,
                              inactiveColor: Colors.black,
                              shape: PinCodeFieldShape.underline,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.slide,
                            animationDuration:
                                const Duration(milliseconds: 100),
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
                            verifyOtp();
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
