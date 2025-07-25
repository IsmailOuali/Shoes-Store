import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/pages/intro_page.dart';
import 'package:store/services/cart_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize cart service
  final cartService = CartService();
  await cartService.loadData();
  
  runApp(MyApp(cartService: cartService));
}

class MyApp extends StatelessWidget {
  final CartService cartService;
  
  const MyApp({super.key, required this.cartService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartService,
      child: MaterialApp(
        title: 'Nike Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          fontFamily: 'SF Pro Display',
        ),
        home: const IntroPage(),
      ),
    );
  }
}