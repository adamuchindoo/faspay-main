import 'dart:convert';

import 'package:faspay/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class RegisterScreen extends StatefulWidget {
 // const RegisterScreen({super.key});
  const RegisterScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _nin, _phoneNumber, _email;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _othername = TextEditingController();
  TextEditingController _my_nin = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
bool    show_preogress = false;
  String? _validateConfirmPassword(String value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Password must contain at least one letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _dateController.text = DateFormat.yMd().format(picked);
      });
  }

  void _submitBVN() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        // backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 200.0,
                        // color: Colors.blue.shade900,
                      ),
                      Center(
                        child: Text(
                          "Let's get you an Account!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 57, 120, 172),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstname,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15),
                                labelText: 'First Name',
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: TextFormField(
                              controller: _surname,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15),
                                labelText: 'Last Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _othername,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue.shade900,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue.shade900,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          labelText: 'Othername (Optional)',
                        ),
                        onSaved: (value) => _email = value,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _my_nin,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue.shade900,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue.shade900,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          labelText: 'National Identification Number (NIN)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'NIN is required';
                          }
                          return null;
                        },
                        onSaved: (value) => _nin = value,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15),
                                labelText: 'Password',
                              ),
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                                  return 'Password must contain at least one letter';
                                }
                                if (!value.contains(RegExp(r'[0-9]'))) {
                                  return 'Password must contain at least one digit';
                                }
                                return null;
                              }),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: TextFormField(
                              obscureText: true,
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15),
                                labelText: 'Confirm Password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                                  return 'Password must contain at least one letter';
                                }
                                if (!value.contains(RegExp(r'[0-9]'))) {
                                  return 'Password must contain at least one digit';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        "By signing up, you agree to our terms of service.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      SizedBox(
                        height: 05,
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              otp_verification();

                            }
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future otp_verification()async {
    var url = "https://a2ctech.net/api/faspay/new_user.php";
    var response;
    response = await http.post(Uri.parse(url), body: {
      // 	phone 	f_name 	s_name 	o_name 	nin 	pass
      "phone": widget.phoneNumber,
      "f_name": _firstname.text,
      "s_name": _surname.text,
      "o_name": _othername.text,
      "nin": _my_nin.text,
      "pass": _passwordController.text,
    });

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      print(data["status"]);
      if(data["status"]=="true"){

      }else if(data["status"]=="01"){
        _showToast(context,"NIN Number Already Exit");
      }else if(data["status"]=="02"){
        _showToast(context,"Phone Number Already Exit");
      }else{

        _showToast(context,"Invalid OTP");
      }
      setState(() {
        show_preogress = false;
      });
    }else{
      print(response.statusCode);
    }
  }
  void _showToast(BuildContext context,String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content:  Text(msg,style: TextStyle(fontWeight: FontWeight.bold,),),
        action: SnackBarAction(label: '', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}



















































 // TextFormField(
                      //   controller: _dateController,
                      //   decoration: InputDecoration(
                      //     contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      //     hintText: "Date of Birth",
                      //     border: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.green),
                      //     ),
                      //     prefixIcon: IconButton(
                      //       onPressed: () => _selectDate(context),
                      //       icon: Icon(Icons.calendar_month),
                      //     ),
                      //   ),
                      //   readOnly: true,
                      //   onTap: () => _selectDate(context),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),