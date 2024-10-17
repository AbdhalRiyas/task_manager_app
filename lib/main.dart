import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'viewmodels/task_viewmodel.dart';

final theme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 87, 143, 195),
    brightness: Brightness.light,
    surface: const Color.fromARGB(255, 87, 143, 195),
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    titleLarge: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const TasksScreen(),
    );
  }
}
