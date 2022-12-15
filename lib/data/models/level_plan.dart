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
  final String? plan;
  final List<WorkspaceOnPlan> workspaces;

  LevelPlan({required this.id, required this.plan, required this.workspaces});

  LevelPlan.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        plan = json['plan'],
        workspaces = (json['workspaces'] as List<dynamic>)
            .map((json) => WorkspaceOnPlan.fromJson(json))
            .toList();
}
