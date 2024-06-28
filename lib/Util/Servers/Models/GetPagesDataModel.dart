class GetPagesDataModel {
  String call_action_type;
  String page_title;
  String about;
  String avatar;
  String cover;
  String website;
  String page_name;
  String company;
  String phone;
  String address;
  final is_reported;
  final is_page_onwer;
  final is_verified;
  String page_category;
  String call_action_type_text;
  final likes_count;
  final is_rated;
  String call_action_type_url;
  String users_post;
  String google;
  String vk;
  String twitter;
  String linkedin;
  String instgram;
  String youtube;
  String facebook;
  String likes;
  final rating;
  String post_count;
  String prices;
  String category;
  String page_id;
  String verified;

  String sub;
  String daily;
  String weekly;
  String monthly;
  String quarterly;
  String yearly;
  String life;
  String daily_price;
  String weekly_price;
  String monthly_price;
  String quarterly_price;
  String yearly_price;
  String life_price;
  bool is_liked;
  bool paid;
  GetPagesDataModel({
    required this.page_name,
    required this.likes,
    required this.facebook,
    required this.is_reported,
    required this.call_action_type,
    required this.page_title,
    required this.about,
    required this.avatar,
    required this.cover,
    required this.website,
    required this.company,
    required this.phone,
    required this.address,
    required this.category,
    required this.is_page_onwer,
    required this.is_verified,
    required this.call_action_type_text,
    required this.likes_count,
    required this.is_liked,
    required this.is_rated,
    required this.call_action_type_url,
    required this.users_post,
    required this.google,
    required this.vk,
    required this.twitter,
    required this.linkedin,
    required this.instgram,
    required this.youtube,
    required this.rating,
    required this.post_count,
    required this.page_id,
    required this.verified,
    required this.paid,
    required this.life_price,
    required this.yearly_price,
    required this.quarterly_price,
    required this.monthly_price,
    required this.weekly_price,
    required this.daily_price,
    required this.life,
    required this.yearly,
    required this.page_category,
    required this.quarterly,
    required this.monthly,
    required this.weekly,
    required this.daily,
    required this.prices,
    required this.sub,

    //
  });

  factory GetPagesDataModel.fromJson(Map<String, dynamic> map) =>
      GetPagesDataModel(
        page_category: map['page_category'] == null ? '' : map['page_category'],
        page_name: map['page_name'] == null ? '' : map['page_name'],
        paid: map['paid'] == null ? false : map['paid'],
        is_liked: map['is_liked'] == null ? false : map['is_liked'],
        life_price: StringMap(map['life_price']),
        yearly_price: StringMap(map['yearly_price']),
        quarterly_price: StringMap(map['quarterly_price']),
        monthly_price: StringMap(map['monthly_price']),
        weekly_price: StringMap(map['weekly_price']),
        daily_price: StringMap(map['daily_price']),
        life: StringMap(map['life']),
        yearly: StringMap(map['yearly']),
        quarterly: StringMap(map['quarterly']),
        monthly: StringMap(map['monthly']),
        weekly: StringMap(map['weekly']),
        daily: map['daily'] == null ? '' : map['daily'],
        prices: map['prices'] == null ? '' : map['prices'],
        sub: map['sub'] == null ? '' : map['sub'],
        likes: map['likes'] == null ? '' : map['likes'],
        call_action_type:
            map['call_action_type'] == null ? '' : map['call_action_type'],
        page_title: map['page_title'] == null ? '' : map['page_title'],
        about: map['about'] == null ? '' : map['about'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
        cover: map['cover'] == null ? '' : map['cover'],
        website: map['website'] == null ? '' : map['website'],
        company: map['company'] == null ? '' : map['company'],
        phone: map['phone'] == null ? '' : map['phone'],
        address: map['address'] == null ? '' : map['address'],
        category: map['category'] == null ? '' : map['category'],
        is_reported: map['is_reported'] == null ? false : map['is_reported'],
        is_page_onwer:
            map['is_page_onwer'] == null ? false : map['is_page_onwer'],
        is_verified: map['is_verified'] == null ? 0 : map['is_verified'],
        call_action_type_text: map['call_action_type_text'] == null
            ? ''
            : map['call_action_type_text'],
        likes_count: map['likes_count'] == null ? '' : map['likes_count'],
        is_rated: map['is_rated'] == null ? false : map['is_rated'],
        call_action_type_url: map['call_action_type_url'] == null
            ? ''
            : map['call_action_type_url'],
        users_post: map['users_post'] == null ? '' : map['users_post'],
        google: map['google'] == null ? '' : map['google'],
        vk: map['vk'] == null ? '' : map['vk'],
        twitter: map['twitter'] == null ? '' : map['twitter'],
        linkedin: map['linkedin'] == null ? '' : map['linkedin'],
        instgram: map['instgram'] == null ? '' : map['instgram'],
        youtube: map['youtube'] == null ? '' : map['youtube'],
        rating: map['rating'] == null ? 0 : map['rating'],
        post_count: map['post_count'] == null ? '' : map['post_count'],
        facebook: map['facebook'] == null ? '' : map['facebook'],
        page_id: map['page_id'] == null ? '' : map['page_id'],
        verified: map['verified'] == null ? '' : map['verified'],
        ////
        ///
      );
}

//////////////////////////////
///
///
///

// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

StringMap(tit) {
  return tit == null ? '' : tit;
}
