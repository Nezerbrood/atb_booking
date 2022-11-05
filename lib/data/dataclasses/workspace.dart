class Workspace {
  int id;
  int typeId;
  String name;
  int numberOfWorkspaces;
  bool isActive;
  Map<String,int> positionOnPlan;
  int levelId;
  Workspace({required this.id,required this.typeId,required this.name,required this.numberOfWorkspaces,required this.isActive,required this.levelId,required this.positionOnPlan});
}