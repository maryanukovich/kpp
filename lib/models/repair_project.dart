/// Проєкт ремонту.
class RepairProject {
  const RepairProject({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.startDate,
    required this.endDate,
    required this.budget,
  });

  final String id;
  final String name;
  final String description;
  final String address;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
}
