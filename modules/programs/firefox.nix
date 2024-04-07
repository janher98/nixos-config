{ config, pkgs, vars, ... }:

  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      languagePacks = [ "en-US" "de" ];
      
      /* ---- POLICIES ---- */
      # Check about:policies#documentation for options.
      policies = {
        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        #BlockAboutAddons = true;
        DisablePrivateBrowsing = true;
        DisablePocket = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"

        Homepage = {
          Locked = true;
          StartPage = "previous-session";
        };
        SearchEngines = {
          Default = "duckduckgo";
          Remove = "bing";
        };

        /* ---- EXTENSIONS ---- */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          # Catppuccin latte Lavender
          "{bc6fdbef-4c18-4967-9899-7803fdcaf3b4}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3990313/catppuccin_latte_lavender_git-2.0.xpi";
            installation_mode = "force_installed";
          };
          # Catppuccin latte Mauve
          "{c827c446-3d00-4160-a992-3ebcbe6d81a6}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3990326/catppuccin_latte_mauve_git-2.0.xpi";
            installation_mode = "force_installed";
          };
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Privacy Badger:
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          # AdBlocker for Youtube
          "jid1-q4sG8pYhq8KGHs@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/adblock-for-youtube/latest.xpi";
            installation_mode = "force_installed";
          };
          # DFYoutube
          "dfyoutube@example.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/df-youtube/latest.xpi";
            installation_mode = "force_installed";
          };
          # Disconnect 
          "2.0@disconnect.me" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/disconnect/latest.xpi";
            installation_mode = "force_installed";
          };
          # 
          "jid1-ZAdIEUB7XOzOJw@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
            installation_mode = "force_installed";
          };
          # Freedom
          "{37cf1a46-0300-4893-a483-248807035bbf}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/freedom-website-blocker/latest.xpi";
            installation_mode = "force_installed";
          };
          # Hide YT Shorts
          "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/hide-youtube-shorts/latest.xpi";
            installation_mode = "force_installed";
          };
          # i dont caare about cookies
          "jid1-KKzOGWgsW3Ao4Q@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi";
            installation_mode = "force_installed";
          };
          # Leechblock
          "leechblockng@proginosko.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/leechblock-ng/latest.xpi";
            installation_mode = "force_installed";
          };
          # Markdown Viewer
          "markdown-viewer@outofindex.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/markdown-viewer-chrome/latest.xpi";
            installation_mode = "force_installed";
          };
          # SingleFile
          "{531906d3-e22f-4a6c-a102-8057b88a1a63}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4249603/single_file-1.22.45.xpi";
            installation_mode = "force_installed";
          };
          # SponsorBlock
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };
        };
  
        /* ---- PREFERENCES ---- */
        # Check about:config for options.
        Preferences = { 
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          #"browser.search.suggest.enabled" = lock-false;
          #"browser.search.suggest.enabled.private" = lock-false;
          #"browser.urlbar.suggest.searches" = lock-false;
          #"browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          #"browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          #"browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          #"browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        };
      };
    };
  };
  home-manager.users.${vars.user}.home.file = {
    ".local/share/mime/packages/text-markdown.xml" = {
      text = ''
        <?xml version="1.0"?>
          <mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
            <mime-type type="text/plain">
              <glob pattern="*.md"/>
              <glob pattern="*.mkd"/>
              <glob pattern="*.mkdn"/>
              <glob pattern="*.mdwn"/>
              <glob pattern="*.mdown"/>
              <glob pattern="*.markdown"/>
            </mime-type>
          </mime-info>
      '';
    };
  };
}
