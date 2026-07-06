#!/usr/bin/env bash
# =====================================================================
# INTERFAZ DE ENERGÍA UNIVERSAL (Agnóstica de Hardware)
# =====================================================================

echo -e "${BLUE}🚀 Configurando gestión de energía global ...${NC}"

# 1. Componentes Core de CPU (Válido para cualquier marca)
execute_step "Instalando power-profiles-daemon" \
             "sudo pacman -S --needed --noconfirm power-profiles-daemon" \
             "Install PPD"

execute_step "Activando servicio de perfiles de energía" \
             "sudo systemctl enable --now power-profiles-daemon" \
             "Enable PPD Service"

execute_step "Estableciendo perfil de energía balanceado" \
             "powerprofilesctl set balanced" \
             "PPD-Initial-Profile"

# 2. Orquestador Dinámico de Umbrales de Batería (Soporte Multi-Batería y Multi-Vendor)
BAT_FOUND=false

for bat_dir in /sys/class/power_supply/BAT*; do
    # Verificar si el directorio realmente existe (evitar fallos si no hay baterías)
    if [ -d "$bat_dir" ]; then
        BAT_NAME=$(basename "$bat_dir") # 🛠️ CORREGIDO: "bat_dir" en lugar de "bt_dir"
        BAT_CMD=""

        # Detectar el archivo compatible con el firmware del equipo
        if [ -f "$bat_dir/charge_control_limit_max" ]; then
            # ASUS nativo (Como tu TUF Gaming)
            BAT_CMD="echo 80 | sudo tee $bat_dir/charge_control_limit_max"
        elif [ -f "$bat_dir/charge_control_end_threshold" ]; then
            # Lenovo / ThinkPad moderno nativo del Kernel API
            BAT_CMD="echo 80 | sudo tee $bat_dir/charge_control_end_threshold"
        elif [ -f "$bat_dir/charge_stop_threshold_max" ]; then
            # Lenovo legado / Capas de compatibilidad antiguas
            BAT_CMD="echo 80 | sudo tee $bat_dir/charge_stop_threshold_max"
        elif [ -f "$bat_dir/fw_charge_threshold" ]; then
            # Huawei / Otras marcas
            BAT_CMD="echo 80 | sudo tee $bat_dir/fw_charge_threshold"
        fi

        # Si se encontró un método de control válido, se ejecuta el paso
        if [ -n "$BAT_CMD" ]; then
            BAT_FOUND=true
            execute_step "Configurando umbral al 80% para: $BAT_NAME" \
                         "$BAT_CMD" \
                         "Battery-$BAT_NAME-Threshold"
        fi
    fi
done

# Si después de escanear no se encontró soporte nativo de hardware
if [ "$BAT_FOUND" = false ]; then
    echo -e "${YELLOW}⚠️ No se detectaron baterías compatibles con umbral nativo en el kernel. Saltando...${NC}"
fi