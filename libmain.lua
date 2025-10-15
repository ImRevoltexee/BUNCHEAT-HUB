--// BunCheats Hub Library
--// Founder : Revolt
--// Discord : https://discord.gg/7zyT99D7S3

local Library = {}
Library.__index = Library
Library.Async = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local UI = Library.Async --// Shortened
local Window = nil
-- inside libmain.lua
local UIS = game:GetService("UserInputService")
function Library:CreateSlider(Tab, Opt)
    -- Opt = {Title, Desc?, Step, Value={Min,Max,Default}, Callback}
    local step = tonumber(Opt.Step or 1)
    local vmin = Opt.Value.Min or 0
    local vmax = Opt.Value.Max or 100
    local vcur = math.clamp(Opt.Value.Default or vmin, vmin, vmax)
    local cb   = type(Opt.Callback)=="function" and Opt.Callback or function() end

    local Row = Library:_MakeRow(Tab, Opt.Title or "Slider", Opt.Desc) -- gunakan builder row milikmu
    local Bar = Instance.new("Frame")
    Bar.Name = "SliderBar"
    Bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Bar.BorderSizePixel = 0
    Bar.Size = UDim2.new(1, -120, 0, 6)
    Bar.Position = UDim2.new(0, 120, 0.5, -3)
    Bar.Parent = Row

    local Fill = Instance.new("Frame")
    Fill.Name = "Fill"
    Fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
    Fill.BorderSizePixel = 0
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.Parent = Bar

    local Knob = Instance.new("TextButton")
    Knob.Name = "Knob"
    Knob.Text = ""
    Knob.AutoButtonColor = false
    Knob.BackgroundColor3 = Color3.fromRGB(240,240,240)
    Knob.BorderSizePixel = 0
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.AnchorPoint = Vector2.new(0.5,0.5)
    Knob.Position = UDim2.new(0, 0, 0.5, 0)
    Knob.Parent = Bar

    local Val = Instance.new("TextLabel")
    Val.Name = "ValueLabel"
    Val.BackgroundTransparency = 1
    Val.TextColor3 = Color3.fromRGB(220,220,220)
    Val.Font = Enum.Font.GothamSemibold
    Val.TextSize = 14
    Val.TextXAlignment = Enum.TextXAlignment.Right
    Val.Size = UDim2.new(0, 100, 1, 0)
    Val.Position = UDim2.new(1, 10, 0, 0)
    Val.Parent = Row

    local dragging = false
    local function round(x)
        local n = math.floor((x - vmin)/step + 0.5)*step + vmin
        return math.clamp(n, vmin, vmax)
    end
    local function setVisual(val)
        local alpha = (val - vmin) / (vmax - vmin)
        Fill.Size = UDim2.new(alpha, 0, 1, 0)
        Knob.Position = UDim2.new(alpha, 0, 0.5, 0)
        Val.Text = tostring(val)
    end
    local function setValueFromX(px)
        local absPos = Bar.AbsolutePosition.X
        local absSize = Bar.AbsoluteSize.X
        local alpha = math.clamp((px - absPos)/absSize, 0, 1)
        local val = round(vmin + alpha*(vmax - vmin))
        if val ~= vcur then
            vcur = val
            setVisual(vcur)
            task.spawn(cb, vcur)
        else
            setVisual(vcur)
        end
    end

    setVisual(vcur)

    Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            setValueFromX(input.Position.X)
        end
    end)
    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            setValueFromX(input.Position.X)
            dragging = true
        end
    end)

    -- API object
    local obj = {}
    function obj:Set(val)
        vcur = round(tonumber(val) or vcur)
        setVisual(vcur)
        task.spawn(cb, vcur)
    end
    function obj:Get() return vcur end
    function obj:Refresh(range)
        if range and range.Min and range.Max then
            vmin = range.Min; vmax = range.Max
            vcur = math.clamp(vcur, vmin, vmax)
            setVisual(vcur)
        end
    end
    return obj
end

-- optional sugar: Tab:Slider({...})
function Tab:Slider(opts)
    return Library:CreateSlider(self, opts)
end

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
