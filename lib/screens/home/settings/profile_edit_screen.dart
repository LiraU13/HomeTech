import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometech/main.dart';
import 'package:hometech/themes/theme.dart';
import 'package:hometech/widgets/routes.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool _isGoogleUser = false;
  bool _obscureText = true;
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Getter to avoid eager initialization on Web
  FirebaseAuth get auth => FirebaseAuth.instance;
  String? uid;
  String? name;
  String? number;
  String? email;
  String? photo;

  @override
  void initState() {
    getData();
    super.initState();
  }

  // Verificar si hay cambios en los campos
  bool hasChanges() {
    return nameController.text.trim() != name ||
        numberController.text.trim() != number ||
        emailController.text.trim() != email ||
        oldpasswordController.text.isNotEmpty ||
        newpasswordController.text.isNotEmpty ||
        confirmPasswordController.text.isNotEmpty;
  }

  // Obtener los datos de Firestore y de Firebase Auth
  Future<void> getData() async {
    if (kIsWeb) {
      setState(() {
        name = "Usuario Demo";
        number = "1234567890";
        email = "demo@hometech.com";
        nameController.text = name!;
        numberController.text = number!;
        emailController.text = email!;
      });
      return;
    }
    try {
      User? user = auth.currentUser;
      if (user != null) {
        uid = user.uid;
        final DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'];
            number = userDoc['phone'];
            email = userDoc['email'];
            nameController.text = name ?? 'HomeTech';
            numberController.text = number ?? '';
            emailController.text = email ?? '';
          });
        } else {
          // Se obtiene la información del perfil de Google
          if (user.providerData
              .any((profile) => profile.providerId == 'google.com')) {
            final googleUser = user.providerData
                .firstWhere((profile) => profile.providerId == 'google.com');
            setState(() {
              name = googleUser.displayName ?? 'HomeTech';
              number = googleUser.phoneNumber ?? '';
              email = googleUser.email ?? '';
              photo = googleUser.photoURL;
              // ?? 'https://firebasestorage.googleapis.com/v0/b/hometech-a45da.appspot.com/o/user_images%2Ficon1.png?alt=media&token=618d9980-4d45-42a6-b839-27834cf8af3e';
              nameController.text = name!;
              emailController.text = email!;
              numberController.text = number!;
            });
          } else {
            warningMessage('No se encontraron datos del usuario.');
          }
        }
        if (user.providerData
            .any((profile) => profile.providerId == 'google.com')) {
          _isGoogleUser = true;
        }
      } else {
        warningMessage('No hay un usuario autenticado.');
      }
    } catch (e) {
      errorMessage('Error al obtener los datos del usuario.');
    }
  }

  // Actualiza la información en Firebase Auth y Firestore (tiene validaciones)
  Future<void> updateUserInfo() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );

    // Verificar si hay cambios antes de proceder
    if (!hasChanges()) {
      message('No se detectaron cambios en la información.');
      return;
    }
    bool passwordChange = oldpasswordController.text.isNotEmpty ||
        newpasswordController.text.isNotEmpty ||
        confirmPasswordController.text.isNotEmpty;

    if (nameController.text.trim().isEmpty ||
        numberController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        (passwordChange &&
            (oldpasswordController.text.trim().isEmpty ||
                newpasswordController.text.trim().isEmpty ||
                confirmPasswordController.text.trim().isEmpty))) {
      errorMessage('Los campos requeridos no deben estar vacíos.');
      return;
    }

    // Validar la longitud de la contraseña
    if (passwordChange && newpasswordController.text.trim().length < 8) {
      errorMessage('La contraseña debe tener al menos 8 caracteres.');
      return;
    }

    // Validar la longitud del número telefónico
    if (numberController.text.trim().length != 10) {
      errorMessage('El número telefónico debe tener 10 dígitos.');
      return;
    }

    // Validar primero las contraseñas si se intenta cambiar la contraseña
    if (passwordChange) {
      bool passwordUpdateSuccessful = await updatePassIfPassIsValid();
      if (!passwordUpdateSuccessful) {
        return;
      }
    }

    if (kIsWeb) {
      message('Modo demo: Información actualizada (simulación).');
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.settings);
      }
      return;
    }

    // Validar si hay cambios en el correo o el número antes de validar la unicidad
    bool emailChanged = emailController.text.trim() != email;
    bool phoneChanged = numberController.text.trim() != number;

    if (emailChanged) {
      bool emailExists = await checkEmailExists(emailController.text.trim());
      if (emailExists) {
        return;
      }
    }

    // Verificar si el número de teléfono ha cambiado y es único, si es necesario
    if (phoneChanged) {
      bool phoneExists = await checkPhoneExists(numberController.text.trim());
      if (phoneExists) {
        return;
      }
    }

    bool hasBasicInfoChanges =
        nameController.text.trim() != name || emailChanged || phoneChanged;
    if (!hasBasicInfoChanges && !passwordChange) {
      message('No se detectaron cambios en la información.');
      return;
    }

    String validationMessage = validateFields() ?? '';
    if (validationMessage.isNotEmpty) {
      errorMessage(validationMessage);
      return;
    }

    try {
      User? user = auth.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          // Cambiar update por set y verificar: SI NO HAY DATOS, DEBE GUARDARLOS, SI HAY LOS DEBE MODIFICAR
          // Update modifica solo si existen el documento del usuario en la colección
          // Set esta añadiendo esos datos si ni el documento existe
          'name': nameController.text.trim(),
          'phone': numberController.text.trim(),
          'email': emailController.text.trim(),
        }, SetOptions(merge: true));

        if (emailController.text.trim() != email &&
            emailController.text.trim().isNotEmpty) {
          await attemptUpdateEmail(emailController.text.trim());
        }
        message('Se actualizó correctamente la información.');
      }
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.settings);
      }
    } catch (e) {
      errorMessage('Hubo un error al intentar actualizar tus datos. $e');
      return;
    }
  }

  void resetStates() {
    if (kIsWeb) return;
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

  // Elimina la cuenta
  Future<void> deleteUserAccount() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    if (kIsWeb) {
      // Mock delete for web
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.of(context).pop(); // Close dialog
        Navigator.of(context).pop(); // Close screen
        Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => const MyApp())),
        );
      }
      return;
    }
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        resetStates();
        // Eliminar datos de Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();
        // Eliminar la cuenta de Firebase Auth
        await user.delete();
        await FirebaseAuth.instance.signOut();
        // final prefs = await SharedPreferences.getInstance();
        // prefs.setBool("onboarding", true);
        // Redirigir a la pantalla de inicio de sesión
        if (mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const MyApp())),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
      }
      errorMessage('Hubo un error al eliminar la cuenta: $e');
    }
  }

  // ------- Validaciones -------
  // Validar que los campos no esten vacios
  String? validateFields() {
    if (nameController.text.isEmpty ||
        numberController.text.isEmpty ||
        emailController.text.isEmpty) {
      return 'Por favor, completa los campos requeridos.';
    } else if (!isValidEmail(emailController.text)) {
      return 'El correo electrónico no es válido.';
    }
    return null;
  }

  // Validar que ele correo este correcto
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  // Validar si el correo o el número ya están en uso con otra cuenta
  // Método para verificar si el correo electrónico ya existe
  Future<bool> checkEmailExists(String email) async {
    if (kIsWeb) return false;
    final QuerySnapshot emailResult = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (emailResult.docs.isNotEmpty) {
      warningMessage('El correo electrónico ya se encuentra en uso, cámbielo.');
      return true;
    }
    return false;
  }

  // Método para verificar si el número de teléfono ya existe
  Future<bool> checkPhoneExists(String phone) async {
    if (kIsWeb) return false;
    final QuerySnapshot phoneResult = await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();
    if (phoneResult.docs.isNotEmpty) {
      warningMessage('El número telefónico ya se encuentra en uso, cámbielo.');
      return true;
    }
    return false;
  }

  // Validar si se ha cambiado el correo para enviar la autenticación para el cambio
  Future<void> attemptUpdateEmail(String newEmail) async {
    if (kIsWeb) return;
    User? user = auth.currentUser;
    if (user != null) {
      if (user.email == newEmail) {
        return;
      }
      try {
        await user.verifyBeforeUpdateEmail(newEmail);
        verificationEmailDialog();
      } catch (e) {
        errorMessage('Error al actualizar el correo electrónico.');
      }
    } else {
      warningMessage('No hay un usuario autenticado.');
    }
  }

  // Validar si la contraseña actual es correcta y permitir el cambio de la misma
  Future<bool> updatePassIfPassIsValid() async {
    User? user = auth.currentUser;
    String oldPassword = oldpasswordController.text.trim();
    String newPassword = newpasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (kIsWeb) return true;

    if (newPassword != confirmPassword) {
      warningMessage('La nueva contraseña no coincide con la confirmación.');
      return false;
    }

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      // message('La contraseña ha sido modificada correctamente.');
      return true;
    } catch (e) {
      errorMessage('La contraseña actual no es correcta.');
      return false;
    }
  }

  // Estilos para los distintos mensajes
  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        backgroundColor: ThemeColors.delftBlue,
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        backgroundColor: ThemeColors.warningMessage,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void verificationEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(
            '¡Aviso!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: ThemeColors.delftBlue,
            ),
          ),
          content: Text(
            'Se ha enviado un enlace para verificar su nuevo correo electrónico. \nPor favor revise su correo electrónico y haga clic en el enlace para completar el cambio.',
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Aceptar',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.delftBlue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteAccountAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(
            textAlign: TextAlign.center,
            'Eliminar cuenta',
            style: GoogleFonts.poppins(
                fontSize: 25,
                color: ThemeColors.errorMessage,
                fontWeight: FontWeight.w400),
          ),
          content: Text(
            '¡Este procedimiento no podrá deshacerce! ¿Está seguro de que quiere continuar?',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancelar',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.delftBlue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Continuar',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.errorMessage,
                ),
              ),
              onPressed: () {
                deleteUserAccount();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildHeader(),
            Transform.translate(
              offset: const Offset(0, -100),
              child: ClipPath(
                clipper: FormClipper(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.7),
                          blurRadius: 10,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 15, 0, 10),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Nomre de usuario',
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 15, 0, 10),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: numberController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                labelText: 'Número telefónico',
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 15, 0, 10),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              enabled: !_isGoogleUser,
                              decoration: InputDecoration(
                                labelText: 'Correo',
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 15, 0, 10),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              controller: oldpasswordController,
                              enabled: !_isGoogleUser,
                              decoration: InputDecoration(
                                labelText: 'Contraseña actual',
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              obscureText: _obscureText,
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 15, 0, 10),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              controller: newpasswordController,
                              enabled: !_isGoogleUser,
                              decoration: InputDecoration(
                                labelText: 'Nueva contraseña',
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              obscureText: _obscureText,
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              controller: confirmPasswordController,
                              enabled: !_isGoogleUser,
                              decoration: InputDecoration(
                                labelText: 'Confirma la contraseña',
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _obscureText,
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildElevatedButton(
                              const EdgeInsetsDirectional.only(top: 15),
                              'Guardar ',
                              ThemeColors.delftBlue,
                              const Icon(
                                OctIcons.upload,
                                color: Colors.white,
                                size: 20,
                              ),
                              () {
                                updateUserInfo();
                              },
                            ),
                            buildElevatedButton(
                              const EdgeInsetsDirectional.only(
                                  top: 15, bottom: 15),
                              'Eliminar cuenta ',
                              Colors.red.shade700,
                              const Icon(
                                OctIcons.trash,
                                color: Colors.white,
                                size: 20,
                              ),
                              kIsWeb
                                  ? null
                                  : () {
                                      deleteAccountAlertDialog();
                                    },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                // LAS IMAGENES DE ESTA PARTE DEBEN CAMBIAR ALEATORIAMENTE CADA CIERTO TIEMPO
                image: AssetImage(
                  'assets/images/bg_ht8.jpeg',
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -26),
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(100, 0, 140, 255),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 46, 0, 107),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: kIsWeb
                          ? Container(
                              width: 130,
                              height: 130,
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: Text(
                                'U',
                                style: GoogleFonts.poppins(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : photo != null
                              ? Image.network(
                                  photo!,
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                  alignment: const Alignment(0, 0),
                                )
                              : Image.network(
                                  photo ??
                                      'https://firebasestorage.googleapis.com/v0/b/hometech-a45da.appspot.com/o/user_images%2Ficon1.png?alt=media&token=618d9980-4d45-42a6-b839-27834cf8af3e',
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                  alignment: const Alignment(0, 0),
                                ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildElevatedButton(
      padding, String buttonText, Color buttonColor, btnIcon, function) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: function,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                buttonText,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              btnIcon,
            ],
          ),
        ),
      ),
    );
  }
}

class FormClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var radius = 80.0;

    path.lineTo((size.width / 2) - radius, 0);
    path.arcToPoint(
      Offset((size.width / 2) + radius, 0),
      radius: Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
