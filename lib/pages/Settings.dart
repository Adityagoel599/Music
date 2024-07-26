import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/themes/themes_provider.dart';
import 'package:provider/provider.dart';
class Settings extends StatelessWidget{
  const Settings({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text("S E T T I N G S"),),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
        margin : const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children:[
           const Text("Dark Mode",style: TextStyle(fontWeight: FontWeight.bold)),
        CupertinoSwitch(value:Provider.of<ThemesProvider>(context, listen: false).isDarkMode, onChanged: (value)=> Provider.of<ThemesProvider>(context, listen: false).toggleTheme())
    ]),
      ),
    );

  }
}