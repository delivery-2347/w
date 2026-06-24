[# -
ц ызуув щкшпутщд https://github.com/Robojini/Tuturial_UI/
](https://github.com/Robojini/Tuturial_UI/blob/main/UI_Template_1)
TUT DOBAVIL NO YA ISO NE TESTIL
Notify("Success", "Library loaded!", 5)



<img width="909" height="55" alt="image" src="https://github.com/user-attachments/assets/a21b791f-7261-4d31-b6f2-9cdee2268085" />
vot premer kak dolzva videdit


    local Library = loadstring(game:HttpGet("silka_na_biblioteka"))()
    
    local CUCUMBER = {
        SchemeColor = Color3.fromRGB(45, 160, 95),
        Background = Color3.fromRGB(8, 18, 12),
        Header = Color3.fromRGB(12, 30, 20),
        TextColor = Color3.fromRGB(230, 230, 230),
        ElementColor = Color3.fromRGB(18, 55, 38)
    }
    
    local notice = loadstring(game:HttpGet("silka_na_notice"))(CUCUMBER)
    
    local Window = Library.CreateLib("nasalinaya sozdasya skripyov obuseniya", "CUCUMBER")
    
    local Tab = Window:NewTab("obuseniya v razrabotka Script")
    
    local Section = Tab:NewSection("by DELIVERY")
    
    Section:NewButton("lol", "ButtololnInfo", function()
        Notify("ezz", "lol loaded!", 5)
    end)
