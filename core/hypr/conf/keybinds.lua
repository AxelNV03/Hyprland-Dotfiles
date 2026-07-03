-- =====================================================================
-- HYPRLAND CORE - LUA KEYBINDS (SOLID ARCHITECTURE)
-- =====================================================================

local mainMod = "SUPER"
local closeWindowBind = hl.bind(mainMod .. " + Backspace", hl.dsp.window.close())   -- Cerrar Ventana
-- ---------------------------------------------------------------------
-- Atajos Básicos de Aplicaciones y Ventanas
-- ---------------------------------------------------------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))          -- Abrir terminal
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))    -- Abrir FileManager
hl.bind(mainMod .. " + T",         hl.dsp.window.float({ action = "toggle" })) -- Ventana Flotante
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd(menu))           -- Menu de Apps
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser))        -- Navegador
hl.bind(mainMod .. " + C",         hl.dsp.exec_cmd(ide))            -- IDE
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(novelas))        -- Novelas Visuales


-- Pin a una ventana. La ventana no se mueve sin importar el WorkSpace
hl.bind(mainMod .. " + P", hl.dsp.window.pin())                     


-- Fullscreen de la app dentro de la Ventana
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ 
    internal = 0,
    client = 2,
    action = "toggle" 
}))

-- Fullscreen de la Ventana
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))


-- Cambio de ventana manteniendo el estado del cliente y de la ventana
hl.bind(mainMod .. " + Tab", function()
  local win = hl.get_active_window()
  local internalState = win ~= nil and win.fullscreen or 0
  local clientState = win ~= nil and win.fullscreenClient or 0
  hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
  hl.dispatch(hl.dsp.window.fullscreen_state({
    internal = internalState,
    client = clientState,
    action = "set"
  }))
end)


-- Togglesplit
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Movimiento entre ventana
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Controles de Multimedia
hl.bind(mainMod .. " + ALT + left",  hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.exec_cmd("playerctl play-pause"))

-- Screenshots



-- Mover de WorkSpaces
hl.bind(mainMod .. " + code:112", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + code:117", hl.dsp.focus({ workspace = "e+1" }))

-- Mover entre WorkSpaces con Main + Rueda Mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Navegacion entre WorkSpaces y envio de ventanas
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- WorkSpace Special
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Redimensionar Ventana
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Laptop multimedia keys para volumen y brillo
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })