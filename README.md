# RenoManager

**RenoManager** — планувальник ремонту квартири. Застосунок допомагає організувати ремонтні роботи за приміщеннями, етапами, строками та витратами.

Лабораторна робота №3 з дисципліни «Кросплатформне програмування»  
Тема: «Створення базової структури застосунку та основних екранів відповідно до розробленого дизайну».  
Виконавець: Надорожняк Мар’яна, група ПЗ-35. Національний університет «Львівська політехніка».

> Це **демонстраційний інтерфейс**. Бекенду, бази даних, Firebase та REST API немає. Вхід, реєстрація, відновлення і зміна пароля лише показують повідомлення; усі дані — локальні статичні (`lib/data/demo_data.dart`).

## Технології

- Flutter (Material 3), Dart
- Цільова платформа: Flutter Web (сучасні браузери)
- Сторонніх пакетів немає (лише `flutter_lints` для аналізу коду)

## Реалізовано

- Авторизація, реєстрація, відновлення пароля
- Профіль користувача, зміна пароля
- Головна сторінка: привітання, поточний проєкт, бюджет / витрачено / залишок, прогрес робіт, найближчі завдання, швидкі переходи
- Список проєктів, деталі проєкту, приміщення, ремонтні роботи (з фільтром за статусом), витрати, бюджет, матеріали
- Адаптивна навігація: бічна панель (ширина ≥ 900 px) або висувне меню (вужче)
- Повторно використовувані віджети в `lib/core/widgets/`

## Структура

```
lib/
  main.dart                 точка входу
  app.dart                  MaterialApp, маршрути
  core/
    theme/app_theme.dart    кольори, відступи, тема
    navigation/             імена маршрутів, навігаційні допоміжні методи
    layout/app_shell.dart   адаптивний каркас із бічною панеллю
    utils/formatters.dart   форматування сум і дат
    widgets/                AppButton, AppTextField, AppCard, StatCard,
                            RepairTaskCard, ProjectCard, StatusChip, ...
  models/                   RepairProject, Room, RepairTask, Expense, MaterialItem, UserProfile
  data/demo_data.dart       локальні демонстраційні дані
  screens/
    auth/                   login, register, forgot_password
    home/                   home_screen
    profile/                profile_screen, change_password_screen
    projects/               projects, project_details, rooms, tasks, expenses, budget, materials
test/widget_test.dart       базові widget-тести
```

## Запуск

Потрібен встановлений [Flutter SDK](https://docs.flutter.dev/get-started/install) із підтримкою Web та Chrome.

Якщо у цій теці ще немає каталогу `web/` (його створює Flutter), виконайте один раз:

```bash
flutter create . --platforms=web --project-name reno_manager
```

Далі:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Збірка для вебу: `flutter build web`.

## Демонстраційні дані

Користувач: `Мар’яна`, `mariana@example.com`. Кнопка «Увійти» відкриває головну сторінку без перевірки пароля.
