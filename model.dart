class UserModel {
  String email;
  String category;
  String uid;

// receiving data
  UserModel({required this.uid,required this.email,required this.category});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      category: map['category'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'category': category,
    };
  }
}