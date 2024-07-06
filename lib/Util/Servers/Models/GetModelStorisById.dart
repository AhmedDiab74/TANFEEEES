class GetModelStorisById {
final images;
final videos;
final thumb;

  GetModelStorisById(
      {required this.images,required this.videos,required this.thumb,});

  factory GetModelStorisById.fromJson(
          Map<String, dynamic> map) =>
      GetModelStorisById(
        thumb:map['thumb']==null?'':map['thumb'],
        images:map['images']==null?'':map['images'],
          videos:map['videos']==null?'':map['videos'],
          ////
          );
}

