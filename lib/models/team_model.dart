import 'package:baseball_info/models/event_model.dart';

class TeamModel {
  final String id;
  final String displayName;
  final List<TeamImageModel> images;

  TeamModel({
    required this.id,
    required this.displayName,
    required this.images,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      displayName: json['displayName'],
      images: (json['logos'] as List)
          .map((logo) => TeamImageModel.fromJson(logo))
          .toList(),
    );
  }
}

class TeamImageModel {
  final String url;

  TeamImageModel({required this.url});

  factory TeamImageModel.fromJson(Map<String, dynamic> json) {
    return TeamImageModel(url: json['href']);
  }
}
