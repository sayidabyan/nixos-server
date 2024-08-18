{ pkgs, ...}:
{
  programs.hyprland = {
    enable = true;
  };

  services.blueman.enable = true;

  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      grim
      grimblast
      slurp
      satty
      playerctl
      brightnessctl
      unstable.nwg-look
      hyprnome
    ];
    services.blueman-applet.enable = true;
    services.network-manager-applet.enable = true;
    programs.wofi = {
      enable = true;
    };
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
        };
        background = [
          {
            path = "/home/sayid/nixos/bg/Sakura Festival.jpg";
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
            font_family = "FiraCode Nerd Font";
            placeholder_text = ''
            <i><span foreground="##ffffff99">Password</span></i>
            '';
            hide_input = false;
            halign = "center";
            valign = "center";
          }
        ];
        # Hour-Time
        label = [
          {
            text = "$USER";
            color ="rgba(205, 214, 244, .75)";
            font_size = 30;
            font_family = "FiraCode Nerd Font";
            position = "0, 40";
            halign = "center";
            valign = "center";
          }
        ];

      };
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
          modules-right = ["tray" "cpu" "memory" "pulseaudio"];

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
              active = "●";
              default = "○";
              special = "⦿";
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
            format = "{icon} {volume}%";
            format-muted = "󰖁 0%";
            format-icons = {default = [" "];};
            scroll-step = 2;
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
            background: #232136;
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
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        "$mainMod" = "ALT";
        #env =  [
        #  
        #];
        
        input = {
          sensitivity = "-0.1";
          accel_profile = "flat";
          scroll_factor = "0.5";
          follow_mouse = "0";
        };

        cursor = {
          enable_hyprcursor = true;
          no_warps = true;
        };
        
        exec-once = [
          "waybar"
          "hyprctl setcursor Bibata-Modern-Ice 24"
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
            popups = "false";
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
            "workspaces, 1, 5, 1, slide"
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
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, J, movefocus, d"

          # Move window
          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, L, movewindow, r"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, J, movewindow, d"

          # Resize window
          "SUPER CTRL, H, resizeactive, -50 0"
          "SUPER CTRL, L, resizeactive, 50 0"
          "SUPER CTRL, K, resizeactive, 0 -50"
          "SUPER CTRL, J, resizeactive, 0 50"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, H, exec, hyprnome -p -n"
          "$mainMod, L, exec, hyprnome"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, H, exec, hyprnome -p -m -n"
          "$mainMod SHIFT, L, exec, hyprnome -m"

          # Screenshot bind
          ", PRINT, exec, grimblast copysave screen"
          "CTRL, PRINT, exec, grimblast copysave area"
          "ALT, PRINT, exec, grimblast save area - | satty -f -"
          "SHIFT, PRINT, exec, grimblast copysave active"

          # Lock screen
          "SUPER, Q, exec, killall hyprlock; hyprlock "
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
