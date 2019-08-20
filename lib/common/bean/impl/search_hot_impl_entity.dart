class SearchHotImplEntity {
	List<SearchHotImplData> data;
	int errorCode;
	String errorMsg;

	SearchHotImplEntity({this.data, this.errorCode, this.errorMsg});

	SearchHotImplEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = new List<SearchHotImplData>();(json['data'] as List).forEach((v) { data.add(new SearchHotImplData.fromJson(v)); });
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

class SearchHotImplData {
	int visible;
	String link;
	String name;
	int id;
	int order;

	SearchHotImplData({this.visible, this.link, this.name, this.id, this.order});

	SearchHotImplData.fromJson(Map<String, dynamic> json) {
		visible = json['visible'];
		link = json['link'];
		name = json['name'];
		id = json['id'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visible'] = this.visible;
		data['link'] = this.link;
		data['name'] = this.name;
		data['id'] = this.id;
		data['order'] = this.order;
		return data;
	}
}
