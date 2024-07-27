class Users {
  String name;
  String phone;
  String email;
  String uId;
  String bio;
  String profilePhoto;
  String coverPhoto;

  Users({
    required this.name,
    required this.phone,
    required this.email,
    required this.uId,
    required this.bio,
    required this.profilePhoto,
    required this.coverPhoto,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name']??'empty name',
      phone: json['phone']??'emopty phone',
      email: json['email']??'empty email',
      uId: json['uId']??' empty uid',
      bio: json['bio']??' empty bio',
      profilePhoto: json['profilePhoto']??'' ,
      coverPhoto: json['coverPhoto']?? 'empty cover',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'bio': bio,
      'profilePhoto': profilePhoto,
      'coverPhoto': coverPhoto,
    };
  }
}
