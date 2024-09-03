import os
import re
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile import layout, bar, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.widget import Spacer
from colors import CATPPUCCIN, MONOKAIPRO
import arcobattery
import traverse
# from functions import toggle_program, toggle_widgetbox, show_text, toggle_conky
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

#mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')
terminal = "kitty"

keys = [

    Key([mod], "f", lazy.window.toggle_fullscreen()),

    Key([mod, "shift"], "c", lazy.window.kill()),
    Key(["mod1", "shift"], "r", lazy.restart()),

    Key(["mod1", "shift"], "q", lazy.window.kill()),

    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),

    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    # Key([mod], "k", lazy.layout.up()),
    # Key([mod], "j", lazy.layout.down()),
    # Key([mod], "h", lazy.layout.left()),
    # Key([mod], "l", lazy.layout.right()),
    Key([mod], "k", lazy.function(traverse.up)),
    Key([mod], "j", lazy.function(traverse.down)),
    Key([mod], "h", lazy.function(traverse.left)),
    Key([mod], "l", lazy.function(traverse.right)),

    Key([mod], "m", lazy.next_screen()),
    Key([mod], "period", lazy.prev_screen()),

    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

    Key([mod, "shift"], "f", lazy.layout.flip()),

    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),

    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    Key([mod, "shift"], "f", lazy.window.toggle_floating()),

    ]

def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)

def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)

keys.extend([
    Key([mod, "shift"], "m", lazy.function(window_to_next_screen, switch_screen=True)),
    Key([mod, "shift"], "period", lazy.function(window_to_previous_screen, switch_screen=True)),
])

groups = []


# FOR QWERTY KEYBOARDS
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",]
group_keys = {
  "1": "q",
  "2": "w",
  "3": "e",
  "4": "r",
  "5": "t",
  "6": "y",
  "7": "u",
  "8": "i",
  "9": "o",
  "0": "p",
}
# group_labels = ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "0",]
# group_labels = ["", "", "", "", "", "", "", "", "", "",]
group_labels = ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "0 ",]

group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall",]
#group_layouts = ["monadtall", "matrix", "monadtall", "bsp", "monadtall", "matrix", "monadtall", "bsp", "monadtall", "monadtall",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([
#CHANGE WORKSPACES
        Key([mod], group_keys[i.name], lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift" ], "Tab", lazy.screen.prev_group()),

# MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
        Key([mod, "shift"], group_keys[i.name], lazy.window.togroup(i.name)),
# MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name) , lazy.group[i.name].toscreen()),
    ])

def init_layout_theme():
    return {"margin": 10,
            "border_width": 2,
            # "border_focus": "#00FFFF",
            "border_focus": "#74C7EC",
            "border_normal": "#4c566a"
            }

layout_theme = init_layout_theme()

layouts = [
    #layout.MonadTall(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.MonadTall(**layout_theme),
    layout.Zoomy(
        columnwidth = 500,
        **layout_theme,
    ),
    # layout.MonadWide(**layout_theme),
    # layout.Slice(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Floating(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Max(**layout_theme)
]

groups.append(
    ScratchPad('scratchpad',
        [
            DropDown(
                'nvim',
                [terminal, '-e', 'nvim'],
                height = 0.7,
                # width = 0.7,
                # x = 0.15,
                y = 0.15,
                on_focus_lost_hide = False,
                opacity = 1,
                warp_pointer = True,
            ),
            DropDown(
                'ranger',
                [terminal, '-e', 'ranger'],
                height = 0.7,
                # width = 0.7,
                # x = 0.15,
                y = 0.15,
                on_focus_lost_hide = False,
                opacity = 1,
                warp_pointer = True,
            ),
            DropDown(
                'bitwarden',
                ['bitwarden-desktop'],
                height = 0.7,
                # width = 0.7,
                # x = 0.15,
                y = 0.15,
                on_focus_lost_hide = False,
                opacity = 1,
                warp_pointer = True,
            ),
            DropDown(
                'pavucontrol',
                ['pavucontrol'],
                height = 0.7,
                # width = 0.7,
                # x = 0.15,
                y = 0.15,
                on_focus_lost_hide = False,
                opacity = 1,
                warp_pointer = True,
            ),
            DropDown(
                'terminal',
                [terminal],
                height = 0.7,
                # width = 0.7,
                # x = 0.15,
                y = 0.15,
                on_focus_lost_hide = False,
                opacity = 1,
                warp_pointer = True,
            ),
        ],
        # position = 2,
        # single = True,
        # layout = layout.Floating(**layout_theme),
    ),
)
keys.extend([
    Key(["mod1", "shift"], "v", lazy.group['scratchpad'].dropdown_toggle('nvim')),
    # Key([mod], "r", lazy.group['scratchpad'].dropdown_toggle('ranger')),
    Key(["mod1", "shift"], "b", lazy.group['scratchpad'].dropdown_toggle('bitwarden')),
    # Key([mod], "p", lazy.group['scratchpad'].dropdown_toggle('pavucontrol')),
    Key(["mod1", "shift"], "t", lazy.group['scratchpad'].dropdown_toggle('terminal')),
])

#keys.extend([
#    Key([mod2], "1", lazy.group['scratchpad'].dropdown_toggle('nvim')),
#
#])

def get_keyboard_layout():
    layout_string = subprocess.check_output(['xkb-switch', 'print', '"%s"']).decode('utf-8').strip()
    return " \uf11c " + layout_string + " "

WIDGETBOX1_COLOR = "lavender"
# WIDGETBOX2_COLOR = 'peach'

BAR_BACKGROUND_COLOR = "background"
BAR_BORDER_BACKGROUND_COLOR = "border"
BAR_TEXT_COLOR = "foreground"
BAR_HEIGHT = 25
BAR_MARGIN = 10
BAR_BORDER_WIDTH = 5
# THEME = CATPPUCCIN
THEME = MONOKAIPRO

RECT_DECORATION_RADIUS = 8

#Theme name : ArcoLinux Default
def init_colors():
    return [["#2F343F", "#2F343F"], # color 0
            ["#2F343F", "#2F343F"], # color 1
            ["#c0c5ce", "#c0c5ce"], # color 2
            ["#fba922", "#fba922"], # color 3
            ["#3384d0", "#3384d0"], # color 4
            ["#f3f4f5", "#f3f4f5"], # color 5
            ["#cd1f3f", "#cd1f3f"], # color 6
            ["#62FF00", "#62FF00"], # color 7
            ["#6790eb", "#6790eb"], # color 8
            ["#a9a9a9", "#a9a9a9"]] # color 9


colors = init_colors()

def init_widgets_defaults():
    return dict(
        font="JetBrainsMono Nerd Font Mono Medium",
        # font="JetBrains Mono Medium",
        fontsize=18,
        padding=0,
        margin=0,
        foreground=THEME["black"],
    )

widget_defaults = init_widgets_defaults()

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    result_widgets_list = [

               widget.Spacer(length=5),

               widget.CurrentLayoutIcon(
                        scale=0.7,
                        use_mask=True,
                        foreground=[THEME[BAR_TEXT_COLOR]],
                        padding=8,
                        decorations=[
                            RectDecoration(
                                colour=THEME[BAR_BACKGROUND_COLOR],
                                radius=RECT_DECORATION_RADIUS,
                                filled=True,
                                group=True,
                            )
                        ],
                      ),

                widget.Spacer(length=5),
                widget.CurrentLayout(
                        padding=8,
                        decorations=[
                            RectDecoration(
                                colour=THEME['blue'],
                                radius=RECT_DECORATION_RADIUS,
                                filled=True,
                                group=True,
                            )
                        ]
                      ),

               widget.Spacer(length=10),
               widget.GroupBox(
                    hide_unused=True,
                    disable_drag=True,
                    toggle=False,
                    highlight_method="block",
                    borderwidth=4,
                    this_current_screen_border=THEME[
                        BAR_BACKGROUND_COLOR
                    ],  # block fill color
                    block_highlight_text_color=THEME["foreground"],  # block text color
                    active=THEME["black"],  # text color
                    urgent_alert_method="block",
                    urgent_border=THEME["lavender"],
                    urgent_text=THEME["black"],
                    spacing=4,
                    margin_x=6,
                    margin_y=3,  # push labels down
                    padding_x=4,
                    padding_y=1,
                    decorations=[
                        RectDecoration(
                            colour=THEME["lavender"],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            # group=True
                        )
                    ],
                ),

                widget.Spacer(length=10),

                widget.CheckUpdates(
                    distro="Arch_checkupdates",
                    display_format="\ueb9a {updates}",
                    no_update_string="\ueaa2 0",
                    colour_have_updates=THEME["maroon"],
                    colour_no_updates=THEME["green"],
                    update_interval=60,
                    execute="~/.config/qtile/scripts/check_updates.sh",
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=THEME[BAR_BACKGROUND_COLOR],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            # group=True
                        )
                    ],
                    name="updateswidget",
                ),
                widget.Spacer(),

                widget.Clock(
                    format="%A, %B %-d, %H:%M:%S",
                    padding=16,
                    decorations=[
                        RectDecoration(
                            colour=THEME["mauve"],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                        )
                    ],
                ),

                widget.Spacer(),

                widget.WidgetBox(
                    widgets=[
                        widget.Spacer(length=10),

                        widget.CPU(
                            format="\uf2db {load_percent:>2.0f}%",
                            update_interval=5,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=THEME["peach"],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                            # mouse_callbacks={"Button1": toggle_conky()},
                        ),

                        widget.Spacer(length=10),

                        widget.Memory(
                            measure_mem="G",
                            format="\uf1c0 {MemPercent:>2.0f}%",
                            update_interval=5,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=THEME["blue"],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                            # mouse_callbacks={"Button1": toggle_conky()},
                        ),

                        widget.Spacer(length=10),

                        widget.DF(
                            format="\uf7c9 {uf}/{s}{m}",
                            # foreground=COLORS[BAR_TEXT_COLOR],
                            visible_on_warn=False,
                            update_interval=60,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=THEME["yellow"],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                        ),
                    ],

                    close_button_location="left",
                    text_closed=" \uEBE2 ",
                    text_open=" \uEBE2 ",
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=THEME[WIDGETBOX1_COLOR],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            # group=True
                        )
                    ],
                    # mouse_callbacks={"Button1": toggle_widgetbox(1)},
                    name="widgetbox1",
                ),

                widget.Spacer(length=10, name="widgetbox_spacer"),

                # widget.WidgetBox(
                #     widgets = [
                #         widget.Spacer(length=10),

                #         # do not activate in Virtualbox - will break qtile
                #         widget.ThermalSensor(
                #             foreground=THEME["black"],
                #             fmt = '\uf2c9 {}',
                #             # foreground = colors[5],
                #             # foreground_alert = colors[6],
                #             # background = colors[1],
                #             metric = True,
                #             padding=8,
                #             decorations=[
                #                 RectDecoration(
                #                     colour=THEME["green"],
                #                     radius=RECT_DECORATION_RADIUS,
                #                     filled=True,
                #                     # group=True
                #                 )
                #             ],

                #             threshold = 80
                #       ),

                #         widget.Spacer(length=10),
                        # widget.Backlight(
                        #     backlight_name="intel_backlight",
                        #     format="\uf185 {percent:2.0%}",
                        #     font="FontAwesome",
                        #     padding=7,
                        #     decorations=[
                        #         RectDecoration(
                        #             colour=THEME["peach"],
                        #             radius=RECT_DECORATION_RADIUS,
                        #             filled=True,
                        #             # group=True
                        #         )
                        #     ],
                        # ),

                        # widget.Spacer(length=10),

                        widget.Volume(
                            font="FontAwesome",
                            get_volume_command=os.path.expanduser(
                                "~/.config/qtile/scripts/get-volume.sh"
                            ),
                            fmt="\uf028 {:>4}",
                            # mute_text="Mute",
                            # mouse_callbacks={"Button1": toggle_program("pavucontrol")},
                            padding=7,
                            foreground=THEME["black"],
                            decorations=[
                                RectDecoration(
                                    colour=THEME["blue"],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    group=True
                                )
                            ],
                        ),

                        # widget.Spacer(length=10),

                        # widget.Battery(
                        #     font="FontAwesome",
                        #     format=" {char} {percent:2.0%} ",
                        #     # format=" {char} {percent:100.0%} ",
                        #     # foreground=THEME[BAR_TEXT_COLOR],
                        #     discharge_char="\uf241",
                        #     charge_char="\uf241+",
                        #     full_char="\uf240",
                        #     unknown_char="\uf240",
                        #     update_interval=60,
                        #     show_short_text=False,
                        #     padding=0,
                        #     decorations=[
                        #         RectDecoration(
                        #             colour=THEME["green"],
                        #             radius=RECT_DECORATION_RADIUS,
                        #             filled=True,
                        #         )
                        #     ]
                        # ),
                    # ],
                #     close_button_location="left",
                #     start_opened = True,
                #     text_closed="\uEB94",
                #     text_open="\uEB94",
                #     # text_closed="",
                #     # text_open="",
                #     padding=15,
                #     decorations=[
                #         RectDecoration(
                #             colour=THEME[WIDGETBOX1_COLOR],
                #             radius=RECT_DECORATION_RADIUS,
                #             filled=True,
                #             # group=True
                #         )
                #     ],
                #     # mouse_callbacks={"Button1": toggle_widgetbox(2)},
                #     name="widgetbox2",
                # ),
                widget.Spacer(length=10),

               # Keyboard layout
               # https://bbs.archlinux.org/viewtopic.php?pid=1973570#p1973570
               widget.GenPollText(
                        font="FontAwesome",
                        func=get_keyboard_layout,
                        update_interval=0.5,
                        decorations=[
                            RectDecoration(
                                colour=THEME[WIDGETBOX1_COLOR],
                                radius=RECT_DECORATION_RADIUS,
                                filled=True,
                            )
                        ]
                      ),

                widget.Spacer(length=5),
                            ]
    return result_widgets_list

# TODO rewrite this shit with cycle
# Need to know how many screens do we have
def init_widgets_screen1():
    widgets = init_widgets_list()
    widgets.append(
        widget.Systray(
                    # background=THEME[BAR_BACKGROUND_COLOR],
                    background="#2D2A2EA0",

                    icon_size=25,
                    padding = 4
                ),
        )

    return widgets

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2

widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()


# TODO rewrite this shit with cycle
# Need to know how many screens do we have
def init_screens():
    return [
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen1(),
                # size=26,
                size=BAR_HEIGHT,
                margin=[BAR_MARGIN, BAR_MARGIN, 0, BAR_MARGIN],
                border_width=BAR_BORDER_WIDTH,
                border_color=THEME[BAR_BORDER_BACKGROUND_COLOR],
                background=THEME[BAR_BACKGROUND_COLOR],
                opacity=1.0,
                # opacity=0.8,
                name="topbar",
            )
        ),
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen2(),
                # size=26,
                size=BAR_HEIGHT,
                margin=[BAR_MARGIN, BAR_MARGIN, 0, BAR_MARGIN],
                border_width=BAR_BORDER_WIDTH,
                border_color=THEME[BAR_BORDER_BACKGROUND_COLOR],
                background=THEME[BAR_BACKGROUND_COLOR],
                opacity=1.0,
                name="secondary_topbar",
            )
        ),
        # Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26, opacity=0.8))
    ]
screens = init_screens()

# Mouse = [
#     Drag([mod], "Button1", lazy.window.set_position_floating(),
#          start=lazy.window.get_position()),
#     Drag([mod], "Button3", lazy.window.set_size_floating(),
#          start=lazy.window.get_size())
# ]

# dgroups_key_binder = None
# dgroups_app_rules = []

#########################################################
################ assgin apps to groups ##################
#########################################################
# @hook.subscribe.client_new
# def assign_app_group(client):
#     d = {}
#     #####################################################################################
#     ### Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient ###
#     #####################################################################################
#     d[group_names[0]] = ["Navigator", "Firefox", "Vivaldi-stable", "Vivaldi-snapshot", "Chromium", "Google-chrome", "Brave", "Brave-browser",
#               "navigator", "firefox", "vivaldi-stable", "vivaldi-snapshot", "chromium", "google-chrome", "brave", "brave-browser", ]
#     d[group_names[1]] = [ "Atom", "Subl", "Geany", "Brackets", "Code-oss", "Code", "TelegramDesktop", "Discord",
#                "atom", "subl", "geany", "brackets", "code-oss", "code", "telegramDesktop", "discord", ]
#     d[group_names[2]] = ["Inkscape", "Nomacs", "Ristretto", "Nitrogen", "Feh",
#               "inkscape", "nomacs", "ristretto", "nitrogen", "feh", ]
#     d[group_names[3]] = ["Gimp", "gimp" ]
#     d[group_names[4]] = ["Meld", "meld", "org.gnome.meld" "org.gnome.Meld" ]
#     d[group_names[5]] = ["Vlc","vlc", "Mpv", "mpv" ]
#     d[group_names[6]] = ["VirtualBox Manager", "VirtualBox Machine", "Vmplayer",
#               "virtualbox manager", "virtualbox machine", "vmplayer", ]
#     d[group_names[7]] = ["Thunar", "Nemo", "Caja", "Nautilus", "org.gnome.Nautilus", "Pcmanfm", "Pcmanfm-qt",
#               "thunar", "nemo", "caja", "nautilus", "org.gnome.nautilus", "pcmanfm", "pcmanfm-qt", ]
#     d[group_names[8]] = ["Evolution", "Geary", "Mail", "Thunderbird",
#               "evolution", "geary", "mail", "thunderbird" ]
#     d[group_names[9]] = ["Spotify", "Pragha", "Clementine", "Deadbeef", "Audacious",
#               "spotify", "pragha", "clementine", "deadbeef", "audacious" ]
#     ######################################################################################
#
# wm_class = client.window.get_wm_class()[0]
#
#     for i in range(len(d)):
#         if wm_class in list(d.values())[i]:
#             group = list(d.keys())[i]
#             client.togroup(group)
#             client.group.cmd_toscreen(toggle=False)

# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME

main = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])
    subprocess.Popen(['autorandr', '-c'])
    subprocess.Popen(['nitrogen', '--restore'])

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

floating_types = ["notification", "toolbar", "splash", "dialog"]
floating_layout_theme = layout_theme
floating_layout_theme["border_width"] = 1
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='Arcolinux-welcome-app.py'),
    Match(wm_class='Arcolinux-calamares-tool.py'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Arandr'),
    Match(wm_class='feh'),
    Match(wm_class='Galculator'),
    Match(wm_class='archlinux-logout'),
    Match(wm_class='xfce4-terminal'),

], **floating_layout_theme, fullscreen_border_width = 0)
auto_fullscreen = True

focus_on_window_activation = "focus" # or smart

wmname = "LG3D"
