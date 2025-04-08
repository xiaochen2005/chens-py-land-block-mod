-- Copyright (c) 2025 JackieChen
-- 此项目遵循 MIT 许可证，详见 LICENSE 文件。
if settings.startup["enable-no-resource"].value then
    -- 注册地图预设
    data:extend({
        {
            type = "noise-expression",
            name = "land_block_no_resource",
            intended_property = "elevation",
            expression = "1"
        }, {
            type = "map-gen-presets",
            name = "default",
            default = {default = true, order = "a"},
            ["land-block-no-resource"] = {
                order = "b",
                basic_settings = {
                    property_expression_names = {
                        elevation = "land_block_no_resource"
                    },
                    cliff_settings = {cliff_elevation_interval = 0},
                    autoplace_settings = {
                        entity = {
                            treat_missing_as_default = false,
                            settings = {
                                fish = {frequency = 0},
                                seaweed = {frequency = 0}
                            }
                        }
                    },
                    autoplace_controls = {
                        trees = {frequency = 0},
                        rocks = {frequency = 0},
                        ["enemy-base"] = {frequency = 0}
                    },
                    starting_area = 0,
                    starting_points = {{x = 0, y = 0}}
                }
            }
        }
    })

    for name, _ in pairs(data.raw.resource) do
        if data.raw["autoplace-control"][name] then
            data.raw["map-gen-presets"].default["land-block-no-resource"]
                .basic_settings.autoplace_controls[name] = {frequency = 0}
        end

        if data.raw.resource[name].autoplace and
            data.raw.resource[name].autoplace.probability_expression then
            data.raw.resource[name].autoplace.probability_expression = "0"
        end
    end
else
    -- 注册地图预设
    data:extend({
        {
            type = "noise-expression",
            name = "land_block",
            intended_property = "elevation",
            expression = "1"
        }, {
            type = "map-gen-presets",
            name = "default",
            default = {default = true, order = "a"},
            ["land-block"] = {
                order = "b",
                basic_settings = {
                    property_expression_names = {elevation = "land_block"},
                    autoplace_settings = {
                        entity = {
                            treat_missing_as_default = false,
                            settings = {
                                fish = {frequency = 0},
                                seaweed = {frequency = 0}
                            }
                        }
                    },
                    autoplace_controls = {["enemy-base"] = {frequency = 0}}
                }
            }
        }
    })
end
