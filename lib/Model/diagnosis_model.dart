// To parse this JSON data, do
//
//     final diagnosis = diagnosisFromJson(jsonString);

import 'dart:convert';

Diagnosis diagnosisFromJson(String str) => Diagnosis.fromJson(json.decode(str));

String diagnosisToJson(Diagnosis data) => json.encode(data.toJson());

class Diagnosis {
  Diagnosis({
    required this.question,
    required this.conditions,
    required this.extras,
    required this.hasEmergencyEvidence,
    required this.interviewToken,
  });

  Question question;
  List<Condition> conditions;
  Extras extras;
  bool hasEmergencyEvidence;
  String interviewToken;

  factory Diagnosis.fromJson(Map<String, dynamic> json) => Diagnosis(
        question: Question.fromJson(json["question"]),
        conditions: List<Condition>.from(
            json["conditions"].map((x) => Condition.fromJson(x))),
        extras: Extras.fromJson(json["extras"]),
        hasEmergencyEvidence: json["has_emergency_evidence"],
        interviewToken: json["interview_token"],
      );

  Map<String, dynamic> toJson() => {
        "question": question.toJson(),
        "conditions": List<dynamic>.from(conditions.map((x) => x.toJson())),
        "extras": extras.toJson(),
        "has_emergency_evidence": hasEmergencyEvidence,
        "interview_token": interviewToken,
      };
}

class Condition {
  Condition({
    required this.id,
    required this.name,
    required this.commonName,
    required this.probability,
  });

  String id;
  String name;
  String commonName;
  double probability;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        id: json["id"],
        name: json["name"],
        commonName: json["common_name"],
        probability: json["probability"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "common_name": commonName,
        "probability": probability,
      };
}

class Extras {
  Extras();

  factory Extras.fromJson(Map<String, dynamic> json) => Extras();

  Map<String, dynamic> toJson() => {};
}

class Question {
  Question({
    required this.type,
    required this.text,
    required this.items,
    required this.extras,
  });

  String type;
  String text;
  List<Item> items;
  Extras extras;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        type: json["type"],
        text: json["text"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        extras: Extras.fromJson(json["extras"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "extras": extras.toJson(),
      };
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.choices,
  });

  String id;
  String name;
  List<Choice> choices;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
      };
}

class Choice {
  Choice({
    required this.id,
    required this.label,
  });

  String id;
  String label;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
      };
}
