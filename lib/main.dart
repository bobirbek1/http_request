import 'package:flutter/material.dart';
import 'package:http_request/base/my_app.dart';
import 'package:http_request/injection_service.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUp();

  runApp(const MyApp());
}
