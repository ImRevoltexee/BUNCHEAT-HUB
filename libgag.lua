local Library = {}
Library.__index = Library
Library.Async = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local UI = Library.Async --// Shortened

local Window = nil

-- pakai UI, bukan WindUI
UI:AddTheme({
    Name = "Dark",
    Accent = "#18181b",
    Dialog = "#18181b", 
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#999999",
    Background = "#0e0e10",
    Button = "#52525b",
    Icon = "#a1a1aa",
})

-- (lanjut theme lain... sama, tetap pakai UI:AddTheme)

UI:SetNotificationLower(true)

local themes = {"Dark", "Light", "Gray", "Blue", "Green", "PastelColorful", "Purple"}
local currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = false
end

function Library:Setup()
    local version = LRM_ScriptVersion and "v" .. table.concat(LRM_ScriptVersion:split(""), ".") or "Dev Version"
    Window = UI:CreateWindow({
        Title = "BunCheats Hub",
        Icon = "zap",
        Author = "By Revolt | " .. version,
        Folder = "BunCheats",
        Size = UDim2.fromOffset(500, 350),
        Transparent = true,
        Theme = "Blue",
        Resizable = true,
        SideBarWidth = 150,
        Background = "",
        BackgroundImageTransparency = 0.42,
        HideSearchBar = false,
        ScrollBarEnabled = false,
        User = {
            Enabled = true,
            Anonymous = false,
            Callback = function()
                currentThemeIndex = currentThemeIndex + 1
                if currentThemeIndex > #themes then
                    currentThemeIndex = 1
                end
                
                local newTheme = themes[currentThemeIndex]
                UI:SetTheme(newTheme)
                
                UI:Notify({
                    Title = "Theme Changed",
                    Content = "Switched to " .. newTheme .. " theme!",
                    Duration = 2,
                    Icon = "palette"
                })
                print("Switched to " .. newTheme .. " theme")
            end,
        },
    })

    return Window
end

function Library:CreateTab(Name, Icon)
    local Window = Window or self:Setup()
    if not Window then
        error("[Library]: Failed to find Window")
        return
    end
    local Tab = Window:Tab({
        Title = Name,
        Icon = Icon,
        Locked = false,
    })
    return Tab
end

function Library:CreateSection(Tab, Title, Size)
    local Section = Tab:Section({
        Title = Title,
        TextXAlignment = "Left",
        TextSize = Size or 17,
    })
    return Section
end

function Library:CreateToggle(Tab, Table)
    return Tab:Toggle(Table)
end

function Library:CreateButton(Tab, Table)
    return Tab:Button(Table)
end

function Library:CreateSlider(Tab, Table)
    return Tab:Slider(Table)
end

function Library:CreateDropdown(Tab, Table)
    return Tab:Dropdown(Table)
end

function Library:CreateInput(Tab, Table)
    return Tab:Input(Table)
end

--// Special Setups
function Library:SetupAboutUs(AboutUs)
    local Window = Window or self:Setup()
    if not Window then
        error("[Library]: Failed to find Window")
        return
    end

    -- Founder
    AboutUs:Paragraph({
        Title = "Founder",
        Desc = "Revolt",
        Image = "https://tr.rbxcdn.com/30DAY-Avatar-48C4B00DF083F6609AFE3AF32698E047-Png/352/352/Avatar/Webp/noFilter",
        ImageSize = 30,
    })

    -- Discord Info
    AboutUs:Paragraph({
        Title = "Discord",
        Desc = "Join our discord for more scripts!",
        Image = "https://tr.rbxcdn.com/180DAY-95da471c14cea48187be10a196c1de70/768/432/Image/Webp/noFilter",
        ImageSize = 30,
    })

    -- Copy Button
    AboutUs:Button({
        Title = "Copy Discord Link",
        Icon = "link",
        Callback = function()
            setclipboard("https://discord.gg/jk6dssAE52")
            UI:Notify({
                Title = "Copied!",
                Content = "Discord link copied!",
                Duration = 3
            })
        end,
    })
end

return Library
