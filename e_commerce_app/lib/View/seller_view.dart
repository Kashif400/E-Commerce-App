import 'package:flutter/material.dart';

class SellerView extends StatefulWidget {
  const SellerView({super.key});

  @override
  State<SellerView> createState() => _SellerViewState();
}

class _SellerViewState extends State<SellerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Seller Account'),
      ),
    );
  }
}
