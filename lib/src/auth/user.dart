class User {
  dynamic id;
  String name;
  String email;
  String phone;
  String photoUrl;
  String accessToken;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.accessToken,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photoUrl: map['photo_url'],
      accessToken: map['api_token'],
    );
  }
}
