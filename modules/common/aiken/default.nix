{inputs, ...}:
{
    home-manager.users.sayid = {...}: {
        home.packages = [
            inputs.aiken.packages.x86_64-linux.default
        ];
    };
}
