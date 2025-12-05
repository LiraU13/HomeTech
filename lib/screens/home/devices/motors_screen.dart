import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hometech/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class MotorsScreen extends StatefulWidget {
  const MotorsScreen({super.key});

  @override
  State<MotorsScreen> createState() => _MotorsScreenState();
}

class _MotorsScreenState extends State<MotorsScreen> {
  late final DatabaseReference _databaseReference;

  bool switch1 = false;
  double charge = 0.0;

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
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.100),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Portón',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/garage3.jpeg',
                                  width: 125,
                                  height: 125,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Abrir / Cerrar',
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                  const SizedBox(width: 15),
                                  Switch(
                                    value: switch1,
                                    onChanged: (value) {
                                      setState(() {
                                        switch1 = value;
                                      });
                                      _stateSwitch('Garage', value);
                                    },
                                    activeColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    activeTrackColor: Colors.indigo.shade400,
                                    inactiveTrackColor: Colors.transparent,
                                    inactiveThumbColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Carga:',
                                style: GoogleFonts.poppins(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 85),
                                child: SimpleCircularProgressBar(
                                  valueNotifier: null,
                                  mergeMode: true,
                                  size: 100.0,
                                  onGetText: (double value) {
                                    return Text(
                                      '${value.toInt()}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
      //         builder: (context) => const DevicesEditScreen(initialIndex: 3),
      //       ),
      //     );
      //   },
      //   child: const Icon(OctIcons.pencil, color: Colors.white, size: 25),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (!AppConfig.isDemoMode) {
      _databaseReference = FirebaseDatabase.instance.ref();
      _loadStateofSandS();
    }
  }

  void _loadStateofSandS() {
    _databaseReference.child('Devices/Motors/Garage/state').onValue.listen(
      (event) {
        final bool stateS1 = event.snapshot.value == true;
        setState(() {
          switch1 = stateS1;
        });
      },
    );
  }

  void _stateSwitch(String roomName, bool value) {
    if (AppConfig.isDemoMode) return;
    _databaseReference
        .child('Devices')
        .child('Motors')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }
}
