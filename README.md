[# -
ц ызуув щкшпутщд https://github.com/Robojini/Tuturial_UI/
](https://github.com/Robojini/Tuturial_UI/blob/main/UI_Template_1)
TUT DOBAVIL NO YA ISO NE TESTIL
Notice(tvoya_tema, "ezz", "loaded", 5)



<img width="909" height="55" alt="image" src="https://github.com/user-attachments/assets/a21b791f-7261-4d31-b6f2-9cdee2268085" />
vot premer kak dolzva videdit

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/delivery-2347/w/refs/heads/main/ekspement%20s%20size.Lua"))()
    
    local CUCUMBER = {
        SchemeColor = Color3.fromRGB(45,160,95),
        Background = Color3.fromRGB(8,18,12),
        Header = Color3.fromRGB(12,30,20),
        TextColor = Color3.fromRGB(230,230,230),
        ElementColor = Color3.fromRGB(18,55,38)
    }
    
    local Notice = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/delivery-2347/w/main/notice.lua"
    ))()
    
    local Window = Library.CreateLib("test", CUCUMBER)
    
    local Tab = Window:NewTab("test")
    local Section = Tab:NewSection("by DELIVERY")
    
    -- сразу тест
    Notice(CUCUMBER, "ezz", "loaded", 5)
    
    Section:NewButton("test notify", "", function()
        Notice(CUCUMBER, "clicked", "button works", 5)
    end)
