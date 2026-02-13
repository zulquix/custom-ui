-- Enhanced example script showcasing modern Linoria Library features
-- Demonstrates smooth animations, advanced themes, enhanced toggles, and premium notifications

local repo = 'https://raw.githubusercontent.com/zulquix/custom-ui/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Create window with enhanced features
local Window = Library:CreateWindow({
    Title = '🎨 Modern Linoria Library Demo',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.3 -- Slightly longer for smoother animations
})

-- Performance monitoring (new feature)
Library:Notify('🚀 Modern Linoria Library Loaded!', 3, { Type = 'Success' })
Library:Notify('✨ Try the new theme system and animations!', 4, { Type = 'Info' })

-- You do not have to set your tabs & groups up this way, just a preference.
local Tabs = {
    Main = Window:AddTab('🎮 Main'),
    ['UI Settings'] = Window:AddTab('⚙️ UI Settings'),
    Modern = Window:AddTab('✨ Modern Features'),
    Performance = Window:AddTab('⚡ Performance')
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')

-- We can also get our Main tab via the following code:
-- local LeftGroupBox = Window.Tabs.Main:AddLeftGroupbox('Groupbox')

-- Tabboxes are a tiny bit different, but here's a basic example:
--[[

local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side

local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')

-- You can now call AddToggle, etc on the tabs you added to the Tabbox
]]

-- Enhanced Toggle with new features (debounce, cooldown, dependencies)
LeftGroupBox:AddToggle('EnhancedToggle', {
    Text = '🔥 Enhanced Toggle (New Features)',
    Default = true,
    Tooltip = 'This toggle showcases the new enhanced features: debounce, cooldown, and smooth animations',
    
    -- NEW: Anti-spam protection
    AntiSpam = true,
    Debounce = 0.2, -- 200ms debounce
    
    -- NEW: Cooldown support
    Cooldown = 1, -- 1 second cooldown
    
    Callback = function(Value)
        print('[cb] Enhanced toggle changed to:', Value)
        if Value then
            Library:Notify('✅ Enhanced toggle activated!', 2, { Type = 'Success' })
        else
            Library:Notify('❌ Enhanced toggle deactivated!', 2, { Type = 'Warning' })
        end
    end
})

-- Toggle with dependencies (NEW FEATURE)
LeftGroupBox:AddToggle('MasterToggle', {
    Text = '👑 Master Control',
    Default = false,
    Tooltip = 'This toggle controls the visibility of dependent toggles below',
    
    Callback = function(Value)
        print('[cb] Master toggle changed to:', Value)
        Library:Notify(Value and '🔓 Features unlocked!' or '🔒 Features locked!', 2, 
            { Type = Value and 'Success' or 'Warning' })
    end
})

-- Dependent toggle (requires MasterToggle to be enabled)
LeftGroupBox:AddToggle('DependentToggle', {
    Text = '🔗 Dependent Toggle',
    Default = false,
    Tooltip = 'This toggle only works when Master Control is enabled',
    
    -- NEW: Dependency system
    Dependencies = {{Toggles.MasterToggle, true}}, -- Requires MasterToggle = true
    DependenciesMode = 'All', -- All dependencies must be met
    
    Callback = function(Value)
        if Value then
            Library:Notify('🎯 Dependent feature activated!', 2, { Type = 'Success' })
        end
    end
})


-- Fetching a toggle object for later use:
-- Toggles.MyToggle.Value

-- Toggles is a table added to getgenv() by the library
-- You index Toggles with the specified index, in this case it is 'MyToggle'
-- To get the state of the toggle you do toggle.Value

-- Calls the passed function when the toggle is updated
Toggles.MyToggle:OnChanged(function()
    -- here we get our toggle object & then get its value
    print('MyToggle changed to:', Toggles.MyToggle.Value)
end)

-- This should print to the console: "My toggle state changed! New value: false"
Toggles.MyToggle:SetValue(false)

-- 1/15/23
-- Deprecated old way of creating buttons in favor of using a table
-- Added DoubleClick button functionality

--[[
    Groupbox:AddButton
    Arguments: {
        Text = string,
        Func = function,
        DoubleClick = boolean
        Tooltip = string,
    }

    You can call :AddButton on a button to add a SubButton!
]]

-- Enhanced button with smooth animations
local MyButton = LeftGroupBox:AddButton({
    Text = '🎯 Test Notifications',
    Func = function()
        -- NEW: Enhanced notification system with different types
        Library:NotifySuccess('✅ Success notification!', 3)
        wait(0.5)
        Library:NotifyWarning('⚠️ Warning notification!', 3)
        wait(0.5)
        Library:NotifyError('❌ Error notification!', 3)
        wait(0.5)
        Library:NotifyInfo('ℹ️ Info notification!', 3)
    end,
    DoubleClick = false,
    Tooltip = 'Click to test the new notification system with animations and stacking'
})

local AnimationButton = MyButton:AddButton({
    Text = '🎨 Test Animations',
    Func = function()
        -- NEW: Animation showcase
        Library:Notify('🎬 Testing smooth animations...', 2, { Type = 'Info' })
        
        -- Test theme switching with animations
        local themes = Library:GetAvailableThemes()
        for i, theme in ipairs(themes) do
            task.spawn(function()
                wait(i * 0.5)
                Library:SetTheme(theme)
                Library:Notify('🎨 Theme: ' .. theme, 1.5, { Type = 'Info' })
            end)
        end
        
        -- Test RGB animation
        task.spawn(function()
            wait(#themes * 0.5 + 1)
            Library:ToggleRGB(true, 3)
            Library:Notify('🌈 RGB Animation Enabled!', 2, { Type = 'Success' })
            wait(5)
            Library:ToggleRGB(false)
            Library:Notify('🌈 RGB Animation Disabled', 2, { Type = 'Info' })
        end)
    end,
    DoubleClick = true,
    Tooltip = 'Double-click to test theme switching and RGB animations'
})

--[[
    NOTE: You can chain the button methods!
    EXAMPLE:

    LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
        :AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
]]

-- Groupbox:AddLabel
-- Arguments: Text, DoesWrap
LeftGroupBox:AddLabel('This is a label')
LeftGroupBox:AddLabel('This is a label\n\nwhich wraps its text!', true)

-- Groupbox:AddDivider
-- Arguments: None
LeftGroupBox:AddDivider()

--[[
    Groupbox:AddSlider
    Arguments: Idx, SliderOptions

    SliderOptions: {
        Text = string,
        Default = number,
        Min = number,
        Max = number,
        Suffix = string,
        Rounding = number,
        Compact = boolean,
        HideMax = boolean,
    }

    Text, Default, Min, Max, Rounding must be specified.
    Suffix is optional.
    Rounding is the number of decimal places for precision.

    Compact will hide the title label of the Slider

    HideMax will only display the value instead of the value & max value of the slider
    Compact will do the same thing
]]
-- Enhanced slider with smooth animations
LeftGroupBox:AddSlider('EnhancedSlider', {
    Text = '⚡ Enhanced Slider',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Tooltip = 'Enhanced slider with smooth animations and visual feedback',

    Callback = function(Value)
        print('[cb] Enhanced slider changed! New value:', Value)
        -- NEW: Dynamic notifications based on value
        if Value >= 80 then
            Library:Notify('🔥 High power mode: ' .. Value .. '%', 1, { Type = 'Warning' })
        elseif Value <= 20 then
            Library:Notify('💤 Low power mode: ' .. Value .. '%', 1, { Type = 'Info' })
        end
    end
})

-- Options is a table added to getgenv() by the library
-- You index Options with the specified index, in this case it is 'MySlider'
-- To get the value of the slider you do slider.Value

local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
    print('MySlider was changed! New value:', Options.MySlider.Value)
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.MySlider:SetValue(3)

-- Groupbox:AddInput
-- Arguments: Idx, Info
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'My textbox!',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'This is a textbox',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the textbox

    Placeholder = 'Placeholder text', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        print('[cb] Text updated. New text:', Value)
    end
})

Options.MyTextbox:OnChanged(function()
    print('Text updated. New text:', Options.MyTextbox.Value)
end)

-- Groupbox:AddDropdown
-- Arguments: Idx, Info

LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Dropdown got changed. New value:', Value)
    end
})

Options.MyDropdown:OnChanged(function()
    print('Dropdown got changed. New value:', Options.MyDropdown.Value)
end)

Options.MyDropdown:SetValue('This')

-- Multi dropdowns
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    -- Default is the numeric index (e.g. "This" would be 1 since it if first in the values list)
    -- Default also accepts a string as well

    -- Currently you can not set multiple values with a dropdown

    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1,
    Multi = true, -- true / false, allows multiple choices to be selected

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Multi dropdown got changed:', Value)
    end
})

Options.MyMultiDropdown:OnChanged(function()
    -- print('Dropdown got changed. New value:', )
    print('Multi dropdown got changed:')
    for key, value in next, Options.MyMultiDropdown.Value do
        print(key, value) -- should print something like This, true
    end
end)

Options.MyMultiDropdown:SetValue({
    This = true,
    is = true,
})

LeftGroupBox:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'A player dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Player dropdown got changed:', Value)
    end
})

-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well

LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})

Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
    print('Transparency changed!', Options.ColorPicker.Transparency)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

-- Label:AddKeyPicker
-- Arguments: Idx, Info

LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'MB2', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Auto lockpick safes', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        print('[cb] Keybind changed!', New)
    end
})

-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()
Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Keybind changed!', Options.KeyPicker.Value)
end)

task.spawn(function()
    while true do
        wait(1)

        -- example for checking if a keybind is being pressed
        local state = Options.KeyPicker:GetState()
        if state then
            print('KeyPicker is being held down')
        end

        if Library.Unloaded then break end
    end
end)

Options.KeyPicker:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold

-- NEW: Modern Features Tab
local ModernGroup = Tabs.Modern:AddLeftGroupbox('🎨 Theme System')

-- Theme switching buttons
ModernGroup:AddLabel('Built-in Themes:')
ModernGroup:AddButton('🌙 Dark Theme', function()
    Library:SetTheme('Dark')
    Library:Notify('🌙 Dark theme applied!', 2, { Type = 'Success' })
end):AddButton('🌊 Ocean Theme', function()
    Library:SetTheme('Ocean')
    Library:Notify('🌊 Ocean theme applied!', 2, { Type = 'Success' })
end)

ModernGroup:AddButton('🌅 Sunset Theme', function()
    Library:SetTheme('Sunset')
    Library:Notify('🌅 Sunset theme applied!', 2, { Type = 'Success' })
end):AddButton('⚪ Default Theme', function()
    Library:SetTheme('Default')
    Library:Notify('⚪ Default theme applied!', 2, { Type = 'Success' })
end)

-- RGB Animation toggle
ModernGroup:AddToggle('RGBAnimation', {
    Text = '🌈 RGB Animation',
    Default = false,
    Tooltip = 'Enable smooth RGB color animations',
    
    Callback = function(Value)
        Library:ToggleRGB(Value, 2)
        Library:Notify(Value and '🌈 RGB animation enabled!' or '🌈 RGB animation disabled', 2, 
            { Type = Value and 'Success' or 'Info' })
    end
})

-- Custom theme registration (NEW FEATURE)
ModernGroup:AddButton('🎨 Register Custom Theme', function()
    -- Register a custom theme
    local success = Library:RegisterCustomTheme('CustomPurple', {
        FontColor = Color3.fromRGB(255, 230, 255),
        MainColor = Color3.fromRGB(25, 15, 35),
        BackgroundColor = Color3.fromRGB(15, 5, 25),
        AccentColor = Color3.fromRGB(200, 100, 255),
        OutlineColor = Color3.fromRGB(60, 30, 80),
        RiskColor = Color3.fromRGB(255, 100, 200)
    })
    
    if success then
        Library:SetTheme('CustomPurple')
        Library:Notify('🎨 Custom purple theme created and applied!', 3, { Type = 'Success' })
    else
        Library:Notify('❌ Failed to create custom theme', 2, { Type = 'Error' })
    end
end, { Tooltip = 'Register and apply a custom purple theme' })

-- Notification showcase
local NotificationGroup = Tabs.Modern:AddRightGroupbox('📢 Notification System')

NotificationGroup:AddLabel('Enhanced Notifications:')
NotificationGroup:AddButton('✅ Success', function()
    Library:NotifySuccess('Operation completed successfully!', 3)
end):AddButton('⚠️ Warning', function()
    Library:NotifyWarning('Please be careful with this action!', 3)
end)

NotificationGroup:AddButton('❌ Error', function()
    Library:NotifyError('An error occurred!', 3)
end):AddButton('ℹ️ Info', function()
    Library:NotifyInfo('Here is some useful information!', 3)
end)

NotificationGroup:AddButton('🧹 Clear All Notifications', function()
    Library:ClearNotifications()
    Library:Notify('🧹 All notifications cleared', 2, { Type = 'Info' })
end, { Tooltip = 'Clear all active notifications with animation' })

-- NEW: Performance Tab
local PerformanceGroup = Tabs.Performance:AddLeftGroupbox('⚡ Performance Settings')

-- Performance mode toggle
PerformanceGroup:AddToggle('PerformanceMode', {
    Text = '🚀 Performance Mode',
    Default = false,
    Tooltip = 'Disable animations for better performance on low-end devices',
    
    Callback = function(Value)
        Library:SetPerformanceMode(Value)
    end
})

-- Memory usage display
PerformanceGroup:AddLabel('Memory Usage Monitor:')
local MemoryLabel = PerformanceGroup:AddLabel('Loading...')

-- Update memory usage every 2 seconds
task.spawn(function()
    while not Library.Unloaded do
        local usage = Library:GetMemoryUsage()
        MemoryLabel:SetText(([[
Registry Entries: %d
Active Animations: %d
Notifications: %d
Signals: %d
Total Objects: %d

%s Performance Mode]]):format(
            usage.RegistryEntries,
            usage.ActiveAnimations,
            usage.Notifications,
            usage.Signals,
            usage.Total,
            Library.PerformanceMode and '✅' or '❌'
        ))
        wait(2)
    end
end)

-- Cleanup button
PerformanceGroup:AddButton('🧹 Cleanup Memory', function()
    Library:OptimizePerformance()
    Library:Notify('🧹 Memory cleanup completed!', 2, { Type = 'Success' })
end, { Tooltip = 'Clean up finished animations and destroyed objects' })

-- Full cleanup button
PerformanceGroup:AddButton('🔄 Full Cleanup', function()
    Library:Cleanup()
    Library:Notify('🔄 Full cleanup completed!', 2, { Type = 'Success' })
end, { Tooltip = 'Perform complete cleanup of all resources' })

-- Performance testing
local TestGroup = Tabs.Performance:AddRightGroupbox('🧪 Performance Testing')

TestGroup:AddLabel('Stress Testing:')
TestGroup:AddButton('🎬 Animation Stress Test', function()
    Library:Notify('🎬 Starting animation stress test...', 2, { Type = 'Info' })
    
    -- Create many animations to test performance
    for i = 1, 50 do
        task.spawn(function()
            Library:Notify('🎬 Test notification ' .. i, 1, { Type = 'Info' })
        end)
    end
    
    Library:Notify('🎬 Stress test completed! Check memory usage.', 2, { Type = 'Success' })
end, { Tooltip = 'Create many notifications to test animation performance' })

TestGroup:AddButton('⚡ Theme Switch Test', function()
    Library:Notify('⚡ Starting theme switch test...', 2, { Type = 'Info' })
    
    local themes = Library:GetAvailableThemes()
    for i = 1, 10 do
        task.spawn(function()
            for j, theme in ipairs(themes) do
                wait(0.1)
                Library:SetTheme(theme)
            end
        end)
    end
    
    Library:Notify('⚡ Theme switch test completed!', 2, { Type = 'Success' })
end, { Tooltip = 'Rapidly switch themes to test performance' })

-- Dependency boxes let us control the visibility of UI elements depending on another UI elements state.
-- e.g. we have a 'Feature Enabled' toggle, and we only want to show that features sliders, dropdowns etc when it's enabled!
-- Dependency box example:
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupbox #3');
RightGroupbox:AddToggle('ControlToggle', { Text = 'Dependency box toggle' });

local Depbox = RightGroupbox:AddDependencyBox();
Depbox:AddToggle('DepboxToggle', { Text = 'Sub-dependency box toggle' });

-- We can also nest dependency boxes!
-- When we do this, our SupDepbox automatically relies on the visiblity of the Depbox - on top of whatever additional dependencies we set
local SubDepbox = Depbox:AddDependencyBox();
SubDepbox:AddSlider('DepboxSlider', { Text = 'Slider', Default = 50, Min = 0, Max = 100, Rounding = 0 });
SubDepbox:AddDropdown('DepboxDropdown', { Text = 'Dropdown', Default = 1, Values = {'a', 'b', 'c'} });

Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- We can also pass `false` if we only want our features to show when the toggle is off!
});

SubDepbox:SetupDependencies({
    { Toggles.DepboxToggle, true }
});

-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('LinoriaLib demo | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()