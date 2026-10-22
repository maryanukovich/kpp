/// Приміщення в межах проєкту ремонту.
class Room {
  const Room({
    required this.id,
    required this.projectId,
    required this.name,
    required this.type,
    required this.area,
    required this.description,
    this.photoCount = 0,
  });

  final String id;
  final String projectId;
  final String name;
  final String type;

  /// Площа, м².
  final double area;
  final String description;

  /// Кількість фотографій (у демо відображаються як заглушки).
  final int photoCount;
}
