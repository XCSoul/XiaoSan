-- 飞龙类(伪)

local Dragon = class("Dragon", function()
	return display.newNode()
end)

function Dragon:ctor()
    local png = "fei.png"
	local plist = "fei.plist"
	display.addSpriteFramesWithFile(plist, png);
	self._sp = display.newSprite("#f1.png")
	self:addChild(self._sp, 0)
end
-- 开始动画
function Dragon:StartRun()
	local frames = display.newFrames("f%d.png",1, 6)
	local animate = display.newAnimation(frames, 0.1)
	self._sp:playAnimationForever(animate, 0.08)
end
-- 停止动画
function Dragon:StopRun()
	self._sp:stopAllActions()
end

return Dragon