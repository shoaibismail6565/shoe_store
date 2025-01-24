// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:shoe_store/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_page.dart';
import 'products_lists_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final pages = [ProductsListPage(),CartPage()];
int currentpageindex= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentpageindex,
        onDestinationSelected: (value) {
          setState(() {
            currentpageindex=value;
          });
        },
        destinations: [
        NavigationDestination(icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.home,),
        ),label: 'Home'),
        NavigationDestination(icon: Container(
child: Stack(
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(Icons.shopping_cart,),
    ),
    Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: 18,
        width: 18,
    
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(child: Text(context.watch<CartProvider>().cartList.length.toString(),style: TextStyle(color: Colors.white),)),
      ),
    )
  ],
),

        ),label: 'Cart'),
       ],
       ),
       body: pages[currentpageindex],
    );
  }
}