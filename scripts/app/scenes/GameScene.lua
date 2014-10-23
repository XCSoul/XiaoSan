local GameScene = class("GameScene", function()
	return display.newScene("GameScene")
end)

function GameScene:ctor()
	-- 加载背景图片
	local bg = display.newSprite("BG2.png")
	bg:setAnchorPoint(ccp(0, 0))
	bg:setPosition(ccp(0, 0))
    bg:setScaleY(0.5)
	self:addChild(bg, 0)
    -- 加载开始按钮
	local sprite = cc.ui.UIPushButton.new({normal = "startBt1.png"},{scale9 = true})
	sprite:setScale(0.2)
	sprite:setPosition(ccp(display.cx, display.cy))
	self:addChild(sprite)
    -- 开始按钮点击事件
	sprite:onButtonClicked(function( event )
		local hello = MainScene.new()
		CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(1, hello))
	end)
end

return GameScene