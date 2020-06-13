class Article {
  int id;
  String title;
  String description;
  String url;
  String imageUrl;
  int totalCount;
  int totalPages;

  Article({this.id, this.title, this.description, this.url, this.imageUrl, this.totalCount, this.totalPages});

  static fromJson(json, headers) {
    return Article(
      title: getNestedJsonField(json['title'],'rendered'),
      description: getNestedJsonField(json['excerpt'],'rendered'),
      id: getNestedJsonField(json,'id'),
      url: getNestedJsonField(json,'link'),
      imageUrl: getNestedJsonField(json,'jetpack_featured_media_url'),
      totalCount: headers['X-WP-Total'],
      totalPages: headers['X-WP-TotalPages']
    );
  }

  static getNestedJsonField(json, field){
    return json[field];
  }
//  static fromJson(json): Article {
//  Post p = new Post()
//  p.name = ...
//    return p
//}
}
