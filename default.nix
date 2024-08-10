{ config, pkgs, ... }:

let
  hm = config.home.homeDirectory;
in
{
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = pkgs.emacs29-pgtk;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  home.packages = with pkgs; [ cmake texliveFull ]; # may be good to add this to user instead perhaps?

  systemd.user.tmpfiles.rules = [
    # "d ${hm}/.emacs.d 0755 jalen users - -" # Create emacs directory.
    # link config files.
    "L+ ${hm}/.emacs.d/config.org - - - - ${hm}/Documents/dot/home/applications/dot-emacs/config.org"
    "L+ ${hm}/.emacs.d/init.el - - - - ${hm}/Documents/dot/home/applications/dot-emacs/init.el"
  ];
}
