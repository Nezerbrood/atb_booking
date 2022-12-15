import 'package:atb_booking/presentation/interface/admin_role/offices/level_editor.dart';
import 'package:flutter/material.dart';

class AdminCreateLevelPage extends StatelessWidget {
  const AdminCreateLevelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const LevelEditor(),
    );
  }
}
