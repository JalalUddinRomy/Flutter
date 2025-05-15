import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:to_d0_apppp/Models/Product.dart';
import 'package:to_d0_apppp/Screens/UpdateProductScreen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.GetProductforUpdate, required this.parentcontext});
  final Product product;
  final VoidCallback GetProductforUpdate;
  final BuildContext parentcontext;

  @override
  Widget build(BuildContext context) {
    return buildProductListTile(context);
  }

  Widget buildProductListTile(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text("Product Name ${product.ProductName}", style: TextStyle(color: Colors.deepPurple)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Code \$${product.ProductCode}", style: TextStyle(color: Colors.white)),
          Text("Unit Price \$${product.UnitPrice}", style: TextStyle(color: Colors.white)),
          Text("Quantity \$${product.Qty}", style: TextStyle(color: Colors.white)),
          Text("Total Price \$${product.TotalPrice}", style: TextStyle(color: Colors.white)),
          Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return updateproductscreen(product: product,);
                  })).then((updated){
                    if(updated==true){
                      GetProductforUpdate();
                    }
                  });
                },
                label: Text('Edit'),
                icon: Icon(Icons.edit),
              ),
              TextButton.icon(
                onPressed: () {
                  deleteProduct(product.id,parentcontext);
                  GetProductforUpdate();
                },
                label: Text('Delete'),
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> deleteProduct(String ProductId,BuildContext context) async{
    Uri uri=Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$ProductId");
    Response response=await get(uri);
    print(response.statusCode);
    }
}
