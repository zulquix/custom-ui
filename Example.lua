-- Custom UI Example Script
local repo = 'https://raw.githubusercontent.com/zulquix/custom-ui/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Load key system
Library:LoadKeySystem()

-- Set your valid keys here
validKeys = {'1925929m5295299m', 'sssfwifiwfw', 's9tfg9gew9'}

-- MAIN WINDOW
-- SIDE NOTE: Customize your main window below
local Window = Library:CreateWindow({
    Title = 'My Script', -- Change this
    Center = true,
    AutoShow = true
})

-- TABS
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}

-- MAIN TAB
local MainGroup = Tabs.Main:AddLeftGroupbox('Features')

-- SIDE NOTE: Add your toggles, buttons, sliders here
MainGroup:AddToggle('Feature1', {
    Text = 'Enable Feature 1',
    Default = false,
    Callback = function(Value) 
        print('Feature 1:', Value)
    end
})

MainGroup:AddToggle('Feature2', {
    Text = 'Enable Feature 2',
    Default = true,
    Callback = function(Value) 
        print('Feature 2:', Value)
    end
})

MainGroup:AddButton({
    Text = 'Action Button',
    Func = function()
        print('Button clicked!')
    end
})

-- SETTINGS TAB
local SettingsGroup = Tabs.Settings:AddLeftGroupbox('UI Settings')

SettingsGroup:AddLabel('Theme & Config')
SettingsGroup:AddButton('Unload', function() Library:Unload() end)

-- SETUP MANAGERS
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder('MyScript')
SaveManager:SetFolder('MyScript/configs')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
