import 'package:flutter/material.dart';
import 'screens/chat_rooms_screen.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sohbet Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          elevation: 2,
          centerTitle: true,
        ),
      ),
      home: ChatRoomsScreen(),
    );
  }
}
