import 'package:flutter/material.dart';
import 'package:http_request/injection_service.dart';
import 'package:http_request/pages/main_page/main_page.dart';
import 'package:http_request/view_models/album_view_model.dart';
import 'package:http_request/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AlbumViewModel(getIt.get()),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(getIt.get()),
        ),
      ],
      builder: (context, child) => child!,
      child: const MaterialApp(
        title: "Http example",
        home: MainPage(),
      ),
    );
  }
}
