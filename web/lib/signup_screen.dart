import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hometech/services/auth_service.dart';
import 'package:hometech/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback showSignInScreen;
  const SignUpScreen({super.key, required this.showSignInScreen});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  // Función para crear la cuenta (TIENE LA VALIDACIÓN DEL NUMERO EXISTENTE)
  Future signUp() async {
    final String? error = validateFields();
    if (error != null) {
      errorMessage(error);
      return;
    }
    final bool phoneInUse = await isPhoneInUse(numberController.text.trim());
    if (phoneInUse) {
      errorMessage(
          'El número telefónico ya está en uso. Por favor, inténtalo con otro.');
      return;
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        await userDetails(
          nameController.text.trim(),
          numberController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
      }
    } catch (error) {
      errorMessage(
          'Hubo un error o el correo ya existe. Por favor, inténtalo de nuevo.');
    }
  }

  // Función para agregar datos en Firestore
  Future userDetails(
      String name, String phone, String email, String password) async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  // VALIDACIONES
  String? validateFields() {
    if (nameController.text.isEmpty) {
      return 'Por favor ingresa un nombre de usuario.';
    }
    if (numberController.text.isEmpty) {
      return 'Por favor ingresa tu número telefónico.';
    } else if (numberController.text.length != 10) {
      return 'El número telefónico debe ser de 10 dígitos.';
    }
    if (emailController.text.isEmpty) {
      return 'Por favor ingresa tu correo electrónico.';
    } else if (!isValidEmail(emailController.text)) {
      return 'El correo electrónico no es válido.';
    }
    if (passwordController.text.isEmpty) {
      return 'Por favor ingresa tu contraseña.';
    } else if (passwordController.text != confirmpasswordController.text) {
      return 'Las contraseñas no coinciden.';
    } else if (passwordController.text.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }
    return null;
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  Future<bool> isPhoneInUse(String phone) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  // ESTILOS PARA MENSAJES DE ERROR
  void errorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: ThemeColors.errorMessage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 20),
                  child: AutoSizeText(
                    'Bienvenido a HomeTech',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                child: Container(
                  width: 370,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.100),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 115, 0),
                        child: Text(
                          'Crea una cuenta',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: SizedBox(
                              width: 330,
                              child: TextField(
                                keyboardType: TextInputType.name,
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Nombre de usuario',
                                  labelStyle: GoogleFonts.poppins(),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: SizedBox(
                              width: 330,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: numberController,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Número telefónico',
                                  labelStyle: GoogleFonts.poppins(),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: SizedBox(
                              width: 330,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Correo electrónico',
                                  labelStyle: GoogleFonts.poppins(),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_rounded,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: SizedBox(
                              width: 330,
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  labelStyle: GoogleFonts.poppins(),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.password_rounded,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                obscureText: _obscureText,
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: SizedBox(
                              width: 330,
                              child: TextField(
                                controller: confirmpasswordController,
                                decoration: InputDecoration(
                                  labelText: 'Confirma la contraseña',
                                  labelStyle: GoogleFonts.poppins(),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.password_rounded,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _obscureText,
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          )
                        ],
                      ),
                      buildElevatedButton('Continuar', ThemeColors.delftBlue),
                      buildText('Puedes continuar con'),
                      buildGoogleSignUpButton(),
                      buildRowForSignIn(
                          '¿Ya tienes una cuenta? ', ' Inicia sesión'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildElevatedButton(String buttonText, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: signUp,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget buildGoogleSignUpButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: SizedBox(
        height: 45,
        child: ElevatedButton.icon(
          onPressed: () => AuthService().signInWithGoogle(),
          icon: Brand(
            Brands.google,
            size: 30,
          ),
          label: Text(
            'Continúa con Google',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget buildRowForSignIn(String text1, String text2) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 17, 0, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          GestureDetector(
            onTap: widget.showSignInScreen,
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
