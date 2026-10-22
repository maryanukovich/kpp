import '../models/expense.dart';
import '../models/material_item.dart';
import '../models/repair_project.dart';
import '../models/repair_task.dart';
import '../models/room.dart';
import '../models/user_profile.dart';

/// Локальні демонстраційні дані. Бекенду, бази даних і мережевих запитів немає.
class DemoData {
  DemoData._();

  static const UserProfile user =
      UserProfile(name: 'Мар’яна', email: 'mariana@example.com');

  static final List<RepairProject> projects = [
    RepairProject(
      id: 'p1',
      name: 'Ремонт двокімнатної квартири',
      description:
          'Капітальний ремонт: демонтаж, електрика, вирівнювання стін, '
          'чистове оздоблення вітальні, кухні, спальні та ванної кімнати.',
      address: 'м. Львів, вул. Зелена, 15, кв. 8',
      startDate: DateTime(2026, 9, 22),
      endDate: DateTime(2026, 12, 15),
      budget: 450000,
    ),
    RepairProject(
      id: 'p2',
      name: 'Ремонт студії',
      description: 'Косметичний ремонт однокімнатної студії для здачі в оренду.',
      address: 'м. Львів, вул. Лугова, 4, кв. 21',
      startDate: DateTime(2026, 11, 1),
      endDate: DateTime(2027, 1, 20),
      budget: 220000,
    ),
  ];

  /// Поточний (активний) проєкт, з яким працюють екрани розділів.
  static RepairProject activeProject = projects.first;

  static final List<Room> rooms = [
    const Room(
      id: 'r1',
      projectId: 'p1',
      name: 'Вітальня',
      type: 'Житлова кімната',
      area: 24,
      description: 'Простора кімната з виходом на балкон.',
      photoCount: 4,
    ),
    const Room(
      id: 'r2',
      projectId: 'p1',
      name: 'Кухня',
      type: 'Кухня',
      area: 12,
      description: 'Кухня-їдальня з новим гарнітуром.',
      photoCount: 1,
    ),
    const Room(
      id: 'r3',
      projectId: 'p1',
      name: 'Спальня',
      type: 'Житлова кімната',
      area: 16,
      description: 'Спальня з вбудованою шафою.',
    ),
    const Room(
      id: 'r4',
      projectId: 'p1',
      name: 'Ванна кімната',
      type: 'Санвузол',
      area: 6,
      description: 'Суміщений санвузол з душовою кабіною.',
      photoCount: 2,
    ),
    const Room(
      id: 'r5',
      projectId: 'p2',
      name: 'Студія',
      type: 'Житлова кімната',
      area: 32,
      description: 'Відкрите планування з кухонною зоною.',
    ),
  ];

  static final List<RepairTask> tasks = [
    RepairTask(
      id: 't1',
      projectId: 'p1',
      roomId: 'r1',
      title: 'Демонтаж старих перегородок',
      description: 'Демонтаж перегородок та вивезення сміття.',
      stage: 'Підготовчий',
      startDate: DateTime(2026, 9, 25),
      endDate: DateTime(2026, 9, 29),
      status: TaskStatus.done,
    ),
    RepairTask(
      id: 't2',
      projectId: 'p1',
      roomId: 'r1',
      title: 'Штукатурення стін',
      description: 'Вирівнювання стін штукатурною сумішшю по маяках.',
      stage: 'Чорновий',
      startDate: DateTime(2026, 9, 30),
      endDate: DateTime(2026, 10, 14),
      status: TaskStatus.done,
    ),
    RepairTask(
      id: 't3',
      projectId: 'p1',
      roomId: 'r2',
      title: 'Електромонтажні роботи',
      description: 'Прокладання проводки, монтаж розеток і вимикачів.',
      stage: 'Чорновий',
      startDate: DateTime(2026, 10, 5),
      endDate: DateTime(2026, 10, 24),
      status: TaskStatus.inProgress,
    ),
    RepairTask(
      id: 't4',
      projectId: 'p1',
      roomId: 'r1',
      title: 'Фарбування стін',
      description: 'Ґрунтування та нанесення двох шарів інтер’єрної фарби.',
      stage: 'Чистовий',
      startDate: DateTime(2026, 10, 26),
      endDate: DateTime(2026, 11, 5),
      status: TaskStatus.planned,
    ),
    RepairTask(
      id: 't5',
      projectId: 'p1',
      roomId: 'r4',
      title: 'Гідроізоляція підлоги',
      description: 'Нанесення обмазувальної гідроізоляції.',
      stage: 'Чорновий',
      startDate: DateTime(2026, 10, 25),
      endDate: DateTime(2026, 10, 30),
      status: TaskStatus.planned,
    ),
    RepairTask(
      id: 't6',
      projectId: 'p1',
      roomId: 'r3',
      title: 'Вирівнювання стін у спальні',
      description: 'Шпаклювання та шліфування стін.',
      stage: 'Чорновий',
      startDate: DateTime(2026, 10, 28),
      endDate: DateTime(2026, 11, 8),
      status: TaskStatus.planned,
    ),
    RepairTask(
      id: 't7',
      projectId: 'p1',
      roomId: 'r1',
      title: 'Укладання ламінату',
      description: 'Підготовка основи та монтаж ламінату з підкладкою.',
      stage: 'Чистовий',
      startDate: DateTime(2026, 11, 6),
      endDate: DateTime(2026, 11, 10),
      status: TaskStatus.planned,
    ),
    RepairTask(
      id: 't8',
      projectId: 'p1',
      roomId: 'r2',
      title: 'Укладання фартуха з плитки',
      description: 'Монтаж керамічної плитки робочої зони кухні.',
      stage: 'Чистовий',
      startDate: DateTime(2026, 11, 12),
      endDate: DateTime(2026, 11, 18),
      status: TaskStatus.planned,
    ),
    RepairTask(
      id: 't9',
      projectId: 'p2',
      roomId: 'r5',
      title: 'Розробка планування',
      description: 'Узгодження розташування меблів і зонування.',
      stage: 'Підготовчий',
      startDate: DateTime(2026, 11, 1),
      endDate: DateTime(2026, 11, 10),
      status: TaskStatus.done,
    ),
    RepairTask(
      id: 't10',
      projectId: 'p2',
      roomId: 'r5',
      title: 'Фарбування стелі',
      description: 'Підготовка та фарбування стелі.',
      stage: 'Чистовий',
      startDate: DateTime(2026, 12, 1),
      endDate: DateTime(2026, 12, 8),
      status: TaskStatus.planned,
    ),
  ];

  static final List<Expense> expenses = [
    Expense(
      id: 'e1',
      projectId: 'p1',
      title: 'Демонтажні роботи',
      description: 'Оплата бригаді за демонтаж перегородок.',
      category: 'Роботи',
      amount: 18500,
      date: DateTime(2026, 9, 29),
      taskId: 't1',
    ),
    Expense(
      id: 'e2',
      projectId: 'p1',
      title: 'Вивезення сміття',
      description: 'Контейнер для будівельного сміття.',
      category: 'Послуги',
      amount: 6200,
      date: DateTime(2026, 9, 30),
    ),
    Expense(
      id: 'e3',
      projectId: 'p1',
      title: 'Штукатурна суміш і ґрунтовка',
      description: '40 мішків суміші та 6 каністр ґрунтовки.',
      category: 'Матеріали',
      amount: 24800,
      date: DateTime(2026, 10, 5),
      taskId: 't2',
    ),
    Expense(
      id: 'e4',
      projectId: 'p1',
      title: 'Кабель і розетки',
      description: 'Кабель ВВГнг, розетки, вимикачі, підрозетники.',
      category: 'Матеріали',
      amount: 32400,
      date: DateTime(2026, 10, 8),
      taskId: 't3',
    ),
    Expense(
      id: 'e5',
      projectId: 'p1',
      title: 'Робота електрика',
      description: 'Аванс за електромонтажні роботи.',
      category: 'Роботи',
      amount: 21000,
      date: DateTime(2026, 10, 16),
      taskId: 't3',
    ),
    Expense(
      id: 'e6',
      projectId: 'p1',
      title: 'Ламінат для вітальні',
      description: 'Ламінат 33 класу з підкладкою.',
      category: 'Матеріали',
      amount: 56700,
      date: DateTime(2026, 10, 18),
      taskId: 't7',
    ),
    Expense(
      id: 'e7',
      projectId: 'p2',
      title: 'Дизайн-проєкт',
      description: 'Планування та візуалізація.',
      category: 'Послуги',
      amount: 15000,
      date: DateTime(2026, 11, 3),
      taskId: 't9',
    ),
  ];

  static final List<MaterialItem> materials = [
    const MaterialItem(
      id: 'm1',
      projectId: 'p1',
      name: 'Штукатурна суміш',
      quantity: 40,
      unit: 'мішок',
      price: 320,
    ),
    const MaterialItem(
      id: 'm2',
      projectId: 'p1',
      name: 'Ґрунтовка глибокого проникнення',
      quantity: 6,
      unit: 'каністра',
      price: 480,
    ),
    const MaterialItem(
      id: 'm3',
      projectId: 'p1',
      name: 'Ламінат 33 клас',
      quantity: 26,
      unit: 'м²',
      price: 780,
    ),
    const MaterialItem(
      id: 'm4',
      projectId: 'p1',
      name: 'Фарба інтер’єрна біла',
      quantity: 5,
      unit: 'відро',
      price: 1780,
    ),
    const MaterialItem(
      id: 'm5',
      projectId: 'p1',
      name: 'Кабель ВВГнг 3×2.5',
      quantity: 150,
      unit: 'м',
      price: 48,
    ),
    const MaterialItem(
      id: 'm6',
      projectId: 'p1',
      name: 'Плитка керамічна для фартуха',
      quantity: 4.5,
      unit: 'м²',
      price: 950,
    ),
    const MaterialItem(
      id: 'm7',
      projectId: 'p2',
      name: 'Фарба для стель',
      quantity: 2,
      unit: 'відро',
      price: 1450,
    ),
  ];

  static List<Room> roomsOf(String projectId) =>
      rooms.where((r) => r.projectId == projectId).toList();

  static List<RepairTask> tasksOf(String projectId) =>
      tasks.where((t) => t.projectId == projectId).toList();

  static List<Expense> expensesOf(String projectId) =>
      expenses.where((e) => e.projectId == projectId).toList();

  static List<MaterialItem> materialsOf(String projectId) =>
      materials.where((m) => m.projectId == projectId).toList();

  static double spentOn(String projectId) =>
      expensesOf(projectId).fold(0.0, (sum, e) => sum + e.amount);

  /// Частка виконаних робіт (0..1).
  static double progressOf(String projectId) {
    final list = tasksOf(projectId);
    if (list.isEmpty) return 0;
    final done = list.where((t) => t.status == TaskStatus.done).length;
    return done / list.length;
  }

  static Room? roomById(String id) {
    for (final room in rooms) {
      if (room.id == id) return room;
    }
    return null;
  }

  static RepairTask? taskById(String? id) {
    if (id == null) return null;
    for (final task in tasks) {
      if (task.id == id) return task;
    }
    return null;
  }

  /// Невиконані роботи, відсортовані за строком завершення.
  static List<RepairTask> upcomingTasks(String projectId, {int limit = 4}) {
    final list = tasksOf(projectId)
        .where((t) => t.status != TaskStatus.done)
        .toList()
      ..sort((a, b) => a.endDate.compareTo(b.endDate));
    return list.take(limit).toList();
  }
}
