import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 55, 20, 20),
          child: Container(
            padding: const EdgeInsetsDirectional.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.100),
                  blurRadius: 8,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Términos y Condiciones de HomeTech',
                  style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I. OBJETO',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Estos términos y condiciones regulan el acceso y uso de la aplicación móvil HomeTech, la cual permite monitorear cámaras de video, sensores de movimiento y de gas, y gestionar las fuentes de luz de una casa. Al utilizar la aplicación, el usuario acepta estos términos y condiciones.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'II. USUARIO',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '1. Registro: Para acceder a la aplicación, el usuario debe crear una cuenta proporcionando su nombre completo, dirección de correo electrónico y número de teléfono. La información proporcionada debe ser verídica y actualizada.\n2. Uso Lícito: El usuario se compromete a utilizar la aplicación de manera lícita y respetuosa, cumpliendo con todas las leyes y regulaciones aplicables.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'III. ACCESO Y NAVEGACIÓN',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '1. Disponibilidad: Si bien nos esforzamos por garantizar la disponibilidad y el funcionamiento continuo de la aplicación, no podemos garantizar que esté libre de interrupciones o errores técnicos.\n2. Responsabilidad del Usuario: El usuario es responsable de mantener la confidencialidad de su información de inicio de sesión y de todas las actividades que ocurran bajo su cuenta.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'IV. PRIVACIDAD Y PROTECCIÓN DE DATOS',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '1. Recopilación de Datos: HomeTech recopila y procesa datos personales del usuario para brindarle nuestros servicios. Nos comprometemos a proteger la privacidad y seguridad de estos datos de acuerdo con nuestra Política de Privacidad.\n2. Consentimiento del Usuario: Al utilizar la aplicación, el usuario consiente la recopilación, procesamiento y uso de sus datos personales de acuerdo con nuestra Política de Privacidad.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'V. PROPIEDAD INTELECTUAL',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '1. Derechos de Propiedad: Todos los derechos de propiedad intelectual relacionados con la aplicación, incluidos pero no limitados a los diseños, gráficos, logotipos y software, son propiedad de HomeTech o de sus licenciantes.\n2. Uso Autorizado: El usuario tiene derecho a utilizar la aplicación únicamente para su uso personal y no comercial, de acuerdo con estos términos y condiciones.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'VI. MODIFICACIONES Y TERMINACIÓN',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'HomeTech se reserva el derecho de modificar, suspender o terminar la aplicación en cualquier momento y sin previo aviso. Además, nos reservamos el derecho de modificar estos términos y condiciones en cualquier momento y sin previo aviso.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Última actualización: Lunes, 11 de marzo de 2024.',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
