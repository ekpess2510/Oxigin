class Specialist {
  Specialist({
    required this.recommendedSpecialist,
    required this.recommendedChannel,
  });

  final RecommendedSpecialist? recommendedSpecialist;
  final String recommendedChannel;

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(
      recommendedSpecialist: json["recommended_specialist"] == null
          ? null
          : RecommendedSpecialist.fromJson(json["recommended_specialist"]),
      recommendedChannel: json["recommended_channel"] ?? "",
    );
  }

  @override
  String toString() {
    return '$recommendedSpecialist, $recommendedChannel';
  }

  Map<String, dynamic> toJson() => {
        "recommended_specialist": recommendedSpecialist?.toJson(),
        "recommended_channel": recommendedChannel,
      };
}

class RecommendedSpecialist {
  RecommendedSpecialist({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory RecommendedSpecialist.fromJson(Map<String, dynamic> json) {
    return RecommendedSpecialist(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }

  @override
  String toString() {
    return '$id, $name';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
