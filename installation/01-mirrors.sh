#!/bin/bash
# =====================================================================
# MIRRORS - Agrega Mirrors de USA y de México
# =====================================================================

MIRROR_CMD="sudo reflector --country 'Mexico,United States' --protocol https --latest 30 --completion-percent 100 --sort rate --save /etc/pacman.d/mirrorlist"

execute_step "Optimizando mirrors (UNAM/USA)" "$MIRROR_CMD" "Mirrors-Update"
execute_step "Sincronizando repositorios" "sudo pacman -Syy" "Pacman-Update"