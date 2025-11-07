fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Santanagamez'
description 'Sistema simple y limpio para sentarse en sillas, bancos y sofás usando ox_lib'
version '1.0.0'

-- Este script es STANDALONE - No requiere ESX
-- Solo necesita ox_lib y ox_target

shared_script '@ox_lib/init.lua'

client_script 'client.lua'

dependencies {
    'ox_lib',
    'ox_target'
}

-- Información adicional
repository 'https://github.com/tuusuario/sit-anywhere' -- Cambia esto por tu repo
license 'MIT'

-- Configuración recomendada:
-- heightOffset = -0.7 (ajustable en client.lua línea 11)