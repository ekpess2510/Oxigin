class SearchModel {
  String? id;
  String? name;
  String? commonName;
  String? sexFilter;
  String? category;
  String? seriousness;

  SearchModel({
    this.id,
    this.name,
    this.commonName,
    this.sexFilter,
    this.category,
    this.seriousness,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    commonName = json['common_name'];
    sexFilter = json['sex_filter'];
    category = json['category'];
    seriousness = json['seriousness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['common_name'] = this.commonName;
    data['sex_filter'] = this.sexFilter;
    data['category'] = this.category;
    data['seriousness'] = this.seriousness;
    return data;
  }
}
