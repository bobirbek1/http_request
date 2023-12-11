import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/models/post_model/post_model.dart';
import 'package:http_request/view_models/comment_view_model.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostModel? _post;

  @override
  void initState() {
    Future.microtask(() {
      if (context.mounted) {
        context.read<CommentViewModel>().fetchComments(_post?.id);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _post ??= ModalRoute.of(context)?.settings.arguments as PostModel?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CommentViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post"),
        ),
        body: switch (vm.state.state) {
          BaseState.loading => _TopWidgets(
              title: _post?.title,
              body: _post?.body,
              isLoading: true,
            ),
          BaseState.loaded => ListView.builder(
              itemCount: (vm.state.comments?.length ?? 0) + 1,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _TopWidgets(
                    title: _post?.title,
                    body: _post?.body,
                  );
                } else {
                  final comment = vm.state.comments![index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.name ?? "No name available",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (comment.email != null)
                          Text(
                            comment.email!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          comment.body ?? "No comment body",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          _ => _TopWidgets(
              title: _post?.title,
              body: _post?.body,
            ),
        });
  }
}

class _TopWidgets extends StatelessWidget {
  final String? title;
  final String? body;
  final bool isLoading;

  const _TopWidgets({this.title, this.body, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title ?? "No title available",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          body ?? "No content",
        ),
        const SizedBox(
          height: 12,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Comments",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
      ],
    );
  }
}
