import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fire/models/userModel.dart' as userModelPrefix;

class EditProfileScreen extends StatefulWidget {
  final userModelPrefix.Users userModel;

  EditProfileScreen({required this.userModel});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  File? _profileImage;
  File? _coverImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userModel.name);
    _emailController = TextEditingController(text: widget.userModel.email);
    _bioController = TextEditingController(text: widget.userModel.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, bool isProfile) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {
          _coverImage = File(pickedFile.path);
        }
      }
    });
  }

  Future<String?> _uploadImage(File image, String path) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = await ref.putFile(image);
      final downloadURL = await uploadTask.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _saveProfileChanges(String name, String email, String bio) async {
    String? profilePhotoUrl = widget.userModel.profilePhoto;
    String? coverPhotoUrl = widget.userModel.coverPhoto;

    if (_profileImage != null) {
      profilePhotoUrl = await _uploadImage(_profileImage!, 'profile_photos/${widget.userModel.uId}');
    }

    if (_coverImage != null) {
      coverPhotoUrl = await _uploadImage(_coverImage!, 'cover_photos/${widget.userModel.uId}');
    }

    final updatedUserModel = userModelPrefix.Users(
      name: name,
      email: email,
      phone: widget.userModel.phone,
      uId: widget.userModel.uId,
      bio: bio,
      profilePhoto: profilePhotoUrl ?? widget.userModel.profilePhoto,
      coverPhoto: coverPhotoUrl ?? widget.userModel.coverPhoto,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userModel.uId)
        .update(updatedUserModel.toJson())
        .then((value) {
      Navigator.pop(context, updatedUserModel);
    }).catchError((e) {
      print('Error updating user: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCoverPhoto(),
              SizedBox(height: 16),
              _buildProfilePhoto(),
              SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  prefixIcon: Icon(Icons.info),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _saveProfileChanges(
                    _nameController.text,
                    _emailController.text,
                    _bioController.text,
                  );
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoverPhoto() {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _coverImage != null
                  ? FileImage(_coverImage!)
                  : NetworkImage(widget.userModel.coverPhoto) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            mini: true,
            onPressed: () => _pickImage(ImageSource.gallery, false),
            child: Icon(Icons.camera_alt),
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePhoto() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : NetworkImage(widget.userModel.profilePhoto) as ImageProvider,
          ),
          FloatingActionButton(
            mini: true,
            onPressed: () => _pickImage(ImageSource.gallery, true),
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
