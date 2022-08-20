class Suggest {
  Suggest({
    required this.id,
    required this.name,
    required this.commonName,
  });

  final String id;
  final String name;
  final String commonName;

  factory Suggest.fromJson(Map<String, dynamic> json){
    return Suggest(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      commonName: json["common_name"] ?? "",
    );
  }

  @override
  String toString(){
    return '$id, $name, $commonName';
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "common_name": commonName,
  };
}
