{ pkgs, ...}:
{
  programs.hyprland = {
    enable = true;
  };

  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      grim
      grimblast
      slurp
      satty
      playerctl
      brightnessctl
    ];
    programs.wofi = {
      enable = true;
    };
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = { 
        mainBar = {
          position = "top";
          layer = "top";
          height = 5;
          margin-top = 0;
          margin-bottom = 0;
          margin-left = 0;
          margin-right = 0;
          modules-left = ["custom/launcher" "hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = ["cpu" "memory" "pulseaudio" "tray"];

          clock = {
            calendar = {
              format = {today = "<span color='#b4befe'><b>{}</b></span>";};
            };
            format = "  {:%a %d %b, %H:%M}";
          };

          "hyprland/workspaces" = {
            active-only = false;
            disable-scroll = true;
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "0";
              sort-by-number = true;
            };
          };

          memory = {
            format = "  {}%";
            format-alt = " {used} GB";
            interval = 2;
          };

          cpu = {
            format = "  {usage}%";
            format-alt = "  {avg_frequency} GHz";
            interval = 2;
          };

          tray = {
            icon-size = 20;
            spacing = 8;
          };

          pulseaudio = {
            format = "{icon}  {volume}%";
            format-muted = "󰖁 ";
            format-icons = {default = [" "];};
            scroll-step = 5;
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          };

          "custom/launcher" = {
            format = "";
            on-click = "pkill wofi || wofi --show drun -I";
            tooltip = "false";
          };
        };
      };
      style = ''
        * {
            border: none;
            border-radius: 0px;
            padding: 0;
            margin: 0;
            min-height: 0px;
            font-family: FiraCode Nerd Font;
            font-weight: bold;
            opacity: 0.98;
        }

        window#waybar {
            background: #1f1d2e;
        }

        #workspaces {
            font-size: 15px;
            padding-left: 15px;
        }
        #workspaces button {
            color: #cdd6f4;
            padding-left:  6px;
            padding-right: 6px;
        }
        #workspaces button.empty {
            color: #6c7086;
        }
        #workspaces button.active {
            color: #b4befe;
        }

        #tray, #pulseaudio, #network, #cpu, #memory, #disk, #clock {
            font-size: 15px;
            color: #cdd6f4;
        }

        #cpu {
            font-size: 15px;
            padding-left: 9px;
            padding-right: 9px;
            margin-left: 7px;
        }
        #memory {
            font-size: 15px;
            padding-left: 9px;
            padding-right: 9px;
        }

        #tray {
            padding: 0 16px;
            padding-right: 12px;
            margin-left: 7px;
        }

        #pulseaudio {
            font-size: 15px;
            padding-left: 15px;
            padding-right: 9px;
            margin-left: 7px;
        }
        #network {
            padding-left: 9px;
            padding-right: 15px;
        }

        #clock {
            padding-left: 9px;
            padding-right: 15px;
        }

        #custom-launcher {
            font-size: 18px;
            color: #b4befe;
            font-weight: bold;
            padding-left: 10px;
            padding-right: 12px;
        }
      '';
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/sayid/nixos/bg/Sakura Festival.jpg"
        ];
        wallpaper = [
          "HDMI-A-1, /home/sayid/nixos/bg/Sakura Festival.jpg"
        ];
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        "$mainMod" = "ALT";
        monitor = [
          "HDMI-A-1, 1920x1080@144, 0x0, 1"
        ];
        #env =  [
        #  
        #];
        
        input = {
          sensitivity = "-0.1";
          accel_profile = "flat";
          scroll_factor = "0.25";
          follow_mouse = "0";
        };

        cursor = {
          enable_hyprcursor = true;
          no_warps = true;
        };
        
        exec-once = [
          "hyprctl setcursor Bibata-Modern-Ice 24"
          "hyprctl waybar"
        ];

        general = {
          gaps_in = "4";
          gaps_out = "4";
          border_size = "2";
          "col.active_border" = "rgb(ebbcba)";
          layout = "dwindle";
        };

        decoration = {
          rounding = "4";

          drop_shadow = "false";
          # shadow_range = "4";
          # shadow_render_power = "3";
          # "col.shadow" = "rgba(1a1a1aee)";

          # dim_inactive = "true";

          blur = {
            enabled = "true";
            size = "8";
            passes = "3";
            popups = "true";
            # too goofy looking
            # noise = "0.05";
            # contrast = "2";
          };
        };

        animations = {
          enabled = true;
          bezier = [ "1, 0.23, 1, 0.32, 1" ];

          animation = [
            "windows, 1, 5, 1"
            "windowsIn, 1, 5, 1, slide"
            "windowsOut, 1, 5, 1, slide"
            "border, 1, 5, default"
            "borderangle, 1, 5, default"
            "fade, 1, 5, default"
            "workspaces, 1, 5, 1, slidefade 30%"
          ];
        };
          
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
        };
         
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
          
        gestures = {
          workspace_swipe = false;
        };
        bind = [
          "$mainMod, T, exec, kitty"
          "$mainMod, Q, killactive" 
          "$mainMod, R, exit"
          "$mainMod, V, togglefloating" 
          "$mainMod, SPACE, exec, pkill wofi || wofi --show drun -I;"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, Y, togglesplit, # dwindle"
          "$mainMod, M, fullscreen, 1"
          "$mainMod SHIFT, M, fullscreen"

           # Move focus
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          # Move window
          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, L, movewindow, r"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, J, movewindow, d"

          # Resize window
          "$mainMod CTRL, H, resizeactive, -50 0"
          "$mainMod CTRL, L, resizeactive, 50 0"
          "$mainMod CTRL, K, resizeactive, 0 50"
          "$mainMod CTRL, J, resizeactive, 0 -50"

          # Switch workspaces with mainMod + [0-9]
          "SUPER, H, workspace, e-1"
          "SUPER, L, workspace, e+1"
          "SUPER, N, workspace, +1"
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "SUPER SHIFT, H, movetoworkspace, -1"
          "SUPER SHIFT, L, movetoworkspace, +1"
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"

          # Screenshot bind
          ", PRINT, exec, grimblast copysave screen"
          "CTRL, PRINT, exec, grimblast copysave area"
          "ALT, PRINT, exec, grimblast save area - | satty -f -"
          "SHIFT, PRINT, exec, grimblast copysave active"
        ];
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        binde = [
          # pipewire volume control
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          # brightness control
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ];
        windowrulev2 = [
          "tile,class:^(kitty)$"
          "noanim, class:^(wofi)$"
        ];
        layerrule = [
          "noanim,  wofi"
        ];
      };
    };
  };
}
