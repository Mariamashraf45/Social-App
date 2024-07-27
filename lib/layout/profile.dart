import 'package:fire/layout/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:fire/models/userModel.dart' as userModelPrefix;

class ProfileScreen extends StatefulWidget {
  final userModelPrefix.Users userModel;

  ProfileScreen({required this.userModel});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late userModelPrefix.Users userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  void _updateUserModel(userModelPrefix.Users updatedUser) {
    setState(() {
      userModel = updatedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final updatedUser = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    userModel: userModel,
                  ),
                ),
              );
              if (updatedUser != null) {
                _updateUserModel(updatedUser);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 350,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(userModel.coverPhoto),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 50)
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 96,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage: NetworkImage(userModel.profilePhoto),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Center(
              child: Column(
                children: [
                  Text(
                    userModel.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userModel.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userModel.bio,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Location: San Francisco, CA',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  _buildProfileOption(
                    icon: Icons.post_add,
                    title: 'My Posts',
                    onTap: () {
                      // Handle viewing user's posts
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      // Handle settings
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      // Handle logout
                    },
                    color: Colors.red,
                  ),
                  Divider(),
                  _buildProfileOption(
                    icon: Icons.people,
                    title: 'Friends',
                    onTap: () {
                      // Handle viewing friends
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.photo,
                    title: 'Photos',
                    onTap: () {
                      // Handle viewing photos
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.event,
                    title: 'Events',
                    onTap: () {
                      // Handle viewing events
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        Divider(),
      ],
    );
  }
}
