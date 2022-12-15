import '../models/workspace.dart';
import 'workspace_provider.dart';

class WorkspaceRepository {
  final WorkspaceProvider _workspaceProvider = WorkspaceProvider();

  Future<Workspace> getWorkspaceById(int id) =>
      _workspaceProvider.fetchWorkspaceById(id);
}

//Future<List<DateTimeRange>> getWindowsBooking(int id, DateTime dateTime) => _workspaceProvider.(id);
// async {
//   await Future.delayed(Duration(seconds: 4));
//   var rangeList = [
//     DateTimeRange(start:DateTime(2022, 10, 31, 8), end: DateTime(2022, 10, 31, 14)),
//     DateTimeRange(start: DateTime(2022, 10, 31, 14, 30),end: DateTime(2022, 10, 31, 15)),
//     DateTimeRange(start: DateTime(2022, 10, 31, 16),end: DateTime(2022, 10, 31, 22)),
//   ];
//   return rangeList;
//}
