/// Витрата в межах проєкту.
class Expense {
  const Expense({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
    this.taskId,
  });

  final String id;
  final String projectId;
  final String title;
  final String description;
  final String category;
  final double amount;
  final DateTime date;

  /// Пов’язана ремонтна робота (необов’язково).
  final String? taskId;
}
