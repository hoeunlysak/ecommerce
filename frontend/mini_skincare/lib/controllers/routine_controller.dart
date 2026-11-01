import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RoutineItem {
  final String id;
  final String name;
  final String step; // 'AM' or 'PM'
  var isCompleted = false.obs;

  RoutineItem({
    required this.id,
    required this.name,
    required this.step,
    bool completed = false,
  }) {
    isCompleted.value = completed;
  }
}

class RoutineController extends GetxController {
  final _box = GetStorage();

  var amRoutine = <RoutineItem>[
    RoutineItem(id: '1', name: 'Gentle Hydrating Cleanser', step: 'AM'),
    RoutineItem(id: '2', name: 'Niacinamide 10% Serum', step: 'AM'),
    RoutineItem(id: '3', name: 'Daily Barrier Defense Sunscreen SPF 50', step: 'AM'),
  ].obs;

  var pmRoutine = <RoutineItem>[
    RoutineItem(id: '4', name: 'Gentle Hydrating Cleanser', step: 'PM'),
    RoutineItem(id: '5', name: 'Niacinamide 10% Serum', step: 'PM'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedRoutineState();
  }

  // Load checkmark states from disk
  void _loadSavedRoutineState() {
    for (var item in amRoutine) {
      bool? savedValue = _box.read('routine_${item.id}');
      if (savedValue != null) {
        item.isCompleted.value = savedValue;
      }
    }

    for (var item in pmRoutine) {
      bool? savedValue = _box.read('routine_${item.id}');
      if (savedValue != null) {
        item.isCompleted.value = savedValue;
      }
    }
  }

  // Toggle state & save to disk
  void toggleTask(RoutineItem item) {
    item.isCompleted.value = !item.isCompleted.value;
    _box.write('routine_${item.id}', item.isCompleted.value);
  }
}