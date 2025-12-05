import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometech/themes/theme.dart';
import 'package:hometech/widgets/routes.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final Uri url1 = Uri.parse('https://flutter.dev');
  final Uri url2 = Uri.parse('https://juandelcar.github.io/INTEGRATOR-II/componentes.html');
  final Uri whatsApp = Uri.parse("https://wa.me/+525650783486");
  final Uri email = Uri.parse('mailto:hometech4@gmail.com');
  final Uri url3 = Uri.parse('https://juandelcar.github.io/INTEGRATOR-II/about.html');
  final Uri url4 = Uri.parse('https://juandelcar.github.io/INTEGRATOR-II/index.html');

  var openResult = 'Unknown';
  Future<void> openFile() async {
    final byteData = await rootBundle.load('assets/documents/Manual de usuario.pdf');
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/Manual de usuario.pdf');
    await tempFile.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    final result = await OpenFilex.open(tempFile.path);
    setState(() {
      openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: true,
        title: Text(
          'Soporte y ayuda',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionAccount(
                const EdgeInsets.only(bottom: 10),
                'App',
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, AppRoutes.restorepass);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.100),
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                            height: 60,
                          ),
                          Icon(
                            Icons.lock_person_outlined,
                            size: 25,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Restablece tu contraseña',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  openFile();
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.100),
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                            height: 60,
                          ),
                          Icon(
                            IonIcons.help_circle,
                            size: 28.5,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '¿Cómo usar la app?',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  launchUrl(url2);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.100),
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                            height: 60,
                          ),
                          Icon(
                            IonIcons.list_circle,
                            size: 28.5,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Info. del hardware',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildSectionAccount(
                const EdgeInsets.only(top: 15, bottom: 10),
                'Contactanos',
              ),
              TextButton(
                onPressed: () async {
                  launchUrl(whatsApp);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.100),
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                            height: 60,
                          ),
                          const Icon(
                            IonIcons.logo_whatsapp,
                            size: 25,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'WhatsApp',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  launchUrl(email);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.100),
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                            height: 60,
                          ),
                          Icon(
                            IonIcons.mail,
                            size: 25,
                            color: ThemeColors.errorMessage,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Email',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildSectionAccount(
                const EdgeInsets.only(top: 15, bottom: 10),
                'Más',
              ),
              TextButton(
                onPressed: () async {
                  launchUrl(url3);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      // height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.100),
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                            height: 60,
                          ),
                          Icon(
                            IonIcons.people,
                            size: 25,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Acerca de nosotros',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  launchUrl(url4);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.100),
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                            height: 60,
                          ),
                          Icon(
                            OctIcons.link_external,
                            size: 25,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Nuestra página web',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionAccount(padding, String title) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: GoogleFonts.lexendDeca(
          fontSize: 19,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
