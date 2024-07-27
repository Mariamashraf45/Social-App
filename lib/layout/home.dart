
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/layout/addPost.dart';
import 'package:fire/layout/notification.dart';
import 'package:fire/layout/profile.dart';
import 'package:fire/layout/usersListScreen.dart';
import 'package:fire/models/postModel.dart';
import 'package:fire/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Users userModel1;

  HomeScreen({required this.userModel1});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _screens = [];
  List<Users> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<Users> users = snapshot.docs.map((doc) => Users.fromJson(doc.data() as Map<String, dynamic>)).toList();
      setState(() {
        _users = users;
        _screens = [
          Column(
            children: [
              StoriesSection(users: _users),
              Expanded(
                child: Feed(userModel4: widget.userModel1),
              ),
            ],
          ),
          UserListScreen(currentUser: widget.userModel1,),
          NotificationPage(),
          ProfileScreen(userModel: widget.userModel1),
        ];
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Social App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.userModel1.profilePhoto),
            ),
          ),
        ],
      ),
      body: _screens.isNotEmpty ? _screens[_currentIndex] : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40),
            label: 'Home',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 40),
            label: 'Chats',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.notifications, size: 40),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 25,
                    height: 20,
                    padding: EdgeInsets.all(.5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            label: 'Notifications',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 40),
            label: 'Profile',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class StoriesSection extends StatelessWidget {
  final List<Users> users;

  StoriesSection({required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return StoryItem(userModel: users[index]);
        },
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final Users userModel;

  StoryItem({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(userModel.profilePhoto),
          ),
          SizedBox(height: 5),
          Text(
            userModel.name,
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class Feed extends StatefulWidget {
  final Users userModel4;

  Feed({required this.userModel4});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No posts found.'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final postDoc = snapshot.data!.docs[index];
                final post = Posts.fromJson(postDoc.id ,postDoc.data() as Map<String, dynamic>);
                return PostItem(post: post, userModel: widget.userModel4);
              },
            );
          },
        ),
        Positioned(
          bottom: 15,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePostScreen(currentUser: widget.userModel4),
                ),
              );
            },
            child: Icon(Icons.post_add),
          ),
        ),
      ],
    );
  }
}

class PostItem extends StatefulWidget {
  final Posts post;
  final Users userModel;

  PostItem({required this.post, required this.userModel});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.userModel.profilePhoto),
            ),
            title: Text(widget.userModel.name),
            subtitle: Text(widget.post.postTime),
            trailing: IconButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('posts').doc(widget.post.postId).delete().then((value) {
                  print('Delete success');
                });
              },
              icon: Icon(Icons.delete),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.text),
          ),
          if (widget.post.imageUrl.isNotEmpty)
            Image.network(widget.post.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        color: isLiked ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                          updateLikes(widget.post.postId, isLiked ? widget.post.likes + 1 : widget.post.likes - 1);
                        });
                      },
                    ),

                  ],
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateLikes(String postId, int newLikes) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': newLikes,
      });

      print('Likes updated successfully');
    } catch (e) {
      print('Error updating likes: $e');
    }
  }
}

