import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/cubit/app_cubit_cubit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'presentation/pages/main_screen.dart';

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    join(await getDatabasesPath(), 'notes_db.db'),
    onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          date_time INTEGER NOT NULL,
          color INTEGER NOT NULL
        );
        ''',
      );
    },
    version: 1,
  );

  getIt.registerSingleton<Database>(database);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.brown
      ),
      home: BlocProvider(//основное окто, которое будет отображаться, блокпровайдер отвечает за создание и закрытие нового блока
        create: (context) => AppCubitCubit(getIt.get<Database>()),
        child: const MainScreen(),
      ),
    );
  }
}
