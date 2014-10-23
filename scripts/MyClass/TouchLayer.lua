-- 触摸响应层

local TouchLayer = class("TouchLayer",function ()
	return display.newNode()
end)

function TouchLayer:ctor(pramas)
	local hero = pramas
	local corlorLayer = display.newColorLayer(ccc4(23, 222, 21, 0))
	self:addChild(corlorLayer, 0)
    print("touch")
	-- 触摸事件
	corlorLayer:setTouchSwallowEnabled(true)
	corlorLayer:setTouchEnabled(true)
	corlorLayer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	corlorLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		if event.name == "began" then
			startPointX = event.x
			startPointY = event.y
			-- if hero:getPositionY() < 210 then
			-- 	hero:setPositionY(hero:getPositionY() + 60)
			-- end
		    if hero:getPositionY() < 210  then
				local jump1 = cc.JumpTo:create(0.8,ccp(hero:getPositionX(), hero:getPositionY()),100,1)
				hero:runAction(jump1)
			end
			--print("beganMask")
			return true
		elseif event.name == "moved" then
			--print("movedMask")
		elseif event.name == "ended" then
			--print("endedMask")
			endPointX = event.x
			endPointY = event.y
			if startPointX == endPointX and startPointY == endPointY then
                --hero:StartDao()
				-- local move1 = cc.MoveBy:create(4,ccp(0, 15))
				-- local move2 = cc.MoveBy:create(4,ccp(0, -15))
				-- if hero:getPositionY() < 200  then
				-- local jump1 = cc.JumpTo:create(0.8,ccp(hero:getPositionX(), hero:getPositionY()),100,1)
				-- hero:runAction(jump1)

				-- end
			end
			return true
		end
		return false
	end)
end

return TouchLayer