import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class SensorsEditScreen extends StatefulWidget {
  const SensorsEditScreen({super.key});

  @override
  State<SensorsEditScreen> createState() => _SensorsEditScreenState();
}

class _SensorsEditScreenState extends State<SensorsEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                height: 65,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.100),
                      blurRadius: 5,
                      offset: const Offset(3, 3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Movimiento',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            ZondIcons.reload,
                            color: Colors.green,
                            size: 25,
                          ),
                          onPressed: () {
                            // Reiniciar el dispositivo
                          },
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(
                            OctIcons.trash,
                            color: Colors.red,
                            size: 25,
                          ),
                          onPressed: () {
                            // Eliminar el dispositivo
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                //  const SizedBox(height: 20) // ESPACIO ENTRE LA IMAGEN DE LA CAMARA Y EL TEXTO
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                height: 65,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.100),
                      blurRadius: 5,
                      offset: const Offset(3, 3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gas',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            ZondIcons.reload,
                            color: Colors.green,
                            size: 25,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(
                            OctIcons.trash,
                            color: Colors.red,
                            size: 25,
                          ),
                          onPressed: () {},
                        ),
                      ],
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
}
