import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/injection_service.dart';
import 'package:http_request/pages/user_page/user_page.dart';
import 'package:http_request/view_models/post_view_model.dart';
import 'package:http_request/view_models/todo_view_model.dart';
import 'package:http_request/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Consumer<UserViewModel>(builder: (ctx, vm, child) {
        return switch (vm.state.state) {
          BaseState.loading => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          BaseState.loaded => ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              children: vm.state.users == null
                  ? []
                  : vm.state.users!.map((user) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 2),
                          ],
                        ),
                        child: ListTile(
                          title: Text(user.name ?? "Unknown"),
                          subtitle: Text(user.email ?? "Unknown"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(create: (context) => TodoViewModel(getIt.get()),),
                                      ChangeNotifierProvider(create: (context) => PostViewModel(getIt.get()),),
                                    ],
                                    builder: (context, child) => child!,
                                    child: const UserPage());
                                },
                                settings: RouteSettings(arguments: user),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),
                          tileColor: Colors.white,
                        ),
                      );
                    }).toList(),
            ),
          _ => const SizedBox(),
        };
      }),
    );
  }
}
