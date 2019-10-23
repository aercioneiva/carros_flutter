import 'package:carros_app/pages/favoritos/favoritos_bloc.dart';
import 'package:carros_app/splash_page.dart';
import 'package:carros_app/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          builder: (context) => FavoritosBloc(),
          dispose: (context,bloc) => bloc.dispose(),
        ),
        Provider<EventBus>(
          builder: (context) => EventBus(),
          dispose: (context,bus) => bus.dispose(),
        ),
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white
        ),
        home: SplashPage(),
      ),
    );
  }
}