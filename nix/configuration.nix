{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "br";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth = {
	  enable = true;
	  powerOnBoot = true;
  };

  # Enable sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Audio fix
  hardware.enableAllFirmware = true;
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.antonio = {
    isNormalUser = true;
    description = "Antonio Drumond";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs = {
		# Firefox
    firefox.enable = true;

		# Steam
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
		};

		# Starship
		starship = {
			enable = true;
			settings = {
				add_newline = true;
				# "$schema" = "https://starship.rs/config-schema.json";
				character = {
					success_symbol = "[❯](bold green)";
					error_symbol = "[❯](bold bright green)";
				};
				nix_shell = {
          symbol = " ";
          heuristic = false;
        };
				username = {
					show_always = true;
					style_user = "green bold";
					style_root = "bright-red bold";
				};
				os.disabled = false;
				# palette = "catppuccin_${"mocha"}";
			};
		};

		/*
		# Eza (Exa) ((Better ls))
		eza = {
			enable = true;
			enableZshIntegration = true;
		};
		*/

	};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

	#CLI -> Essential
	vim
	git
	wezterm
	fzf
	zip
	neovim

	#CLI -> Pretty and shiny :D
	bat
	tree
	eza # -> better to do in programs. but couldnt yet
	neofetch

	# zsh
	zsh
	zsh-bd
	zsh-nix-shell
	fzf-zsh

	#Image stuff
	cinnamon.pix
	darktable
	krita

	#Nonfree entertainment
	stremio
	discord
	spotify

	#Hardware/Libs
	ventoy-full
	gparted
	fan2go

	#Other
	obsidian
	kdePackages.kcalc
	cava
  ];

  environment.localBinInPath = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
