--! map.lua — tilemap for DotLua (inline, no require)
--
-- Usage:
--   --[[lib/map.lua]]         -- в main.dlua до init_game()
--   map.w = 20
--   map.h = 20
--   map.data = { ... }        -- 1-based, 0 = пусто
--   map.draw(celx, cely, sx, sy, celw, celh)
--
-- Поля:
--   map.w        — ширина карты в тайлах (по умолчанию 128)
--   map.h        — высота (по умолчанию 32)
--   map.data     — плоский массив, 1-based, 0 = пусто
--
-- Методы:
--   map.draw(celx, cely, sx, sy, celw, celh)
--       celx, cely  — тайл карты (0-based), с которого начать
--       sx, sy      — пиксель экрана, куда рисовать
--                     (обычно -cam_x % 8, -cam_y % 8)
--       celw, celh  — сколько тайлов рисовать (12 + запас)
--
--   map.mget(x, y)   — прочитать тайл (0-based). 0 = пусто.
--   map.mset(x, y, id) — записать тайл (0-based, 0 = пусто).
--
-- Конвенции:
--   - Тайлы 8×8 пикселей.
--   - map.data 1-based (Lua), 0 = пусто (пропускается).
--   - ID в map.data 1-based (как GID в Tiled).
--     Перед spr() вычитается 1 (DotLua спрайты 0-based).
--   - Спрайт 0 зарезервирован — не используйте в картах.
--   - Out-of-bounds: mget → 0, mset → no-op.

map = {
    w    = 128,
    h    = 32,
    data = {},
}

function map.draw(celx, cely, sx, sy, celw, celh)
    local _map_spr = rawget(_G, "_spr") or spr
    local data = map.data
    local mw   = map.w
    local mh   = map.h

    for row = 0, celh - 1 do
        for col = 0, celw - 1 do
            local mx = celx + col
            local my = cely + row

            if mx >= 0 and mx < mw and my >= 0 and my < mh then
                local tile = data[my * mw + mx + 1]
                if tile and tile ~= 0 then
                    spr(tile - 1, sx + col * 8, sy + row * 8)
                end
            end
        end
    end
end

function map.mget(x, y)
    if x < 0 or x >= map.w or y < 0 or y >= map.h then
        return 0
    end
    local tile = map.data[y * map.w + x + 1] or 0
    if tile == 0 then return 0 end
    return tile - 1
end

function map.mset(x, y, id)
    if x < 0 or x >= map.w or y < 0 or y >= map.h then
        return
    end
    if id < 0 then
        map.data[y * map.w + x + 1] = 0
    else
        map.data[y * map.w + x + 1] = id + 1
    end
end