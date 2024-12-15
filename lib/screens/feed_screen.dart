import 'package:flutter/material.dart';
import 'package:lab10/models/post.dart';
import 'upload_screen.dart';

class FeedScreen extends StatelessWidget {
  final List<Post> posts;
  final Function(String) deletePost;
  final Function(String, String, String, String) editPost;

  FeedScreen({
    required this.posts,
    required this.deletePost,
    required this.editPost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media Feed'),
      ),
      body: posts.isEmpty
          ? const Center(
              child: Text(
                'No posts available',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: post.imagePath.isNotEmpty
                        ? Image.asset(
                            post.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image),
                    title: Text(post.title),
                    subtitle: Text(post.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => UploadScreen(
                                  addPost: (title, description, imagePath) {
                                    editPost(
                                        post.id, title, description, imagePath);
                                  },
                                  existingPost: post,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deletePost(post.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/upload');
        },
      ),
    );
  }
}
