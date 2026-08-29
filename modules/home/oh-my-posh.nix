{ ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      version = 3;
      final_space = true;
      console_title_template = "{{ .Folder }}";

      palette = {
        blue = "#91A7E6";
        green = "#A4C38A";
        pink = "#BE9CDB";
        purple = "#313445";
        red = "#CE8282";
        yellow = "#DCC595";
      };

      secondary_prompt = {
        template = "❯❯ ";
        foreground = "p:pink";
        background = "transparent";
      };

      transient_prompt = {
        template = "❯ ";
        background = "transparent";
        foreground_templates = [
          "{{if gt .Code 0}}p:red{{end}}"
          "{{if eq .Code 0}}p:pink{{end}}"
        ];
      };

      upgrade = {
        source = "cdn";
        interval = "168h";
        auto = false;
        notice = false;
      };

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          segments = [
            {
              type = "path";
              style = "plain";
              foreground = "p:blue";
              background = "transparent";
              template = "{{ .Path }}";
              options = {
                style = "full";
              };
            }
            {
              type = "git";
              style = "plain";
              foreground = "p:grey";
              background = "transparent";
              template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}\u21e3{{ end }}{{ if gt .Ahead 0 }}\u21e1{{ end }}</>";
              options = {
                branch_icon = "";
                commit_icon = "@";
                fetch_status = true;
              };
            }
          ];
          newline = true;
        }
        {
          type = "rprompt";
          overflow = "hidden";
          segments = [
            {
              type = "executiontime";
              style = "plain";
              foreground = "p:yellow";
              background = "transparent";
              template = "{{ .FormattedMs }}";
              options = {
                threshold = 5000;
              };
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          segments = [
            {
              type = "text";
              style = "plain";
              background = "transparent";
              template = "❯";
              foreground_templates = [
                "{{if gt .Code 0}}p:red{{end}}"
                "{{if eq .Code 0}}p:pink{{end}}"
              ];
            }
          ];
          newline = true;
        }
      ];
    };
  };
}
