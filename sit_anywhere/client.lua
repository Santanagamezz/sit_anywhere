-- ================================================
-- SISTEMA DE SENTARSE - VERSIÓN LIMPIA
-- ================================================

local sitting = false
local chairObject = nil
local sittingPos = nil
local sittingHeading = nil

-- ================================================
-- CONFIGURACIÓN
-- ================================================
local CONFIG = {
    -- Ajusta esta altura si el personaje flota o se hunde
    -- IMPORTANTE: Valores negativos bajan al personaje DEBAJO del centro del prop
    -- Prueba: -0.2, -0.3, -0.4, -0.5 hasta que se vea bien
    heightOffset = -0.7,  -- Valor negativo = más abajo
    
    -- Props de sillas/bancos/sofás (LISTA COMPLETA)
    chairProps = {
        -- Sillas normales
        `prop_chair_01a`, `prop_chair_01b`, `prop_chair_02`, `prop_chair_03`, `prop_chair_04`,
        `prop_chair_05`, `prop_chair_06`, `prop_chair_07`, `prop_chair_08`, `prop_chair_09`,
        `prop_chair_10`, `prop_chairtable_chr_chair_08`,
        
        -- Sillas de oficina
        `prop_cs_office_chair`, `prop_off_chair_01`, `prop_off_chair_03`, `prop_off_chair_04`,
        `prop_off_chair_05`, `v_club_officechair`, `v_corp_offchair`, `v_ilev_chair02_ped`,
        `hei_prop_heist_off_chair`, `hei_prop_hei_skid_chair`,
        
        -- Bancos
        `prop_bench_01a`, `prop_bench_01b`, `prop_bench_01c`, `prop_bench_02`, `prop_bench_03`,
        `prop_bench_04`, `prop_bench_05`, `prop_bench_06`, `prop_bench_07`, `prop_bench_08`,
        `prop_bench_09`, `prop_bench_10`, `prop_bench_11`, `prop_fib_3b_bench`, `prop_ld_bench01`,
        `prop_wait_bench_01`, `hei_prop_heist_bench`,
        
        -- Sofás y sillones
        `prop_couch_01`, `prop_couch_02`, `prop_couch_03`, `prop_couch_04`, `prop_couch_05`,
        `prop_couch_lg_02`, `prop_couch_lg_03`, `prop_couch_lg_05`, `prop_couch_lg_06`,
        `prop_couch_lg_07`, `prop_couch_lg_08`, `v_res_tre_sofa_s`, `v_tre_sofa_mess_a_s`,
        `v_tre_sofa_mess_b_s`, `v_tre_sofa_mess_c_s`, `miss_ramp_couch_01`, `prop_rub_couch01`,
        `prop_rub_couch02`, `prop_rub_couch03`, `prop_rub_couch04`,
        
        -- Taburetes
        `prop_bar_stool_01`, `prop_barstool_01`, `prop_barstool_02`, `prop_barstool_03`,
        `prop_barstool_04`, `prop_barstool_05`, `hei_prop_hei_bar_stool_01`,
        
        -- Sillas especiales
        `v_ilev_leath_chr`, `prop_old_wood_chair`, `prop_table_03_chr`, `prop_table_04_chr`,
        `prop_table_05_chr`, `prop_table_06_chr`, `v_ret_gc_chair03`, `prop_sol_chair`,
        `prop_skid_chair_01`, `prop_skid_chair_02`, `prop_skid_chair_03`,
        
        -- Sillas de playa
        `prop_beach_lounge_01`, `prop_beach_lounge_02`, `prop_beach_lounge_03`,
        `prop_beach_lounge_04`, `prop_yacht_seat_01`, `prop_yacht_seat_02`, `prop_yacht_seat_03`,
        
        -- Sillas de jardín/patio
        `prop_patio_lounger1`, `prop_patio_lounger1_table`, `prop_picnic_table_01`, `prop_picnic_table_02`,
        
        -- Sillas de bar/restaurante
        `apa_mp_h_din_chair_04`, `apa_mp_h_din_chair_08`, `apa_mp_h_din_chair_09`,
        `apa_mp_h_din_chair_12`, `hei_heist_din_chair_01`, `hei_heist_din_chair_02`,
        `hei_heist_din_chair_03`, `hei_heist_din_chair_04`, `hei_heist_din_chair_05`,
        `hei_heist_din_chair_06`, `hei_heist_din_chair_08`, `hei_heist_din_chair_09`,
    }
}

-- ================================================
-- FUNCIÓN: SENTARSE
-- ================================================
local function Sit(chair)
    if sitting then return end
    
    local playerPed = PlayerPedId()
    
    -- Obtener posición y rotación de la silla
    local chairCoords = GetEntityCoords(chair)
    local chairHeading = GetEntityHeading(chair)
    
    -- Calcular posición donde sentarse
    sittingPos = vector3(chairCoords.x, chairCoords.y, chairCoords.z + CONFIG.heightOffset)
    sittingHeading = chairHeading + 180.0 -- Girar 180° para mirar al frente
    
    -- Guardar referencia
    chairObject = chair
    sitting = true
    
    -- Mover al jugador
    SetEntityCoords(playerPed, sittingPos.x, sittingPos.y, sittingPos.z)
    SetEntityHeading(playerPed, sittingHeading)
    
    -- Freeze para que no se mueva
    FreezeEntityPosition(playerPed, true)
    
    -- Esperar un poco
    Wait(100)
    
    -- Usar SCENARIO en lugar de animación (más estable)
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_SEAT_CHAIR", 0, true)
    
    -- Notificación
    lib.notify({
        description = 'Presiona X para levantarte',
        type = 'success'
    })
end

-- ================================================
-- FUNCIÓN: LEVANTARSE
-- ================================================
local function StandUp()
    if not sitting then return end
    
    local playerPed = PlayerPedId()
    
    -- Desfreezar
    FreezeEntityPosition(playerPed, false)
    
    -- Detener scenario/animación
    ClearPedTasks(playerPed)
    
    -- Resetear variables
    sitting = false
    chairObject = nil
    sittingPos = nil
    sittingHeading = nil
    
    -- Notificación
    lib.notify({
        description = 'Te levantaste',
        type = 'info'
    })
end

-- ================================================
-- THREAD PRINCIPAL
-- ================================================
CreateThread(function()
    while true do
        local sleep = 1000
        
        if sitting then
            sleep = 0
            
            -- Bloquear movimiento
            DisableControlAction(0, 32, true)  -- W
            DisableControlAction(0, 33, true)  -- S
            DisableControlAction(0, 34, true)  -- A
            DisableControlAction(0, 35, true)  -- D
            DisableControlAction(0, 21, true)  -- Sprint
            DisableControlAction(0, 22, true)  -- Jump
            
            -- Detectar tecla X para levantarse
            if IsDisabledControlJustPressed(0, 73) then
                StandUp()
            end
        end
        
        Wait(sleep)
    end
end)

-- ================================================
-- REGISTRAR OX_TARGET
-- ================================================
CreateThread(function()
    exports.ox_target:addModel(CONFIG.chairProps, {
        {
            name = 'sit_chair',
            icon = 'fas fa-chair',
            label = 'Sentarse',
            onSelect = function(data)
                Sit(data.entity)
            end,
            canInteract = function()
                return not sitting
            end
        }
    })
end)

-- ================================================
-- LIMPIEZA AL CERRAR
-- ================================================
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if sitting then
        StandUp()
    end
end)