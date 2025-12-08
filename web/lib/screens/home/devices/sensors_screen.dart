import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hometech/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  late final DatabaseReference _databaseReference;

  bool switch1M = false;
  bool switch2MN = false;
  bool switch1G = false;
  bool switch2GN = false;
  bool switch1P = false;
  bool switch2PN = false;

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
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
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
                                'Movimiento',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/sensor m1.jpeg',
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
                                      'ON / OFF',
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ),
                                    const SizedBox(width: 15),
                                    Switch(
                                      value: switch1M,
                                      onChanged: (value) {
                                        setState(() {
                                          switch1M = value;
                                        });
                                        _stateSwitchM1('Movement', value);
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
                                Row(
                                  children: [
                                    Text(
                                      'Notificaciones',
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ),
                                    const SizedBox(width: 15),
                                    Switch(
                                      value: switch2MN,
                                      onChanged: (value) {
                                        setState(() {
                                          switch2MN = value;
                                        });
                                        _notificationSwitch(
                                            'Notifications/Movement', value);
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
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
                                'Gas',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/sensor g2.jpeg',
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
                                    // No debería tener ON/OFF el sensor de gas?
                                    Text('ON / OFF',
                                        style:
                                            GoogleFonts.poppins(fontSize: 15)),
                                    const SizedBox(width: 15),
                                    Switch(
                                      value: switch1G,
                                      onChanged: (value) {
                                        setState(() {
                                          switch1G = value;
                                        });
                                        _stateSwitchG1('Gas', value);
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
                                Row(
                                  children: [
                                    Text(
                                      'Notificaciones',
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ),
                                    const SizedBox(width: 15),
                                    Switch(
                                      value: switch2GN,
                                      onChanged: (value) {
                                        setState(() {
                                          switch2GN = value;
                                        });
                                        _notificationSwitch(
                                            'Notifications/Gas', value);
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
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
                                'Proximidad',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/sensor p1.jpeg',
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
                                    // No debería tener ON/OFF el sensor de gas?
                                    Text('ON / OFF',
                                        style:
                                            GoogleFonts.poppins(fontSize: 15)),
                                    const SizedBox(width: 15),
                                    Switch(
                                      value: switch1P,
                                      onChanged: (value) {
                                        setState(() {
                                          switch1P = value;
                                        });
                                        _stateSwitchP1('Proximity', value);
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
                                Row(
                                  children: [
                                    Text(
                                      'Notificaciones',
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ),
                                    const SizedBox(width: 15),
                                    Switch(
                                      value: switch2PN,
                                      onChanged: (value) {
                                        setState(() {
                                          switch2PN = value;
                                        });
                                        _notificationSwitch(
                                            'Notifications/Proximity', value);
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
      //         builder: (context) => const DevicesEditScreen(initialIndex: 2),
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
      _loadNotifications();
    } else {
      _loadPreferences();
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      switch1M = prefs.getBool('Devices/Sensors/Movement/state') ?? false;
      switch1G = prefs.getBool('Devices/Sensors/Gas/state') ?? false;
      switch1P = prefs.getBool('Devices/Sensors/Proximity/state') ?? false;

      switch2MN = prefs.getBool('Notifications/Movement') ?? false;
      switch2GN = prefs.getBool('Notifications/Gas') ?? false;
      switch2PN = prefs.getBool('Notifications/Proximity') ?? false;
    });
  }

  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    }
  }

  void _loadNotifications() {
    _databaseReference.child('Notifications/Movement').onValue.listen(
      (event) {
        final bool stateMN = event.snapshot.value == true;
        setState(() {
          switch2MN = stateMN;
        });
      },
    );

    _databaseReference.child('Notifications/Gas').onValue.listen(
      (event) {
        final bool stateGN = event.snapshot.value == true;
        setState(() {
          switch2GN = stateGN;
        });
      },
    );

    _databaseReference.child('Notifications/Proximity').onValue.listen(
      (event) {
        final bool statePN = event.snapshot.value == true;
        setState(() {
          switch2PN = statePN;
        });
      },
    );
  }

  void _notificationSwitch(String section, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference(section, value);
      return;
    }
    _databaseReference.child(section).set(value);
  }

  void _loadStateofSandS() {
    _databaseReference.child('Devices/Sensors/Movement/state').onValue.listen(
      (event) {
        final bool stateSM1 = event.snapshot.value == true;
        setState(() {
          switch1M = stateSM1;
        });
      },
    );

    _databaseReference.child('Devices/Sensors/Gas/state').onValue.listen(
      (event) {
        final bool stateSG1 = event.snapshot.value == true;
        setState(() {
          switch1G = stateSG1;
        });
      },
    );

    _databaseReference.child('Devices/Sensors/Proximity/state').onValue.listen(
      (event) {
        final bool stateSP1 = event.snapshot.value == true;
        setState(() {
          switch1P = stateSP1;
        });
      },
    );
  }

  void _stateSwitchM1(String roomName, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Sensors/$roomName/state', value);
      return;
    }
    _databaseReference
        .child('Devices')
        .child('Sensors')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }

  void _stateSwitchG1(String roomName, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Sensors/$roomName/state', value);
      return;
    }
    _databaseReference
        .child('Devices')
        .child('Sensors')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }

  void _stateSwitchP1(String roomName, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Sensors/$roomName/state', value);
      return;
    }
    _databaseReference
        .child('Devices')
        .child('Sensors')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }
}
