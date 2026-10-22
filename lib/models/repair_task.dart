/// Статус виконання ремонтної роботи.
enum TaskStatus {
  planned('Заплановано'),
  inProgress('У процесі'),
  done('Виконано');

  const TaskStatus(this.label);

  final String label;
}

/// Ремонтна робота, прив’язана до приміщення та етапу ремонту.
class RepairTask {
  const RepairTask({
    required this.id,
    required this.projectId,
    required this.roomId,
    required this.title,
    required this.description,
    required this.stage,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  final String id;
  final String projectId;
  final String roomId;
  final String title;
  final String description;
  final String stage;
  final DateTime startDate;
  final DateTime endDate;
  final TaskStatus status;
}
