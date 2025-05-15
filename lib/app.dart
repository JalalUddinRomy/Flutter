import 'package:flutter/material.dart';

import 'Screens/ProductScreen.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Product_ScreenList(),
    );
  }
}
