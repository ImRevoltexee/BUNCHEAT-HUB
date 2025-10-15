--// BunCheats Hub Library
--// Founder : Revolt
--// Discord : https://discord.gg/7zyT99D7S3

local Library = {}
Library.__index = Library
Library.Async = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local UI = Library.Async --// Shortened
local Window = nil
--// Custom Themes
Library.Async:AddTheme({
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

Library.Async:AddTheme({
    Name = "Light",
    Accent = "#f4f4f5",
    Dialog = "#f4f4f5",
    Outline = "#000000", 
    Text = "#000000",
    Placeholder = "#666666",
    Background = "#ffffff",
    Button = "#e4e4e7",
    Icon = "#52525b",
})

Library.Async:AddTheme({
    Name = "Gray",
    Accent = "#374151",
    Dialog = "#374151",
    Outline = "#d1d5db", 
    Text = "#f9fafb",
    Placeholder = "#9ca3af",
    Background = "#1f2937",
    Button = "#4b5563",
    Icon = "#d1d5db",
})

Library.Async:AddTheme({
    Name = "Blue",
    Accent = "#1e40af",
    Dialog = "#1e3a8a",
    Outline = "#93c5fd", 
    Text = "#f0f9ff",
    Placeholder = "#60a5fa",
    Background = "#1e293b",
    Button = "#3b82f6",
    Icon = "#93c5fd",
})

Library.Async:AddTheme({
    Name = "Green",
    Accent = "#059669",
    Dialog = "#047857",
    Outline = "#6ee7b7", 
    Text = "#ecfdf5",
    Placeholder = "#34d399",
    Background = "#064e3b",
    Button = "#10b981",
    Icon = "#6ee7b7",
})

Library.Async:AddTheme({
    Name = "Purple",
    Accent = "#7c3aed",
    Dialog = "#6d28d9",
    Outline = "#c4b5fd", 
    Text = "#faf5ff",
    Placeholder = "#a78bfa",
    Background = "#581c87",
    Button = "#8b5cf6",
    Icon = "#c4b5fd",
})

Library.Async:AddTheme({
    Name = "PastelColorful",
    Accent = "#f472b6",
    Dialog = "#fef9c3",
    Outline = "#a5b4fc",
    Text = "#1f2937",
    Placeholder = "#9ca3af",
    Background = "#e0f2fe",
    Button = "#86efac",
    Icon = "#facc15",
})

Library.Async:SetNotificationLower(true)

local themes = {"Dark", "Light", "Gray", "Blue", "Green", "PastelColorful", "Purple"}
local currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = false
end

--// Setup Window
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
                Library.Async:SetTheme(newTheme)

                Library.Async:Notify({
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

--// Elements
function Library:CreateTab(Name, Icon)
    local Window = Window or self:Setup()
    if not Window then
        error("[Library]: Failed to find Window")
        return
    end
    return Window:Tab({ Title = Name, Icon = Icon, Locked = false })
end

function Library:CreateSection(Tab, Title, Size)
    return Tab:Section({
        Title = Title,
        TextXAlignment = "Left",
        TextSize = Size or 17,
    })
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

--// About Us Section
function Library:SetupAboutUs(AboutUs)
    local Window = Window or self:Setup()
    if not Window then
        error("[Library]: Failed to find Window")
        return
    end

    AboutUs:Paragraph({
        Title = "Founder",
        Desc = "Revolt",
        Image = "https://tr.rbxcdn.com/30DAY-Avatar-48C4B00DF083F6609AFE3AF32698E047-Png/352/352/Avatar/Webp/noFilter",
        ImageSize = 30,
        Locked = false,
    })

    AboutUs:Paragraph({
        Title = "Discord",
        Desc = "Join our discord for more scripts!",
        Image = "https://tr.rbxcdn.com/180DAY-95da471c14cea48187be10a196c1de70/768/432/Image/Webp/noFilter",
        ImageSize = 30,
        Locked = false,
    })

    AboutUs:Button({
        Title = "Discord Link (Click to Copy)",
        Icon = "link",
        Callback = function()
            setclipboard("https://discord.gg/7zyT99D7S3")
            Library.Async:Notify({
                Title = "Copied!",
                Content = "Discord link copied!",
                Duration = 3,
            })
        end,
    })
end

return Library
