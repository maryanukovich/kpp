/// Будівельний матеріал.
class MaterialItem {
  const MaterialItem({
    required this.id,
    required this.projectId,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.price,
  });

  final String id;
  final String projectId;
  final String name;
  final double quantity;
  final String unit;

  /// Ціна за одиницю, ₴.
  final double price;

  double get total => quantity * price;
}
