{
  pkgs,
  config,
  lib,
  ...
}: let
  ext = config.dev.shell.extras;
  condEnable = lib.attrsets.optionalAttrs;
in {
  imports = [];

  options.dev.shell.extras = {
    enable = lib.mkEnableOption "extras";

    use-eza = lib.mkEnableOption "eza";
  };

  config = lib.mkIf config.dev.shell.extras.enable {
    home.packages = with pkgs; [
      devenv
      handlr-regex # xdg-open but cool

      (writeShellApplication {
        name = "mvn-test";
        runtimeInputs = [ripgrep skim maven];

        text =
          # bash
          ''
            MAIN_TEST_FILES=$(rg --files -g '*Test.java' src/test/java)

            if [ -z "$MAIN_TEST_FILES" ]; then
                echo "Error: No test classes found (e.g., *Test.java) in src/test/java." >&2
                exit 1
            fi

            FQCN_LIST=$(echo "$MAIN_TEST_FILES" | sed 's|^src/test/java/||' | sed 's|/|.|g' | sed 's|\.java$||')

            CLASS_COUNT=$(echo "$FQCN_LIST" | wc -l)

            if [ "$CLASS_COUNT" -eq 1 ]; then
                SELECTED_CLASS="$FQCN_LIST"
            else
                SELECTED_CLASS=$(echo "$FQCN_LIST" | sk)

                if [ -z "$SELECTED_CLASS" ]; then
                    exit 0
                fi
            fi

            mvn test -Dtest="$SELECTED_CLASS" -DtrimStackTrace=true "$@"
          '';
      })

      (writeShellApplication {
        name = "mvn-run";
        runtimeInputs = [ripgrep skim maven];

        text =
          # bash
          ''
            MAIN_FILES=$(rg -l -g '*.java' 'public static void main' src/main/java)

            if [ -z "$MAIN_FILES" ]; then
                echo "Error: No classes found with 'public static void main(String[] args)' in src/main/java." >&2
                exit 1
            fi

            FQCN_LIST=$(echo "$MAIN_FILES" | sed 's|^src/main/java/||' | sed 's|/|.|g' | sed 's|\.java$||')

            CLASS_COUNT=$(echo "$FQCN_LIST" | wc -l)

            if [ "$CLASS_COUNT" -eq 1 ]; then
                SELECTED_CLASS="$FQCN_LIST"
            else
                SELECTED_CLASS=$(echo "$FQCN_LIST" | sk)

                if [ -z "$SELECTED_CLASS" ]; then
                    exit 0
                fi
            fi

            mvn compile exec:java -Dexec.mainClass="$SELECTED_CLASS" "$@"
          '';
      })

      (writeShellApplication {
        name = "mvn-new";
        runtimeInputs = [maven];

        text =
          # bash
          ''
            if [ -z "$1" ]; then
                echo "Usage: mvn-new <project-name>"
                return 1
            fi
            mvn archetype:generate \
                -DgroupId=org.example \
                -DartifactId="$1" \
                -DarchetypeArtifactId=maven-archetype-quickstart \
                -DinteractiveMode=false
          '';
      })
    ];

    programs.ripgrep.enable = true;
    programs.ripgrep-all.enable = true;
    programs.fd.enable = true;
    programs.jq.enable = true;
    programs.bat.enable = true;
    programs.bacon.enable = true;

    programs.delta.enable = true;
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          nerdFontsVersion = 3;
        };
        git = {
          pagers = [
            {
              pager = "delta --paging=never --line-numbers";
              colorArg = "always";
            }
          ];
        };
      };
    };

    stylix.targets.btop.enable = false;
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        vim_keys = true;
      };
    };

    programs.tealdeer = {
      enable = true;
      settings = {
        display.compact = true;
        updates.auto_update = true;
      };
    };

    programs.skim = {
      enable = true;
      defaultOptions = ["--color 16"];
    };

    programs.eza = condEnable ext.use-eza {
      enable = true;
      colors = "auto";
      icons = "auto";
      git = true;
    };
  };
}
