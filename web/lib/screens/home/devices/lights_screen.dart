import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hometech/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LightsScreen extends StatefulWidget {
  const LightsScreen({super.key});

  @override
  State<LightsScreen> createState() => _LightsScreenState();
}

class _LightsScreenState extends State<LightsScreen> {
  late final DatabaseReference _databaseReference;

  bool switch1 = false;
  double slider1 = 0.0;
  bool switch2 = false;
  double slider2 = 0.0;
  bool switch3 = false;
  double slider3 = 0.0;
  bool switch4 = false;
  double slider4 = 0.0;
  // bool switch5 = false;
  // double slider5 = 0.0;

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
                                'Sala principal',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/sala principal.jpeg',
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
                                    'ON / OFF',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Switch(
                                    value: switch1,
                                    onChanged: (value) {
                                      setState(() {
                                        switch1 = value;
                                      });
                                      _stateSwitch1('Main_room', value);
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Intensidad de la luz:',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Slider(
                                    value: slider1,
                                    min: 0.0,
                                    max: 10.0,
                                    onChanged: (value) {
                                      setState(() {
                                        slider1 = value;
                                      });
                                      _stateSlider1('Main_room', value);
                                    },
                                    activeColor: Colors.indigo.shade500,
                                    inactiveColor: Colors.blueGrey[50],
                                    thumbColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    divisions: 10,
                                    label: '${slider1.round()}',
                                  ),
                                ],
                              ),
                            ],
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
                                'Recámara 1',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/recamara 1.jpeg',
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
                                    'ON / OFF',
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                  const SizedBox(width: 15),
                                  Switch(
                                    value: switch2,
                                    onChanged: (value) {
                                      setState(() {
                                        switch2 = value;
                                      });
                                      _stateSwitch2('Room_1', value);
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Intensidad de la luz:',
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                  const SizedBox(height: 5),
                                  Slider(
                                    value: slider2,
                                    min: 0.0,
                                    max: 10.0,
                                    onChanged: (value) {
                                      setState(() {
                                        slider2 = value;
                                      });
                                      _stateSlider2('Room_1', value);
                                    },
                                    activeColor: Colors.indigo.shade500,
                                    inactiveColor: Colors.blueGrey[50],
                                    thumbColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    divisions: 10,
                                    label: '${slider2.round()}',
                                  ),
                                ],
                              ),
                            ],
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
                                'Recámara 2',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/recamara 2.jpeg',
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
                                    'ON / OFF',
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                  const SizedBox(width: 15),
                                  Switch(
                                    value: switch3,
                                    onChanged: (value) {
                                      setState(() {
                                        switch3 = value;
                                      });
                                      _stateSwitch3('Room_2', value);
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
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Intensidad de la luz:',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                      )),
                                  const SizedBox(height: 5),
                                  Slider(
                                    value: slider3,
                                    min: 0.0,
                                    max: 10.0,
                                    onChanged: (value) {
                                      setState(() {
                                        slider3 = value;
                                      });
                                      _stateSlider3('Room_2', value);
                                    },
                                    activeColor: Colors.indigo.shade500,
                                    inactiveColor: Colors.blueGrey[50],
                                    thumbColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    divisions: 10,
                                    label: '${slider3.round()}',
                                  ),
                                ],
                              ),
                            ],
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
                                'Garage',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/garage2.jpeg',
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
                                    'ON / OFF',
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                  const SizedBox(width: 15),
                                  Switch(
                                    value: switch4,
                                    onChanged: (value) {
                                      setState(() {
                                        switch4 = value;
                                      });
                                      _stateSwitch4('Parking', value);
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
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text('Mantener encendido:',
                              //         style: GoogleFonts.poppins(
                              //           fontSize: 15,
                              //         )),
                              //     const SizedBox(
                              //       height: 5,
                              //     ),
                              //     Slider(
                              //       value: slider4,
                              //       min: 0.0,
                              //       max: 10.0,
                              //       onChanged: (value) {
                              //         setState(() {
                              //           slider4 = value;
                              //         });
                              //         _stateSlider4('Kitchen', value);
                              //       },
                              //       activeColor: Colors.indigo.shade500,
                              //       inactiveColor: Colors.blueGrey[50],
                              //       thumbColor:
                              //           Theme.of(context).colorScheme.tertiary,
                              //       divisions: 10,
                              //       label: '${slider4.round()}',
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Container(
              //   padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.tertiaryContainer,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.100),
              //         blurRadius: 10,
              //       )
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding:
              //                 const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   'Patio trasero',
              //                   style: GoogleFonts.poppins(
              //                       fontSize: 18, fontWeight: FontWeight.w300),
              //                 ),
              //                 const SizedBox(height: 10),
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(8),
              //                   child: Image.asset(
              //                     'assets/images/patio 1.jpeg',
              //                     width: 125,
              //                     height: 125,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Row(
              //                   children: [
              //                     Text(
              //                       'ON / OFF',
              //                       style: GoogleFonts.poppins(fontSize: 15),
              //                     ),
              //                     const SizedBox(width: 15),
              //                     Switch(
              //                       value: switch5,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           switch5 = value;
              //                         });
              //                         _stateSwitch5('Backyard', value);
              //                       },
              //                       activeColor:
              //                           Theme.of(context).colorScheme.tertiary,
              //                       activeTrackColor: Colors.indigo.shade400,
              //                       inactiveTrackColor: Colors.transparent,
              //                       inactiveThumbColor: Theme.of(context)
              //                           .colorScheme
              //                           .onSecondary,
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(height: 10),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text('Intensidad de la luz:',
              //                         style: GoogleFonts.poppins(
              //                           fontSize: 15,
              //                         )),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     Slider(
              //                       value: slider5,
              //                       min: 0.0,
              //                       max: 10.0,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           slider5 = value;
              //                         });
              //                         _stateSlider5('Backyard', value);
              //                       },
              //                       activeColor: Colors.indigo.shade500,
              //                       inactiveColor: Colors.blueGrey[50],
              //                       thumbColor:
              //                           Theme.of(context).colorScheme.tertiary,
              //                       divisions: 10,
              //                       label: '${slider5.round()}',
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
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
      //         builder: (context) => const DevicesEditScreen(initialIndex: 1),
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
    } else {
      _loadPreferences();
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      switch1 = prefs.getBool('Devices/Lights/Main_room/state') ?? false;
      slider1 =
          (prefs.getInt('Devices/Lights/Main_room/intensity') ?? 0).toDouble();
      switch2 = prefs.getBool('Devices/Lights/Room_1/state') ?? false;
      slider2 =
          (prefs.getInt('Devices/Lights/Room_1/intensity') ?? 0).toDouble();
      switch3 = prefs.getBool('Devices/Lights/Room_2/state') ?? false;
      slider3 =
          (prefs.getInt('Devices/Lights/Room_2/intensity') ?? 0).toDouble();
      switch4 = prefs.getBool('Devices/Lights/Parking/alwaysOn') ?? false;
    });
  }

  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setInt(key, value.toInt());
    }
  }

  void _loadStateofSandS() {
    _databaseReference.child('Devices/Lights/Main_room/state').onValue.listen(
      (event) {
        final bool stateSw1 = event.snapshot.value == true;
        setState(() {
          switch1 = stateSw1;
        });
      },
    );

    _databaseReference
        .child('Devices/Lights/Main_room/intensity')
        .onValue
        .listen(
      (event) {
        final double stateSl1 = double.parse(event.snapshot.value.toString());
        setState(() {
          slider1 = stateSl1;
        });
      },
    );

    _databaseReference.child('Devices/Lights/Room_1/state').onValue.listen(
      (event) {
        final bool stateSw2 = event.snapshot.value == true;
        setState(() {
          switch2 = stateSw2;
        });
      },
    );

    _databaseReference.child('Devices/Lights/Room_1/intensity').onValue.listen(
      (event) {
        final double stateSl2 = double.parse(event.snapshot.value.toString());
        setState(() {
          slider2 = stateSl2;
        });
      },
    );

    _databaseReference.child('Devices/Lights/Room_2/state').onValue.listen(
      (event) {
        final bool stateSw3 = event.snapshot.value == true;
        setState(() {
          switch3 = stateSw3;
        });
      },
    );

    _databaseReference.child('Devices/Lights/Room_2/intensity').onValue.listen(
      (event) {
        final double stateSl3 = double.parse(event.snapshot.value.toString());
        setState(() {
          slider3 = stateSl3;
        });
      },
    );

    _databaseReference.child('Devices/Lights/Parking/alwaysOn').onValue.listen(
      (event) {
        final bool stateSw4 = event.snapshot.value == true;
        setState(() {
          switch4 = stateSw4;
        });
      },
    );

    // _databaseReference.child('Devices/Lights/Kitchen/intensity').onValue.listen(
    //   (event) {
    //     final double stateSl4 = double.parse(event.snapshot.value.toString());
    //     setState(() {
    //       slider4 = stateSl4;
    //     });
    //   },
    // );

    // _databaseReference.child('Devices/Lights/Backyard/state').onValue.listen(
    //   (event) {
    //     final bool stateSw5 = event.snapshot.value == true;
    //     setState(() {
    //       switch5 = stateSw5;
    //     });
    //   },
    // );
    // _databaseReference.child('Devices/Lights/Backyard/intensity').onValue.listen(
    //   (event) {
    //     final double stateSl5 = double.parse(event.snapshot.value.toString());
    //     setState(() {
    //       slider5 = stateSl5;
    //     });
    //   },
    // );
  }

  void _stateSwitch1(String roomName, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Lights/$roomName/state', value);
      return;
    }
    _databaseReference
        .child('Devices/Lights/$roomName/state')
        .set(value ? true : false);
  }

  void _stateSlider1(String roomName, double value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Lights/$roomName/intensity', value);
      return;
    }
    _databaseReference
        .child('Devices/Lights/$roomName/intensity')
        .set(value.toInt());
  }

  void _stateSwitch2(String roomName, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Lights/$roomName/state', value);
      return;
    }
    _databaseReference
        .child('Devices/Lights/$roomName/state')
        .set(value ? true : false);
  }

  void _stateSlider2(String roomName, double value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Lights/$roomName/intensity', value);
      return;
    }
    _databaseReference
        .child('Devices/Lights/$roomName/intensity')
        .set(value.toInt());
  }

  void _stateSwitch3(String roomName, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Lights/$roomName/state', value);
      return;
    }
    _databaseReference
        .child('Devices/Lights/$roomName/state')
        .set(value ? true : false);
  }

  void _stateSlider3(String roomName, double value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Lights/$roomName/intensity', value);
      return;
    }
    _databaseReference
        .child('Devices/Lights/$roomName/intensity')
        .set(value.toInt());
  }

  void _stateSwitch4(String roomName, bool value) {
    if (AppConfig.isDemoMode) {
      _savePreference('Devices/Lights/$roomName/alwaysOn', value);
      return;
    }
    _databaseReference
        .child('Devices/Lights/$roomName/alwaysOn')
        .set(value ? true : false);
  }

  // void _stateSlider4(String roomName, double value) {
  //   _databaseReference
  //       .child('Devices/Lights/$roomName/intensity')
  //       .set(value.toInt());
  // }

  // void _stateSwitch5(String roomName, bool value) {
  //   _databaseReference
  //       .child('Devices/Lights/$roomName/state')
  //       .set(value ? true : false);
  // }
  // void _stateSlider5(String roomName, double value) {
  //   _databaseReference
  //       .child('Devices/Lights/$roomName/intensity')
  //       .set(value.toInt());
  // }
}
