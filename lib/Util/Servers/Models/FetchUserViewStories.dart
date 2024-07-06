class FetchUserViewStories {
  String user_id;
  String name;
  String avatar;

  FetchUserViewStories(
      {required this.avatar,
      required this.name,
      required this.user_id
      ////details
      });

  factory FetchUserViewStories.fromJson(Map<String, dynamic> map) => FetchUserViewStories(

      user_id: map['user_id'] == null ? '' : map['user_id'],
      avatar: map['avatar'] == null ? '' : map['avatar'],
      name: map['name'] == null ? '' : map['name']);

  /////details
}
