import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:paydash/core/app_colors.dart';

class AppTheme {



  static const Color _darkBackground = Color(0xFF180030); 
  static const Color _darkSurface = Color(0xFF2F0052); 


  static const Color _lightBackground = Color(
    0xFFF6F0FF,
  );
  static const Color _lightText = Color(0xFF240046); 

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF180030),
    primaryColor: AppColors.primary,
    cardColor: _darkSurface,

    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      surface: _darkSurface,
      background: _darkBackground,
      onPrimary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

 
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
    ),

    iconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.white24,
    dialogBackgroundColor: _darkSurface,
    useMaterial3: true,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: _lightBackground,
    primaryColor: AppColors.primary,
    cardColor: Colors.white,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: Colors.white,
      background: _lightBackground,
      onPrimary: Colors.white,
      onSurface: _lightText,
      onBackground: _lightText,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: _lightText),
      titleTextStyle: TextStyle(
        color: _lightText,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

 
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: _lightText),
      bodyMedium: TextStyle(color: _lightText),
      bodySmall: TextStyle(color: _lightText),
      titleLarge: TextStyle(color: _lightText),
      titleMedium: TextStyle(color: _lightText),
      titleSmall: TextStyle(color: _lightText),
      labelLarge: TextStyle(color: _lightText),
      displayLarge: TextStyle(color: _lightText),
      displayMedium: TextStyle(color: _lightText),
      displaySmall: TextStyle(color: _lightText),
    ),

    iconTheme: const IconThemeData(color: _lightText),
    dividerColor: const Color(0xFF2F0052).withOpacity(0.1),
    dialogBackgroundColor: Colors.white,
    useMaterial3: true,
  );
}


class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themeKey = 'theme_mode';
  final Box _box;

  ThemeCubit(this._box) : super(_initialTheme(_box));

  static ThemeMode _initialTheme(Box box) {
    final String? mode = box.get(_themeKey) as String?;
    if (mode == 'dark') return ThemeMode.dark;
    if (mode == 'light') return ThemeMode.light;
    return ThemeMode.dark;
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
      _box.put(_themeKey, 'light');
    } else {
      emit(ThemeMode.dark);
      _box.put(_themeKey, 'dark');
    }
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
    _box.put(_themeKey, mode == ThemeMode.dark ? 'dark' : 'light');
  }
}
