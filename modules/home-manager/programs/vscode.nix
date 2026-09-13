{ self, inputs, ...}: {
    flake.homeModules.vscode = { pkgs, lib, ... }:
    {
        programs.vscode = {
            enable = true;
            profiles.default.extensions = with pkgs.vscode-extensions; [
                dracula-theme.theme-dracula
                vscodevim.vim
                yzhang.markdown-all-in-one
                zainchen.json
                ms-python.python
                ms-python.debugpy
                ms-vscode.cpptools
                ms-vscode.cmake-tools
                ms-vscode-remote.remote-ssh
            ];
        };
    };
}
