# Flutter Counter

Учебное приложение на Flutter: счётчик с усложнениями.

## Что реализовано

- Счётчик с возможностью закинуть число в локальную БД Hive, добавить описание в блок к числу. Добавлена локализация
- Асинхронные операции через async/await в счетчике и Hive
- Управление состоянием через Provider (ChangeNotifier): логика счётчика, секций и базы данных вынесена в отдельные классы и отделена от UI

## Технологии

- Flutter, Dart
- provider
- другие пакеты из pubspec.yaml:
    hive, hive_flutter: локальная база данных
    shared_preferences: хранение простых настроек (если ты используешь его для языка или темы, так и напиши)
    easy_localization, easy_localization_loader, intl: локализация
    go_router: навигация
    flutter_svg: SVG-картинки
    icons_launcher, flutter_native_splash: загрузочный экран приложения
    cupertino_icons: иконки

## Планы

Переделать БД с Hive на SQL-Lite
