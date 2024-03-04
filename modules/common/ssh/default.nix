{...}:
{
    programs.ssh.askPassword = "";
    services.openssh = {
        enable = true;
        ports = [31475];
        settings = {
            PasswordAuthentication = false;
        };
    };
    users.users.sayid.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINqFi6txBF5FtkV10/LKMsxUK82PMbFpEYZJF2g7fYCP sayid@Sayids-MacBook-Pro.local"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO/PyHcXklsFeMvkESVHQfeO6NO3kDfoBF3wKkAjdgiH sayidabyan@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEDdTC2vkW+j8YOj9p/U7O9kTnpMVzPqCfKw/iHKrX6 sayid@nixos"
    ];
}
