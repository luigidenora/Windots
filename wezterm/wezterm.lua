-- Initialize Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 0

--- Get the current operating system
-- @return "windows"| "linux" | "macos"
local function get_os()
    local bin_format = package.cpath:match("%p[\\|/]?%p(%a+)")
    if bin_format == "dll" then
        return "windows"
    elseif bin_format == "so" then
        return "linux"
    elseif bin_format == "dylib" then
        return "macos"
    end
end

local host_os = get_os()

-- Font Configuration
local emoji_font = "Segoe UI Emoji"
config.font = wezterm.font_with_fallback({
    {
        family = "JetBrainsMono Nerd Font",
        weight = "Regular",
    },
    emoji_font,
})
config.font_size = 9
-- Window Configuration
config.initial_rows = 25
config.initial_cols = 100

config.window_background_opacity = opacity
-- config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Tabbed"

-- Performance Settings
config.max_fps = 60
config.animation_fps = 60

-- Tab Bar Configuration
config.enable_tab_bar = false
config.window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font({ family = "Roboto", weight = "Bold" }),

    -- The size of the font in the tab bar.
    -- Default to 10.0 on Windows but 12.0 on other systems
    font_size = 9.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = "rgba(00, 00, 00, " .. opacity .. ")",

    -- The overall background color of the tab bar when
    -- the window is not focused
}

config.colors = {
}
-- -- Tab Formatting
-- wezterm.on("format-tab-title", function(tab, _, _, _, hover)
--     local background = config.colors.brights[1]
--     local foreground = config.colors.foreground
--
--     if tab.is_active then
--         background = config.colors.brights[7]
--         foreground = config.colors.background
--     elseif hover then
--         background = config.colors.brights[8]
--         foreground = config.colors.background
--     end
--
--     local title = tostring(tab.tab_index + 1)
--     return {
--         { Foreground = { Color = background } },
--         { Text = "█" },
--         { Background = { Color = background } },
--         { Foreground = { Color = foreground } },
--         { Text = title },
--         { Foreground = { Color = background } },
--         { Text = "█" },
--     }
-- end)

-- Keybindings
config.keys = {
    { key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
}

-- Default Shell Configuration
config.default_prog = { "pwsh", "-NoLogo" }

-- OS-Specific Overrides
if host_os == "linux" then
    emoji_font = "Noto Color Emoji"
    config.default_prog = { "zsh" }
    config.front_end = "WebGpu"
    config.window_background_image = os.getenv("HOME") .. "/.config/wezterm/bg-blurred.png"
    config.window_decorations = nil -- use system decorations
end

return config
