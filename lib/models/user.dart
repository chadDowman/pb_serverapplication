class User{
  final String uid;

  User({this.uid});
}

class UserAccountData{
  final String uid;
  final String username;
  final String role;
  final String imgUrl;

  UserAccountData({this.uid, this.username, this.role, this.imgUrl});
}