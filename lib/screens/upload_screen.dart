import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab10/models/post.dart';
import 'dart:io';

class UploadScreen extends StatefulWidget {
  final Function(String, String, String) addPost;
  final Post? existingPost;

  UploadScreen({required this.addPost, this.existingPost});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedImagePath = '';

  @override
  void initState() {
    if (widget.existingPost != null) {
      _titleController.text = widget.existingPost!.title;
      _descriptionController.text = widget.existingPost!.description;
      _selectedImagePath = widget.existingPost!.imagePath;
    }
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;

    if (enteredTitle.isEmpty ||
        enteredDescription.isEmpty ||
        _selectedImagePath.isEmpty) {
      return; // Do nothing if any field is empty
    }

    widget.addPost(enteredTitle, enteredDescription, _selectedImagePath);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingPost == null ? 'Add Post' : 'Edit Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 10),
              _selectedImagePath.isEmpty
                  ? const Text('No image selected.')
                  : Image.file(
                      File(_selectedImagePath),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Select Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(widget.existingPost == null ? 'Upload' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
