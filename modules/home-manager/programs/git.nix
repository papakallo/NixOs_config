{
    flake.homeModules.git = { pkgs, lib, ... }: {
        programs.git = {
          enable = true;
          settings.user.name = "papakallo";
          settings.user.email = "paviveerar@gmail.com";
        };
    };
}
