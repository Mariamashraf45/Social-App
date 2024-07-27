import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fire/models/postModel.dart'; // Update import to match your model
import 'package:fire/models/userModel.dart'; // Update import to match your model

class CreatePostScreen extends StatefulWidget {
  final Users currentUser;

  CreatePostScreen({required this.currentUser});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _textController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitPost() async {
    if (_textController.text.isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add text or an image to post.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl;
      if (_image != null) {
        final ref = FirebaseStorage.instance.ref().child('post_images')
        .child('${DateTime.now().toIso8601String()}.jpg');
        await ref.putFile(_image!);
        imageUrl = await ref.getDownloadURL();
      }
      final postRef = FirebaseFirestore.instance.collection('posts').doc();
      final post = Posts(
        postId: postRef.id,
        name: widget.currentUser.name,
        uId: widget.currentUser.uId,
        profilePhoto: widget.currentUser.profilePhoto,
        postTime: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        text: _textController.text,
        imageUrl: imageUrl ?? '',
        likes: 0

      );

      await FirebaseFirestore.instance
          .collection('posts')
          .add(post.toJson())
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post submitted successfully!')),
        );
        Navigator.pop(context);
      });

    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit post: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage(widget.currentUser.profilePhoto),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.currentUser.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (_image != null)
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(
                    _image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                    },
                  ),
                ],
              ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.add_photo_alternate, color: Colors.white),
                  label: Text(
                    'Add Image',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _submitPost,
                  icon: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                  label: Text(
                    'Post',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
