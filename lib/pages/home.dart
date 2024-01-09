import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tarefas_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.teal)),
      home: TarefaPage(),
    );
  }
}
