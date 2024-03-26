class GetAppCountData {
  bool? isError;
  List<CountList>? data;
  String? message;
  List<AppliedUser>? appliedUser;
  List<Sortlisted>? sortlisted;
  List<HiredUser>? hiredUser;
  List<RejectedUser>? rejectedUser;

  GetAppCountData(
      {this.isError,
        this.data,
        this.message,
        this.appliedUser,
        this.sortlisted,
        this.hiredUser,
        this.rejectedUser});

  GetAppCountData.fromJson(Map<String, dynamic> json) {
    isError = json['is_error'];
    if (json['data'] != null) {
      data = <CountList>[];
      json['data'].forEach((v) {
        data!.add(new CountList.fromJson(v));
      });
    }
    message = json['message'];
    if (json['applied_user'] != null) {
      appliedUser = <AppliedUser>[];
      json['applied_user'].forEach((v) {
        appliedUser!.add(new AppliedUser.fromJson(v));
      });
    }
    if (json['sortlisted'] != null) {
      sortlisted = <Sortlisted>[];
      json['sortlisted'].forEach((v) {
        sortlisted!.add(new Sortlisted.fromJson(v));
      });
    }
    if (json['hired'] != null) {
      hiredUser = <HiredUser>[];
      json['hired'].forEach((v) {
        hiredUser!.add(new HiredUser.fromJson(v));
      });
    }

    if (json['rejected'] != null) {
      rejectedUser = <RejectedUser>[];
      json['rejected'].forEach((v) {
        rejectedUser!.add(new RejectedUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_error'] = this.isError;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.appliedUser != null) {
      data['applied_user'] = this.appliedUser!.map((v) => v.toJson()).toList();
    }
    if (this.sortlisted != null) {
      data['sortlisted'] = this.sortlisted!.map((v) => v.toJson()).toList();
    }
    if (this.hiredUser != null) {
      data['hired'] = this.hiredUser!.map((v) => v.toJson()).toList();
    }
    if (this.rejectedUser != null) {
      data['rejected'] = this.rejectedUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountList {
  int? applied;
  int? sortlisted;
  int? rejected;
  int? hired;
  int? totalJobs;

  CountList(
      {this.applied,
        this.sortlisted,
        this.rejected,
        this.hired,
        this.totalJobs});

  CountList.fromJson(Map<String, dynamic> json) {
    applied = json['applied'];
    sortlisted = json['sortlisted'];
    rejected = json['rejected'];
    hired = json['hired'];
    totalJobs = json['total_jobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applied'] = this.applied;
    data['sortlisted'] = this.sortlisted;
    data['rejected'] = this.rejected;
    data['hired'] = this.hired;
    data['total_jobs'] = this.totalJobs;
    return data;
  }
}

class AppliedUser {
  String? profileImage;
  Null? coverPhoto;
  String? bio;
  String? experience;
  String? resume;
  int? id;
  String? name;
  String? email;
  String? contactNo;
  Null? website;
  Null? position;
  int? age;
  String? location;
  String? gender;
  String? about;
  Null? address;
  Null? socialId;
  Null? deviceId;
  Null? platform;
  Null? fcmKey;
  String? role;
  Null? companyLogo;
  Null? companyName;
  Null? city;
  Null? area;
  Null? companyUrl;
  Null? aboutCompany;
  Null? gstNum;
  String? referenceCode;
  Null? referFrom;
  String? referCode;
  Null? socialLogin;
  String? fcm;
  Null? endDate;
  String? createdAt;
  String? updatedAt;

  AppliedUser(
      {this.profileImage,
        this.coverPhoto,
        this.bio,
        this.experience,
        this.resume,
        this.id,
        this.name,
        this.email,
        this.contactNo,
        this.website,
        this.position,
        this.age,
        this.location,
        this.gender,
        this.about,
        this.address,
        this.socialId,
        this.deviceId,
        this.platform,
        this.fcmKey,
        this.role,
        this.companyLogo,
        this.companyName,
        this.city,
        this.area,
        this.companyUrl,
        this.aboutCompany,
        this.gstNum,
        this.referenceCode,
        this.referFrom,
        this.referCode,
        this.socialLogin,
        this.fcm,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  AppliedUser.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    coverPhoto = json['cover_photo'];
    bio = json['bio'];
    experience = json['experience'];
    resume = json['resume'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    website = json['website'];
    position = json['position'];
    age = json['age'];
    location = json['location'];
    gender = json['gender'];
    about = json['about'];
    address = json['address'];
    socialId = json['social_id'];
    deviceId = json['device_id'];
    platform = json['platform'];
    fcmKey = json['fcm_key'];
    role = json['role'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
    city = json['city'];
    area = json['area'];
    companyUrl = json['company_url'];
    aboutCompany = json['about_company'];
    gstNum = json['gst_num'];
    referenceCode = json['reference_code'];
    referFrom = json['refer_from'];
    referCode = json['refer_code'];
    socialLogin = json['social_login'];
    fcm = json['fcm'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['cover_photo'] = this.coverPhoto;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['resume'] = this.resume;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['website'] = this.website;
    data['position'] = this.position;
    data['age'] = this.age;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['address'] = this.address;
    data['social_id'] = this.socialId;
    data['device_id'] = this.deviceId;
    data['platform'] = this.platform;
    data['fcm_key'] = this.fcmKey;
    data['role'] = this.role;
    data['company_logo'] = this.companyLogo;
    data['company_name'] = this.companyName;
    data['city'] = this.city;
    data['area'] = this.area;
    data['company_url'] = this.companyUrl;
    data['about_company'] = this.aboutCompany;
    data['gst_num'] = this.gstNum;
    data['reference_code'] = this.referenceCode;
    data['refer_from'] = this.referFrom;
    data['refer_code'] = this.referCode;
    data['social_login'] = this.socialLogin;
    data['fcm'] = this.fcm;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }


}

class Sortlisted {
  String? profileImage;
  Null? coverPhoto;
  String? bio;
  String? experience;
  String? resume;
  int? id;
  String? name;
  String? email;
  String? contactNo;
  Null? website;
  Null? position;
  int? age;
  String? location;
  String? gender;
  String? about;
  Null? address;
  Null? socialId;
  Null? deviceId;
  Null? platform;
  Null? fcmKey;
  String? role;
  Null? companyLogo;
  Null? companyName;
  Null? city;
  Null? area;
  Null? companyUrl;
  Null? aboutCompany;
  Null? gstNum;
  String? referenceCode;
  Null? referFrom;
  String? referCode;
  Null? socialLogin;
  String? fcm;
  Null? endDate;
  String? createdAt;
  String? updatedAt;

  Sortlisted(
      {this.profileImage,
        this.coverPhoto,
        this.bio,
        this.experience,
        this.resume,
        this.id,
        this.name,
        this.email,
        this.contactNo,
        this.website,
        this.position,
        this.age,
        this.location,
        this.gender,
        this.about,
        this.address,
        this.socialId,
        this.deviceId,
        this.platform,
        this.fcmKey,
        this.role,
        this.companyLogo,
        this.companyName,
        this.city,
        this.area,
        this.companyUrl,
        this.aboutCompany,
        this.gstNum,
        this.referenceCode,
        this.referFrom,
        this.referCode,
        this.socialLogin,
        this.fcm,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  Sortlisted.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    coverPhoto = json['cover_photo'];
    bio = json['bio'];
    experience = json['experience'];
    resume = json['resume'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    website = json['website'];
    position = json['position'];
    age = json['age'];
    location = json['location'];
    gender = json['gender'];
    about = json['about'];
    address = json['address'];
    socialId = json['social_id'];
    deviceId = json['device_id'];
    platform = json['platform'];
    fcmKey = json['fcm_key'];
    role = json['role'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
    city = json['city'];
    area = json['area'];
    companyUrl = json['company_url'];
    aboutCompany = json['about_company'];
    gstNum = json['gst_num'];
    referenceCode = json['reference_code'];
    referFrom = json['refer_from'];
    referCode = json['refer_code'];
    socialLogin = json['social_login'];
    fcm = json['fcm'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['cover_photo'] = this.coverPhoto;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['resume'] = this.resume;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['website'] = this.website;
    data['position'] = this.position;
    data['age'] = this.age;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['address'] = this.address;
    data['social_id'] = this.socialId;
    data['device_id'] = this.deviceId;
    data['platform'] = this.platform;
    data['fcm_key'] = this.fcmKey;
    data['role'] = this.role;
    data['company_logo'] = this.companyLogo;
    data['company_name'] = this.companyName;
    data['city'] = this.city;
    data['area'] = this.area;
    data['company_url'] = this.companyUrl;
    data['about_company'] = this.aboutCompany;
    data['gst_num'] = this.gstNum;
    data['reference_code'] = this.referenceCode;
    data['refer_from'] = this.referFrom;
    data['refer_code'] = this.referCode;
    data['social_login'] = this.socialLogin;
    data['fcm'] = this.fcm;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}

class HiredUser {
  String? profileImage;
  Null? coverPhoto;
  String? bio;
  String? experience;
  String? resume;
  int? id;
  String? name;
  String? email;
  String? contactNo;
  Null? website;
  Null? position;
  int? age;
  String? location;
  String? gender;
  String? about;
  Null? address;
  Null? socialId;
  Null? deviceId;
  Null? platform;
  Null? fcmKey;
  String? role;
  Null? companyLogo;
  Null? companyName;
  Null? city;
  Null? area;
  Null? companyUrl;
  Null? aboutCompany;
  Null? gstNum;
  String? referenceCode;
  Null? referFrom;
  String? referCode;
  Null? socialLogin;
  String? fcm;
  Null? endDate;
  String? createdAt;
  String? updatedAt;

  HiredUser(
      {this.profileImage,
        this.coverPhoto,
        this.bio,
        this.experience,
        this.resume,
        this.id,
        this.name,
        this.email,
        this.contactNo,
        this.website,
        this.position,
        this.age,
        this.location,
        this.gender,
        this.about,
        this.address,
        this.socialId,
        this.deviceId,
        this.platform,
        this.fcmKey,
        this.role,
        this.companyLogo,
        this.companyName,
        this.city,
        this.area,
        this.companyUrl,
        this.aboutCompany,
        this.gstNum,
        this.referenceCode,
        this.referFrom,
        this.referCode,
        this.socialLogin,
        this.fcm,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  HiredUser.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    coverPhoto = json['cover_photo'];
    bio = json['bio'];
    experience = json['experience'];
    resume = json['resume'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    website = json['website'];
    position = json['position'];
    age = json['age'];
    location = json['location'];
    gender = json['gender'];
    about = json['about'];
    address = json['address'];
    socialId = json['social_id'];
    deviceId = json['device_id'];
    platform = json['platform'];
    fcmKey = json['fcm_key'];
    role = json['role'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
    city = json['city'];
    area = json['area'];
    companyUrl = json['company_url'];
    aboutCompany = json['about_company'];
    gstNum = json['gst_num'];
    referenceCode = json['reference_code'];
    referFrom = json['refer_from'];
    referCode = json['refer_code'];
    socialLogin = json['social_login'];
    fcm = json['fcm'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['cover_photo'] = this.coverPhoto;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['resume'] = this.resume;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['website'] = this.website;
    data['position'] = this.position;
    data['age'] = this.age;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['address'] = this.address;
    data['social_id'] = this.socialId;
    data['device_id'] = this.deviceId;
    data['platform'] = this.platform;
    data['fcm_key'] = this.fcmKey;
    data['role'] = this.role;
    data['company_logo'] = this.companyLogo;
    data['company_name'] = this.companyName;
    data['city'] = this.city;
    data['area'] = this.area;
    data['company_url'] = this.companyUrl;
    data['about_company'] = this.aboutCompany;
    data['gst_num'] = this.gstNum;
    data['reference_code'] = this.referenceCode;
    data['refer_from'] = this.referFrom;
    data['refer_code'] = this.referCode;
    data['social_login'] = this.socialLogin;
    data['fcm'] = this.fcm;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}

class RejectedUser {
  String? profileImage;
  Null? coverPhoto;
  String? bio;
  String? experience;
  String? resume;
  int? id;
  String? name;
  String? email;
  String? contactNo;
  Null? website;
  Null? position;
  int? age;
  String? location;
  String? gender;
  String? about;
  Null? address;
  Null? socialId;
  Null? deviceId;
  Null? platform;
  Null? fcmKey;
  String? role;
  Null? companyLogo;
  Null? companyName;
  Null? city;
  Null? area;
  Null? companyUrl;
  Null? aboutCompany;
  Null? gstNum;
  String? referenceCode;
  Null? referFrom;
  String? referCode;
  Null? socialLogin;
  String? fcm;
  Null? endDate;
  String? createdAt;
  String? updatedAt;

  RejectedUser(
      {this.profileImage,
        this.coverPhoto,
        this.bio,
        this.experience,
        this.resume,
        this.id,
        this.name,
        this.email,
        this.contactNo,
        this.website,
        this.position,
        this.age,
        this.location,
        this.gender,
        this.about,
        this.address,
        this.socialId,
        this.deviceId,
        this.platform,
        this.fcmKey,
        this.role,
        this.companyLogo,
        this.companyName,
        this.city,
        this.area,
        this.companyUrl,
        this.aboutCompany,
        this.gstNum,
        this.referenceCode,
        this.referFrom,
        this.referCode,
        this.socialLogin,
        this.fcm,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  RejectedUser.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    coverPhoto = json['cover_photo'];
    bio = json['bio'];
    experience = json['experience'];
    resume = json['resume'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    website = json['website'];
    position = json['position'];
    age = json['age'];
    location = json['location'];
    gender = json['gender'];
    about = json['about'];
    address = json['address'];
    socialId = json['social_id'];
    deviceId = json['device_id'];
    platform = json['platform'];
    fcmKey = json['fcm_key'];
    role = json['role'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
    city = json['city'];
    area = json['area'];
    companyUrl = json['company_url'];
    aboutCompany = json['about_company'];
    gstNum = json['gst_num'];
    referenceCode = json['reference_code'];
    referFrom = json['refer_from'];
    referCode = json['refer_code'];
    socialLogin = json['social_login'];
    fcm = json['fcm'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['cover_photo'] = this.coverPhoto;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['resume'] = this.resume;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['website'] = this.website;
    data['position'] = this.position;
    data['age'] = this.age;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['address'] = this.address;
    data['social_id'] = this.socialId;
    data['device_id'] = this.deviceId;
    data['platform'] = this.platform;
    data['fcm_key'] = this.fcmKey;
    data['role'] = this.role;
    data['company_logo'] = this.companyLogo;
    data['company_name'] = this.companyName;
    data['city'] = this.city;
    data['area'] = this.area;
    data['company_url'] = this.companyUrl;
    data['about_company'] = this.aboutCompany;
    data['gst_num'] = this.gstNum;
    data['reference_code'] = this.referenceCode;
    data['refer_from'] = this.referFrom;
    data['refer_code'] = this.referCode;
    data['social_login'] = this.socialLogin;
    data['fcm'] = this.fcm;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}