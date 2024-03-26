class GetAllSearchJobPosts {
  bool? isError;
  List<SearchJobList>? data;
  String? message;

  GetAllSearchJobPosts({this.isError, this.data, this.message});

  GetAllSearchJobPosts.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <SearchJobList>[];
      json['data'].forEach((v) {
        data!.add(new SearchJobList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_error'] = this.isError;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class SearchJobList {
  int? id;
  int? userId;
  String? description;
  String? post;
  int? vacancy;
  String? skills;
  String? ageCriteria;
  int? state;
  String? companyAddress;
  String? website;
  String? position;
  int? isClosed;
  int? city;
  String? isSave;
  String? isApply;
  String? createdAt;
  File? file;
  String? profilePhoto;

  SearchJobList(
      {this.id,
        this.userId,
        this.description,
        this.post,
        this.vacancy,
        this.skills,
        this.ageCriteria,
        this.state,
        this.companyAddress,
        this.website,
        this.position,
        this.isClosed,
        this.city,
        this.isSave,
        this.isApply,
        this.createdAt,
        this.file,
        this.profilePhoto});

  SearchJobList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    post = json['post'];
    vacancy = json['vacancy'];
    skills = json['skills'];
    ageCriteria = json['age_criteria'];
    state = json['state'];
    companyAddress = json['company_address'];
    website = json['website'];
    position = json['position'];
    isClosed = json['is_closed'];
    city = json['city'];
    isSave = json['is_save'];
    isApply = json['is_apply'];
    createdAt = json['created_at'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['post'] = this.post;
    data['vacancy'] = this.vacancy;
    data['skills'] = this.skills;
    data['age_criteria'] = this.ageCriteria;
    data['state'] = this.state;
    data['company_address'] = this.companyAddress;
    data['website'] = this.website;
    data['position'] = this.position;
    data['is_closed'] = this.isClosed;
    data['city'] = this.city;
    data['is_save'] = this.isSave;
    data['is_apply'] = this.isApply;
    data['created_at'] = this.createdAt;
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class File {
  int? id;
  String? fileName;
  String? mainImageUrl;
  String? thumbImageUrl;

  File({this.id, this.fileName, this.mainImageUrl, this.thumbImageUrl});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    mainImageUrl = json['main_image_url'];
    thumbImageUrl = json['thumb_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['main_image_url'] = this.mainImageUrl;
    data['thumb_image_url'] = this.thumbImageUrl;
    return data;
  }
}