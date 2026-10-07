{ config, pkgs, pwndbg, ... }:

{
  home.packages = with pkgs; [
    # --- Engenharia Reversa & Exploração ---
    pwndbg.packages.${pkgs.system}.default  # conferir
    nmap
    file
    (python3.withPackages (ps: [ ps.pwntools ps.pytest ]))
    ltrace

    docker
    proton-vpn
    vlc

    # --- Aqui você pode ir adicionando outras ferramentas no futuro ---
    # burpsuite   # Análise de vulnerabilidades Web
    # wireshark   # Análise de tráfego de rede
    # metasploit  # Framework clássico de exploração
    # hashcat     # Quebra de hashes
  ]; 
}