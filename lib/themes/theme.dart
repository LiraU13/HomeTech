import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: ThemeColors.backlight, // Fondo
    onBackground: ThemeColors.backTyClight, // Fondo de TyC
    primary: ThemeColors.letterlightblue, // Letra color azul
    secondary: ThemeColors.btn1light, // Fondo del botón Google
    tertiary: ThemeColors.switchlight, // Switch
    onPrimary: ThemeColors.iconActivelight, // Icono activo
    onSecondary: ThemeColors.letterlight, // Letra normal activada
    onTertiary: ThemeColors.letterDeslight, // Letra normal desactivada
    primaryContainer: ThemeColors.formslight, // Formularios
    secondaryContainer: ThemeColors.messagelihght, // Mensaje de estado correcto
    tertiaryContainer: ThemeColors.containerslight, // Contenedores
    onPrimaryContainer: ThemeColors.shadowFormlight, // Sombreado
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: ThemeColors.backdark,
    onBackground: ThemeColors.backTyCdark,
    primary: ThemeColors.letterdarkblue,
    secondary: ThemeColors.btn1dark,
    tertiary: ThemeColors.switchdark,
    onPrimary: ThemeColors.iconActivedark,
    onSecondary: ThemeColors.letterdark,
    onTertiary: ThemeColors.letterDesdark,
    primaryContainer: ThemeColors.formsdark,
    secondaryContainer: ThemeColors.messagedark,
    tertiaryContainer: ThemeColors.containersdark,
    onPrimaryContainer: ThemeColors.shadowFormdark,
  ),
);

class ThemeColors {
  // Colores para los mensajes
  static Color warningMessage = const Color.fromARGB(255, 255, 230, 0);
  static Color errorMessage = const Color.fromARGB(255, 223, 0, 0);
  static Color message = const Color.fromARGB(255, 0, 17, 112);

  // Tema claro
  static Color backlight = Colors.white;
  static Color backTyClight = const Color.fromARGB(255, 226, 226, 226);
  static Color formslight = const Color.fromARGB(239, 255, 255, 255);
  static Color shadowFormlight = const Color.fromARGB(255, 0, 0, 0);
  static Color containerslight = const Color.fromARGB(255, 255, 255, 255);
  static Color letterlightblue = const Color.fromARGB(255, 0, 12, 82);
  static Color letterlight = const Color.fromARGB(255, 0, 0, 0);
  static Color letterDeslight = const Color.fromARGB(255, 95, 95, 95);
  static Color btn1light = const Color.fromARGB(255, 255, 255, 255);
  static Color switchlight = const Color.fromARGB(255, 0, 50, 100);
  static Color messagelihght = const Color.fromARGB(255, 0, 17, 112);
  static Color iconActivelight = const Color.fromARGB(255, 32, 40, 83);

  // Tema oscuro
  static Color backdark = const Color.fromARGB(255, 0, 5, 39);
  static Color backTyCdark = const Color.fromARGB(178, 199, 199, 199);
  static Color formsdark = const Color.fromARGB(236, 55, 65, 95);
  static Color shadowFormdark = const Color.fromARGB(255, 0, 0, 0);
  static Color containersdark = const Color.fromARGB(255, 0, 35, 53);
  static Color letterdarkblue = const Color.fromARGB(255, 0, 10, 73);
  static Color letterdark = const Color.fromARGB(255, 255, 255, 255);
  static Color letterDesdark = const Color.fromARGB(255, 180, 180, 180);
  static Color btn1dark = const Color.fromARGB(255, 255, 255, 255);
  static Color switchdark = const Color.fromARGB(255, 0, 40, 100);
  static Color messagedark = const Color.fromARGB(255, 73, 90, 131);
  static Color iconActivedark = const Color.fromARGB(255, 255, 255, 255);

  // Colores del logotipo
  static Color delftBlue = const Color.fromARGB(255, 32, 40, 83);
  static Color delftBlue2 = const Color(0xFF424a9b);
  static Color mulberry = const Color.fromARGB(255, 214, 79, 147);
  static Color steelBlue = const Color(0xFF3282b5);
  static Color blue = const Color(0xFF1d6caa);
  static Color eminence = const Color.fromARGB(255, 93, 0, 133);
  static Color buttonColor = const Color.fromARGB(255, 0, 119, 255);
}
