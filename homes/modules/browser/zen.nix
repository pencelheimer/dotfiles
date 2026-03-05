{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  options.browser.zen = {
    enable = lib.mkEnableOption "zen-browser";

    profileName = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "Zen profile name";
    };
  };

  config = lib.mkIf config.browser.zen.enable {
    stylix.targets.zen-browser = {
      enable = true;
      profileNames = [config.browser.zen.profileName];
    };
    programs.zen-browser = {
      enable = true;
      suppressXdgMigrationWarning = true;

      nativeMessagingHosts = [pkgs.firefoxpwa];
      languagePacks = ["uk" "en-US"];

      # https://mozilla.github.io/policy-templates/
      policies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };

      profiles.default = {
        id = 0;
        name = config.browser.zen.profileName;
        isDefault = true;

        search = {
          force = true;
          default = "unduckified";
          engines = {
            "unduck" = {
              urls = [
                { template = "https://unduck.link"; params = [ { name = "q"; value = "{searchTerms}"; } ]; }
              ];
            };
            "unduckified" = {
              urls = [
                { template = "https://s.dunkirk.sh"; params = [ { name = "q"; value = "{searchTerms}"; } ]; }
              ];
              definedAliases = ["@udg"];
            };
          };
        };

        # https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          darkreader
          bitwarden
          sponsorblock
          istilldontcareaboutcookies
          simple-translate
        ];

        # http://kb.mozillazine.org/Category:Preferences
        settings = {
          # "browser.search.defaultenginename" = "unduckified";
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = false;
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
          "browser.sessionstore.enabled" = true;
          "browser.sessionstore.resume_from_crash" = true;
          "browser.sessionstore.resume_session_once" = true;
          "browser.tabs.drawInTitlebar" = true;
          "general.smoothScroll" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-vpx.enabled" = true;
          "browser.tabs.tabmanager.enabled" = false;
          "full-screen-api.ignore-widgets" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.addons" = false;
          "browser.urlbar.suggest.pocket" = false;
          "browser.urlbar.suggest.topsites" = false;

          # Zen settings
          "zen.view.experimental-no-window-controls" = true;
        };
      };
    };
  };
}
