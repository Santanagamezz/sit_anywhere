-- config.lua
Config = {}

-- AJUSTE DE ALTURA
-- Este es el único ajuste que necesitas hacer
-- Representa la altura sobre el prop (positivo = arriba, negativo = abajo)
Config.SitHeightOffset = 0.5  -- Empieza con 0.5 y ajusta según necesites

-- Lista de props donde se puede sentar
Config.SitModels = {
    -- Sillas
    `prop_chair_01a`, `prop_chair_01b`, `prop_chair_02`, `prop_chair_03`, `prop_chair_04`,
    `prop_chair_05`, `prop_chair_06`, `prop_chair_07`, `prop_chair_08`, `prop_chair_09`,
    `prop_chair_10`, `prop_cs_office_chair`, `prop_off_chair_01`, `prop_off_chair_03`,
    `prop_off_chair_04`, `prop_off_chair_05`, `v_club_officechair`, `v_corp_offchair`,
    `hei_prop_heist_off_chair`, `hei_prop_hei_skid_chair`,
    
    -- Bancos
    `prop_bench_01a`, `prop_bench_01b`, `prop_bench_01c`, `prop_bench_02`, `prop_bench_03`,
    `prop_bench_04`, `prop_bench_05`, `prop_bench_06`, `prop_bench_07`, `prop_bench_08`,
    `prop_bench_09`, `prop_bench_10`, `prop_bench_11`, `prop_fib_3b_bench`,
    `prop_ld_bench01`, `prop_wait_bench_01`,
    
    -- Sofás
    `prop_couch_01`, `prop_couch_02`, `prop_couch_03`, `prop_couch_04`, `prop_couch_lg_02`,
    `v_res_tre_sofa_s`, `miss_ramp_couch_01`, `prop_rub_couch01`, `prop_rub_couch02`,
    
    -- Taburetes
    `prop_bar_stool_01`, `prop_barstool_01`, `prop_barstool_02`, `prop_barstool_03`,
    `prop_barstool_04`, `prop_barstool_05`,
    
    -- Otros
    `v_ilev_leath_chr`, `prop_old_wood_chair`, `prop_sol_chair`,
}