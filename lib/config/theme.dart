import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themes {
  static ThemeData get normal {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 35, 194, 41),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        buttonColor: const Color.fromARGB(255, 35, 194, 41),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Color.fromARGB(255, 35, 194, 41),
          ),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        labelStyle: const TextStyle(fontSize: 14),
        prefixIconColor: Colors.grey[600],
        suffixIconColor: Colors.grey[600],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.grey,
      ),
      dialogTheme: const DialogTheme(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const Icon(
                Icons.done,
                color: Color(0xff17ff19),
              );
            }
            return null;
          },
        ),
        trackColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xff2FB5B0).withOpacity(0.7);
            }
            return null;
          },
        ),
      ),
      tabBarTheme: const TabBarTheme(
        dividerColor: Colors.transparent,
      ),
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 35, 194, 41),
        secondary: Color(0xff2FB5B0),
      ),
      textTheme: TextTheme(
        headlineSmall: Get.theme.textTheme.headlineSmall?.copyWith(
          color: Colors.grey,
          fontSize: 20,
        ),
        bodySmall: Get.theme.textTheme.bodySmall?.copyWith(
          color: Colors.grey,
        ),
        bodyMedium: Get.theme.textTheme.bodyMedium?.copyWith(
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

const borderColor = Color.fromARGB(255, 218, 227, 235);

const modalSheetBorder = BorderRadius.only(
  topLeft: Radius.circular(40),
  topRight: Radius.circular(40),
);
