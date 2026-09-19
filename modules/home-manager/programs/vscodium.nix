{ self, inputs, ...}: {
    flake.homeModules.vscodium = { pkgs, lib, ... }:
    {
        programs.vscodium = {
            enable = true;
            profiles.default.extensions = with pkgs.vscode-extensions; [
                dracula-theme.theme-dracula
                yzhang.markdown-all-in-one
                zainchen.json
                ms-python.python
                ms-python.debugpy
                ms-vscode.cpptools
                ms-vscode.cmake-tools
                ms-vscode-remote.remote-ssh
                james-yu.latex-workshop
            ];
        };
    };
}
