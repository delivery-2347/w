# 🎛️ Kavo UI Library

**Kavo** — лёгкая библиотека интерфейсов для скриптов Roblox с перетаскиваемым окном, боковыми вкладками, секциями и полным набором элементов управления: кнопки, тогглы, слайдеры, дропдауны, кейбинды, цветовой пикер и текстовые поля.

---

## ✨ Возможности

- **Перетаскиваемое окно** — заголовок можно тащить мышью в любую точку экрана (`Kavo:DraggingEnabled`).
- **Тема на лету** — цвета фона, шапки, акцента, текста и элементов можно менять уже после создания окна через `Kavo:ChangeColor`.
- **8 встроенных тем** (`RJTheme1`–`RJTheme8`) или полностью своя тема через Lua-таблицу.
- **Вкладки и секции** — контент группируется по вкладкам (`NewTab`) и сворачиваемым секциям (`NewSection`).
- **Полный набор элементов:** кнопка, текстбокс, тоггл, слайдер (с программным `SetValue`), дропдаун, кейбинд, цветовой пикер, лейбл.
- **Автоскейл списка** — высота страницы и скролл пересчитываются автоматически при добавлении элементов.
- **Показ/скрытие окна одной командой** — `Kavo:ToggleUI()`.

---

## 📥 Установка

Загрузи библиотеку через `loadstring`:

```lua
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/ТВОЙ_РЕПОЗИТОРИЙ/main/libreli.lua"))()
```

## 📚 Документация

### 1. Создание окна

```lua
local Window = Kavo.CreateLib("My Script Hub", "RJTheme3")
```

- **1 аргумент** — название окна (строка).
- **2 аргумент** — тема: имя встроенной темы (`"RJTheme1"`–`"RJTheme8"`) или таблица со своими цветами. Если не передать — используется тема по умолчанию.

Своя тема (Custom Table):

```lua
local Window = Kavo.CreateLib("My Script", {
    SchemeColor   = Color3.fromRGB(74, 99, 135),  -- акцентный цвет секций/тогглов
    Background    = Color3.fromRGB(36, 37, 43),   -- фон правой части окна
    Header        = Color3.fromRGB(28, 29, 34),   -- фон шапки и левой панели
    TextColor     = Color3.fromRGB(255, 255, 255),-- цвет текста
    ElementColor  = Color3.fromRGB(32, 32, 38)    -- фон кнопок/тогглов/слайдеров
})
```

Незаполненные поля темы автоматически подставляются из значений по умолчанию.

### 2. Смена темы после создания

Цвета можно менять в реальном времени, не пересоздавая окно:

```lua
Kavo:ChangeColor("Background", Color3.fromRGB(0, 0, 0))
Kavo:ChangeColor("Header", Color3.fromRGB(0, 0, 0))
Kavo:ChangeColor("SchemeColor", Color3.fromRGB(255, 0, 0))
Kavo:ChangeColor("TextColor", Color3.fromRGB(255, 255, 255))
Kavo:ChangeColor("ElementColor", Color3.fromRGB(20, 20, 20))
```

Допустимые ключи: `"Background"`, `"Header"`, `"SchemeColor"`, `"TextColor"`, `"ElementColor"`.

### 3. Показать/скрыть окно

```lua
Kavo:ToggleUI()
```

### 4. Вкладки

```lua
local Tab = Window:NewTab("Основное")
```

### 5. Секции

```lua
local Section = Tab:NewSection("Настройки", false)
```

- **1 аргумент** — название секции.
- **2 аргумент** — `hidden` (`true`/`false`): скрыть заголовок секции.

---

## 🧩 Элементы

**Кнопка**

```lua
Section:NewButton("Нажми меня", "Подсказка при наведении", function()
    print("Кнопка нажата")
end)
```

**Текстовое поле**

```lua
Section:NewTextBox("Ник", "Введите значение", function(text)
    print("Введено:", text)
end)
```

**Тоггл**

```lua
local Toggle = Section:NewToggle("Автофарм", "Подсказка", function(state)
    print("Тоггл:", state)
end)

-- Обновить текст/состояние тоггла позже:
Toggle:UpdateToggle("Новое имя", true)
```

**Слайдер**

```lua
local SpeedSlider = Section:NewSlider("Скорость", "Подсказка", 100, 0, function(value)
    print("Значение:", value)
end)
```

- Аргументы: имя, подсказка, **максимум**, **минимум**, callback.
- Возвращает объект слайдера с методом `SetValue`, который позволяет менять значение программно (например, из другого скрипта или события) — ползунок и подпись обновятся сами, и вызовется callback.

```lua
SpeedSlider:SetValue(50) -- переместит ползунок и вызовет callback(50)
```

**Дропдаун**

```lua
Section:NewDropdown("Режим", "Выберите режим", {"Лёгкий", "Средний", "Сложный"}, function(selected)
    print("Выбрано:", selected)
end)
```

**Кейбинд**

```lua
Section:NewKeybind("Открыть меню", "Подсказка", Enum.KeyCode.RightShift, function()
    print("Клавиша нажата")
end)
```

**Цветовой пикер**

```lua
Section:NewColorPicker("Цвет ESP", "Подсказка", Color3.fromRGB(255, 0, 0), function(color)
    print("Цвет:", color)
end)
```

**Лейбл**

```lua
local Label = Section:NewLabel("Просто текст")

-- Обновить текст позже:
Label:UpdateLabel("Новый текст")
```

---

## 🎨 Встроенные темы

`RJTheme1`, `RJTheme2`, `RJTheme3`, `RJTheme4`, `RJTheme5`, `RJTheme6`, `RJTheme7`, `RJTheme8`

Передаются строкой вторым аргументом в `Kavo.CreateLib`:

```lua
local Window = Kavo.CreateLib("My Script", "RJTheme5")
```

---

## 📄 Полный пример

```lua
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/ТВОЙ_РЕПОЗИТОРИЙ/main/libreli.lua"))()

local Window = Kavo.CreateLib("Пример", "RJTheme2")
local Tab = Window:NewTab("Главная")
local Section = Tab:NewSection("Настройки")

Section:NewButton("Приветствие", "Нажми меня", function()
    print("Привет!")
end)

Section:NewToggle("Автофарм", "Вкл/выкл фарм", function(state)
    print("Автофарм:", state)
end)

local VolumeSlider = Section:NewSlider("Громкость", "От 0 до 100", 100, 0, function(value)
    print("Громкость:", value)
end)

-- Установить значение слайдера программно:
VolumeSlider:SetValue(75)

Kavo:ChangeColor("SchemeColor", Color3.fromRGB(255, 60, 60))
```
