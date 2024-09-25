import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/providers/counter_provider.dart';
import 'package:provider_example/providers/user_provider.dart';
import 'package:provider_example/screens/home_screen.dart';

void main(){
runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (context)=>CounterProvider()),
  ChangeNotifierProvider(create: (context)=>PostProvider()),
],
    child: (const MyApp()),
),);

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
