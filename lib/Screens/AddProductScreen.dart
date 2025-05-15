import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class addNewProduct extends StatefulWidget {
  const addNewProduct({super.key});

  @override
  State<addNewProduct> createState() => _addNewProductState();
}

class _addNewProductState extends State<addNewProduct> {
  final TextEditingController _productNameTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productImageTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _qyantityTEController = TextEditingController();
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add New Product")
      ),
      body: buildProductForm(),
    );
  }

  Widget buildProductForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _Formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameTEController,
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  labelText: 'Product Name',
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Valid Value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitPriceTEController,
                decoration: InputDecoration(
                  hintText: 'Unit Price',
                  labelText: 'Unit Price',
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Valid Value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _totalPriceTEController,
                decoration: InputDecoration(
                  hintText: 'Total Price',
                  labelText: 'Total Price',
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Valid Value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productImageTEController,
                decoration: InputDecoration(
                  hintText: 'Image',
                  labelText: 'Image',
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Valid Value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productCodeTEController,
                decoration: InputDecoration(
                  hintText: 'Product code',
                  labelText: 'Product code',
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Valid Value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qyantityTEController,
                decoration: InputDecoration(
                  hintText: 'Quantity',
                  labelText: 'Quantity',
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Valid Value';
                  }
                  return null;
                },
              ),
              _inProgress
                  ? Center(child: CircularProgressIndicator(),)
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(double.maxFinite)
                ),
                onPressed: () {
                  _onTapAddProduct();
                }, child: Text('Add Product'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTapAddProduct() {
    if (_Formkey.currentState!.validate()) {
      addProductOnProductList();
    }
  }

  Future<void> addProductOnProductList() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String, dynamic> requestBody = {
    "Img":_productImageTEController.text,
    "ProductCode":_productCodeTEController.text,
    "ProductName":_productNameTEController.text,
    "Qty":_qyantityTEController.text,
    "TotalPrice":_totalPriceTEController.text,
    "UnitPrice":_unitPriceTEController.text
  };
    Response response=await post(uri,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(requestBody),);
    print(response);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
    _clearTextField();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Product Added ")));
    }
    _inProgress=false;
    setState(() {});

  }

  void _clearTextField() {
    _unitPriceTEController.clear();
    _totalPriceTEController.clear();
    _qyantityTEController.clear();
    _productNameTEController.clear();
    _productCodeTEController.clear();
    _productImageTEController.clear();
  }

  @override
  void dispose() {
    _qyantityTEController.dispose();
    _productCodeTEController.dispose();
    _productImageTEController.dispose();
    _totalPriceTEController.dispose();
    _unitPriceTEController.dispose();
    _productNameTEController.dispose();
    super.dispose();
  }
}
