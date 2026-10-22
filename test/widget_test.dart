import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reno_manager/app.dart';
import 'package:reno_manager/core/navigation/app_routes.dart';
import 'package:reno_manager/core/widgets/app_button.dart';
import 'package:reno_manager/data/demo_data.dart';

void setScreenSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    DemoData.activeProject = DemoData.projects.first;
  });

  testWidgets('Авторизація: кнопка «Увійти» відкриває головну сторінку',
      (tester) async {
    setScreenSize(tester, const Size(1280, 900));
    await tester.pumpWidget(const RenoManagerApp());

    expect(find.text('Вхід до системи'), findsOneWidget);
    await tester.tap(find.text('Увійти'));
    await tester.pumpAndSettle();

    expect(find.text('Вітаю, Мар’яна!'), findsOneWidget);
    expect(find.text('Запланований бюджет'), findsOneWidget);
  });

  testWidgets('Авторизація → реєстрація → авторизація', (tester) async {
    setScreenSize(tester, const Size(1280, 900));
    await tester.pumpWidget(const RenoManagerApp());

    await tapVisible(tester, find.text('Зареєструватися'));
    expect(find.text('Створіть обліковий запис RenoManager'), findsOneWidget);

    await tapVisible(tester, find.text('Увійти'));
    expect(find.text('Вхід до системи'), findsOneWidget);
  });

  testWidgets('Відновлення пароля показує демонстраційне повідомлення',
      (tester) async {
    setScreenSize(tester, const Size(1280, 900));
    await tester.pumpWidget(const RenoManagerApp());

    await tapVisible(tester, find.text('Забули пароль?'));
    expect(find.text('Відновлення пароля'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'mariana@example.com');
    await tapVisible(tester, find.text('Надіслати інструкцію'));
    expect(find.textContaining('Демонстраційний режим'), findsOneWidget);
  });

  testWidgets('Проєкти → деталі → приміщення → ремонтні роботи',
      (tester) async {
    setScreenSize(tester, const Size(1280, 900));
    await tester.pumpWidget(const RenoManagerApp(initialRoute: AppRoutes.home));
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Мої проєкти').first);
    expect(find.text('Створити проєкт'), findsOneWidget);

    await tapVisible(tester, find.text('Ремонт двокімнатної квартири'));
    expect(find.text('Опис проєкту'), findsOneWidget);

    await tapVisible(tester, find.text('Приміщення').last);
    expect(find.text('Вітальня'), findsOneWidget);

    await tapVisible(
      tester,
      find.widgetWithText(AppButton, 'Ремонтні роботи').first,
    );
    expect(find.text('Приміщення: Вітальня'), findsOneWidget);
  });

  testWidgets('Профіль → зміна пароля та вихід на авторизацію', (tester) async {
    setScreenSize(tester, const Size(1280, 900));
    await tester.pumpWidget(const RenoManagerApp(initialRoute: AppRoutes.home));
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Профіль').first);
    expect(find.text('mariana@example.com'), findsOneWidget);

    await tapVisible(tester, find.widgetWithText(AppButton, 'Змінити пароль'));
    expect(find.text('Поточний пароль'), findsOneWidget);

    await tapVisible(tester, find.text('Вийти'));
    expect(find.text('Вхід до системи'), findsOneWidget);
  });

  const routes = [
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.forgotPassword,
    AppRoutes.home,
    AppRoutes.profile,
    AppRoutes.changePassword,
    AppRoutes.projects,
    AppRoutes.rooms,
    AppRoutes.tasks,
    AppRoutes.expenses,
    AppRoutes.budget,
    AppRoutes.materials,
  ];

  for (final size in const [Size(1280, 800), Size(390, 844)]) {
    testWidgets('Усі екрани відображаються без винятків (${size.width.toInt()} px)',
        (tester) async {
      setScreenSize(tester, size);
      for (final route in routes) {
        await tester.pumpWidget(RenoManagerApp(key: UniqueKey(), initialRoute: route));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'Маршрут $route');
      }
    });
  }
}
