class FechBlogsModel {
  String id;
  String user_id;
  String title;
  String description;
  String posted;
  String category;
  String thumbnail;
  String view;
  String shared;
  String content;
  String tags;
  final author;
  final tags_array;
  String url;
  String category_link;
  String category_name;
  bool is_post_admin;
  final reaction;

  FechBlogsModel({
    required this.content,
    required this.reaction,
    required this.is_post_admin,
    required this.category_name,
    required this.category_link,
    required this.url,
    required this.tags_array,
    required this.author,
    required this.tags,
    required this.shared,
    required this.view,
    required this.thumbnail,
    required this.category,
    required this.posted,
    required this.description,
    required this.title,
    required this.id,
    required this.user_id,
  });

  factory FechBlogsModel.fromJson(Map<String, dynamic> map) => FechBlogsModel(
        content: map['content'] == null ? '' : map['content'],
        reaction: map['reaction'] == null ? '' : map['reaction'],
        is_post_admin:
            map['is_post_admin'] == null ? false : map['is_post_admin'],
        category_name: map['category_name'] == null ? '' : map['category_name'],
        category_link: map['category_link'] == null ? '' : map['category_link'],
        url: map['url'] == null ? '' : map['url'],
        tags_array: map['tags_array'] == null ? '' : map['tags_array'],
        author: map['author'] == null ? '' : map['author'],
        tags: map['tags'] == null ? '' : map['tags'],
        shared: map['shared'] == null ? '' : map['shared'],
        view: map['view'] == null ? '' : map['view'],
        thumbnail: map['thumbnail'] == null ? '' : map['thumbnail'],
        category: map['category'] == null ? '' : map['category'],
        posted: map['posted'] == null ? '' : map['posted'],
        description: map['description'] == null ? '' : map['description'],
        title: map['title'] == null ? '' : map['title'],
        user_id: map['user'] == null ? '' : map['user'],
        id: map['id'] == null ? "" : map['id'],
      );
}
