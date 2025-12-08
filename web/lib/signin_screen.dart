import 'package:flutter/material.dart';
import 'package:hometech/services/auth_service.dart';
import 'package:hometech/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hometech/widgets/routes.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback showSignUpScreen;
  const SignInScreen({super.key, required this.showSignUpScreen});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Liberar recursos de los controladores de texto cuando el widget se elimina del árbol de widgets
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    final String? error = validateFields();
    if (error != null) {
      errorMessage(error);
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (error) {
      errorMessage(
          'Hubo un error al iniciar sesión. Por favor, inténtalo de nuevo.');
    }
  }

  String? validateFields() {
    if (emailController.text.isEmpty) {
      return 'Por favor ingresa tu correo electrónico.';
    } else if (!isValidEmail(emailController.text)) {
      return 'El correo electrónico no es válido.';
    }

    if (passwordController.text.isEmpty) {
      return 'Por favor ingresa tu contraseña.';
    } else if (passwordController.text.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }

    return null;
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

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
                    'Bienvenido de nuevo',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 15),
                child: Container(
                  width: 370,
                  // height: 600,
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
                        padding: const EdgeInsets.fromLTRB(0, 30, 175, 0),
                        child: Text(
                          'Inicia sesión',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      buildTextField('Correo', emailController),
                      buildTextFieldWithVisibility(
                          'Contraseña', passwordController),
                      buildElevatedButton('Continuar'),
                      buildRowForNewPass('¿Olvidaste tu contraseña?'),
                      buildText('O continúa con'),
                      buildGoogleSignInButton(),
                      buildRowForSignUp('¿No tienes una cuenta? ', ' Crea una'),
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

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: SizedBox(
        width: 330,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle: GoogleFonts.poppins(),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }

  Widget buildTextFieldWithVisibility(
      String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: SizedBox(
        width: 330,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixIcon: Icon(
              Icons.password_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
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
    );
  }

  Widget buildElevatedButton(String buttonText) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: signIn,
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.delftBlue,
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

  Widget buildRowForNewPass(String text1) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.newpass);
          },
          child: Text(
            text1,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ));
  }

  Widget buildText(String text) {
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

  Widget buildGoogleSignInButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: SizedBox(
        height: 45,
        child: ElevatedButton.icon(
          onPressed: () => AuthService().signInWithGoogle(),
          // El siguiente bloque se utiliza para mostrar alertas, mostrar el icono de carga, mostrar errores, etc
          // onPressed: () async {
          //   try {
          //     await AuthService().signInWithGoogle();
          //     // Navegar a la pantalla principal si el inicio de sesión es exitoso
          //   } catch (e) {
          //     // Manejar el error o mostrar un mensaje al usuario
          //     print(
          //         e); // Considera usar algo más sofisticado en una aplicación real
          //   }
          // },
          icon: Brand(
            Brands.google,
            size: 30,
          ),
          label: Text(
            'Continúa con Google',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget buildRowForSignUp(String text1, String text2) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 25),
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
            onTap: widget.showSignUpScreen,
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
