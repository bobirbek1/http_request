import 'package:flutter/material.dart';
import 'package:http_request/base_state.dart';
import 'package:http_request/models/album_model/album_model.dart';
import 'package:http_request/view_models/album_view_model.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  AlbumModel? _album;

  @override
  void initState() {
    Future.microtask(() {
      if (context.mounted) {
        context.read<AlbumViewModel>().fetchPhotosByAlbumId(_album?.id);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _album ??= ModalRoute.of(context)?.settings.arguments as AlbumModel?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlbumViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_album?.title ?? "No title"),
      ),
      body: switch (vm.photoState.state) {
        BaseState.loading => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        BaseState.loaded => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: vm.photoState.photos?.length ?? 0,
            itemBuilder: (context, index) {
              final photo = vm.photoState.photos![index];
              return photo.url != null
                  ? Image.network(
                      photo.url!,
                      fit: BoxFit.cover,
                    )
                  : const Text("No image");
            },
          ),
        _ => const SizedBox(),
      },
    );
  }
}
