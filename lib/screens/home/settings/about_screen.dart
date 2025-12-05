import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text(
              'HomeTech',
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              'Versión 1.0.0',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
            Image.asset(
              'assets/images/icon_wbg300x300.png',
              width: 170,
              height: 170,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copyright,
                  size: 18,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
                const SizedBox(width: 5),
                Text(
                  'HomeTech',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Todos los derechos reservados.',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
