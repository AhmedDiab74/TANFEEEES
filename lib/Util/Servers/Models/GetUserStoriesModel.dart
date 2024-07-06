class GetUserStoriesModel {
  String name;
  String avatar;
  String stories;
  String user_id;
  List<UserDataStory> storiess;

  GetUserStoriesModel(
      {required this.name,
      required this.storiess,
      required this.avatar,
      required this.stories,
      required this.user_id});

  factory GetUserStoriesModel.fromJson(
          Map<String, dynamic> map) =>
      GetUserStoriesModel(
          storiess: List<UserDataStory>.from(
              map["stories"].map((x) => UserDataStory.fromJson(x))),
          user_id: map['user_id'] == null ? '' : map['user_id'],
          stories: map['stories'].length == 0
              ? ''
              : map['stories'][0]['thumbnail'],
          name: map['name'] == null ? '' : map['name'],
          avatar: map['avatar'] == null ? '' : map['avatar']
          ////
          );
}

class UserDataStory {
  String user_id;
  String id;
  String time_text;
  String thumbnail;
  String description;
  bool is_reacted;
  int countLike;
  bool is_owner;
  int view_count;
  String timeVid;
  String ad_id;
  // String filename;
  List<Videos> videos;
  

  UserDataStory({
    required this.ad_id,
    required this.countLike,
    required this.user_id,
    required this.is_reacted,
    required this.is_owner, 
    required this.time_text,
    required this.description,
    required this.videos,
    required this.view_count,
    required this.timeVid,
    //     required this.view_count,

    required this.id,
    required this.thumbnail,
  });

  factory UserDataStory.fromJson(Map<String, dynamic> map) => UserDataStory(
    ad_id:map['ad_id']==null?'':map['ad_id'],
    countLike:map['reaction']['count']==null?0:map['reaction']['count'],
    user_id:map['user_id']==null?'':map['user_id'],
    is_reacted:map['reaction']['is_reacted']==null?false:map['reaction']['is_reacted'],
    view_count:map['view_count']==null?0:map['view_count'],
    is_owner:map['is_owner']==null?false:map['is_owner'],
    time_text: map['time_text']==null?'':map['time_text'],
        description: map['description'] == null ? '' : map['description'],
        timeVid: map['timeVid'] == null ? '' : map['timeVid'],

        id: map['id'] == null ? '' : map['id'],
        videos: List<Videos>.from(map["videos"].map((x) => Videos.fromJson(x))),
        thumbnail: map['thumbnail'] == null ? '' : map['thumbnail'],
        ////
      );
}

class Videos {

  String id;
  String timeVid;
  String filename;
  Videos({
    required this.filename,
    required this.id,
    required this.timeVid,
  });

  factory Videos.fromJson(Map<String, dynamic> map) => Videos(
        timeVid: map['timeVid'] == null ? '' : map['timeVid'],
        id: map['id'] == null ? '' : map['id'],
        filename: map['filename'] == null ? '' : map['filename'],

        ////
      );
}
