import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator',
      home: SIForm(),
      theme: ThemeData(
          primaryColor: Colors.blueAccent,
          primaryColorLight: Colors.blue.shade400,
          primaryColorDark: Colors.blue,
          accentColor: Colors.green.shade300,
          brightness: Brightness.light,
          fontFamily: 'Rajdhani',
          textTheme: TextTheme(
            headline6: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade400,
            ),
            bodyText2: const TextStyle(fontWeight: FontWeight.normal),
          )),
    ),
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIForm_state();
  }
}

class _SIForm_state extends State<SIForm> {
  final _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumpadding = 5.0;
  String? currentlyselecteditem = '';
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentlyselecteditem = _currencies[0];
  }

  TextEditingController principalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  String? display_result = '';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Form(
          //margin: EdgeInsets.all(_minimumpadding * 2),
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(_minimumpadding * 2),
            child: ListView(
              children: [
                getimageasset(),
                Padding(
                  padding: EdgeInsets.all(_minimumpadding * 2),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: principalcontroller,
                    style: textStyle,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please enter valid Principal value";
                      } else if (RegExp(r'^[a-zA-Z&%=]+$').hasMatch(value!)) {
                        return "Please enter valid Principal value";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        hintText: 'Enter Principal e.g 12000',
                        labelStyle: textStyle,
                        errorStyle: const TextStyle(fontSize: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumpadding * 2),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: roicontroller,
                    style: textStyle,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please enter valid Rate of Interest value";
                      } else if (RegExp(r'^[a-zA-Z&%=]+$').hasMatch(value!)) {
                        return "Please enter valid Rate of Interest value";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: 'In Percent',
                        labelStyle: textStyle,
                        errorStyle: const TextStyle(fontSize: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumpadding,
                      bottom: _minimumpadding,
                      left: _minimumpadding * 2,
                      right: _minimumpadding),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: timecontroller,
                        style: textStyle,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Please enter valid Time value in years";
                          } else if (RegExp(r'^[a-zA-Z&%=]+$')
                              .hasMatch(value!)) {
                            return "Please enter valid Time value in years";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Time',
                            hintText: 'In Years',
                            labelStyle: textStyle,
                            errorStyle: const TextStyle(fontSize: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                      )),
                      Container(
                        width: _minimumpadding * 4,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                              value: currentlyselecteditem,
                              items: _currencies.map((String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (String? newvalueSelected) {
                                setState(() {
                                  currentlyselecteditem = newvalueSelected;
                                });
                              })),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(_minimumpadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              child: const Text(
                                'Calculate',
                                textScaleFactor: 1.5,
                              ),
                              style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.all<double>(6.0),
                                    textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
                                    // foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
                                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
                              ),
                              //  textColor: Theme.of(context).primaryColorDark,
                              // elevation: 6.0,
                              // color: Theme.of(context).primaryColorLight,
                              onPressed: () {
                                setState(() {
                                  if (_formkey.currentState?.validate() ??
                                      false) {
                                    display_result = _totalamount();
                                  }
                                });
                              }),
                        ),
                        Expanded(
                          child: ElevatedButton(
                              child: Text(
                                'Reset',
                                textScaleFactor: 1.5,
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( Theme.of(context).accentColor ),
                                textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),

                                // foregroundColor: MaterialStateProperty.all( Theme.of(context).primaryColorDark),
                                elevation: MaterialStateProperty.all<double>(6.0),
                                
                              ),
                              // textColor: Theme.of(context).primaryColorDark,
                              // colorBrightness: Brightness.dark,
                              // elevation: 6.0,
                              // color: Theme.of(context).colorScheme.secondary,
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              }),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumpadding * 2),
                  child: Text(
                    display_result ?? '',
                    style: textStyle,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget getimageasset() {
    AssetImage assetImage = const AssetImage('images/simple_interest.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 120.0,
    );

    return Container(
      margin: const EdgeInsets.all(50.0),
      child: image,
    );
  }

  String? _totalamount() {
    double principal = double.parse(principalcontroller.text);
    double roi = double.parse(roicontroller.text);
    double time = double.parse(timecontroller.text);
    double total = principal + (principal * roi * time) / 100;
    String time1 = '';
    String total1 = '';
    double x = time - time.toInt();
    double y = total - total.toInt();
    // print(x);
    if (x == 0.0) {
      // print("inside if");

      time1 = time.toStringAsFixed(0);
    } else {
      time1 = time.toString();
    }

    if (y == 0.0) {
      total1 = total.toStringAsFixed(0);
    } else {
      total1 = total.toString();
    }

    String? result =
        "After $time1 years your investment will be worth $total1 $currentlyselecteditem";

    return result;
  }

  void _reset() {
    principalcontroller.text = '';
    roicontroller.text = '';
    timecontroller.text = '';

    display_result = '';

    currentlyselecteditem = _currencies[0];
  }
}
