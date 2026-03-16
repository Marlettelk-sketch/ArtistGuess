import 'package:flutter/material.dart';
import 'package:artistar_app/accueil.dart';
 
void main() {
  runApp(artistarApp());
}
 
Widget artistarApp() {
  return MaterialApp(
    title: "ARTISTAR",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: AccueilPage(),
  );
}