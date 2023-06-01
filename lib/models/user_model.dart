class UserModal {
  String? displayName;
  String? email;
  String? photoURL;

  UserModal({this.displayName, this.email, this.photoURL});

  UserModal.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoURL'] = photoURL;
    return data;
  }
}
