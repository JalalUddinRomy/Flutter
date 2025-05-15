import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:to_d0_apppp/Models/Product.dart';
import 'package:to_d0_apppp/Screens/AddProductScreen.dart';

import '../Widgets/product_Item.dart';

class Product_ScreenList extends StatefulWidget {
  const Product_ScreenList({super.key});

  @override
  State<Product_ScreenList> createState() => _Product_ScreenListState();
}

class _Product_ScreenListState extends State<Product_ScreenList> {
  List<Product> ProductList=[];
  bool _inprogress=false;
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product list"),
        backgroundColor: Colors.lightGreenAccent,
        actions: [
          IconButton(onPressed: (){
            getProduct();
          }, icon: Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return addNewProduct();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body:_inprogress ?Center(
        child: CircularProgressIndicator(),
      ) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount:ProductList.length,
          itemBuilder: (context, index) {
            return ProductItem(product: ProductList[index],GetProductforUpdate: getProduct, parentcontext: context,);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> getProduct() async {
    _inprogress=true;
    setState(() {});
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response = await get(uri);
    print(response);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      ProductList.clear();
      Map<String, dynamic> jsonlist = jsonDecode(response.body);
      for (var item in jsonlist['data']) {
        Product product = Product(id: item['_id']?? '',
            ProductName: item['ProductName']?? '',
            ProductCode: item['ProductCode']?? '',
            Img: item['Img']?? '',
            UnitPrice: item['UnitPrice']??'',
            Qty: item['Qty']??'',
            TotalPrice:item['TotalPrice']??'',
            CreatedDate: item['CreatedDate']??''
        );
        ProductList.add(product);

      }
    }
    _inprogress=false;
    setState(() {
    });
  }
}
