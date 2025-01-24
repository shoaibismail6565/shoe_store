// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:shoe_store/home_page.dart';
import 'package:flutter/material.dart';

class orderConfirmatiomPage extends StatefulWidget {
  final String name;
  final String mobileNumber;
  final String address;
  final String city;
  const orderConfirmatiomPage(
      {required this.name,
      required this.mobileNumber,
      required this.address,
      required this.city,
      super.key});

  @override
  State<orderConfirmatiomPage> createState() => _orderConfirmatiomPageState();
}

class _orderConfirmatiomPageState extends State<orderConfirmatiomPage> {
  @override
  Widget build(BuildContext context) {
    
    
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => HomePage(), ), (route) => false);
        return Future(() => false);
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(
            20,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Congratulations',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  'Your order ha been placed and will be delivered your city ${widget.city} at the address ${widget.address}within 3-5 working days ',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
      
                    },
                    child: Text(
                      'Go to Home',
                    ),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        backgroundColor: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
