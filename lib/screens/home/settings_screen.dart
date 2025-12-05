import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometech/main.dart';
import 'package:hometech/themes/theme.dart';
import 'package:hometech/widgets/routes.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:hometech/themes/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool valswitch1 = false;

  int selectedIndex = 2;
  List<String> screenRoutes = [
    AppRoutes.home,
    AppRoutes.devices,
    AppRoutes.settings,
    AppRoutes.introduction,
  ];
  void openScreen(int index) {
    Navigator.pushNamed(context, screenRoutes[index]);
    setState(() => selectedIndex = index);
  }

  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;
  String? name;
  String? email;
  String? number;
  String? photo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData(); // Asegúrate de que getData() maneje correctamente los estados de carga y error.
  }

  @override
  void initState() {
    super.initState();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      valswitch1 =
          Provider.of<ThemeProvider>(context, listen: false).themeData ==
              darkMode;
    });
  }

  // Obtener los datos de Firestore y Firebase Auth (IGUAL DATOS DE CUENTAS DE GOOGLE)
  Future<void> getData() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        uid = user.uid;
        final DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'];
            email = userDoc['email'];
            number = userDoc['phone'];
          });
        } else {
          if (user.providerData
              .any((profile) => profile.providerId == 'google.com')) {
            final googleUser = user.providerData
                .firstWhere((profile) => profile.providerId == 'google.com');
            setState(() {
              name = googleUser.displayName ?? 'HomeTech';
              email = googleUser.email ?? '';
              photo = googleUser.photoURL ??
                  'https://firebasestorage.googleapis.com/v0/b/hometech-a45da.appspot.com/o/user_images%2Ficon1.png?alt=media&token=618d9980-4d45-42a6-b839-27834cf8af3e';
            });
          } else {
            warningMessage('No se encontraron datos del usuario.');
          }
        }
      }
    } catch (e) {
      errorMessage('Error al obtener los datos del usuario.');
    }
  } // Estilos para los mensajes

  // Estilos para distintos mensajes
  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void errorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: ThemeColors.errorMessage,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void warningMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        backgroundColor: ThemeColors.warningMessage,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void resetStates() {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    // LUCES
    // - Switch
    databaseReference.child('Devices/Lights/Main_room/state').set(false);
    databaseReference.child('Devices/Lights/Room_1/state').set(false);
    databaseReference.child('Devices/Lights/Room_2/state').set(false);
    databaseReference.child('Devices/Lights/Parking/state').set(false);
    // - Slider
    databaseReference.child('Devices/Lights/Main_room/intensity').set(0);
    databaseReference.child('Devices/Lights/Room_1/intensity').set(0);
    databaseReference.child('Devices/Lights/Room_2/intensity').set(0);
    // databaseReference.child('Devices/Lights/Parking/intensity').set(0);
    // MOTORES
    databaseReference.child('Devices/Motors/Garage/state').set(false);
    // SENSORES
    databaseReference.child('Devices/Sensors/Movement/state').set(false);
    databaseReference.child('Devices/Sensors/Gas/state').set(false);
    databaseReference.child('Devices/Sensors/Proximity/state').set(false);
    //Notificaciones
    databaseReference.child('Notifications/General').set(false);
    databaseReference.child('Notifications/Movement').set(false);
    databaseReference.child('Notifications/Gas').set(false);
    databaseReference.child('Notifications/Garage').set(false);
    databaseReference.child('Notifications/Proximity').set(false);
  }

  // Cerrar sesión
  void signUserOut() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );
    // Navigator.of(context).pop();
    resetStates();
    await FirebaseAuth.instance.signOut();
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool("onboarding", true); // Establecer onboarding a true
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const MyApp())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            buildProfileInfo(),
            buildSectionAccount('Cuenta'),
            buildProfileEditButton(),
            // buildDevicesEditButton(),
            buildSectionApp('Preferencias'),
            buildNotificationsButton(),
            buildDarkThemeButton(),
            buildSectionMore('Más'),
            buildSupportButton(),
            buildAboutButton(),
            buildTandCButton(),
            buildElevatedButton(
              'Cerrar sesión',
              const Icon(
                EvaIcons.log_out,
                color: Colors.white,
                size: 20,
              ),
              ThemeColors.delftBlue,
              () async {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => const MyApp())),
                );
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("onboarding", false);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/bg_ht8.jpeg',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 110, 0, 0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(100, 0, 140, 255),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThemeColors.eminence,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        photo ??
                            'https://firebasestorage.googleapis.com/v0/b/hometech-a45da.appspot.com/o/user_images%2Ficon1.png?alt=media&token=618d9980-4d45-42a6-b839-27834cf8af3e',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, 0),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileInfo() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? '',
            style:
                GoogleFonts.poppins(fontSize: 35, fontWeight: FontWeight.w500),
          ),
          Text(email ?? '',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onTertiary,
              )),
        ],
      ),
    );
  }

  Widget buildSectionAccount(String title) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 4, 0, 0),
      child: Text(
        title,
        style: GoogleFonts.lexendDeca(
          fontSize: 19,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }

  Widget buildProfileEditButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.profileEdit);
        },
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
                  Icons.account_circle_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Editar mis datos',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 18,
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

  // Widget buildDevicesEditButton() {
  //   return Padding(
  //     padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.pushNamed(context, AppRoutes.devicesEdit);
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         height: 65,
  //         decoration: BoxDecoration(
  //           color: Theme.of(context).colorScheme.tertiaryContainer,
  //           boxShadow: [
  //             BoxShadow(
  //               blurRadius: 2,
  //               color: Colors.black.withOpacity(0.100),
  //               offset: const Offset(0, 5),
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(15),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               Icon(
  //                 Icons.devices_other_rounded,
  //                 color: Theme.of(context).colorScheme.onPrimary,
  //                 size: 30,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
  //                 child: Text(
  //                   'Editar dispositivos',
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 17,
  //                   ),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Align(
  //                   alignment: const AlignmentDirectional(0.95, 0),
  //                   child: Icon(
  //                     Icons.arrow_forward_ios,
  //                     color: Theme.of(context).colorScheme.onPrimary,
  //                     size: 18,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildSectionApp(String title) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 25, 0, 0),
      child: Text(
        title,
        style: GoogleFonts.lexendDeca(
          fontSize: 19,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }

  Widget buildNotificationsButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.notifications);
        },
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
                  Icons.notifications_none_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Notificaciones',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 18,
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

  Widget buildDarkThemeButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
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
                  BoxIcons.bx_moon,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Modo oscuro',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Switch(
                      value: valswitch1,
                      onChanged: (value) {
                        // Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                        setState(() {
                          valswitch1 = value;
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        });
                      },
                      activeColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    activeTrackColor: Colors.indigo.shade400,
                                    inactiveTrackColor: Colors.transparent,
                                    inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
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

  Widget buildSectionMore(String title) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 25, 0, 0),
      child: Text(
        title,
        style: GoogleFonts.lexendDeca(
          fontSize: 19,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }

  Widget buildSupportButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.support);
        },
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
                  Icons.help_outline_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Soporte y ayuda',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 18,
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

  Widget buildAboutButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.about);
        },
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
                  Icons.adb_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Acerca de la app',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 18,
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

  Widget buildTandCButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 20),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.terms);
        },
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
                  Icons.book_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Términos y condiciones',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.95, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 18,
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

  Widget buildElevatedButton(
      String buttonText, Icon newicon, Color bgcolor, VoidCallback? function) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: function,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgcolor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                newicon,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
      onTap: openScreen,
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
          icon: Icon(Icons.settings),
          label: 'Configuración',
        ),
      ],
    );
  }
}
