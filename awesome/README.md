# my config for awesome window manager

## Features
Minimal - no fancy effects, widgets  
Modular - Different files for keybindings, rules, rc.lua  
Rofi Scripts for some Useful tasks - control Volume, Brightness, Wifi, Emoji, BrowserMenu, Lollypop music  

## Operandi theme
![operandi](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/operandi.png)

## Vivendi theme
Work In progess
![vivendi](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/vivendi.png)

## Moonlight theme
![moonlight](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/moonlight.png)

## Aqua theme
![aqua](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/aqua.png)

## Pastel theme
![pastel](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/pastel1.png)
![pastel](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/pastel2.png)

## Warm theme
![warm](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/warm1.png)
![warm](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/warm2.png)

## One-dark theme
![onedark](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/onedark1.png)
![onedark](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/onedark2.png)

## Gruv theme
![gruv](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/gruv1.png)
![gruv](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/gruv2.png)

## Boxes theme
![boxes](https://github.com/anhsirk0/awesome-config/blob/master/screenshots/boxes2.png)

## change-theme.pl
use `change-theme.pl` to change the themes (fzf optionally required)
```bash
$ ~/.config/awesome/change-theme.pl 
```
> This will use fzf to select a theme (from ~/.config/awesome/themes) interactively (fzf)
```bash
$ ~/.config/awesome/change-theme.pl viv
'vivendi' theme selected
```
> This will change theme to the first theme that has viv in its name
```bash
$ ~/.config/awesome/change-theme.pl gruv
'gruv' theme selected
```
> This will change theme to the first theme that has gruv in its name, like gruvbox

## Some defaults info
Default font - [Iosevka Comfy](https://gitlab.com/protesilaos/iosevka-comfy)  
Rofi Scripts are located in ```~/.config/awesome/```.  
> if you have your Rofi Scripts in ```~/.config/rofi```, you can just change the ```rofi_dir```(myshortcuts.lua) variable to appropriate location  

Newer themes are for resolution 1920x1080 while some are for 1366x768, change the font size, gaps etc etc accordingly  
Matching themes are also avalable for Alacritty and Kakoune in my [alacritty-config](https://github.com/anhsirk0/alacritty-config) and [kakoune-themes](https://github.com/anhsirk0/kakoune-themes) repo respectively  
modified from awesome-copycats
