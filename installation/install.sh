#!/bin/bash
# =====================================================================
# INSTALACIÓN AUTOMATIZADA - ARCH / DERIVADAS
# =====================================================================

# Sudo solo una vez
echo -e "${YELLOW}🔑 Solicitando privilegios administrativos...${NC}"
# El flag -v (validate) fuerza a pedir la contraseña y actualiza el timestamp de sudo
if ! sudo -v; then
    echo -e "${RED}❌ Error: No se pudieron obtener privilegios. Abortando.${NC}"
    exit 1
fi

# Mantener la sesión activa en segundo plano (opcional)
# Esto actualiza el timestamp cada minuto mientras el script corre
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_PID=$!
trap 'kill $SUDO_PID' EXIT

# 1. Ruta absoluta
BASE_DIR=$(cd "$(dirname "$0")" && pwd)
DOTFILES_DIR=$(cd "$BASE_DIR/../" && pwd)  # un nivel arriba de /installation/

# 2. Dar permisos de ejecución
chmod +x "$BASE_DIR/_rollback.sh"
chmod +x "$BASE_DIR"/*.sh

# 3. Importar el motor de Rollback
source "$BASE_DIR/_rollback.sh"
 
# 4. Funciones de utilidad
print_line() {
    echo -e "${YELLOW}==========================================${NC}"
}

print_section() {
    local title="$1"
    print_line
    echo -e "${BLUE}📂 $title${NC}"
    print_line
}

# 5. Banner inicial
print_line
echo -e "${GREEN}🚀 INICIANDO INSTALACIÓN DE HYPRLAND DOTFILES   ${NC}"
echo -e "${YELLOW}Directorio: $DOTFILES_DIR${NC}"
print_line

# 6. Ejecutar módulos en orden explícito (mejor que glob + grep)
print_section "Ejecutando módulos de instalación"

declare -a SCRIPTS=(
    # "$BASE_DIR/00-reflector.sh"
    # "$BASE_DIR/01-mirrors.sh"
    # "$BASE_DIR/02-packages.sh"
    # "$BASE_DIR/03-paru.sh"
    # "$BASE_DIR/04-start_services.sh"
    # "$BASE_DIR/05-battery.sh"  #Solo se ejecuta si es laptop
    "$BASE_DIR/06-core_config.sh"
)

for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        NOMBRE_MODULO=$(basename "$script")
        echo -e "${YELLOW}▶ Lanzando módulo: $NOMBRE_MODULO${NC}"
        
        # Exportar variables que los scripts puedan necesitar
        export BASE_DIR DOTFILES_DIR
        source "$script"
        
        print_line
    else
        echo -e "${RED}⚠️  Módulo no encontrado: $script${NC}"
    fi
done

# 7. Resumen final (leyendo el contador de errores correctamente)
print_section "Resumen de instalación"
ERROR_COUNT=$(cat "$ERROR_COUNT_FILE" 2>/dev/null || echo "0")
 
if [ "$ERROR_COUNT" -eq 0 ]; then
    echo -e "${GREEN}    ✨ ¡Proceso finalizado con éxito!${NC}"
    echo -e "${GREEN}    Todos los módulos se completaron correctamente.${NC}"
else
    echo -e "${RED}⚠️  Se detectaron $ERROR_COUNT errores durante la instalación.${NC}"
    echo -e "${YELLOW}    Revisa el log para más detalles:${NC}"
    echo -e "${YELLOW}    $LOG_FILE${NC}"
fi
 
# 8. Limpiar archivos temporales
rm -f "$ERROR_COUNT_FILE"
print_line
echo -e "${GREEN}   📋 Log guardado en: $LOG_FILE${NC}"
print_line
