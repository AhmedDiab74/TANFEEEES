import 'package:meta/meta.dart';

class User {
  final String name;
  final String profileImageUrl;

   User({
    required this.name,
    required this.profileImageUrl,
  });
}




enum MediaType {
  image,
  video,
}

class Story {
    int countLike;
  final String user_id;
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;
  final String time;
final   bool is_owner;
 String id_ads;
 bool is_reacted;
final int view_count;
final story_id;

   Story({
    required this.countLike,
    required this.user_id,
    required this. is_reacted,
    required this.view_count,
    required this.story_id,
    required this.time,
    required this.id_ads,
    required this.is_owner,
    required this.url,
    required this.media,
    required this.duration,
    required this.user,
  });
}
