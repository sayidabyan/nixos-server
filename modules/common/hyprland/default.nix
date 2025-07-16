{pkgs, ...}:
{
  imports = 
    [
      ./fuzzel.nix
    ];

  programs.hyprland = {
    enable = true;
  };

  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      blueman
      brightnessctl
      hyprnome
      hyprpicker
      hyprshot
      nwg-look
      playerctl
    ];
    
    #-----Hyprapps-----
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/sayid/nixos/bg/path less traveled.jpg"
        ];
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
        };
        background = [
          {
            path = "/home/sayid/nixos/bg/path less traveled.jpg";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        input-field = [
          {
            size = "250, 60";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color ="rgba(0, 0, 0, 0)";
            inner_color ="rgba(30, 30, 46, 0.5)";
            font_color = "rgb(200, 200, 200)";
            fade_on_empty = false;
            font_family = "Quicksand";
            placeholder_text = ''
            <span foreground="##ffffff99">Password</span>
            '';
            hide_input = false;
            halign = "center";
            valign = "center";
          }
        ];
        label = [
          {
            text = "$USER";
            color ="rgba(205, 214, 244, .75)";
            font_size = 30;
            font_family = "Quicksand";
            position = "0, 60";
            halign = "center";
            valign = "center";
          }
        ];

      };
    };

    programs.hyprpanel = {
        enable = true;
        systemd.enable = true;
        settings = {
          "bar.layouts" = {
            "*" = {
              left = ["dashboard" "windowtitle"];
              middle = ["workspaces"];
              right = ["volume" "network" "bluetooth" "systray" "clock" "notifications"];
            };
          };
          bar = {
            autoHide = "never";
            layer = "overlay";
            location = "top";
          };
          theme.bar = {
            background = "#000000";
            opacity = 60;
            scaling = 80;
            buttons.background_opacity = 0;
            buttons.monochrome = true;
            buttons.text = "#ffffff";
            buttons.icon = "#ffffff";
            menus.menu.bluetooth.scaling = 80;
            menus.menu.clock.scaling = 80;
            menus.menu.dashboard.scaling = 80;
            menus.menu.dashboard.confirmation_scaling = 80;
            menus.menu.media.scaling = 80;
            menus.monochrome = true;
            menus.menu.notifications.scaling = 80;
            menus.menu.volume.scaling = 80;
            menus.popover.scaling = 80;
            buttons.workspaces = {
              occupied = "#ffffff";
              active = "#ffffff";
              hover = "#ffffff";
            };
          };
          notifications.position = "overlay";
          theme.osd.scaling = 80;
          theme.tooltip.scaling = 80;
          theme.notification.scaling = 80;
          bar.launcher.autoDetectIcon = false;
          bar.launcher.icon = "󱄅 ";
          # bar.launcher.icon = "󰣇_󰣇";
          theme.bar.floating = false;
          bar.clock.format = "%a %b %d  %I:%M";
          bar.media.show_active_only = false;
          bar.notifications.show_total = true;
          menus.dashboard.controls.enabled = true;
          menus.dashboard.shortcuts.enabled = true;
          menus.dashboard.shortcuts.right.shortcut1.command = "gcolor3";
          menus.media.displayTime = true;
          bar.volume.rightClick = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          bar.volume.middleClick = "pavucontrol";
          bar.media.format = "{title}";
          # bar.workspaces.show_icons = true;
          bar.workspaces.show_numbered = false;
          bar.workspaces.ignored = "[-99]";
          theme.font.name = "Quicksand";
          theme.font.size = "1.1rem";
          bar.workspaces.monitorSpecific = true;
          bar.workspaces.workspaces = 3;
          menus.clock = {
            time = {
              hideSeconds = true;
            };
            weather.unit = "metric";
          };
          menus.dashboard.directories.enabled = false;
        };
      };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        env =  [
          "ELECTRON_OZONE_PLATFORM_HINT, wayland" 
        ];
        
        input = {
          scroll_factor = "1.5";
          follow_mouse = "1";
          touchpad = {
            natural_scroll = "1";
            scroll_factor = "0.1";
            tap-to-click = false;
            tap-and-drag = false;
            clickfinger_behavior = true;
            disable_while_typing = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_cancel_ratio = 0.8;
          workspace_swipe_min_speed_to_force = 3;
          workspace_swipe_distance = 1200;
          workspace_swipe_direction_lock = false;
        };

        cursor = {
          enable_hyprcursor = true;
          no_hardware_cursors = true;
        };
        
        exec-once = [
          "hyprctl setcursor Bibata-Modern-Ice 24"
        ];

        general = {
          gaps_in = "5";
          gaps_out = "5";
          border_size = "2";
          "col.active_border" = "rgb(ffffff)";
          layout = "dwindle";
        };

        decoration = {
          blur = {
            enabled = true;
            passes = "2";
            xray = true;
          };
          shadow = {
            enabled = false;
          };
        };

        animations = {
          enabled = true;
          bezier = [ "1, 0.23, 1, 0.32, 1" ];

          animation = [
            "windows, 1, 5, 1"
            "windowsIn, 1, 5, 1, slide"
            "windowsOut, 1, 5, 1, slide"
            "windowsMove, 1, 5, 1, slide"
            "border, 1, 5, default"
            "borderangle, 1, 5, default"
            "workspaces, 1, 5, 1, slide"
          ];
        };
          
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          new_window_takes_over_fullscreen = 1;
        };
         
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
          
        bind = [
          "$mainMod, T, exec, ghostty"
          "$mainMod, Q, killactive" 
          # "$mainMod, R, exit"
          "$mainMod, V, togglefloating" 
          "$mainMod, SPACE, exec, pkill fuzzel || fuzzel"
          "$mainMod SHIFT, SPACE, execr, pkill fuzzel || ~/nixos/modules/common/hyprland/fuzzel/fuzzel-calculator.sh"
          "$mainMod CTRL, SPACE, execr, pkill fuzzel || ~/nixos/modules/common/hyprland/fuzzel/fuzzel-powermenu.sh"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, Y, togglesplit, # dwindle"
          "$mainMod, M, fullscreen, 1"
          "$mainMod SHIFT, M, fullscreen"
          "$mainMod, TAB, cyclenext"
          "$mainMod, TAB, bringactivetotop"

           # Move focus
          "$mainMod2, H, movefocus, l"
          "$mainMod2, L, movefocus, r"
          "$mainMod2, K, movefocus, u"
          "$mainMod2, J, movefocus, d"

          # Move window
          "$mainMod2 SHIFT, H, movewindow, l"
          "$mainMod2 SHIFT, L, movewindow, r"
          "$mainMod2 SHIFT, K, movewindow, u"
          "$mainMod2 SHIFT, J, movewindow, d"

          # Resize window
          "$mainMod2 CTRL, H, resizeactive, -50 0"
          "$mainMod2 CTRL, L, resizeactive, 50 0"
          "$mainMod2 CTRL, K, resizeactive, 0 -50"
          "$mainMod2 CTRL, J, resizeactive, 0 50"

          # Switch workspaces with mainMod + H/L
          "$mainMod, H, exec, hyprnome -p -n"
          "$mainMod, L, exec, hyprnome"

          # Move active window to a workspace with mainMod + SHIFT + H/L
          "$mainMod SHIFT, H, exec, hyprnome -p -m -n"
          "$mainMod SHIFT, L, exec, hyprnome -m"

          # Special workspace
          # "$mainMod, K, togglespecialworkspace"
          # "$mainMod SHIFT, K, movetoworkspace, special"

          # Screenshot bind
          ", PRINT, exec, hyprshot --clipboard-only -s -m output"
          "$mainMod SHIFT, s, exec, hyprshot --clipboard-only -s -m region"
          "CTRL, PRINT, exec, hyprshot -m output -o ~/Pictures"
          "$mainMod CTRL, s, exec, hyprshot -m region -o ~/Pictures"

          # Lock screen
          "$mainMod2, Q, exec, killall hyprlock; hyprlock"
        ];
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        binde = [
          # pipewire volume control
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ --limit 1"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          # brightness control
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

          # keyboard backlit
          "$mainMod, XF86MonBrightnessUp, exec, brightnessctl -d kbd_backlight s +20"
          "$mainMod, XF86MonBrightnessDown, exec,  brightnessctl -d kbd_backlight s 20-"
        ];
        windowrulev2 = [
          # "float,class:^(steam)$"
          "float,class:^(nemo)$"
          "float,class:^(org.pulseaudio.pavucontrol)$"
          "float,class:^(.blueman-manager-wrapped)$"
          "fullscreen,class:^steam_app\d+$"
          "monitor 0,class:^steam_app_\d+$"
        ];
        layerrule = [
          "blur, bar-0"
          "blur, bar-1"
        ];
      };
    };
  };
}
