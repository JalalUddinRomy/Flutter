import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:to_d0_apppp/Models/Product.dart';

class updateproductscreen extends StatefulWidget {
  const updateproductscreen({super.key, required this.product});

  final Product product;

  @override
  State<updateproductscreen> createState() => _updateproductscreenState();
}

class _updateproductscreenState extends State<updateproductscreen> {
  late TextEditingController _productNameTEController = TextEditingController();
  late TextEditingController _totalPriceTEController = TextEditingController();
  late TextEditingController _productImageTEController =
      TextEditingController();
  late TextEditingController _unitPriceTEController = TextEditingController();
  late TextEditingController _productCodeTEController = TextEditingController();
  late TextEditingController _qyantityTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    _productNameTEController = TextEditingController(
      text: widget.product.ProductName,
    );
    _totalPriceTEController = TextEditingController(
      text: widget.product.UnitPrice,
    );
    _productImageTEController = TextEditingController(text: widget.product.Img);
    _unitPriceTEController = TextEditingController(
      text: widget.product.UnitPrice,
    );
    _productCodeTEController = TextEditingController(
      text: widget.product.ProductCode,
    );
    _qyantityTEController = TextEditingController(text: widget.product.Qty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product")),
      body:
          _inProgress
              ? Center(child: CircularProgressIndicator())
              : buildUpdateForm(),
    );
  }

  Widget buildUpdateForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameTEController,
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  labelText: 'Product Name',
                ),
                validator: (String? value) {
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
                validator: (String? value) {
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
                validator: (String? value) {
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
                validator: (String? value) {
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
                validator: (String? value) {
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Valid Value';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(double.maxFinite),
                ),
                onPressed: () {
                  _onTapEditProduct();
                },
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapEditProduct() {
    UpdateProduct();
  }

  Future<void> UpdateProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
      'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}',
    );
    Map<String, dynamic> UpdateBody = {
      "Img": _productImageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _productNameTEController.text,
      "Qty": _qyantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text,
    };
    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(UpdateBody),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      _clearTextField();
      Navigator.pop(context,true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Succesfully")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error!")));
    }
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
