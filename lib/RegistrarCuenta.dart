import 'package:flutter/material.dart';

class PaginaRegistro extends StatefulWidget {
  @override
  _EstadoPaginaRegistro createState() => _EstadoPaginaRegistro();
}

class _EstadoPaginaRegistro extends State<PaginaRegistro> {
  // Controladores
  TextEditingController controladorCedula = TextEditingController();
  TextEditingController controladorCorreo = TextEditingController();
  TextEditingController controladorContrasena = TextEditingController();

  // Mensajes de error
  String mensajeErrorCedula = '';
  String mensajeErrorCorreo = '';
  String mensajeErrorContrasena = '';

  // Colores
  Color colorCedula = Colors.black;
  Color colorCorreo = Colors.black;
  Color colorContrasena = Colors.black;

 
  void validarCedula() {
    String cedula = controladorCedula.text;
    mensajeErrorCedula = '';
    colorCedula = Colors.black;

   
    if (cedula.length > 10) {
      mensajeErrorCedula = 'El numero de cedula esta incorrecta';
      colorCedula = Colors.red;
      return;
    }

    
    if (cedula.length >= 3) {
      int tercerDigito = int.tryParse(cedula[2]) ?? -1;
      if (tercerDigito >= 6) {
        mensajeErrorCedula = ' El numero de cedula esta incorrecta';
        colorCedula = Colors.red;
        return;
      }
    }

    
    if (cedula.length == 10) {
      int digitoVerificador = int.tryParse(cedula[9]) ?? -1;
      if (!_validarModulo10(cedula.substring(0, 9), digitoVerificador)) {
        mensajeErrorCedula = 'El numero de cedula esta incorrecta';
        colorCedula = Colors.red;
        return;
      }
    }
  }

  bool _validarModulo10(String primerosNueve, int digitoVerificador) {
    int suma = 0;
    for (int i = 0; i < 9; i++) {
      int digito = int.tryParse(primerosNueve[i]) ?? 0;
      if (i % 2 == 0) {
       
        digito *= 2;
        if (digito >= 10) digito -= 9;
      }
      
      suma += digito;
    }
    int ultimoDigitoSuma = suma % 10;
    int verificadorCalculado = (10 - ultimoDigitoSuma) % 10;
    return verificadorCalculado == digitoVerificador;
  }

  
  void validarCorreo() {
    String correo = controladorCorreo.text;
    mensajeErrorCorreo = '';
    colorCorreo = Colors.black;

    if (!RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$').hasMatch(correo)) {
      mensajeErrorCorreo = '• El correo no tiene un formato válido';
      colorCorreo = Colors.red;
    }
  }

 
  void validarContrasena() {
    String contrasena = controladorContrasena.text;
    mensajeErrorContrasena = '';
    colorContrasena = Colors.black;

    if (!contrasena.contains(RegExp(r'[A-Z]'))) {
      mensajeErrorContrasena = '• Debe tener al menos una letra mayúscula';
      colorContrasena = Colors.red;
    } else if (!contrasena.contains(RegExp(r'[0-9]'))) {
      mensajeErrorContrasena = '• Debe tener al menos un número';
      colorContrasena = Colors.red;
    } else if (!contrasena.contains(RegExp(r'[!@#\$&*~%^]'))) {
      mensajeErrorContrasena = '• Debe tener al menos un carácter especial';
      colorContrasena = Colors.red;
    } else if (contrasena.contains(' ')) {
      mensajeErrorContrasena = '• No debe tener espacios en blanco';
      colorContrasena = Colors.red;
    } else if (!contrasena.toLowerCase().contains('pucetec')) {
      mensajeErrorContrasena = '• Debe contener la secuencia "pucetec"';
      colorContrasena = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           

            TextField(
              controller: controladorCedula,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cédula de identidad',
                labelStyle: TextStyle(color: colorCedula),
              ),
              style: TextStyle(color: colorCedula),
            ),
            if (mensajeErrorCedula.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  mensajeErrorCedula,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 16),

            

            TextField(
              controller: controladorCorreo,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(color: colorCorreo),
              ),
              style: TextStyle(color: colorCorreo),
            ),
            if (mensajeErrorCorreo.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  mensajeErrorCorreo,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 16),

            

            Text(
              'La contraseña debe cumplir con:\n'
              '• Al menos una letra mayúscula\n'
              '• Al menos un número\n'
              '• Al menos un carácter especial (!@#\$&*~%^)\n'
              '• No tener espacios en blanco\n'
              '• Contener la secuencia "pucetec"',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 16),

            

            TextField(
              controller: controladorContrasena,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: colorContrasena),
              ),
              style: TextStyle(color: colorContrasena),
            ),
            if (mensajeErrorContrasena.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  mensajeErrorContrasena,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 32),

            
            Center(
              child: ElevatedButton(
                onPressed: () {
                  
                  validarCedula();
                  validarCorreo();
                  validarContrasena();

                  setState(() {});

                  if (mensajeErrorCedula.isEmpty &&
                      mensajeErrorCorreo.isEmpty &&
                      mensajeErrorContrasena.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cuenta creada (simulado)')),
                    );
                    print('Cédula: ${controladorCedula.text}');
                    print('Correo: ${controladorCorreo.text}');
                    print('Contraseña: ${controladorContrasena.text}');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Hay errores en los campos')),
                    );
                  }
                },
                child: Text('Crear Cuenta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

