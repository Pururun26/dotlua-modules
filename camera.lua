cam_x = 0
cam_y = 0

-- Сохраняем оригиналы --
_print = print
_rect  = rect
_oval  = oval
_line  = line
_pset  = pset
_spr   = spr

-- Установка камеры --
function camera(x, y)
    cam_x = x or 0
    cam_y = y or 0
end

-- Graphics --
function print(text, x, y, color)
    _print(text, x - cam_x, y - cam_y, color)
end

-- Примитивы --
function rect(x, y, w, h, color)
    _rect(x - cam_x, y - cam_y, w, h, color)
end

function oval(x, y, w, h, color)
    _oval(x - cam_x, y - cam_y, w, h, color)
end

function line(x0, y0, x1, y1, color)
    _line(x0 - cam_x, y0 - cam_y, x1 - cam_x, y1 - cam_y, color)
end

function pset(x, y, color)
    _pset(x - cam_x, y - cam_y, color)
end

-- Спрайт --
function spr(id, x, y)
    _spr(id, x - cam_x, y - cam_y)
end