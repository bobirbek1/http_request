import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/injection_service.dart';
import 'package:http_request/models/user_model/user_model.dart';
import 'package:http_request/pages/album_page/album_page.dart';
import 'package:http_request/pages/post_page/post_page.dart';
import 'package:http_request/view_models/album_view_model.dart';
import 'package:http_request/view_models/comment_view_model.dart';
import 'package:http_request/view_models/post_view_model.dart';
import 'package:http_request/view_models/todo_view_model.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel? _user;

  @override
  void initState() {
    Future.microtask(() {
      context.read<TodoViewModel>().fetchTodos(_user?.id);
      context.read<PostViewModel>().fetchPosts(_user?.id);
      context.read<AlbumViewModel>().fetchAlbums(_user?.id);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _user ??= ModalRoute.of(context)?.settings.arguments as UserModel?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user?.username ?? "Unknown"),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Text("Name: ${_user?.name}"),
            const SizedBox(
              height: 4,
            ),
            Text("Email: ${_user?.email}"),
            const SizedBox(
              height: 4,
            ),
            Text("Phone: ${_user?.phone}"),
            const SizedBox(
              height: 4,
            ),
            Text("Website: ${_user?.website}"),
            const SizedBox(
              height: 16,
            ),
            const TabBar(
              tabs: [
                Tab(
                  text: "Todos",
                ),
                Tab(
                  text: "Posts",
                ),
                Tab(
                  text: "Albums",
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _Todo(),
                  _Post(),
                  _Album(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Album extends StatelessWidget {
  const _Album();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlbumViewModel>();
    return switch (vm.state.state) {
      BaseState.loading => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      BaseState.loaded => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: vm.state.albums
                  ?.map<Widget>((album) => _AlbumItem(
                        title: album.title,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return const AlbumPage();
                                },
                                settings: RouteSettings(arguments: album)),
                          );
                        },
                      ))
                  .toList() ??
              [],
        ),
      _ => const SizedBox(),
    };
  }
}

class _AlbumItem extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;

  const _AlbumItem({
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: ListTile(
        onTap: onPressed,
        title: Text(
          title ?? "No title available",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PostViewModel>();
    return switch (vm.state.state) {
      BaseState.loading => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      BaseState.loaded => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: vm.state.posts
                  ?.map<Widget>((post) => _PostItem(
                        title: post.title,
                        subtitle: post.body,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: RouteSettings(arguments: post),
                              builder: (context) {
                                return ChangeNotifierProvider(
                                  create: (context) =>
                                      CommentViewModel(getIt.get()),
                                  builder: (context, child) => child!,
                                  child: const PostPage(),
                                );
                              },
                            ),
                          );
                        },
                      ))
                  .toList() ??
              [],
        ),
      _ => const SizedBox(),
    };
  }
}

class _PostItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onPressed;

  const _PostItem({this.title, this.subtitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: ListTile(
        onTap: onPressed,
        title: Text(
          title ?? "No title available",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle ?? "No subtitle",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}

class _Todo extends StatelessWidget {
  const _Todo();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TodoViewModel>();
    return switch (vm.state.state) {
      BaseState.loading => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      BaseState.loaded => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: vm.state.todos
                  ?.map<Widget>((todo) => _TodoItem(
                        title: todo.title,
                        value: todo.completed,
                        onChanged: (value) {
                          vm.updateTodoComplete(todo.id, value).then((value) {
                            if (value) {
                              Fluttertoast.showToast(
                                  msg: "Todo updated successfully!");
                            } else {
                              Fluttertoast.showToast(
                                msg: "Todo not updated, please try again.",
                              );
                            }
                          });
                        },
                      ))
                  .toList() ??
              [],
        ),
      _ => const SizedBox(),
    };
  }
}

class _TodoItem extends StatefulWidget {
  final String? title;
  final bool? value;
  final void Function(bool value)? onChanged;

  const _TodoItem({this.title, this.value, this.onChanged});

  @override
  State<_TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<_TodoItem> {
  bool current = false;

  @override
  void initState() {
    current = widget.value ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: ListTile(
        title: Text(widget.title ?? "No title available"),
        trailing: Checkbox(
            value: current,
            onChanged: (value) {
              setState(() {
                current = value ?? false;
                if (widget.onChanged != null) {
                  widget.onChanged!(current);
                }
              });
            }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
