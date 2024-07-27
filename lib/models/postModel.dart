class Posts {
  final String postId;
  final String name;
  final String uId;
  final String profilePhoto;
  final String postTime;
  final String text;
  final String imageUrl;
  final int likes;

  Posts({
    required this.postId,
    required this.name,
    required this.uId,
    required this.profilePhoto,
    required this.postTime,
    required this.text,
    required this.imageUrl,
    required this.likes,
  });

  factory Posts.fromJson(String id, Map<String, dynamic> json) {
    return Posts(
      postId: id??'',
      name: json['name']??'',
      uId: json['uId']??'',
      profilePhoto: json['profilePhoto']??'',
      postTime: json['postTime']??'',
      text: json['text']??'',
      imageUrl: json['imageUrl']??'',
      likes:0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'profilePhoto': profilePhoto,
      'postTime': postTime,
      'text': text,
      'imageUrl': imageUrl,
      'likes': likes,
    };
  }
}
