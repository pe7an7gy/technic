local digits = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
local base_chars = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
    "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
}
local special_chars = {
    "!", "#", "$", "%", "&", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";",
    "<", "=", ">", "?", "@", "'", '"'
}
local german_chars = {"Ä", "Ö", "Ü", "ß"}
local cyrillic_chars = {
    "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н",
    "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь",
    "Э", "Ю", "Я"
}
local greek_chars = {
    "Α", "Β", "Γ", "Δ", "Ε", "Ζ", "Η", "Θ", "Ι", "Κ", "Λ", "Μ", "Ν", "Ξ", "Ο",
    "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω"
}
local additional_chars = {
    "猫","北","东","東","南","西","站",
}

local characters = {}
local characters_sticker = {}

local function table_merge(t1, t2)
    for k, v in ipairs(t2) do
       table.insert(t1, v)
    end
    return t1
end

local function is_multibyte(ch)
    local byte = ch:byte()
    -- return (195 == byte) or (208 == byte) or (209 == byte)
    if not byte then
       return false
    else
       return (byte > 191)
    end
end

table_merge(characters, base_chars)
table_merge(characters, digits)
table_merge(characters, special_chars)
table_merge(characters, german_chars)
table_merge(characters, cyrillic_chars)
table_merge(characters, greek_chars)
table_merge(characters, additional_chars)

table_merge(characters_sticker, characters)
table.insert(characters_sticker, " ")


-- generate all available blocks
for _, name in ipairs(characters) do
    local desc = "Ehlphabet Block '" .. name .. "'"
    local byte = name:byte()
    local mb = is_multibyte(name)
    local file, key

    if mb then
        mb = byte
        byte = name:byte(2)
        key = ":ehlphabet:" .. mb .. byte
        file = ("%03d_%03d"):format(mb, byte)
    else
        key = ":ehlphabet:" .. byte
        file = ("%03d"):format(byte)
    end

    minetest.register_node(
        key.."_sticker_color",
        {
            description = desc.." Colored Sticker",
            tiles = {"technic_paint.png^[colorize:#000000" },
            overlay_tiles = {"ehlphabet_" .. file .. ".png",
		      "ehlphabet_" .. file .. ".png^[transformR180" },
            palette = "technic_paint_palette.png",
	    inventory_image = "ehlphabet_" .. file .. ".png",
            paramtype = "light",
            paramtype2 = "colorwallmounted",
            drawtype = "nodebox",
            is_ground_content = false,   
            drop = key.."_sticker", 
  	    node_box = {
			type = "wallmounted",
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
			wall_top = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
			wall_side = {-0.5, -0.5, -0.5, -0.49, 0.5, 0.5},
                },
            groups = {attached_node = 1, dig_immediate = 2,  
                         not_in_creative_inventory = 1, 
			 not_blocking_trains = 1 },
        }
    )

    minetest.register_node(
        key.."_sticker_color_inv",
        {
            description = desc.." Colored Sticker",
            tiles = {{name = "technic_paint.png^[colorize:#ffffff", color = "white"}},
            overlay_tiles = {"ehlphabet_" .. file .. ".png",
		      "ehlphabet_" .. file .. ".png^[transformR180" },
            palette = "technic_paint_palette.png",
	    inventory_image = "ehlphabet_" .. file .. ".png",
            paramtype = "light",
            paramtype2 = "colorwallmounted",
            drawtype = "nodebox",
            is_ground_content = false,   
            drop = key.."_sticker", 
  	    node_box = {
			type = "wallmounted",
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
			wall_top = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
			wall_side = {-0.5, -0.5, -0.5, -0.49, 0.5, 0.5},
                },
            groups = {attached_node = 1, dig_immediate = 2,  
                         not_in_creative_inventory = 1, 
			 not_blocking_trains = 1 },
        }
    )


end



-- empty sticker

local key = ":ehlphabet:32"
local file = ("%03d"):format(32)
local desc = "Ehlphabet Block ' '"

minetest.register_node(
 key.."_sticker_color",
 {
    description = desc.." Colored Sticker",
    tiles = {"technic_paint.png^[colorize:#000000" },
    overlay_tiles = {"ehlphabet_000.png", 
    	      "ehlphabet_000.png^[transformR180" },
    palette = "technic_paint_palette.png",
    inventory_image = "ehlphabet_000.png",
    paramtype = "light",
    paramtype2 = "colorwallmounted",
    drawtype = "nodebox",
    is_ground_content = false,   
    drop = key,  -- new
    node_box = {
       type = "wallmounted",
       wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
       wall_top = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
       wall_side = {-0.5, -0.5, -0.5, -0.49, 0.5, 0.5},
    },
    groups = {attached_node = 1, dig_immediate = 2,  
       not_in_creative_inventory = 1, 
       not_blocking_trains = 1 },
 }
)

minetest.register_node(
 key.."_sticker_color_inv",
 {
    description = desc.." Colored Sticker",
    tiles = {{name = "technic_paint.png^[colorize:#ffffff", color = "white"}},
    overlay_tiles = {"ehlphabet_000.png", 
    	      "ehlphabet_000.png^[transformR180" },
    palette = "technic_paint_palette.png",
    inventory_image = "ehlphabet_000.png",
    paramtype = "light",
    paramtype2 = "colorwallmounted",
    drawtype = "nodebox",
    is_ground_content = false,   
    drop = key,  -- new
    node_box = {
       type = "wallmounted",
       wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
       wall_top = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
       wall_side = {-0.5, -0.5, -0.5, -0.49, 0.5, 0.5},
    },
    groups = {attached_node = 1, dig_immediate = 2,  
       not_in_creative_inventory = 1, 
       not_blocking_trains = 1 },
 }
)

