class Condition {
  Condition({
    required this.id,
    required this.name,
    required this.commonName,
    required this.sexFilter,
    required this.categories,
    required this.prevalence,
    required this.acuteness,
    required this.severity,
    required this.extras,
    required this.triageLevel,
    required this.recommendedChannel,
  });

  final String id;
  final String name;
  final String commonName;
  final String sexFilter;
  final List<String> categories;
  final String prevalence;
  final String acuteness;
  final String severity;
  final Extras? extras;
  final String triageLevel;
  final String recommendedChannel;

  factory Condition.fromJson(Map<String, dynamic> json){
    return Condition(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      commonName: json["common_name"] ?? "",
      sexFilter: json["sex_filter"] ?? "",
      categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
      prevalence: json["prevalence"] ?? "",
      acuteness: json["acuteness"] ?? "",
      severity: json["severity"] ?? "",
      extras: json["extras"] == null ? null : Extras.fromJson(json["extras"]),
      triageLevel: json["triage_level"] ?? "",
      recommendedChannel: json["recommended_channel"] ?? "",
    );
  }

  @override
  String toString(){
    return '$id, $name, $commonName, $sexFilter, $categories, $prevalence, $acuteness, $severity, $extras, $triageLevel, $recommendedChannel';
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "common_name": commonName,
    "sex_filter": sexFilter,
    "categories": List<String>.from(categories.map((x) => x)),
    "prevalence": prevalence,
    "acuteness": acuteness,
    "severity": severity,
    "extras": extras?.toJson(),
    "triage_level": triageLevel,
    "recommended_channel": recommendedChannel,
  };
}

class Extras {
  Extras({
    required this.icd10Code,
    required this.hint,
  });

  final String icd10Code;
  final String hint;

  factory Extras.fromJson(Map<String, dynamic> json){
    return Extras(
      icd10Code: json["icd10_code"] ?? "",
      hint: json["hint"] ?? "Please consult a doctor",
    );
  }

  @override
  String toString(){
    return '$icd10Code, $hint';
  }

  Map<String, dynamic> toJson() => {
    "icd10_code": icd10Code,
    "hint": hint,
  };
}
