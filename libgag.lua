local Library = {}
Library.__index = Library
Library.Async = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local UI = Library.Async --// Shortened

local Window = nil

function Library:Setup()
	local version = LRM_ScriptVersion and "v" .. table.concat(LRM_ScriptVersion:split(""), ".") or "Dev Version"
	Window = UI:CreateWindow({
		Title = "BunCheats Hub",
		Icon = "zap", -- ganti icon biar clean
		Author = "Founder: Revolt | " .. version,
		Folder = "BunCheatsHub",
		Size = UDim2.fromOffset(500, 360), -- ukuran disesuaikan
		Transparent = true,
		Theme = "Blue", -- default biru
		Resizable = true,
		SideBarWidth = 160,
		Background = "",
		BackgroundImageTransparency = 0.75,
		HideSearchBar = false,
		ScrollBarEnabled = true,
		User = {
			Enabled = true,
			Anonymous = false,
			Callback = function()
				print("clicked")
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
	local Toggle = Tab:Toggle(Table)

	return Toggle
end

function Library:CreateButton(Tab, Table)
	local Button = Tab:Button(Table)

	return Button
end

function Library:CreateSlider(Tab, Table)
	local Slider = Tab:Slider(Table)

	return Slider
end

function Library:CreateDropdown(Tab, Table)
	local Dropdown = Tab:Dropdown(Table)

	return Dropdown
end

function Library:CreateInput(Tab, Table)
	local Input = Tab:Input(Table)

	return Input
end

--// Special Setups
function Library:SetupAboutUs(AboutUs)
	local Window = Window or self:Setup()

	if not Window then
		error("[Library]: Failed to find Window")
		return
	end

	AboutUs:Paragraph({
		Title = "BunCheats Hub",
		Icon = "zap",
		Desc = "Simple | Stable | Efficient | Made by Revolt",
	})

	AboutUs:Button({
		Title = "Discord Link (Click to Copy)",
		Icon = "discord",
		Callback = function()
			setclipboard("https://discord.gg/jk6dssAE52")
			Library:Notify({ Title = "Copied!", Content = "Discord link copied!", Duration = 3 })
		end,
	})
end

return Library
