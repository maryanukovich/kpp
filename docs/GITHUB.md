# Інструкція: завантаження проєкту на GitHub

Репозиторій створюється вами вручну від власного облікового запису.

1. На github.com натисніть **New repository**, назва: `reno_manager` (Public або Private).
   Не додавайте README, .gitignore і ліцензію — вони вже є в проєкті.
2. Якщо репозиторій приватний — у **Settings → Collaborators** надайте доступ лектору та керівнику лабораторних робіт (вимога методички, п. 1.2).
3. У теці проєкту виконайте (підставте свій URL):

```bash
git init
git branch -M main
git config user.name  "Ваше Ім’я"
git config user.email "ваша_пошта@example.com"

# Запропоновані логічні коміти
git add .gitignore pubspec.yaml analysis_options.yaml README.md web
git commit -m "chore: initialize Flutter Web project RenoManager"

git add lib/core/theme lib/core/utils lib/models lib/data
git commit -m "feat: add theme, models and demo data"

git add lib/core/widgets lib/core/layout lib/core/navigation
git commit -m "feat: add reusable widgets, responsive shell and routes"

git add lib/screens/auth lib/screens/profile lib/main.dart lib/app.dart
git commit -m "feat: add auth and profile screens"

git add lib/screens/home lib/screens/projects
git commit -m "feat: add home and project-related screens"

git add test docs
git commit -m "test: add widget tests; docs: add GitHub instructions"

git remote add origin https://github.com/<ваш_логін>/reno_manager.git
git push -u origin main
```

4. Скопіюйте URL репозиторію у розділ «Посилання на GitHub» звіту.
