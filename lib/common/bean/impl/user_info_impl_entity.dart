import '../BaseBean.dart';

class UserInfoImplEntity extends BaseBean{
	UserInfoImplData data;
	int errorCode;
	String errorMsg;

	UserInfoImplEntity({this.data, this.errorCode, this.errorMsg});

	UserInfoImplEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new UserInfoImplData.fromJson(json['data']) : null;
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}


	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class UserInfoImplData {
	String password;
	List<Null> chapterTops;
	String icon;
	String nickname;
	bool admin;
	List<int> collectIds;
	int id;
	int type;
	String email;
	String token;
	String username;

	UserInfoImplData({this.password, this.chapterTops, this.icon, this.nickname, this.admin, this.collectIds, this.id, this.type, this.email, this.token, this.username});

	UserInfoImplData.fromJson(Map<String, dynamic> json) {
		password = json['password'];
		if (json['chapterTops'] != null) {
			chapterTops = new List<Null>();
		}
		icon = json['icon'];
		nickname = json['nickname'];
		admin = json['admin'];
		collectIds = json['collectIds']?.cast<int>();
		id = json['id'];
		type = json['type'];
		email = json['email'];
		token = json['token'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['password'] = this.password;
		if (this.chapterTops != null) {
      data['chapterTops'] =  [];
    }
		data['icon'] = this.icon;
		data['nickname'] = this.nickname;
		data['admin'] = this.admin;
		data['collectIds'] = this.collectIds;
		data['id'] = this.id;
		data['type'] = this.type;
		data['email'] = this.email;
		data['token'] = this.token;
		data['username'] = this.username;
		return data;
	}
}
