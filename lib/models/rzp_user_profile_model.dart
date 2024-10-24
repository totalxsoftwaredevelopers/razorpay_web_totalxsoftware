class RzpUserProfile {
  String? name;
  String? phoneNumber;
  String? email;
  String? uid;
  RzpUserProfile({
    this.name,
    this.phoneNumber,
    this.email,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'uid': uid,
    };
  }

  factory RzpUserProfile.fromMap(Map<String, dynamic> map) {
    return RzpUserProfile(
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      uid: map['uid'] as String,
    );
  }
}
