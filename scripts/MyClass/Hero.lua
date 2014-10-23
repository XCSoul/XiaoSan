-- 英雄类(伪)

local Hero = class("Hero", function()
	return display.newNode()
end)

function Hero:ctor()
	local png = "run1.png"
	local plist = "run1.plist"
	display.addSpriteFramesWithFile(plist, png);
	self._sp = display.newSprite("#r1.png")
	self:addChild(self._sp, 0)
end

-- 开始跑步动画
function Hero:StartRun()
	local frames = display.newFrames("r%d.png",1, 10)
	local animate = display.newAnimation(frames, 0.1)
	self._sp:playAnimationForever(animate, 0.1)
end
-- 停止动画
function Hero:StopRun()
	self._sp:stopAllActions()
end
-- 开始挥刀动画
function Hero:StartDao()
	self._sp:stopAllActions()
	display.addSpriteFramesWithFile("dao.plist", "dao.png");
	local frames = display.newFrames("d%d.png",1, 6)
	local animate = display.newAnimation(frames, 0.1)
	self._sp:playAnimationOnce(animate)

end

return Hero