import 'package:flutter/material.dart';
import 'package:flutter_app_c/controller/ResourceController.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInfoScreen extends StatefulWidget {
  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  String _districtValue = "Delhi";
  final GlobalKey<FormState> _formKey = GlobalKey();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  final providerNameNode = FocusNode();
  final mobileNode = FocusNode();
  final altMobileNode = FocusNode();
  final emailNode = FocusNode();
  final itemNode = FocusNode();
  final quantityNode = FocusNode();
  final infoNode = FocusNode();
  final addressNode = FocusNode();
  //
  final nameCont = TextEditingController();
  final mobCont = TextEditingController();
  final altMobileController = TextEditingController();
  final emailCont = TextEditingController();
  final itemCont = TextEditingController();
  final qtyCont = TextEditingController();
  final infoCont = TextEditingController();
  final addCont = TextEditingController();
  final dropCont = TextEditingController();

  bool isSubmit = false;

  @override
  void dispose() {
    providerNameNode.dispose();
    mobileNode.dispose();
    altMobileNode.dispose();
    emailNode.dispose();
    itemNode.dispose();
    quantityNode.dispose();
    infoNode.dispose();
    addressNode.dispose();
    super.dispose();
  }

  String uid;
  String uPhone;

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid");
    uPhone = prefs.getString("phone");
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFB0FFA8),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: isSubmit
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.orangeAccent,
                          primaryColorDark: Colors.orangeAccent,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                top: 15,
                                bottom: 8.0,
                                left: 8.0,
                              ),
                              child: TextFormField(
                                focusNode: providerNameNode,
                                controller: nameCont,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Provider's Name",
                                  border: OutlineInputBorder(),
                                  helperText:
                                      "* Name of person who is providing item",
                                ),
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(mobileNode);
                                },
                                validator: (val) {
                                  if (val.length < 3) {
                                    return "Provider's name is too short";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      focusNode: mobileNode,
                                      controller: mobCont,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(altMobileNode);
                                      },
                                      keyboardType: TextInputType.number,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        labelText: "Mobile Number",
                                        helperText: "*Required",
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (val) {
                                        if (val.length < 9) {
                                          return "Invalid number";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: altMobileController,
                                      focusNode: altMobileNode,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(emailNode);
                                      },
                                      keyboardType: TextInputType.number,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        labelText: "Alternate Mobile Number",
                                        helperText: "",
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return null;
                                        }
                                        if (val.length < 9) {
                                          return "Invalid number";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                focusNode: emailNode,
                                controller: emailCont,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(itemNode);
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return null;
                                  }
                                  if (val.length < 3 || !val.contains("@")) {
                                    return "Email is invalid";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: itemCont,
                                focusNode: itemNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(quantityNode);
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Item Name",
                                  helperText: "*Required",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val.length < 3) {
                                    return "Item name is too short";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: qtyCont,
                                focusNode: quantityNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(infoNode);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Quantity",
                                  helperText: "*Required",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val == "0" || val.isEmpty) {
                                    return "Quantity can't be 0";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: infoCont,
                                focusNode: infoNode,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: "Additional Information",
                                  helperText: "*Required",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val.length < 4) {
                                    return "Information is too short";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: addCont,
                                focusNode: addressNode,
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  labelText: "Address",
                                  helperText: "*Required",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val.length < 4) {
                                    return "Address is too short";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.all(10),
                              child: DropdownButtonFormField<String>(
                                value: _districtValue,
                                style: TextStyle(color: Colors.black),
                                items: [
                                  'Delhi',
                                  'Delhi NCR',
                                  'North Delhi',
                                  'South Delhi',
                                  'East Delhi',
                                  'West Delhi',
                                  'Noida',
                                  'Gurugram',
                                  'Other',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    _districtValue = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: RaisedButton(
                                onPressed: () {
                                  _saveForm();
                                },
                                padding: EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.orange[300],
                                          Colors.orangeAccent,
                                          Colors.orange[300],
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: double.infinity,
                                          minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.save,
                                            color: Colors.black87,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Save Information",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isSubmit = true;
    });
    _formKey.currentState.save();
    ResourceController controller = ResourceController();
    controller.submitForm({
      "time":
          DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now()).toString(),
      "name": nameCont.text.toString().trim(),
      "mobile":
          "${mobCont.text.toString().trim()}, ${altMobileController.text.toString().trim()}",
      "email": emailCont.text.toString().trim(),
      "items": itemCont.text.toString().trim(),
      "quantity": qtyCont.text.toString().trim(),
      "description": infoCont.text.toString().trim(),
      "address": addCont.text.toString().trim(),
      "district": _districtValue,
      "userId": uid,
      "userPhone": uPhone,
    }, (response) {
      print("Response: $response");
      if (response == ResourceController.STATUS_SUCCESS) {
        // Feedback is saved succesfully in Google Sheets.
        _showPopUp("Thank You", false);
        clearFormFields();
        setState(() {
          isSubmit = false;
        });
      } else {
        // Error Occurred while saving data in Google Sheets.
        _showPopUp("Error Occurred!", true);
      }
    });
  }

  _showPopUp(String message, bool error) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 15), () {
            Navigator.of(context).pop(true);
          });
          return Container(
            padding: EdgeInsets.all(15),
            child: Dialog(
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: error
                        ? Text(
                            "Sorry. Something went wrong.\nPlease try again later.",
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "Thanks for providing information.\nThis will help a lot to others.",
                            textAlign: TextAlign.center,
                          ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Ok",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  clearFormFields() {
    nameCont.clear();
    mobCont.clear();
    altMobileController.clear();
    emailCont.clear();
    itemCont.clear();
    qtyCont.clear();
    infoCont.clear();
    addCont.clear();
    dropCont.clear();
  }
}
