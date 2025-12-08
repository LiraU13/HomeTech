import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometech/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Getter to avoid eager initialization on Web
  DatabaseReference get _databaseReference => FirebaseDatabase.instance.ref();
  bool switchT = false;
  bool switchG = false;
  bool switchSM = false;
  bool switchSG = false;
  bool switchSP = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: true,
        title: Text(
          'Notificaciones',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionApp('General'),
            buildAllNotificationsButton(),
            buildMotorNotificationsButton(),
            buildSensor1NotificationsButton(),
            buildSensor2NotificationsButton(),
            buildSensor3NotificationsButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: ThemeColors.delftBlue,
      //   onPressed: () {},
      //   child: const Icon(
      //     Clarity.notification_solid_badged,
      //     color: Colors.white,
      //     size: 25,
      //   ),
      // ),
    );
  }

  Widget buildSectionApp(String title) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
      child: Text(
        title,
        style: GoogleFonts.lexendDeca(
          fontSize: 19,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }

  Widget buildAllNotificationsButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
      child: InkWell(
        onTap: null,
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.100),
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.circle_notifications_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 32,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Todo',
                    style: GoogleFonts.lexendDeca(fontSize: 17),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Switch(
                      value: switchT,
                      onChanged: (value) {
                        setState(() {
                          switchT = value;
                          switchG = value;
                          switchSM = value;
                          switchSG = value;
                          switchSP = value;
                        });
                        _notificationSwitch('Notifications/General', value);
                        _notificationSwitch('Notifications/Garage', value);
                        _notificationSwitch('Notifications/Movement', value);
                        _notificationSwitch('Notifications/Gas', value);
                        _notificationSwitch('Notifications/Proximity', value);
                      },
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      activeTrackColor: Colors.indigo.shade400,
                      inactiveTrackColor: Colors.transparent,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMotorNotificationsButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
      child: InkWell(
        onTap: null,
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.100),
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.notifications_on_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Portón',
                    style: GoogleFonts.lexendDeca(fontSize: 17),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Switch(
                      value: switchG,
                      onChanged: (value) {
                        setState(() {
                          switchG = value;
                        });
                        _notificationSwitch('Notifications/Garage', value);
                      },
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      activeTrackColor: Colors.indigo.shade400,
                      inactiveTrackColor: Colors.transparent,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSensor1NotificationsButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
      child: InkWell(
        onTap: null,
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.100),
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.notifications_on_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Sensor de Movimiento',
                    style: GoogleFonts.lexendDeca(fontSize: 17),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Switch(
                      value: switchSM,
                      onChanged: (value) {
                        setState(() {
                          switchSM = value;
                        });
                        _notificationSwitch('Notifications/Movement', value);
                      },
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      activeTrackColor: Colors.indigo.shade400,
                      inactiveTrackColor: Colors.transparent,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSensor2NotificationsButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
      child: InkWell(
        onTap: null,
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.100),
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.notifications_on_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Sensor de Gas',
                    style: GoogleFonts.lexendDeca(fontSize: 17),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Switch(
                      value: switchSG,
                      onChanged: (value) {
                        setState(() {
                          switchSG = value;
                        });
                        _notificationSwitch('Notifications/Gas', value);
                      },
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      activeTrackColor: Colors.indigo.shade400,
                      inactiveTrackColor: Colors.transparent,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSensor3NotificationsButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
      child: InkWell(
        onTap: null,
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.100),
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.notifications_on_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Sensor de Proximidad',
                    style: GoogleFonts.lexendDeca(fontSize: 17),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Switch(
                      value: switchSP,
                      onChanged: (value) {
                        setState(() {
                          switchSP = value;
                        });
                        _notificationSwitch('Notifications/Proximity', value);
                      },
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      activeTrackColor: Colors.indigo.shade400,
                      inactiveTrackColor: Colors.transparent,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (!AppConfig.isDemoMode) {
      _loadNotifications();
    } else {
      _loadPreferences();
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      switchT = prefs.getBool('Notifications/General') ?? false;
      switchG = prefs.getBool('Notifications/Garage') ?? false;
      switchSM = prefs.getBool('Notifications/Movement') ?? false;
      switchSG = prefs.getBool('Notifications/Gas') ?? false;
      switchSP = prefs.getBool('Notifications/Proximity') ?? false;
    });
  }

  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  void _loadNotifications() {
    // kIsWeb check removed as it is handled in initState
    _databaseReference.child('Notifications/General').onValue.listen(
      (event) {
        final bool stateNT = event.snapshot.value == true;
        setState(() {
          switchT = stateNT;
        });
      },
    );

    _databaseReference.child('Notifications/Garage').onValue.listen(
      (event) {
        final bool stateNG = event.snapshot.value == true;
        setState(() {
          switchG = stateNG;
        });
      },
    );

    _databaseReference.child('Notifications/Movement').onValue.listen(
      (event) {
        final bool stateNSM = event.snapshot.value == true;
        setState(() {
          switchSM = stateNSM;
        });
      },
    );

    _databaseReference.child('Notifications/Gas').onValue.listen(
      (event) {
        final bool stateNSG = event.snapshot.value == true;
        setState(() {
          switchSG = stateNSG;
        });
      },
    );

    _databaseReference.child('Notifications/Proximity').onValue.listen(
      (event) {
        final bool stateNSP = event.snapshot.value == true;
        setState(() {
          switchSP = stateNSP;
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
}
