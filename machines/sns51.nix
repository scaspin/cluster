{ config, pkgs, ... }:

let
  utils = import ../utils.nix;
in {

  # Import common configurat for all machines (locale, SSHd, updates...)
  imports= [ ../common.nix ];

  networking.hostName = "sns51"; # Define your hostname.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
  ];

  programs.mosh.enable = true;

  virtualisation.docker.enable = true;

  users.users.alevy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = utils.githubSSHKeys "alevy";
  };
}
