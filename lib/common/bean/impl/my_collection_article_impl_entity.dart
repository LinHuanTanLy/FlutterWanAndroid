class MyCollectionArticleImplEntity {
	MyCollectionArticleImplData data;
	int errorCode;
	String errorMsg;

	MyCollectionArticleImplEntity({this.data, this.errorCode, this.errorMsg});

	MyCollectionArticleImplEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new MyCollectionArticleImplData.fromJson(json['data']) : null;
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

class MyCollectionArticleImplData {
	bool over;
	int pageCount;
	int total;
	int curPage;
	int offset;
	int size;
	List<MyCollectionArticleImplDataData> datas;

	MyCollectionArticleImplData({this.over, this.pageCount, this.total, this.curPage, this.offset, this.size, this.datas});

	MyCollectionArticleImplData.fromJson(Map<String, dynamic> json) {
		over = json['over'];
		pageCount = json['pageCount'];
		total = json['total'];
		curPage = json['curPage'];
		offset = json['offset'];
		size = json['size'];
		if (json['datas'] != null) {
			datas = new List<MyCollectionArticleImplDataData>();(json['datas'] as List).forEach((v) { datas.add(new MyCollectionArticleImplDataData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['over'] = this.over;
		data['pageCount'] = this.pageCount;
		data['total'] = this.total;
		data['curPage'] = this.curPage;
		data['offset'] = this.offset;
		data['size'] = this.size;
		if (this.datas != null) {
      data['datas'] =  this.datas.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class MyCollectionArticleImplDataData {
	int publishTime;
	int visible;
	String niceDate;
	String author;
	int zan;
	String origin;
	String chapterName;
	String link;
	String title;
	int userId;
	int originId;
	String envelopePic;
	int chapterId;
	int id;
	int courseId;
	String desc;

	MyCollectionArticleImplDataData({this.publishTime, this.visible, this.niceDate, this.author, this.zan, this.origin, this.chapterName, this.link, this.title, this.userId, this.originId, this.envelopePic, this.chapterId, this.id, this.courseId, this.desc});

	MyCollectionArticleImplDataData.fromJson(Map<String, dynamic> json) {
		publishTime = json['publishTime'];
		visible = json['visible'];
		niceDate = json['niceDate'];
		author = json['author'];
		zan = json['zan'];
		origin = json['origin'];
		chapterName = json['chapterName'];
		link = json['link'];
		title = json['title'];
		userId = json['userId'];
		originId = json['originId'];
		envelopePic = json['envelopePic'];
		chapterId = json['chapterId'];
		id = json['id'];
		courseId = json['courseId'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['publishTime'] = this.publishTime;
		data['visible'] = this.visible;
		data['niceDate'] = this.niceDate;
		data['author'] = this.author;
		data['zan'] = this.zan;
		data['origin'] = this.origin;
		data['chapterName'] = this.chapterName;
		data['link'] = this.link;
		data['title'] = this.title;
		data['userId'] = this.userId;
		data['originId'] = this.originId;
		data['envelopePic'] = this.envelopePic;
		data['chapterId'] = this.chapterId;
		data['id'] = this.id;
		data['courseId'] = this.courseId;
		data['desc'] = this.desc;
		return data;
	}
}
