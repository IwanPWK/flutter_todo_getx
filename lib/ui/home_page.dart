import 'package:flutter/material.dart';

import '../services/theme_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const Text('Theme Data'),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          //membuat instance dari class tanpa membuat method static
          ThemeService().switchTheme();
        },
        child: const Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: const [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(width: 20)
      ],
    );
  }
}
