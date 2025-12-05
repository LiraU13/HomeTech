import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometech/screens/home/devices_screen.dart';
import 'package:hometech/widgets/routes.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:hometech/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DatabaseReference _databaseReference;
  // Luces
  bool switch1 = false;
  double slider1 = 0.0;
  // Motor
  bool switch2 = false;
  // Sensores
  bool switch3 = false;
  bool switch3N = false;

  int selectedIndex = 0;
  List screens = const [
    AppRoutes.home,
    AppRoutes.devices,
    AppRoutes.settings,
  ];
  openScreen(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, AppRoutes.home);
          break;
        case 1:
          Navigator.pushNamed(context, AppRoutes.devices);
          break;
        case 2:
          Navigator.pushNamed(context, AppRoutes.settings);
          break;
      }
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Inicio',
          style: GoogleFonts.poppins(
            fontSize: 35,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Accesos directos',
                style: GoogleFonts.lexendDeca(fontSize: 22),
              ),
              const SizedBox(height: 30),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Luces',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_right),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DevicesScreen(initialIndex: 1),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/sala principal.jpeg',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sala principal',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                              Row(
                                children: [
                                  Text('ON / OFF',
                                      style: GoogleFonts.poppins(fontSize: 15)),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: switch1,
                                    onChanged: (value) {
                                      setState(() {
                                        switch1 = value;
                                      });
                                      _stateSwitchLight('Main_room', value);
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
                              const SizedBox(height: 8),
                              Text('Intensidad',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                  )),
                              Slider(
                                value: slider1,
                                min: 0.0,
                                max: 10.0,
                                onChanged: (value) {
                                  setState(() {
                                    slider1 = value;
                                  });
                                  _stateSliderLight('Main_room', value);
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cámaras',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_circle_right,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DevicesScreen(initialIndex: 0),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            // cambiar de camara
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            // cambiar de camara
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Motores',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_right),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DevicesScreen(initialIndex: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/garage3.jpeg',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Portón',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                              Row(
                                children: [
                                  Text('Abrir / Cerrar',
                                      style: GoogleFonts.poppins(fontSize: 15)),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: switch2,
                                    onChanged: (value) {
                                      setState(() {
                                        switch2 = value;
                                      });
                                      _stateSwitchMotor('Garage', value);
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
                              Row(children: [
                                Text('Carga:',
                                    style: GoogleFonts.poppins(fontSize: 15)),
                                const SizedBox(width: 30),
                                SimpleCircularProgressBar(
                                  valueNotifier: null,
                                  mergeMode: true,
                                  size: 60.0,
                                  progressStrokeWidth: 10.0,
                                  onGetText: (double value) {
                                    return Text(
                                      '${value.toInt()}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sensores',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_right),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DevicesScreen(initialIndex: 3),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/sensor m1.jpeg',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sensor de movimiento',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                              Row(
                                children: [
                                  Text('ON / OFF',
                                      style: GoogleFonts.poppins(fontSize: 15)),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: switch3,
                                    onChanged: (value) {
                                      setState(() {
                                        switch3 = value;
                                      });
                                      _stateSwitchSensor('Movement', value);
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
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text('Notificaciones',
                                      style: GoogleFonts.poppins(fontSize: 15)),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: switch3N,
                                    onChanged: (value) {
                                      setState(() {
                                        switch3N = value;
                                      });
                                      _notificationSwitch(
                                          'Notifications/Movement', value);
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
        onTap: (index) => openScreen(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_other),
            label: 'Dispositivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (!AppConfig.isDemoMode) {
      _databaseReference = FirebaseDatabase.instance.ref();
      _loadStateofSandS();
      _loadNotifications();
    }
  }

  void _loadNotifications() {
    _databaseReference.child('Notifications/Movement').onValue.listen(
      (event) {
        final bool stateMN = event.snapshot.value == true;
        setState(() {
          switch3N = stateMN;
        });
      },
    );
  }

  void _notificationSwitch(String section, bool value) {
    if (AppConfig.isDemoMode) return;
    _databaseReference.child(section).set(value);
  }

  void _loadStateofSandS() {
    _databaseReference.child('Devices/Lights/Main_room/state').onValue.listen(
      (event) {
        final bool stateS1 = event.snapshot.value == true;
        setState(() {
          switch1 = stateS1;
        });
      },
    );

    _databaseReference
        .child('Devices/Lights/Main_room/intensity')
        .onValue
        .listen(
      (event) {
        final double sliderS1 = double.parse(event.snapshot.value.toString());
        setState(() {
          slider1 = sliderS1;
        });
      },
    );

    _databaseReference.child('Devices/Motors/Garage/state').onValue.listen(
      (event) {
        final bool stateS2 = event.snapshot.value == true;
        setState(() {
          switch2 = stateS2;
        });
      },
    );

    _databaseReference.child('Devices/Sensors/Movement/state').onValue.listen(
      (event) {
        final bool stateS3 = event.snapshot.value == true;
        setState(() {
          switch3 = stateS3;
        });
      },
    );
  }

  void _stateSwitchLight(String roomName, bool value) {
    if (AppConfig.isDemoMode) return;
    _databaseReference
        .child('Devices')
        .child('Lights')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }

  void _stateSliderLight(String roomName, double value) {
    if (AppConfig.isDemoMode) return;
    _databaseReference
        .child('Devices')
        .child('Lights')
        .child(roomName)
        .child('intensity')
        .set(value.toInt());
  }

  void _stateSwitchMotor(String roomName, bool value) {
    if (AppConfig.isDemoMode) return;
    _databaseReference
        .child('Devices')
        .child('Motors')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }

  void _stateSwitchSensor(String roomName, bool value) {
    if (AppConfig.isDemoMode) return;
    _databaseReference
        .child('Devices')
        .child('Sensors')
        .child(roomName)
        .child('state')
        .set(value ? true : false);
  }
}
