import '../models/level_plan.dart';
import 'level_plan_provider.dart';

// class LevelPlanRepository {
//   final LevelPlanProvider _LevelPlanProvider = LevelPlanProvider();
// Future<LevelPlan> getPlanById(int id) => _LevelPlanProvider.getBookingByUserId(id);
// Future<LevelPlan> getBookingById(int id)=>_LevelPlanProvider.getBookingById(id);
// }

class LevelPlanRepository {
  final LevelProvider _levelPlanProvider = LevelProvider();
  Future<Level> getPlanByLevelId(int id) => _levelPlanProvider.getPlanByLevelId(id);
  // Future<LevelPlan> getPlanByLevelId(int id) async {
  //   var levelPlan =
  //       LevelPlan(id: 42, plan: "https://i.ibb.co/vZJzGDp/map.png", workspaces: [
  //     WorkspaceOnPlan(
  //         id: 1,
  //         isActive: true,
  //         positionX: 10,
  //         positionY: 10,
  //         sizeX: 40,
  //         sizeY: 40,
  //         typeId: 1),
  //     WorkspaceOnPlan(
  //         id: 2,
  //         isActive: true,
  //         positionX: 60,
  //         positionY: 10,
  //         sizeX: 40,
  //         sizeY: 40,
  //         typeId: 1),
  //     WorkspaceOnPlan(
  //         id: 3,
  //         isActive: true,
  //         positionX: 110,
  //         positionY: 10,
  //         sizeX: 40,
  //         sizeY: 40,
  //         typeId: 1),
  //     WorkspaceOnPlan(
  //         id: 4,
  //         isActive: false,
  //         positionX: 200,
  //         positionY: 10,
  //         sizeX: 40,
  //         sizeY: 40,
  //         typeId: 1),
  //     WorkspaceOnPlan(
  //         id: 5,
  //         isActive: true,
  //         positionX: 250,
  //         positionY: 10,
  //         sizeX: 40,
  //         sizeY: 40,
  //         typeId: 1),
  //     WorkspaceOnPlan(
  //         id: 7,
  //         isActive: true,
  //         positionX: 300,
  //         positionY: 10,
  //         sizeX: 40,
  //         sizeY: 40,
  //         typeId: 1),
  //     WorkspaceOnPlan(
  //         id: 8,
  //         isActive: true,
  //         positionX: 220,
  //         positionY: 220,
  //         sizeX: 120,
  //         sizeY: 120,
  //         typeId: 2),
  //     WorkspaceOnPlan(
  //         id: 9,
  //         isActive: true,
  //         positionX: 5,
  //         positionY: 220,
  //         sizeX: 120,
  //         sizeY: 120,
  //         typeId: 2),
  //   ]);
  //   return levelPlan;
  // }
}
