import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geogrcy_firebase/generated_plugin_registrant.dart';
import 'package:geogrcy_firebase/inner_screens/cat_screen.dart';
import 'package:geogrcy_firebase/inner_screens/feeds_screen.dart';
import 'package:geogrcy_firebase/inner_screens/on_sale_screen.dart';
import 'package:geogrcy_firebase/inner_screens/product_details.dart';
import 'package:geogrcy_firebase/provider/cart_provider.dart';
import 'package:geogrcy_firebase/provider/products_provider.dart';
import 'package:geogrcy_firebase/provider/viewed_prod_provider.dart';
import 'package:geogrcy_firebase/provider/wishlist_provider.dart';
import 'package:geogrcy_firebase/screens/auth/forget_pass.dart';
import 'package:geogrcy_firebase/screens/auth/login.dart';
import 'package:geogrcy_firebase/screens/auth/register.dart';
import 'package:geogrcy_firebase/screens/cart/cart_widget.dart';
import 'package:geogrcy_firebase/screens/orders/orders_screen.dart';
import 'package:geogrcy_firebase/screens/viewed_recently/viewed_recently.dart';
import 'package:geogrcy_firebase/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'screens/btm_bar.dart';

void main() {
  final containar = ProviderContainer();
  containar.read(Cart);
  containar.read(product);
  containar.read(ViewedProd);
  containar.read(Wishlist);
  runApp(
    UncontrolledProviderScope(container: containar, child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // return
    // MultiProvider(
    // providers: [
    // ChangeNotifierProvider(create: (_) {
    //   return themeChangeProvider;
    // })
    // ],
    // child:
    // Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: Styles.themeData(themeProvider.getDarkTheme, context),
      home: const BottomBarScreen(),
      // routes: {
      //   OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
      //   FeedsScreen.routeName: (ctx) => const FeedsScreen(),
      //   ProductDetails.routeName: (ctx) => const ProductDetails(),
      //   WishlistScreen.routeName: (ctx) => const WishlistScreen(),
      //   OrdersScreen.routeName: (ctx) => const OrdersScreen(),
      //   ViewedRecentlyScreen.routeName: (ctx) => const ViewedRecentlyScreen(),
      //   RegisterScreen.routeName: (ctx) => const RegisterScreen(),
      //   LoginScreen.routeName: (ctx) => const LoginScreen(),
      //   ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
      //   CategoryScreen.routeName: (ctx) => const CategoryScreen(),
      // }
    );
    //   }),
    // );
  }
}
