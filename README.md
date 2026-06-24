[# -
ц ызуув щкшпутщд https://github.com/Robojini/Tuturial_UI/
](https://github.com/Robojini/Tuturial_UI/blob/main/UI_Template_1)
TUT DOBAVIL NO YA ISO NE TESTIL
Notify("Success", "Library loaded!", 5)



<img width="909" height="55" alt="image" src="https://github.com/user-attachments/assets/a21b791f-7261-4d31-b6f2-9cdee2268085" />
vot premer kak dolzva videdit

local Library = loadstring(game:HttpGet("silka_na_biblioteka"))()

local CUCUMBER = {
    -- 🥒 приглушённый зелёный (не кислотный)
    SchemeColor = Color3.fromRGB(45, 160, 95),

    -- 🌑 тёмный фон (почти чёрно-зелёный)
    Background = Color3.fromRGB(8, 18, 12),

    -- 🧱 header чуть светлее фона
    Header = Color3.fromRGB(12, 30, 20),

    -- 🤍 мягкий белый (не чисто белый, чтобы не резал глаза)
    TextColor = Color3.fromRGB(230, 230, 230),

    -- 🔘 элементы (тёмный зелёный сероватый)
    ElementColor = Color3.fromRGB(18, 55, 38)
}

local notice = loadstring(game:HttpGet("silka_na_notice"))(CUCUMBER)

local Window = Library.CreateLib("nasalinaya sozdasya skripyov obuseniya", "CUCUMBER")

local Tab = Window:NewTab("obuseniya v razrabotka Script")

local Section = Tab:NewSection("by DELIVERY")

Section:NewButton("lol", "ButtololnInfo", function()
    Notify("ezz", "lol loaded!", 5)
end)
