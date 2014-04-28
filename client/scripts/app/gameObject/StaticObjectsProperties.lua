
--[[--

定义了所有的静态对象

]]

local StaticObjectsProperties = {}

local defines = {}

----------------------------------------

----飞机
--local object = {
--    classId      = "static",
----     positon= 0, -- 0-15
--  	 number= 0, -- 这个格子显示的数字. 0表示灰的
--	 steps= 0,  -- 0-3 经过计算这个格子移动的距离
--
----    animation   = "tile",
----	flyDegrees = 1,--飞行的方向 ，1-32
----    radius       = 30,
----    zorder       = 30000,
----    viewZOrdered = true,
----     speed = 300,
----     isHero = true,--是否是主角
--    behaviors   = {
--    				"DecorateBehavior","ObjectViewBehavior",
--    			},
--}
--defines["title"] = object









----------------------------------------


--local object = {
--    classId     = "static",
--    imageName   = {"#PlayerTower0101.png", "#PlayerTower0102.png"},
--    radius      = 32,
--    offsetX     = {-15, -16, -16},
--    offsetY     = {3, 3, 2},
--    towerId     = "PlayerTower01L01",
--    decorations = {"PlayerTower01Destroyed"},
--    behaviors   = {"TowerBehavior"},
--    fireOffsetX = {0, 0, 0},
--    fireOffsetY = {24, 24, 24},
--    campId      = MapConstants.PLAYER_CAMP,
--}
--defines["PlayerTower01"] = object


----------------------------------------

function StaticObjectsProperties.getAllIds()
    local keys = table.keys(defines)
    table.sort(keys)
    return keys
end

function StaticObjectsProperties.get(defineId)
    assert(defines[defineId], string.format("StaticObjectsProperties.get() - invalid defineId %s", tostring(defineId)))
    return clone(defines[defineId])
end

function StaticObjectsProperties.isExists(defineId)
    return defines[defineId] ~= nil
end

return StaticObjectsProperties
