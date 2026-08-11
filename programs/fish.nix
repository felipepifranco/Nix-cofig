{ config, pkgs, lib, ... }:

{
  # 1. Adicione os pacotes que estavam faltando
  home.packages = with pkgs; [
    any-nix-shell # <-- Resolve o erro 'any-nix-shell'
    eza           # Usado pelo alias 'ls'
    bat           # Usado pelo alias 'cat'
    fd            # Usado pelo alias 'find'
    dust          # Usado pelo alias 'du'
    dua           # Usado pelo alias 'ncdu'
    ripgrep       # Usado pelo alias 'grep'
    xh            # Usado pelo alias 'http'
  ];

  # 2. Ative o Zellij via Home Manager (Resolve o erro 'zellij')
  programs.zellij = {
    enable = true;
  };

  # 1. Ferramentas CLI Integradas
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.skim = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # 2. Configuração Principal do Fish Shell
  programs.fish = {

    interactiveShellInit = ''
      # Ativa atalhos de navegação estilo Vi
      fish_vi_key_bindings

      # Desativa a mensagem de boas-vindas do Fish
      set -U fish_greeting

      # Integração com nix-shell clássico
      any-nix-shell fish --info-right | source

      # Remove logs poluídos do direnv
      set -gx DIRENV_LOG_FORMAT ""

      # Atalho Ctrl-F para busca de diretórios com FZF
      bind \cf fzf-cd-widget

      # Cores personalizadas para listagem de arquivos
      set -gx LS_COLORS "di=1;94:ln=1;36:so=1;35:pi=1;33:ex=1;97:bd=1;38;5;110:cd=1;38;5;110:su=1;31:sg=1;31:tw=1;34:ow=1;34:fi=38;5;67:*.md=38;5;67:*.c=1;36:*.rb=1;36:*.ele=1;36:*.el=1;36:*.ipynb=1;36:*.py=1;36:*.cpp=1;36:*.rs=1;36:*.lua=1;36:*.log=38;5;:*.str=92:"

      # Anexa automaticamente à sessão 'Grimoire' do Zellij ao abrir o terminal
      if status is-interactive
        if not set -q ZELLIJ; and test "$TERM" != "dumb"
          exec zellij attach -c Grimoire
        end
      end
    '';

    # 3. Aliases do Shell
    shellAliases = {
      rb = "nh os switch";
      btw = "echo uso o nixos, btw";
      config = "cd /etc/nixos";
    };

    # 4. Funções Personalizadas do Fish
    functions = {
      # Desativa alteração do título do terminal para não conflitar com o Zellij
      fish_title = "";

      # Função para criar estrutura de projetos de CTF/pentest
      summon = ''
        if test (count $argv) -lt 2
          echo "Usage: summon <phase> <directory-name>"
          echo "Phases: recon, web, exploit, payloads, blockchain"
          return 1
        end

        set -l phase $argv[1]
        set -l directory $argv[2]

        mkdir -p "$directory"
        set -l config_root "/etc/nixos"

        if test -f "$config_root/grimoire/schools/template/.envrc"
          sed \
            "s/{{PHASE}}/$phase/g" \
            "$config_root/grimoire/schools/template/.envrc" \
            > "$directory/.envrc"

          cd "$directory"
          direnv allow

          echo ">> Custom environment initiated in $directory for phase $phase"
        else
          echo "Template .envrc não encontrado em $config_root/grimoire/schools/template/.envrc"
        end
      '';
    };
  };

  # 5. Variáveis de Ambiente Globais
  home.sessionVariables = {
    GOPATH = "$HOME/go";
  };

  # 6. Adição de diretórios ao PATH do usuário
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];
}