import 'package:flutter/material.dart';
import '../models/post.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const PostCard({
    super.key,
    required this.post,
    required this.onDelete,
    required this.onEdit,
  });

  Future<void> _downloadImage(BuildContext context, String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile = File(imagePath);
    final newImage = File('${directory.path}/${DateTime.now().toString()}.png');

    await imageFile.copy(newImage.path);

    Fluttertoast.showToast(msg: 'Image downloaded successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: GestureDetector(
          onLongPress: () => _downloadImage(context, post.imagePath),
          child: Image.file(File(post.imagePath), width: 60, height: 60),
        ),
        title: Text(post.title),
        subtitle: Text(post.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
