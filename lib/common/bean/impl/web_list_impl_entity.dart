class WebListImplEntity {
	List<WebListImplData> data;
	int errorCode;
	String errorMsg;

	WebListImplEntity({this.data, this.errorCode, this.errorMsg});

	WebListImplEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = new List<WebListImplData>();(json['data'] as List).forEach((v) { data.add(new WebListImplData.fromJson(v)); });
		}
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class WebListImplData {
	int visible;
	String icon;
	String link;
	String name;
	int id;
	int userId;
	String desc;
	int order;

	WebListImplData({this.visible, this.icon, this.link, this.name, this.id, this.userId, this.desc, this.order});

	WebListImplData.fromJson(Map<String, dynamic> json) {
		visible = json['visible'];
		icon = json['icon'];
		link = json['link'];
		name = json['name'];
		id = json['id'];
		userId = json['userId'];
		desc = json['desc'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visible'] = this.visible;
		data['icon'] = this.icon;
		data['link'] = this.link;
		data['name'] = this.name;
		data['id'] = this.id;
		data['userId'] = this.userId;
		data['desc'] = this.desc;
		data['order'] = this.order;
		return data;
	}
}
