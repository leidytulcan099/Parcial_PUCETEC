import 'package:flutter/material.dart';
import 'RegistrarCuenta.dart'; 

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Registro',
      home: PaginaRegistro(),
    );
  }
}
