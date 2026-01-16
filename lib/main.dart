import 'package:flutter/material.dart';
import 'ViewModel/home_viewmodel.dart';
import 'view/home_page.dart';
import 'view/order_summary_page.dart';

void main() {
  runApp(BarApp());
}

class BarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar MVVM',
      debugShowCheckedModeBanner: false,
      routes: {
        '/resumen': (context) => OrderSummaryPage(),
      },
      home: HomePage(viewModel: HomeViewModel()),
    );
  }
}
