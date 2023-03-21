import 'dart:convert';

import 'package:faspay/pages/otppage.dart';
import 'package:faspay/pages/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isButtonEnabled = false;
  bool show_preogress =false;
  bool correct_pass_checker=false ;
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onTextChanged);
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _textEditingController.text.length >= 11;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 18, 98, 109),
          ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 200.0,
                      // color: Colors.blue.shade900,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Enter your mobile number.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "To use Faspay, Please enter your mobile number",
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                      prefixText: "+234 - ",
                      prefixStyle: TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                    onChanged: (value) => _phoneNumber = value,
                  ),
                ],
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: _isButtonEnabled ? Colors.blue.shade900 : Colors.grey,
                ),
                child: TextButton(
                  onPressed:(){
                    login(_textEditingController.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtpPage(phoneNumber: _textEditingController.text,)),
                    );

                  },
                  child: Text(
                    'PROCEED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future login(phone)async {
    var url = "https://a2ctech.net/api/faspay/otp.php";
    var response;
    response = await http.post(Uri.parse(url), body: {
      "phone": phone,

    });

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
//print(data["token"]);
      if(data["phone"]=="true"){
        //_to_reg_page( context);
        _showToast( context,"phone exit");
      }else if(data["status"]=="true"){
        _showToast( context,"goood to go");
      }
      setState(() {
        show_preogress = false;
      });
    }
  }
  void _showToast(BuildContext context,String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(msg),
        action: SnackBarAction(label: '', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
