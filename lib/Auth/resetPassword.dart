///this widget(screen) for resetting passwords
///

import 'package:flutter/material.dart';
import 'package:topix/Auth/AuthServices.dart';

class TopixResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResetWidget();
  }
}

class ResetWidget extends StatefulWidget {
  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<ResetWidget> {
  //global key for email form
  final _formKey = GlobalKey<FormState>();

  //text controller for email and password
  final emailController = TextEditingController();

  //variable for indicating submit button state
  bool enable = false;

  //bool for loading state
  bool isLoading = false;

  //clean up the controllers
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    emailController.addListener(emailListner);

    super.initState();
  }

  emailListner() {
    if (_formKey.currentState.validate()) {
      setState(() {
        enable = true;
      });
    } else {
      setState(() {
        enable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text("Reset"),
        ),
        body: Theme(
          child: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        "Reset password",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5),
                      child: Text(
                        "We'll email you a code to reset your password.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black38),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      labelText: 'Enter registered Email',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);

                      if (!regex.hasMatch(value)) return 'Enter Valid Email';
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          autofocus: true,
                          clipBehavior: Clip.none,
                          onPressed: enable
                              ? () async {
                                  if (_formKey.currentState.validate()) {
                                    //on success
                                    setState(() {
                                      isLoading = true;
                                      enable = !enable;
                                    });
                                    if (await AuthServices.resetPassword(
                                        emailController.text)) {
                                      setState(() {
                                        isLoading = false;
                                        enable = !enable;
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                        enable = !enable;
                                      });
                                    }
                                  }
                                }
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Spacer(),
                              Text(
                                "Reset",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Spacer(),
                              isLoading
                                  ? Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.black38,
                                      ),
                                    )
                                  : Text("")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Add TextFormFields and RaisedButton here.
              ])),
          data: ThemeData(
            primaryColor: Colors.blue,
          ),
        ));
  }
}
