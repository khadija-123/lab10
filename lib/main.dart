import 'package:flutter/material.dart';
import 'package:lab10/models/post.dart';
import 'package:lab10/screens/feed_screen.dart';
import 'package:lab10/screens/upload_screen.dart';

void main() {
  runApp(SocialMediaApp());
}

class SocialMediaApp extends StatefulWidget {
  @override
  _SocialMediaAppState createState() => _SocialMediaAppState();
}

class _SocialMediaAppState extends State<SocialMediaApp> {
  List<Post> _posts = [];

  void _addPost(String title, String description, String imagePath) {
    setState(() {
      _posts.add(Post(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        imagePath: imagePath,
      ));
    });
  }

  void _deletePost(String id) {
    setState(() {
      _posts.removeWhere((post) => post.id == id);
    });
  }

  void _editPost(
      String id, String title, String description, String imagePath) {
    setState(() {
      final index = _posts.indexWhere((post) => post.id == id);
      if (index >= 0) {
        _posts[index].title = title;
        _posts[index].description = description;
        _posts[index].imagePath = imagePath;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FeedScreen(
        posts: _posts,
        deletePost: _deletePost,
        editPost: _editPost,
      ),
      routes: {
        '/upload': (ctx) => UploadScreen(addPost: _addPost),
      },
    );
  }
}
