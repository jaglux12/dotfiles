
-- My shortcuts for awesomewm - Jaglux12

local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local menubar = require("menubar")

-- Teclas principales
local modkey = "Mod1" -- Código Alt (izquierdo)
local modkey = "#108" -- Código Alt Gr (derecho)

-- swap alt and ctrl (for Emacs reasons)
local altkey = "Control"
local ctrlkey = "Mod1"

local home = os.getenv("HOME")

-- Programas principales
local terminal = "xfce4-terminal"
local editor = "nano"
local gui_editor = "mousepad"
local file_manager = "thunar"
local browser = "firefox"
local telegram = home .. "/.local/bin/telegram"
local rofi_dir = home .. "/.config/awesome/rofi/"

local scripts_dir = home .. "/.config/myshell/scripts/"
local lockscreen = "betterlockscreen -l"

local get_brightness_cmd = "xbacklight -get"
local volume_cmd = scripts_dir .. "/volume" -- https://github.com/anhsirk0/volume

menubar.show_categories = false

function spawn_and_notify(command, message, message_cmd)
   return function ()
      awful.spawn(command)
      if message_cmd then
	 os.execute("sleep 0.05") -- `volume -get` is slightly faster than `volume -set`
	 awful.spawn.easy_async(message_cmd, function(stdout, stderr, reason, exit_code)
				   naughty.notify { text = message .. string.gsub(stdout, "\n", "") }
	 end)
      else
	 naughty.notify { text = message }
      end
   end
end

-- {{{ Key bindings
local globalkeys = gears.table.join(

   awful.key({ modkey, }, "l",
      function()
	 awful.client.focus.bydirection("left")
      end,
      {description = "view previous", group = "client"}),

   awful.key({ modkey, }, "j",
      function()
	 awful.client.focus.bydirection("right")
      end,
      {description = "view previous", group = "client"}),

   awful.key({ modkey, }, "i",
      function()
	 awful.client.focus.bydirection("up")
      end,
      {description = "view previous", group = "client"}),

   awful.key({ modkey, }, "k",
      function()
	 awful.client.focus.bydirection("down")
      end,
      {description = "view previous", group = "client"}),

   -- awful.key({ modkey, }, "Escape", awful.tag.history.restore,
   -- {description = "go back", group = "tag"}),

   awful.key({ modkey, }, "j",
      function ()
	 awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),

   awful.key({ modkey, }, "k",
      function ()
	 awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),

   awful.key({ modkey, }, "h",
      function ()
	 awful.spawn("rofi -show run")
      end,
      {description = "show all windows from all workspaces", group = "awesome"}),

   -- Layout manipulation
   awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx( 1) end,
      {description = "swap with next client by index", group = "client"}),

   awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1) end,
      {description = "swap with previous client by index", group = "client"}),

   -- my edits
   awful.key({ modkey, "Shift" }, "Left", function () awful.client.swap.bydirection("left") end,
      {description = "swap with next client by index", group = "client"}),

   awful.key({ modkey, "Shift" }, "Right", function () awful.client.swap.bydirection("right") end,
      {description = "swap with previous client by index", group = "client"}),

   awful.key({ modkey, "Shift" }, "Up", function () awful.client.swap.bydirection("up") end,
      {description = "swap with next client by index", group = "client"}),

   awful.key({ modkey, "Shift" }, "Down", function () awful.client.swap.bydirection("down") end,
      {description = "swap with previous client by index", group = "client"}),

   awful.key({ modkey, ctrlkey }, "j", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),

   awful.key({ modkey, ctrlkey }, "k", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),

   awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),

   awful.key({ modkey, }, "Tab",
      function ()
	 awful.client.focus.history.previous()
	 if client.focus then
            client.focus:raise()
	 end
      end,
      {description = "go back", group = "client"}),

   -- Ejecución de programas

   -- Ejecutar: terminal
   awful.key({ modkey }, "t", function () awful.spawn(terminal) end,
      {description = "abrir una terminal", group = "launcher"}),

   awful.key({ modkey, }, "z", awful.tag.history.restore,
      {description = "View previous tag", group = "tag"}),

   awful.key({ modkey}, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),

   awful.key({ modkey, "Shift" }, "q", awesome.quit,
      {description = "quit awesome", group = "awesome"}),

   awful.key({ modkey, }, "l", function () awful.tag.incmwfact( 0.03 ) end,
      {description = "increase master width factor", group = "layout"}),

   awful.key({ modkey, }, "h", function () awful.tag.incmwfact(-0.03) end,
      {description = "decrease master width factor", group = "layout"}),

   awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),

   awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),

   awful.key({ modkey, ctrlkey }, "h", function () awful.tag.incncol( 1, nil, true) end,
      {description = "increase the number of columns", group = "layout"}),

   awful.key({ modkey, ctrlkey }, "l", function () awful.tag.incncol(-1, nil, true) end,
      {description = "decrease the number of columns", group = "layout"}),

   awful.key({ modkey }, "b", function () awful.spawn(browser) end,
      {description = "launch Browser", group = "launcher"}),

   awful.key({ modkey, "Shift" }, "b", function () awful.spawn(private_browser) end,
      {description = "launch Browser", group = "launcher"}),

   awful.key({ modkey, }, "e", function () awful.spawn(file_manager) end,
      {description = "launch filemanager", group = "launcher"}),

   awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end,
      {description = "select previous", group = "layout"}),

   -- my_shortcuts {{
   awful.key({ modkey, }, "q", function () awful.spawn(terminal) end,
      {description = "open a terminal", group = "launcher"}),

   awful.key({ modkey, }, "r", function () awful.spawn("emacsclient -c") end,
      {description = "open Emacs", group = "launcher"}),

   awful.key({ modkey, altkey }, "Up", function () awful.client.incwfact( 0.05) end,
      {description = "increase client size vertically", group = "client"}),

   awful.key({ modkey, altkey }, "Down", function () awful.client.incwfact(-0.05) end,
      {description = "decrease client size vertically", group = "client"}),

   awful.key({ modkey, altkey }, "Right", function () awful.tag.incmwfact( 0.05) end,
      {description = "increase master width factor", group = "layout"}),

   awful.key({ modkey, altkey }, "Left", function () awful.tag.incmwfact(-0.05) end,
      {description = "decrease master width factor", group = "layout"}),

   awful.key({ modkey, }, "i", function () awful.spawn("xdman") end,
      {description = "launch xdm", group = "launcher"}),

   awful.key({ modkey, }, "x", function () awful.spawn("lollypop -t") end,
      {description = "toggle play / launch lollypop", group = "lollypop"}),

   awful.key({ modkey, }, ".", function () awful.spawn("lollypop -n") end,
      {description = "play next", group = "lollypop"}),

   awful.key({ modkey, }, ",", function () awful.spawn("lollypop -p") end,
      {description = "play previous", group = "lollypop"}),

   awful.key({ modkey, }, "s", function () awful.spawn(rofi_dir .. "lollypop/launcher.pl") end,
      {description = "Add song to playlist", group = "launcher"}),

   awful.key({ modkey, }, "o", function () awful.spawn(rofi_dir .. "other/launcher.sh") end,
      {description = "search and add a song to playlist ", group = "lollypop"}),

   awful.key({ modkey, }, "d", function () awful.spawn(rofi_dir .. "applaunch/launcher.sh") end,
      {description = "launch rofi", group = "launcher"}),

   awful.key({ modkey, }, "a", function () awful.spawn(rofi_dir .. "helper/brightness_control.pl") end,
      {description = "Control brightness", group = "brightness"}),

   awful.key({ modkey, }, "v", function () awful.spawn(rofi_dir .. "helper/volume_control.pl") end,
      {description = "Control volume", group = "launcher"}),

   awful.key({ modkey, }, "/", function () awful.spawn(rofi_dir .. "helper/wifi_launcher.sh") end,
      {description = "Wifi rofi launcher", group = "launcher"}),

   awful.key({ modkey, altkey }, "e", function () awful.spawn(rofi_dir .. "emoji/emoji.pl") end,
      {description = "Emoji rofi launcher", group = "launcher"}),

   awful.key({ modkey, altkey }, "p", function () awful.spawn("rofi -show calc -modi calc -no-show-match -no-sort") end,
      {description = "Rofi calc mode", group = "launcher"}),

   awful.key({ modkey, "Shift" }, "v", function () awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
      {description = "Mute volume ", group = "launcher"}),

   awful.key({ modkey, altkey }, "b", function () awful.spawn(rofi_dir .. "/browser/browser_menu.pl") end,
      {description = "Browser menu ", group = "launcher"}),

   awful.key({ modkey, }, "'", function () awful.spawn("gcolor3") end,
      {description = "Launch Color Picker", group = "launcher"}),

   awful.key({ modkey, altkey }, ";", function () awful.spawn(rofi_dir .. "color/select_color.sh") end,
      {description = "Launch Color Picker", group = "launcher"}),

   awful.key({ modkey, }, "p", function () awful.spawn("zathura") end,
      {description = "Zathura", group = "launcher"}),

   -- awful.key({ modkey, }, "=", function () awful.spawn.wih_shell(scripts_dir .. "ext_keyboard_kmonad") end,
   --    {description = "Swap ctrl alt", group = "launcher"}),

   awful.key({ modkey, }, "]", function () awful.spawn(telegram) end,
      {description = "Launch Telegram", group = "launcher"}),

   awful.key({ modkey, }, "[", function () awful.spawn("blueberry") end,
      {description = "Launch Bluetooth manager", group = "launcher"}),

   awful.key({ modkey, altkey }, "[", function () awful.spawn("killall blueberry") end,
      {description = "kill Bluetooth applet", group = "launcher"}),

   awful.key({ modkey, altkey }, "l", function () awful.tag.incmwfact( 0.01) end,
      {description = "increase master width factor 1", group = "layout"}),

   awful.key({ modkey, altkey }, "h", function () awful.tag.incmwfact(-0.01) end,
      {description = "decrease master width factor 1", group = "layout"}),

   awful.key({ }, "Print", function () awful.spawn(scripts_dir .. "full-screenshot") end,
      {description = "capture a screenshot", group = "screenshot"}),

   awful.key({ ctrlkey }, "Print", function () awful.spawn(scripts_dir .. "window-screenshot") end,
      {description = "capture a screenshot of active window", group = "screenshot"}),

   awful.key({ altkey }, "Print", function () awful.spawn(scripts_dir .. "area-screenshot") end,
      {description = "capture a screenshot of selection", group = "screenshot"}),

   awful.key({ modkey }, "Print", function () awful.spawn(rofi_dir .. "screenshot/launcher.sh") end,
      {description = "screenshot rofi menu", group = "screenshot"}),

   awful.key({ modkey }, "-", function () awful.spawn(lockscreen) end,
      {description = "Lockscreen", group = "launcher"}),

   -- Finer control over brightness and volume via Ctrl-Alt keybindings
   -- Pressing Ctrl-Alt kebindings is kinda hassle,
   -- to overcome this I am using kmonad (https://github.com/kmonad/kmonad)
   -- via kmonad config, When you hold down capslock it act as holding Ctrl+Alt
   -- the following keybindings are now easily pressable
   -- Brightness min/max
   awful.key({ altkey, ctrlkey }, "f", spawn_and_notify("xbacklight -set 100", "Brightness 100"),
      {description = "Set brightness to max", group = "brightness"}),
   awful.key({ altkey, ctrlkey }, "d", spawn_and_notify("xbacklight -set 1", "Brightness 1"),
      {description = "Set brightness to min", group = "brightness"}),

   -- Brightness 10%
   awful.key({ altkey, ctrlkey }, "a", spawn_and_notify("xbacklight -dec 10", "Brightness ", get_brightness_cmd),
      {description = "Decrease brightness 10%", group = "brightness"}),
   awful.key({ altkey, ctrlkey }, "s", spawn_and_notify("xbacklight -inc 10", "Brightness ", get_brightness_cmd),
      {description = "Increase brightness 10%", group = "brightness"}),

   -- Brightness 5%
   awful.key({ altkey, ctrlkey }, "g", spawn_and_notify("xbacklight -dec 5", "Brightness ", get_brightness_cmd),
      {description = "Decrease brightness 5%", group = "brightness"}),
   awful.key({ altkey, ctrlkey }, "h", spawn_and_notify("xbacklight -inc 5", "Brightness ", get_brightness_cmd),
      {description = "Increase brightness 5%", group = "brightness"}),

   -- Volume min/max
   awful.key({ altkey, ctrlkey }, "v", spawn_and_notify(volume_cmd .. " -set 100", "Volume 100"),
      {description = "Set volume to max", group = "volume"}),
   awful.key({ altkey, ctrlkey }, "c", spawn_and_notify(volume_cmd .. " -mute", "Volume mute toggle"),
      {description = "Toggles mute", group = "volume"}),

   -- Volume 10%
   awful.key({ altkey, ctrlkey }, "z", spawn_and_notify(volume_cmd .. " -dec 10", "Volume ", volume_cmd .. " -get"),
      {description = "Decrease volume 10%", group = "volume"}),
   awful.key({ altkey, ctrlkey }, "x", spawn_and_notify(volume_cmd .. " -inc 10", "Volume ", volume_cmd .. " -get"),
      {description = "Increase volume 10%", group = "volume"}),

   -- Volume 5%
   awful.key({ altkey, ctrlkey }, "b", spawn_and_notify(volume_cmd .. " -dec 5", "Volume ", volume_cmd .. " -get"),
      {description = "Decrease volume 5%", group = "volume"}),
   awful.key({ altkey, ctrlkey }, "n", spawn_and_notify(volume_cmd .. " -inc 5", "Volume ", volume_cmd .. " -get"),
      {description = "Increase volume 5%", group = "volume"}),

   -- Other shortcuts
   awful.key({ altkey, ctrlkey }, "k", spawn_and_notify("killall java", "Killed XDM"),
      {description = "Increase volume 10%", group = "volume"}),   
   -- End Other shortcuts
   -- End finer controls
   
   -- Show/Hide Wibox
   awful.key({ modkey }, "g", function ()
	 for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
	       s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
	 end
   end,
      {description = "toggle wibox", group = "awesome"}),

   -- my_shortcuts ends }}

   awful.key({ modkey, ctrlkey }, "n",
      function ()
	 local c = awful.client.restore()
	 -- Focus restored client
	 if c then
            client.focus = c
            c:raise()
	 end
      end,
      {description = "restore minimized", group = "client"}),

   -- Menubar
   awful.key({ modkey }, "y", function() menubar.show() end,
      {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
   awful.key({ modkey, }, "f",
      function (c)
	 c.fullscreen = not c.fullscreen
	 c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),

   awful.key({ modkey, }, "c", function (c) c:kill() end,
      {description = "close", group = "client"}),

   awful.key({ modkey, "Shift" }, "c", function (c) awful.spawn("xkill") end,
      {description = "xkill", group = "client"}),

   awful.key({ modkey, ctrlkey }, "space", awful.client.floating.toggle,
      {description = "toggle floating", group = "client"}),

   awful.key({ modkey, }, ";", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),

   -- awful.key({ modkey,             }, "o",        function (c) c:move_to_screen()                 end,
   --             {description = "move to screen", group = "client"}),

   awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end,
      {description = "toggle keep on top", group = "client"}),

   awful.key({ modkey, }, "n",
      function (c)
	 -- The client currently has the input focus, so it cannot be
	 -- minimized, since minimized clients can't have the focus.
	 c.minimized = true
      end,
      {description = "minimize", group = "client"}),

   awful.key({ modkey, }, "m",
      function (c)
	 c.maximized = not c.maximized
	 c:raise()
      end,
      {description = "(un)maximize", group = "client"}),

   awful.key({ modkey, ctrlkey }, "m",
      function (c)
	 c.maximized_vertical = not c.maximized_vertical
	 c:raise()
      end,
      {description = "(un)maximize vertically", group = "client"}),

   awful.key({ modkey, "Shift" }, "m",
      function (c)
	 c.maximized_horizontal = not c.maximized_horizontal
	 c:raise()
      end,
      {description = "(un)maximize horizontally", group = "client"})
)


clientbuttons = gears.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise()
	 mymainmenu:hide() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ ctrlkey }, 1, awful.mouse.client.resize)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.

local np_map = { 87, 88, 89, 83, 84, 85, 79, 80, 81 }
for i = 1, 9 do
   globalkeys = gears.table.join(
      globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. np_map[i],
	 function ()
	    local screen = awful.screen.focused()
	    local tag = screen.tags[i]
	    if tag then
	       tag:view_only()
	    end
	 end,
	 {description = "view tag #"..i, group = "tag"}),

      -- Toggle tag display.
      awful.key({ modkey, altkey }, "#" .. np_map[i],
	 function ()
	    local screen = awful.screen.focused()
	    if client.focus then
	       local tag = client.focus.screen.tags[i]
	       if tag then
		  client.focus:move_to_tag(tag)
	       end
	    end
	    local tag = screen.tags[i]
	    if tag then
	       tag:view_only()
	    end
	 end,
	 {description = "toggle tag #" .. i, group = "tag"}),

      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. np_map[i],
	 function ()
	    if client.focus then
	       local tag = client.focus.screen.tags[i]
	       if tag then
		  client.focus:move_to_tag(tag)
	       end
	    end
	 end,
	 {description = "move focused client to tag #"..i, group = "tag"}),

      -- This should map on the top row of your keyboard, usually 1 to 9.
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9,
	 function ()
	    local screen = awful.screen.focused()
	    local tag = screen.tags[i]
	    if tag then
	       tag:view_only()
	    end
	 end,
	 {description = "view tag #"..i, group = "tag"}),

      -- Toggle tag display.
      awful.key({ modkey, altkey }, "#" .. i + 9,
	 function ()
	    local screen = awful.screen.focused()
	    if client.focus then
	       local tag = client.focus.screen.tags[i]
	       if tag then
		  client.focus:move_to_tag(tag)
	       end
	    end
	    local tag = screen.tags[i]
	    if tag then
	       tag:view_only()
	    end
	 end,
	 {description = "toggle tag #" .. i, group = "tag"}),

      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
	 function ()
	    if client.focus then
	       local tag = client.focus.screen.tags[i]
	       if tag then
		  client.focus:move_to_tag(tag)
	       end
	    end
	 end,
	 {description = "move focused client to tag #"..i, group = "tag"})
   )
end

return globalkeys
