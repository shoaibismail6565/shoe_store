// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:shoe_store/cart_provider.dart';
import 'package:shoe_store/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: context.watch<CartProvider>().cartList.isEmpty ? [] : [
          TextButton(
            onPressed: () {
              context.read<CartProvider>().clearCart();
            },
            child: Text('Clear Cart'),
            style: TextButton.styleFrom(foregroundColor: Colors.black87),
          )
        ],
      ),
      body: context.watch<CartProvider>().cartList.isEmpty
          ? Center(child: Text('Cart is Empty'))
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount:
                            context.watch<CartProvider>().cartList.length,
                        itemBuilder: ((context, index) {
                          final product =
                              context.watch<CartProvider>().cartList[index];

                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction){
                              context
                                  .read<CartProvider>()
                                  .removeProduct(product);
                            },
                            confirmDismiss: (direction) {
                              return showDialog(context: context, builder:(context)=>
                                  AlertDialog(
                                    surfaceTintColor: Colors.transparent,
                                    title: Text('Confirmation'),
                                    content: Text('Do you want to remove product from cart?'),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop(false);
                                      } , child: Text('No'),style: TextButton.styleFrom(foregroundColor: Colors.blue,)),
                                      TextButton(onPressed:  (){
                                        Navigator.of(context).pop(true);
                                        context
                                            .read<CartProvider>()
                                            .removeProduct(product);
                                      }, child: Text('Yes'),style: TextButton.styleFrom(foregroundColor: Colors.red,))
                                    ],
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 6),
                              child: Card(
                                child: ListTile(
                                  title: Text(product['title']),
                                  subtitle: Text('Size : ${product['size']}\n \$${product['price']}'),
                                  leading: Image.asset(
                                    product['imageUrl'],
                                    width: 80,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () { showDialog(context: context, builder:(context)=>
                                        AlertDialog(
                                      surfaceTintColor: Colors.transparent,
                                      title: Text('Confirmation'),
                                      content: Text('Do you want to remove product from cart?'),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        } , child: Text('No'),style: TextButton.styleFrom(foregroundColor: Colors.blue,)),
                                        TextButton(onPressed:  (){
                                          Navigator.of(context).pop();
                                          context
                                              .read<CartProvider>()
                                              .removeProduct(product);
                                        }, child: Text('Yes'),style: TextButton.styleFrom(foregroundColor: Colors.red,))
                                      ],
                                    ));

                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )
                ),
                child: Column(
                  children: [
                    Text('Total : \$${getCartTotal().toStringAsFixed(2)}',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    ElevatedButton.icon(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => CheckOutPage())));
                    }, 
                    icon: Icon(Icons.chevron_right),
                     label: Text('Proceed to Checkout'),
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.black87,backgroundColor: Theme.of(context).colorScheme.primary),
                     ),
                  ],
                  
                ),
              )
              ],
            ),
    );
  }
  double getCartTotal (){
    double total=0;

    final cart= context.read<CartProvider>().cartList;

    cart.forEach((element) {
      total= total + double.parse(element['price'].toString());
    });
    return total;
  }
}
