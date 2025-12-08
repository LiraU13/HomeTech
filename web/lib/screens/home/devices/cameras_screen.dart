import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CamerasScreen extends StatefulWidget {
  const CamerasScreen({super.key});

  @override
  State<CamerasScreen> createState() => _CamerasScreenState();
}

class _CamerasScreenState extends State<CamerasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Puerta principal',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        // const SizedBox(height: 20)  ESPACIO ENTRE LA IMAGEN DE LA CAMARA Y EL TEXTO
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.fullscreen),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.broadcast_on_home_rounded),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sala principal',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        // const SizedBox(height: 20)  ESPACIO ENTRE LA IMAGEN DE LA CAMARA Y EL TEXTO
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.fullscreen),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.broadcast_on_home_rounded),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Habitación 1',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        // const SizedBox(height: 20)  ESPACIO ENTRE LA IMAGEN DE LA CAMARA Y EL TEXTO
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.fullscreen),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.broadcast_on_home_rounded),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Habitación 2',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        // const SizedBox(height: 20)  ESPACIO ENTRE LA IMAGEN DE LA CAMARA Y EL TEXTO
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.fullscreen),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.broadcast_on_home_rounded),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Patio',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        // const SizedBox(height: 20)  ESPACIO ENTRE LA IMAGEN DE LA CAMARA Y EL TEXTO
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.fullscreen),
                          onPressed: () {
                            // maximizar pantalla
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.broadcast_on_home_rounded),
                          onPressed: () {
                            // transmitir
                          },
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: ThemeColors.delftBlue,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const DevicesEditScreen(initialIndex: 0),
      //       ),
      //     );
      //   },
      //   child: const Icon(OctIcons.pencil, color: Colors.white, size: 25),
      // ),
    );
  }
}
