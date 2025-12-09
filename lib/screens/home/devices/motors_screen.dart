import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hometech/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MotorsScreen extends StatefulWidget {
  const MotorsScreen({super.key});

  @override
  State<MotorsScreen> createState() => _MotorsScreenState();
}

class _MotorsScreenState extends State<MotorsScreen> {
  late final DatabaseReference _databaseReference;

  bool switch1 = false;
  double charge = 0.0;
  late ValueNotifier<double> motorNotifier;

  @override
  void initState() {
    super.initState();
    motorNotifier = ValueNotifier(0.0);
    if (!AppConfig.isDemoMode) {
      _databaseReference = FirebaseDatabase.instance.ref();
      _loadStateofSandS();
    } else {
      _loadPreferences();
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      switch1 = prefs.getBool('Devices/Motors/Garage/state') ?? false;
      if (switch1) {
        // If switched on in another screen, show fully loaded or animate?
        // Let's just set it to 0 or 100 conceptually, but for now just state.
        // The valueNotifier is for animation, we can reset it.
        motorNotifier.value = 0.0;
      }
    });
  }

  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    }
  }

  @override
  void dispose() {
    motorNotifier.dispose();
    super.dispose();
  }

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
                        Expanded(
                          child: Padding(
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
                                        _simulateMotorProgress();
                                        _stateSwitch('Garage', value);
                                      },
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
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
                                    valueNotifier: motorNotifier,
                                    mergeMode: true,
                                    size: 100.0,
                                    onGetText: (double value) {
                                      return Text(
                                        '${value.toInt()}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
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
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Motors/$roomName/state', value);
      return;
    }
    _databaseReference
        .child('Devices')
        .child('Motors')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }

  void _simulateMotorProgress() {
    motorNotifier.value = 0.0;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (motorNotifier.value >= 100) {
        timer.cancel();
      } else {
        motorNotifier.value += 2; // Adjust speed as needed
      }
    });
  }
}
