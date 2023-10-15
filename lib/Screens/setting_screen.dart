import 'package:e_learn/utils/decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/user_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            ListTile(
              title: const Text(
                'Dark theme',
                style: TextStyle(fontSize: 18.0),
              ),
              trailing: Consumer<ThemeModel>(
                builder: (context, themeModelProvider, child) {
                  return Switch(
                    value: themeModelProvider.isDarkMode,
                    activeColor: orangeColor,
                    onChanged: (value) {
                      themeModelProvider.toggleTheme();
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
