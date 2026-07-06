#!/usr/bin/env bash
# =====================================================================
#       PAQUETES BASE INSTALACIÓN NUEVA
# =====================================================================

# --- [ 1. HERRAMIENTAS DEL SISTEMA Y RED ] ---
PKGS_SYSTEM=(
    "base-devel"                  # Grupo de herramientas para compilar software (GCC, Make, etc. - Vital para AUR)
    "git"                         # Control de versiones (Indispensable para clonar dotfiles y usar Paru)
    "curl"                        # Utilidad CLI para transferir datos con URLs (Utilizado en scripts)
    "wget"                        # Descargador de archivos web directo desde la línea de comandos
    "jq"                          # Procesador de JSON en terminal (Parsea datos de hyprctl, cliphist, etc.)
    "polkit"                      # Marco de control de privilegios base del sistema (Manejo de reglas de seguridad)
    "hyprpolkitagent"             # Agente de autenticación oficial en Wayland (Levanta el prompt para contraseñas sudo)
    "networkmanager"              # Demonio central que gestiona conexiones de red, Wi-Fi y cableadas
    "bluez"                       # Pila de protocolos de Bluetooth nativos de Linux (Carga los drivers de radio)
    "bluez-utils"                 # Herramientas de control por línea de comandos para Bluetooth (Incluye bluetoothctl)
    "dnsmasq"                     # Servidor ligero de DNS/DHCP para manejo rápido de redes locales
    "tree"                        # Visor en arbol de directorios y files
)

# --- [ 2. MOTORES DE COMPRESIÓN Y EXTRACCIÓN ] ---
PKGS_COMPRESSION=(
    "unrar"                       # Extractor oficial y propietario para archivos con formato .rar
    "p7zip"                       # Versión de comando de 7-Zip con alta tasa de compresión para .7z
    "unzip"                       # Utilidad clásica para listar y extraer archivos comprimidos en .zip
    "zip"                         # Herramienta nativa para empaquetar y comprimir archivos en .zip
    "lrzip"                       # Compresor de largo alcance optimizado para archivos masivos o respaldos grandes
    "lz4"                         # Algoritmo de compresión ultra-rápido enfocado en velocidad de descompresión en tiempo real
    "lzo"                         # Compresor enfocado en velocidad (Muy usado por el kernel y sistemas de archivos)
    "cpio"                        # Archivador clásico de Unix utilizado por instaladores y gestores de paquetes initramfs
    "the-unarchiver"              # Extractor universal inteligente que maneja nombres de archivos con codificaciones raras
)

# --- [ 3. ECOSISTEMA DE PANTALLA Y WAYLAND CORE ] ---
PKGS_WAYLAND=(
    "hyprland"                    # El compositor principal de ventanas dinámicas basado en Wayland (Tiling WM)
    "wayland"                     # El protocolo de servidor gráfico moderno que reemplaza a X11
    "xorg-xwayland"               # Capa de compatibilidad para ejecutar apps viejas de X11 de forma transparente en Wayland
    "qt5-wayland"                 # Módulo necesario para que las aplicaciones escritas en Qt5 corran nativamente en Wayland
    "qt6-wayland"                 # Módulo necesario para que las aplicaciones modernas en Qt6 corran nativamente en Wayland
    "xdg-utils"                   # Herramientas estándar del escritorio (Comandos como xdg-open para abrir URLs en tu browser)
    "xdg-user-dirs"               # Generador automático de las carpetas del Home (Descargas, Documentos, Música, etc.)
    "xdg-desktop-portal"          # Backend de comunicación agnóstico para permisos, pantallas compartidas y diálogos
    "xdg-desktop-portal-hyprland" # Portal específico de Hyprland indispensable para capturas de pantalla y compartir en Discord/Web
    "xdg-desktop-portal-gtk"      # Portal de respaldo de GTK requerido para que funcionen las ventanas de abrir/guardar archivo
    "libxkbcommon"                # Librería encargada de mapear, traducir y gestionar las distribuciones de teclado
    "rofi-wayland"                # Bifurcación nativa para Wayland de Rofi; usado como launcher de apps y menús interactivos
)

# --- [ 4. ENTORNO DE TRABAJO Y PRODUCTIVIDAD ] ---
# Aplicaciones del día a día, editores de código y utilidades de usuario.
PKGS_APPS=(
    "yazi"                        # Explorador de archivos CLI ultra-veloz escrito en Rust, controlado por Vim motions
    "nvim"                        # Neovim: El editor de texto extensible basado en teclado para desarrollo ágil
    "vscode"                      # Visual Studio Code: IDE secundario para proyectos extensos o debugging visual
    "greetd"                      # Demonio de inicio de sesión gráfico/consola agnóstico y seguro que corre en segundo plano
    "tuigreet"                    # Interfaz de texto avanzada (TUI) para greetd que permite loguearte de forma minimalista
    "cliphist"                    # Gestor de historial del portapapeles que almacena tanto texto plano como imágenes binarias
    "wl-clipboard"                # Utilidades de bajo nivel para Wayland (`wl-copy`/`wl-paste`) necesarias para clonar texto
    "wf-recorder"                 # Grabador de pantalla por línea de comandos optimizado para compositores basados en wlroots
    "matugen"                     # Generador de paletas de colores Material You que extrae los tonos de tu wallpaper en caliente
    "hyprshot"                    # Capturador de pantalla nativo para Hyprland que interactúa directamente con sus sockets
    "hyprsunset"                  # Herramienta oficial para aplicar filtros de temperatura de color (Luz azul para las noches)
    "vim"                         # Editor de texto clásico estándar para emergencias cuando la config de Neovim esté rota
    "bitwarden"                   # Gestor de contraseñas oficial en la nube para asegurar credenciales de desarrollo
    "obsidian"                    # Entorno de Markdown offline para base de conocimientos, notas de código y planeación
    # cursor-clip
)

# --- [ 5. ARQUITECTURA DE AUDIO PIPEWIRE ] ---
# Subsistema de sonido moderno con baja latencia y ruteo profesional.
PKGS_AUDIO=(
    "pipewire"                    # El motor de audio central de nueva generación que reemplaza a PulseAudio y JACK
    "pipewire-pulse"              # Servidor proxy que traduce llamadas de apps PulseAudio antiguas al servidor de PipeWire
    "pipewire-alsa"               # Capa de emulación para enrutar el software que busca drivers de bajo nivel de ALSA
    "wireplumber"                 # El cerebro de PipeWire; gestiona sesiones, políticas de dispositivos y suspensión automática
    "pwvucontrol"                 # Control de volumen avanzado escrito en GTK4 nativo para PipeWire (Reemplaza a pavucontrol)
    "easyeffects"                 # Procesador de efectos avanzado para ecualizar y limitar tus IEMs Hidizs MS3 y JBL Charge 6
    "qpwgraph"                    # Matriz de conexiones gráfica para cablear virtualmente apps a salidas de audio específicas
    "playerctl"                   # Utilidad CLI que intercepta y controla reproductores multimedia usando teclas de función (FN)
)

# --- [ 6. DAEMONS DE INTERFAZ, AUTOMATIZACIÓN Y ENERGÍA ] ---
# Servicios que orquestan el comportamiento físico de tu entorno.
PKGS_DESKTOP=(
    "kanshi"                      # Gestor dinámico que monitorea eventos de hotplug de pantallas (Tus perfiles del HDMI)
    "waybar"                      # Barra de estado altamente configurable basada en CSS y GTK (Usada previo al salto a AGS)
    "hyprpaper"                   # Utilidad oficial de Hyprland para inyectar fondos de pantalla en múltiples monitores
    "hyprlock"                    # Bloqueador de pantalla seguro con soporte para blur, shaders y diseño estético nativo
    "hypridle"                    # Demonio de gestión de inactividad (Atenúa el brillo y bloquea el sistema tras X minutos)
    "wlogout"                     # Menú visual a pantalla completa basado en CSS/JSON para gestionar apagado, reinicio y suspensión
    "brightnessctl"               # Utilidad de bajo nivel para ajustar por software la luz de fondo de la pantalla de tu laptop
)

# --- [ 7. TERMINAL, SHELL Y MONITOREO (ZSH STACK) ] ---
# Herramientas para optimizar la velocidad y la analítica dentro de tu terminal.
PKGS_TERMINAL=(
    "kitty"                       # Emulador de terminal acelerado por GPU que soporta renderizado de imágenes nativo
    "zsh"                         # El shell interactivo avanzado configurado para tus atajos de desarrollo
    "zsh-autosuggestions"         # Plugin que te sugiere comandos de forma inteligente basados en tu historial estilo Fish
    "zsh-syntax-highlighting"     # Resaltado de sintaxis en tiempo real para comandos válidos y rutas en tu terminal
    "zsh-history-substring-search"# Permite buscar comandos en tu historial escribiendo cualquier parte de una palabra previa
    "fastfetch"                   # Herramienta moderna en C para imprimir los specs del sistema de forma ultra-rápida al abrir Kitty
    "btop"                        # Monitor de procesos e hilos con interfaz gráfica en terminal (Muestra carga de CPU, RAM y red)
    "expac"                       # Extractor de datos para Pacman indispensable para que funcione tu alias 'rip' de apps recientes
    "fzf"                         # Buscador difuso (Fuzzy Finder) interactivo integrado con el historial para búsquedas rápidas
    "pkgfile"                     # Base de datos local que provee el servicio "Command Not Found" si erras un comando en Zsh
)

# --- [ 8. TIPOGRAFÍAS E IDENTIDAD VISUAL ] ---
# Fuentes del sistema para evitar carácteres rotos y renderizar iconos Nerd Fonts.
PKGS_FONTS=(
    "ttf-jetbrains-mono-nerd"     # La tipografía principal para Neovim y barras (Incluye todos los glifos de Nerd Fonts)
    "ttf-font-awesome"            # Iconos vectoriales complementarios legados que consumen barras externas antiguas
    "otf-font-awesome"            # Variación OpenType de la tipografía FontAwesome para compatibilidad extendida
    "noto-fonts-cjk"              # Soporte tipográfico para caracteres chinos, japoneses y coreanos (Evita los cuadros vacíos en web)
    "noto-fonts-emoji"            # Paquete oficial de Google para renderizar emojis de color en navegadores y apps de chat
    "ttf-dejavu"                  # Fuentes TrueType genéricas Sans, Serif y Mono usadas como estándar de respaldo en la web
    "ttf-liberation"              # Tipografías métricamente idénticas a las de Microsoft (Arial, Times New Roman) para docs
)

# --- [ 9. GESTOR MULTIMEDIA Y EXPLORADOR DE RESPALDO ] ---
# Capa visual para gestionar almacenamiento externo y reproducción multimedia ágil.
PKGS_MULTIMEDIA=(
    "thunar"                      # Explorador de archivos visual ligero de XFCE, usado para manejo manual de assets de código
    "tumbler"                     # Demonio externo encargado de renderizar miniaturas de imágenes para Thunar y Yazi
    "ffmpegthumbnailer"           # Generador de miniaturas liviano para archivos de video utilizando las librerías de ffmpeg
    "file-roller"                 # Interfaz gráfica para compresión y empaquetado; se integra al menú contextual de Thunar
    "gvfs"                        # Sistema de archivos virtual de GNOME encargado de la papelera y el automontaje de USBs
    "gvfs-mtp"                    # Extensión de gvfs necesaria para montar celulares y dispositivos Android mediante cable
    "mpv"                         # Reproductor de video nativo en Wayland sin bordes, ultra-ligero y controlado por teclado
)

# =====================================================================
#                 UNIFICACIÓN E INSTALACIÓN FINAL
# =====================================================================

# Fusionamos los arrays semánticos en un vector global e independiente para Bash
ALL_PACKAGES=(
    "${PKGS_SYSTEM[@]}"
    "${PKGS_COMPRESSION[@]}"
    "${PKGS_WAYLAND[@]}"
    "${PKGS_APPS[@]}"
    "${PKGS_AUDIO[@]}"
    "${PKGS_DESKTOP[@]}"
    "${PKGS_TERMINAL[@]}"
    "${PKGS_FONTS[@]}"
    "${PKGS_MULTIMEDIA[@]}"
)

echo "📦 Total de paquetes core indexados con éxito: ${#ALL_PACKAGES[@]}"

# Mandamos el array limpio a pacman de forma segura e idempotente
execute_step "Instalando Paquetes" \
             "sudo pacman -S --needed --noconfirm ${ALL_PACKAGES[*]}" \
             "Base-Packages"