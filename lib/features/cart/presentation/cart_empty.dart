import 'package:flutter/material.dart';

class CartEmptyScreen extends StatefulWidget {
  const CartEmptyScreen({Key? key}) : super(key: key);

  @override
  State<CartEmptyScreen> createState() => _CartEmptyScreenState();
}

class _CartEmptyScreenState extends State<CartEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 205, 203, 203),
                  ),
                  child: const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Center(
                        child: Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.white,
                          size: 80,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Whoops',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: Text(
                  'Your cart is empty!',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
