class GetAllFrindsModel {
  String user_id;
  String name;
  String avatar;
  String username;
  String cover;
  final friends_count;
  final chat_color;
  GetAllFrindsModel({
    required this.friends_count,
    required this.user_id,
    required this.name,
    required this.avatar,
    required this.username,
    required this.chat_color,
    required this.cover,
  });

  factory GetAllFrindsModel.fromJson(Map<String, dynamic> map) =>
      GetAllFrindsModel(
        username: map['username'] == null ? '' : map['username'],
        friends_count: map['details']['mutual_friends_count'] == null
            ? ''
            : map['details']['mutual_friends_count'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        name: map['name'] == null ? '' : map['name'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
        chat_color:  map['name'] == null ? '' :  map['name'],
        cover:  map['cover'] == null ? '' :  map['cover'],
      );
}
