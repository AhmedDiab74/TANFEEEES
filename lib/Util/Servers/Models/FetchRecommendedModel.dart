class FetchRecommendedModel {
  String name;
  String user_id;
  String cover;
  String avatar;
  String confirm_followers;

  FetchRecommendedModel({
    required this.confirm_followers,
    required this.name,
    required this.user_id,
    required this.cover,
    required this.avatar,
  });

  factory FetchRecommendedModel.fromJson(Map<String, dynamic> map) =>
      FetchRecommendedModel(
        confirm_followers:
            map['confirm_followers'] == null ? '' : map['confirm_followers'],
        name: map['name'] == null ? '' : map['name'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        cover: map['cover'] == null ? '' : map['cover'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
      );
}
