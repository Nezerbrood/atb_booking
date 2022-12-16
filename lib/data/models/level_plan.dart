import 'workspace.dart';

class Level {
  final int id;
  final int number;

  Level({required this.id, required this.number});

  Level.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        number = json['number'];
}

class LevelPlan {
  final int id;
  final int number;
  final int? planId;
  final List<LevelPlanElementData> workspaces;

  LevelPlan({required this.id, required this.number,required this.planId, required this.workspaces});

  LevelPlan.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        planId = json['planId'],
        number = json['number'],
        workspaces = (json['workspaces'] as List<dynamic>)
            .map((json) => LevelPlanElementData.fromJson(json))
            .toList();
}

