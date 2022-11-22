class Workspace {
  final int id;
  final int numberOfWorkspaces;
  final String description;
  final bool isActive;
  final double positionX;
  final double positionY;
  final double sizeX;
  final double sizeY;
  final int typeId;
  final int level;
  final List<Photo> photos;

  Workspace.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        numberOfWorkspaces = json['numberOfWorkspaces'],
        description = json['description'],
        isActive = json['isActive'],
        positionX = json['positionX'],
        positionY = json['positionY'],
        sizeX = json['sizeX'],
        sizeY = json['sizeY'],
        typeId = json['typeId'],
        level = json['level'],
        photos = (json['photos'] as List<dynamic>).map((json) => Photo.fromJson(json)).toList();

  Workspace(
      this.id,
      this.numberOfWorkspaces,
      this.description,
      this.isActive,
      this.positionX,
      this.positionY,
      this.typeId,
      this.level,
      this.photos,
      this.sizeX,
      this.sizeY);
}

class WorkspaceOnPlan {
  final int id;
  final bool isActive;
  final double positionX;
  final double positionY;
  final double sizeX;
  final double sizeY;
  final int typeId;

  WorkspaceOnPlan(
      {required this.id,
      required this.isActive,
      required this.positionX,
      required this.positionY,
      required this.sizeX,
      required this.sizeY,
      required this.typeId});
  WorkspaceOnPlan.fromJson(Map<String,dynamic> json)
      : id = json['id'],
  isActive = json['isActive'],
  positionX = json['positionX'],
  positionY = json['positionY'],
  sizeX = json['sizeX'],
  sizeY = json['sizeY'],
  typeId = json['typeId'];

}

class Photo {
  final int id;
  final String photo;
  Photo.fromJson(Map<String,dynamic> json):
      id = json['id'],
  photo = json['photo'];
  Photo({required this.id, required this.photo});
}
