import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/routine_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'home_screen.dart';


class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routineController = Get.find<RoutineController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          title: const Text('Daily Routine'),
          bottom: const TabBar(
            labelColor: AppTheme.primaryPurple,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppTheme.primaryPurple,
            tabs: [
              Tab(icon: Icon(Icons.wb_sunny_outlined), text: 'Morning (AM)'),
              Tab(icon: Icon(Icons.nights_stay_outlined), text: 'Night (PM)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _RoutineList(items: routineController.amRoutine),
            _RoutineList(items: routineController.pmRoutine),
          ],
        ),
      ),
    );
  }
}

class _RoutineList extends StatelessWidget {
  final List<RoutineItem> items;

  const _RoutineList({required this.items});

  @override
  Widget build(BuildContext context) {
    final routineController = Get.find<RoutineController>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Obx(
              () => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: CheckboxListTile(
              activeColor: AppTheme.primaryPurple,
              title: Text(
                item.name,
                style: TextStyle(
                  decoration: item.isCompleted.value
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text('Step ${index + 1}'),
              value: item.isCompleted.value,
              onChanged: (_) => routineController.toggleTask(item),
            ),
          ),
        );
      },
    );
  }
}