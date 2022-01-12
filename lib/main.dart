import 'package:flutter/material.dart';
import 'constants/color.dart';
import '../presentation/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF808080),),
      ),
      onGenerateRoute: (settings) {
        for (var route in ROUTES) {
          if (route.matches(settings)) {
            return route.build(settings);
          }
        }
        return ROUTES.first.build( const RouteSettings(name: '/'));
      },
    );
  }
}
