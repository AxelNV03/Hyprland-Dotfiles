#!/usr/bin/env bash

# =====================================================================
#               INSTALACIÓN DE PAQUETES DE AUR Y AUR
# =====================================================================

# --- 1. Catálogo Limpio de Paquetes AUR ---
PARU_PKGS=(
    "losslesscut-bin"               # Editor de video sin pérdida (Ultra rápido, ideal para clips multimedia)
    "brave-origin-nightly-bin"      # Browser
)

echo -e "${BLUE}🛠️ Verificando instalador de AUR (Paru)...${NC}"

# 2. Compilación e Instalación Idempotente de Paru
if ! command -v paru &> /dev/null; then
    echo -e "${YELLOW}⏳ Paru no encontrado. Compilando desde origen...${NC}"
    
    if git clone https://aur.archlinux.org/paru.git /tmp/paru; then
        (
            cd /tmp/paru || exit
            makepkg -si --noconfirm
        )
        rm -rf /tmp/paru
    fi

    # Cláusula de escape si la compilación falla
    if ! command -v paru &> /dev/null; then
        echo -e "${RED}❌ Error crítico: No se pudo consolidar Paru. Abortando...${NC}"
        exit 1
    fi
else
    echo -e "✅ Gestor Paru: OK"
fi


# 3. Despliegue en bucle utilizando tus bloques de control
echo -e "${BLUE}📦 Iniciando instalación de paquetes AUR con Paru...${NC}"
for pkg in "${PARU_PKGS[@]}"; do
    execute_step "Instalando desde AUR: $pkg" \
                 "paru -S --needed --noconfirm $pkg" \
                 "$pkg"
done