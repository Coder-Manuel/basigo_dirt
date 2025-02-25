import 'package:flutter/material.dart';

class Themes {
  static ThemeData get normal {
    return ThemeData(
      primaryColor: const Color(0xff062A30),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        buttonColor: const Color(0xff2FB5B0),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
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
                color: Color(0xff062A30),
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
      dataTableTheme: const DataTableThemeData(
        dividerThickness: 0.00000000001,
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xff062A30),
        secondary: Color(0xff2FB5B0),
      ),
    );
  }
}

const borderColor = Color.fromARGB(255, 218, 227, 235);

const modalSheetBorder = BorderRadius.only(
  topLeft: Radius.circular(40),
  topRight: Radius.circular(40),
);
