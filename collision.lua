function collision_rect(a, b)
    -- TABLE A AND B --
    local a_left = a.x
    local a_top = a.y
    local a_right = a.x + a.w - 1
    local a_bottom = a.y + a.h - 1

    local b_left = b.x
    local b_top = b.y
    local b_right = b.x + b.w - 1
    local b_bottom = b.y + b.h - 1

    if a_left > b_right then return false end
    if b_left > a_right then return false end
    if a_top > b_bottom then return false end
    if b_top > a_bottom then return false end

    return true
end