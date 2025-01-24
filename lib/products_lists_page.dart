// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'product_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final List<String> companies = const [
    'All',
    'Adidas',
    'Bata',
    'Service',
    'Nike',
    'Reebok',
    'Puma'
  ];
  int selectedcomapnyindex = 0;

  final searchborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: Colors.black54));

      FirebaseFirestore db=FirebaseFirestore.instance;
      late Stream<QuerySnapshot<Map<String,dynamic>>> dataStream;

      @override
  void initState() {
    super.initState();

    dataStream=db.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Shoes Collecton',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: searchborder,
                    focusedBorder: searchborder,
                    enabledBorder: searchborder,
                  ),
                ))
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedcomapnyindex = index;
                            if(selectedcomapnyindex==0){
                              dataStream=db.collection('products').snapshots();
                            } else {
                              dataStream=db.collection('products').where('company',isEqualTo: companies[selectedcomapnyindex]).snapshots();
                            }
                          });
                        },
                        child: Chip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            backgroundColor: selectedcomapnyindex == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                            label: Text(companies[index])),
                      ));
                },
              ),
            ),
            StreamBuilder(
              stream: dataStream,
              builder: (context, snapshot) {

                if(!snapshot.hasData){
                  return Center(child: Text('Please Wait'), );
                }
                if(snapshot==null || snapshot.data!.docs.isEmpty){
                  return Center(child: Text('No items available'),);
                }
                return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final product= snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ProductDetailPage(product: product.data()))));
                  },
                  child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 3,
                      color: index.isEven ? Colors.blue.shade50 : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['title'],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${product['price']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(child: Image.asset(product['imageUrl']))
                        ],
                      )),
                ),
              );
                },
              );
              },
            )
          ],
              ),
            ),
        ));
  }
}
