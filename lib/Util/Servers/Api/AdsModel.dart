class AdsModel {
  String url;
  String headline;
  String description;
  String ad_media;
  String bidding;
  AdsModel({
    required this.url,
    required this.headline,
    required this.description,
    required this.ad_media,
    required this.bidding,
  });

  factory AdsModel.fromJson(Map<String, dynamic> map) => AdsModel(
        ad_media: map['ad_media'] == null ? '' : map['ad_media'],
        url: map['url'] == null ? '' : map['url'],
        headline: map['headline'] == null ? '' : map['headline'],
        description: map['description'] == null ? '' : map['description'],
        bidding:map['bidding']==null?'':map['bidding'],
      );
}
