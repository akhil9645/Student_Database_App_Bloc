import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_data_base/data/db/db_funtion.dart';
import 'package:student_data_base/data/model/student_model.dart';
import 'package:student_data_base/domain/bloc/studentbloc_bloc.dart';
import 'package:student_data_base/domain/imagepicking/imagepicking_bloc.dart';
import 'package:student_data_base/domain/searchbloc/bloc/search_bloc.dart';

import 'package:student_data_base/presentation/mainpage/main_screen.dart';

List<String> list = [];
Future<void> main() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  await Hive.openBox<StudentModel>("students_db");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getAllstudnets();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickingBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student list',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          appBarTheme: const AppBarTheme(color: Colors.teal),
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }
}
