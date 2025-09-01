# VSCode Settings

Набор настроек и конфигураций VS Code, оптимизированных для современной фронтенд-разработки с TypeScript, Angular и современными инструментами.

## 🚀 Основные возможности

- **Автоматическое форматирование** кода при сохранении с Prettier
- **ESLint интеграция** с автоматическим исправлением ошибок
- **TypeScript поддержка** с улучшенными настройками импортов
- **Angular разработка** с готовыми конфигурациями отладки
- **CSS/SCSS поддержка** с Tailwind CSS
- **Автоматическая организация импортов** и рефакторинг

## 📁 Структура проекта

```
vscode-settings/
├── .vscode/
│   ├── settings.json      # Основные настройки редактора
│   ├── extensions.json    # Рекомендуемые расширения
│   └── launch.json        # Конфигурации отладки
├── vscode-setup.sh    # Скрипт установки для Linux/macOS
└── vscode-setup.ps1   # Скрипт установки для Windows
```

## 🚀 Быстрая установка (одной командой)

### Linux/macOS
```bash
curl -sSL https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.sh | bash
```

### Windows (PowerShell)
```powershell
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.ps1").Content
```

## 🛠️ Установка

### Автоматическая установка

#### Linux/macOS

```bash
# Скачать и запустить скрипт
curl -sSL https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.sh | bash

# Или с указанием URL
curl -sSL https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.sh | bash -s "https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main"
```

#### Windows (PowerShell)

```powershell
# Скачать и запустить скрипт
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.ps1").Content

# Или с указанием URL
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.ps1").Content -GitHubUrl "https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main"
```

### Ручная установка

1. Создайте папку `.vscode` в корне вашего проекта
2. Скопируйте файлы `settings.json`, `extensions.json` и `launch.json` в папку `.vscode`
3. Перезапустите VS Code

## ⚙️ Настройки

### Основные настройки (settings.json)

- **Форматирование**: Автоматическое форматирование при сохранении с Prettier
- **ESLint**: Автоматическое исправление ошибок и организация импортов
- **TypeScript**: Оптимизированные настройки для работы с TypeScript
- **Файлы**: Исключение папок `node_modules`, `dist`, `coverage` из поиска и отслеживания
- **Emmet**: Поддержка HTML-сниппетов в TypeScript файлах

### Рекомендуемые расширения (extensions.json)

| Расширение                           | Описание                                 |
| ------------------------------------ | ---------------------------------------- |
| `esbenp.prettier-vscode`             | Форматирование кода с Prettier           |
| `ms-vscode.vscode-typescript-next`   | Улучшенная поддержка TypeScript          |
| `angular.ng-template`                | Поддержка Angular шаблонов               |
| `bradlc.vscode-tailwindcss`          | IntelliSense для Tailwind CSS            |
| `ms-vscode.vscode-eslint`            | Интеграция с ESLint                      |
| `formulahendry.auto-rename-tag`      | Автоматическое переименование HTML тегов |
| `christian-kohler.path-intellisense` | Автодополнение путей к файлам            |

### Отладка (launch.json)

- **Launch Chrome**: Запуск Chrome с отладкой для Angular приложения (порт 4200)
- **Attach to Chrome**: Подключение к уже запущенному Chrome (порт 9222)

## 🔧 Интеграция в существующий проект

### Для Angular проектов

```bash
# В корне Angular проекта
curl -sSL https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.sh | bash
```

### Для React/TypeScript проектов

```bash
# В корне проекта
curl -sSL https://raw.githubusercontent.com/aburdeinyy/vscode-settings/main/vscode-setup.sh | bash
```

## 📋 Требования

- VS Code версии 1.60.0 или выше
- Node.js для работы с ESLint и Prettier
- Chrome для отладки (опционально)

## 🎯 Особенности

- **Кроссплатформенность**: Скрипты для Windows, Linux и macOS
- **Отказоустойчивость**: Fallback на дефолтные настройки при ошибках загрузки
- **Гибкость**: Возможность указать кастомный URL для загрузки настроек
- **Автоматизация**: Полная настройка VS Code одним командой

## 🤝 Вклад в проект

1. Форкните репозиторий
2. Создайте feature branch (`git checkout -b feature/amazing-feature`)
3. Зафиксируйте изменения (`git commit -m 'Add amazing feature'`)
4. Отправьте в branch (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

## 📄 Лицензия

Проект распространяется под лицензией MIT. См. файл `LICENSE` для деталей.

## 🆘 Поддержка

При возникновении проблем:

- Создайте issue в GitHub
- Опишите вашу операционную систему и версию VS Code
- Приложите логи ошибок, если они есть

---

**Примечание**: Эти настройки оптимизированы для фронтенд-разработки с TypeScript и Angular. Для других технологий может потребоваться дополнительная настройка.
