# 🥒 Kavo Ultimate

**Kavo Ultimate** — UI-библиотека для Roblox на Luau. Она собирает в одном месте привычные элементы Kavo: вкладки, секции, кнопки, переключатели, слайдеры, выпадающие списки, бинды клавиш, выбор цвета и текстовые поля. Плюс здесь есть программное управление некоторыми элементами, динамическая смена темы и уведомления.

Идея простая: библиотека строит интерфейс, а ты пишешь только логику своего скрипта. Не нужно вручную создавать десятки `Frame`, `TextButton` и `UICorner`.

> **Важно:** примеры рассчитаны на клиентский код Roblox. `loadstring` и `game:HttpGet` доступны не во всех средах. Для обычного проекта Roblox помести библиотеку в `ModuleScript` и подключи через `require`.

## Подключение

### Вариант 1 — загрузка с GitHub

Если файл `Kavo_Ultimate.lua` лежит в корне ветки `Kavo Ultimate` репозитория `delivery-2347/w`, загрузи его так:

```lua
local Kavo = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/delivery-2347/w/refs/heads/main/Kavo%20Ultimate/Kavo%20Ultimate"
))()
```

Если ты сохранил файл в другом месте или под другим названием, замени URL на адрес своего raw-файла.

### Вариант 2 — через ModuleScript

1. Создай `ModuleScript` и вставь в него содержимое `Kavo_Ultimate.lua`.
2. Назови его, например, `KavoUltimate`.
3. В клиентском `LocalScript` подключи библиотеку:

```lua
local Kavo = require(game:GetService("ReplicatedStorage"):WaitForChild("KavoUltimate"))
```

Для обычного проекта Roblox размещай GUI-код на клиенте, например в `LocalScript`. Не помещай интерфейс в серверный `Script`.

## Первый интерфейс за минуту

```lua
local Kavo = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/delivery-2347/w/main/Kavo_Ultimate.lua"
))()

local Window = Kavo.CreateLib("My Hub", "RJTheme6")

local MainTab = Window:NewTab("Главная")
local MainSection = MainTab:NewSection("Основные функции")

MainSection:NewLabel("Добро пожаловать!")

MainSection:NewButton("Проверить", "Нажми, чтобы вывести сообщение", function()
    print("Кнопка работает!")
end)

MainSection:NewToggle("Автоматический режим", "Включить или выключить режим", function(enabled)
    print("Enabled:", enabled)
end)

Kavo:Notify("Kavo Ultimate", "Интерфейс загружен", 4)
```

`CreateLib` создаёт окно и возвращает объект, через который добавляются вкладки. У каждой вкладки могут быть свои секции, а уже в секции размещаются элементы.

## Как устроен интерфейс

```lua
local Window = Kavo.CreateLib("My Hub", "RJTheme3")

local PlayerTab = Window:NewTab("Игрок")
local Movement = PlayerTab:NewSection("Передвижение")
local Other = PlayerTab:NewSection("Другое", true)
```

`NewTab(name)` создаёт вкладку.

`NewSection(name, hidden)` создаёт секцию. Если передать `true` вторым аргументом, заголовок секции будет скрыт — сами элементы останутся на месте.

Вкладки и элементы можно создавать в цикле, например на основе списка игровых объектов. При этом следи за тем, чтобы не создавать новый интерфейс каждый кадр.

## Элементы управления

### Кнопка

Код в callback выполняется при нажатии кнопки.

```lua
local ActionButton = Movement:NewButton(
    "Обновить",
    "Перезапустить выбранное действие",
    function()
        print("Обновление запущено")
    end
)

-- Поменять название уже созданной кнопки
ActionButton:UpdateButton("Обновить сейчас")
```

Параметры: `название`, `подсказка`, `callback`.

### Toggle — переключатель

Callback получает `true`, когда переключатель включён, и `false`, когда выключен.

```lua
local AutoToggle = Movement:NewToggle(
    "Автоматическое действие",
    "Запускает или останавливает действие",
    function(enabled)
        if enabled then
            print("Включено")
        else
            print("Выключено")
        end
    end
)

-- Изменить состояние программно. Callback тоже будет вызван.
AutoToggle:Set(true)

-- Прочитать текущее состояние
print(AutoToggle:GetValue())

-- Переименовать переключатель
AutoToggle:SetName("Авто-режим")

-- Старый совместимый метод: название и состояние можно менять вместе
AutoToggle:UpdateToggle("Авто-режим", false)
```

### Slider — ползунок

У слайдера параметры расположены в старом порядке Kavo: **максимум, затем минимум**.

```lua
local SpeedSlider = Movement:NewSlider(
    "Скорость",
    "Выбери значение от 0 до 100",
    100, -- максимум
    0,   -- минимум
    function(value)
        print("Новая скорость:", value)
    end
)

-- Установить значение программно (callback сработает)
SpeedSlider:SetValue(45)

-- Прочитать текущее значение
local currentSpeed = SpeedSlider:GetValue()
print(currentSpeed)
```

Значение ограничивается диапазоном слайдера. Если минимум и максимум переданы в обратном порядке, библиотека меняет их местами.

### TextBox — текстовое поле

Callback срабатывает, когда пользователь вводит текст и подтверждает ввод клавишей Enter. После обработки подтверждённый текст очищается в самом поле — при необходимости сохрани его в переменную.

```lua
local playerName = ""

local NameBox = Movement:NewTextBox(
    "Имя игрока",
    "Введи имя и нажми Enter",
    function(text)
        playerName = text
        print("Введено:", playerName)
    end
)

-- Установить текст вручную
NameBox:SetText("ExamplePlayer")

-- Прочитать текст
print(NameBox:GetText())

-- Изменить подпись элемента
NameBox:SetName("Новый заголовок")
```

### Dropdown — выпадающий список

Callback получает выбранный пункт как строку.

```lua
local ModeDropdown = Movement:NewDropdown(
    "Режим",
    "Выбери режим работы",
    {"Обычный", "Быстрый", "Точный"},
    function(selected)
        print("Выбран режим:", selected)
    end
)

-- Полностью заменить список пунктов
ModeDropdown:Refresh({"Режим A", "Режим B", "Режим C"})
```

### Keybind — клавиша

Четвёртый аргумент — функция, которая вызывается при нажатии назначенной клавиши. Пользователь может изменить клавишу, нажав на сам элемент и затем на новую клавишу.

```lua
Movement:NewKeybind(
    "Переключить меню",
    "Нажми элемент, чтобы назначить другую клавишу",
    Enum.KeyCode.RightShift,
    function()
        Kavo:ToggleUI()
    end
)
```

Можно использовать любую подходящую клавишу из `Enum.KeyCode`, например `Enum.KeyCode.G` или `Enum.KeyCode.F`. Для бинда не возвращается отдельный контроллер.

### ColorPicker — выбор цвета

Callback получает выбранный цвет в виде `Color3`.

```lua
Movement:NewColorPicker(
    "Цвет эффекта",
    "Выбери цвет",
    Color3.fromRGB(60, 200, 120),
    function(color)
        print("RGB:", color.R, color.G, color.B)
        -- Пример: effectPart.Color = color
    end
)
```

Цвет по умолчанию можно задать через `Color3.fromRGB(r, g, b)`. Этот элемент управляется самим интерфейсом и не возвращает объект для отдельного программного вызова.

### Label — текстовая строка

```lua
local StatusLabel = Movement:NewLabel("Статус: ожидание")

-- Обновить подпись позднее
StatusLabel:UpdateLabel("Статус: готово")
```

Label удобно использовать для статуса, текущего режима или значения, которое изменяется в процессе работы скрипта.

## Темы и цвета

Можно использовать встроенную тему по имени:

```lua
local Window = Kavo.CreateLib("My Hub", "RJTheme6")
```

Доступные названия: `RJTheme1`, `RJTheme2`, `RJTheme3`, `RJTheme4`, `RJTheme5`, `RJTheme6`, `RJTheme7`, `RJTheme8` и `RJTheme9`.

Если второй аргумент не передавать, будет использована тема по умолчанию.

### Своя тема

Тема — это таблица с цветами `Color3`. Можно указать только несколько свойств: для остальных останутся значения по умолчанию.

```lua
local MyTheme = {
    SchemeColor = Color3.fromRGB(55, 190, 115), -- акцент: заголовки секций и активные элементы
    Background = Color3.fromRGB(10, 12, 14),   -- основной фон
    Header = Color3.fromRGB(17, 20, 23),        -- верхняя панель и панель вкладок
    TextColor = Color3.fromRGB(240, 245, 242),  -- текст
    ElementColor = Color3.fromRGB(25, 30, 31)   -- фон элементов
}

local Window = Kavo.CreateLib("Green Hub", MyTheme)
```

### Изменить цвет после создания

```lua
Kavo:ChangeColor("SchemeColor", Color3.fromRGB(80, 220, 140))
Kavo:ChangeColor("Background", Color3.fromRGB(8, 10, 12))
Kavo:ChangeColor("Header", Color3.fromRGB(15, 18, 20))
Kavo:ChangeColor("TextColor", Color3.fromRGB(255, 255, 255))
Kavo:ChangeColor("ElementColor", Color3.fromRGB(28, 33, 35))
```

Допустимые ключи: `SchemeColor`, `Background`, `Header`, `TextColor`, `ElementColor`. Для изменения цвета передавай именно `Color3`. Метод возвращает `true`, если цвет принят, и `false`, если ключ или значение не подходит.

## Уведомления

`Kavo:Notify(title, message, duration)` показывает небольшое уведомление в правом верхнем углу.

```lua
Kavo:Notify("Успешно", "Настройки сохранены", 3)
Kavo:Notify("Внимание", "Не выбран игрок", 5)
Kavo:Notify("Ошибка", "Объект не найден", 6)
```

`duration` — время показа в секундах. Если его не указать, используется 5 секунд. Уведомления используют акцентный цвет и цвета текущей темы.

## Показать, скрыть или удалить интерфейс

```lua
-- Скрыть или снова показать окно
Kavo:ToggleUI()

-- Полностью удалить окно и GUI уведомлений
Kavo:Destroy()
```

`ToggleUI()` переключает видимость текущего окна. `Destroy()` удаляет созданный интерфейс и уведомления. После `Destroy()` создай окно заново через `Kavo.CreateLib(...)`, если оно снова понадобится.

## Полный пример

Небольшой пример, в котором собраны самые частые элементы. Логику внутри callback подставь под свою задачу.

```lua
local Kavo = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/delivery-2347/w/main/Kavo_Ultimate.lua"
))()

local Window = Kavo.CreateLib("CUCUMBER HUB", "RJTheme6")
local PlayerTab = Window:NewTab("Игрок")
local SettingsTab = Window:NewTab("Настройки")

local Movement = PlayerTab:NewSection("Передвижение")
local Other = PlayerTab:NewSection("Другое")
local Settings = SettingsTab:NewSection("Интерфейс")

local enabled = false
local speed = 16
local selectedMode = "Обычный"

Movement:NewLabel("Настройки персонажа")

local SpeedSlider = Movement:NewSlider("Скорость", "Значение от 0 до 100", 100, 0, function(value)
    speed = value
    print("Speed:", speed)
end)
SpeedSlider:SetValue(16)

local AutoToggle = Movement:NewToggle("Авто-режим", "Включает или выключает режим", function(state)
    enabled = state
    print("Auto:", enabled)
end)

Movement:NewDropdown("Режим", "Выбери один вариант", {"Обычный", "Быстрый", "Точный"}, function(value)
    selectedMode = value
    print("Mode:", selectedMode)
end)

Movement:NewTextBox("Сообщение", "Введи сообщение и нажми Enter", function(text)
    Kavo:Notify("Ввод получен", text, 3)
end)

Other:NewButton("Показать статус", "Вывести текущие настройки", function()
    print("Enabled:", enabled, "Speed:", speed, "Mode:", selectedMode)
end)

Other:NewKeybind("Скрыть / показать", "Нажми, чтобы назначить кнопку", Enum.KeyCode.RightShift, function()
    Kavo:ToggleUI()
end)

Settings:NewColorPicker("Акцентный цвет", "Выбери цвет интерфейса", Color3.fromRGB(55, 190, 115), function(color)
    Kavo:ChangeColor("SchemeColor", color)
end)

local Status = Settings:NewLabel("Статус: загружено")
Settings:NewButton("Обновить статус", "Изменить текст статуса", function()
    Status:UpdateLabel("Статус: работает")
end)

Kavo:Notify("CUCUMBER HUB", "Всё готово к работе", 4)
```

## Небольшие подсказки

- **Callback не вызывается?** Проверь, что функция передана последним аргументом и что действие действительно произошло. У `TextBox` нужно подтвердить ввод клавишей Enter.
- **Слайдер всегда возвращает старое значение?** Сохраняй аргумент `value`, который приходит в callback, или читай его через `GetValue()`.
- **Хочешь обновить Dropdown?** Передай новый массив строк в `Refresh({...})`.
- **Тема поменялась не так, как ожидалось?** Проверь, что цвета заданы как `Color3`, а ключи написаны точно: например, `SchemeColor`, а не `Schemecolor`.
- **Окно не появляется?** Запускай GUI на клиенте. Если библиотека загружается по URL, проверь, что файл действительно опубликован по этому адресу.

## API вкратце

```lua
Kavo.CreateLib(name, theme)                  -- создать окно
Window:NewTab(name)                           -- добавить вкладку
Tab:NewSection(name, hidden)                  -- добавить секцию

Section:NewButton(name, tip, callback)        -- кнопка
Section:NewTextBox(name, tip, callback)       -- текстовое поле
Section:NewToggle(name, tip, callback)        -- переключатель
Section:NewSlider(name, tip, max, min, callback) -- слайдер
Section:NewDropdown(name, tip, items, callback)  -- выпадающий список
Section:NewKeybind(name, tip, keyCode, callback) -- клавиша
Section:NewColorPicker(name, tip, color, callback) -- выбор цвета
Section:NewLabel(text)                        -- подпись

Slider:SetValue(value)                        -- задать значение слайдера
Slider:GetValue()                             -- получить значение слайдера
Toggle:Set(value)                             -- задать состояние
Toggle:SetName(name)                          -- переименовать Toggle
Toggle:GetValue()                             -- получить состояние
TextBox:SetText(text)                         -- задать текст
TextBox:GetText()                             -- получить текст
TextBox:SetName(name)                         -- изменить подпись
Dropdown:Refresh(items)                       -- заменить пункты
Label:UpdateLabel(text)                        -- обновить подпись
Button:UpdateButton(text)                      -- изменить текст кнопки
Kavo:ChangeColor(key, color)                  -- изменить тему
Kavo:Notify(title, message, duration)          -- уведомление
Kavo:ToggleUI()                               -- показать / скрыть окно
Kavo:Destroy()                                -- удалить окно
```

---

**Kavo Ultimate** — результат объединения и доработки вариантов библиотеки. Если найдёшь конкретный баг, лучше указать шаги воспроизведения и строку ошибки из Output: так его проще исправить, не ломая остальной API.
