// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({required this.product, super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedsizeindex = 0;
  @override
  Widget build(BuildContext context) {
    final sizes = widget.product['sizes'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Image.asset(widget.product['imageUrl']),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
              children: [
                Text(
                  '\$${widget.product['price']}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: sizes.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedsizeindex = index;
                              });
                            },
                            child: Chip(
                                backgroundColor: selectedsizeindex == index
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                                label: Text(sizes[index].toString())),
                          ));
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    widget.product['size']=sizes[selectedsizeindex];
                    context.read<CartProvider>().addProduct(widget.product);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: Text('Add To Cart'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.black87,
                      minimumSize: Size(double.infinity, 50)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
