local Loading = class("Loading", function()
	return display.newScene("Loading")
end)

function Loading:ctor()
	-- 全局变量，为了实现进度条百分比
	currentNumber = 0
	totalNumber = 100
	-- 加载标题
	local label = ui.newTTFLabel({
		text = "小三快跑",
		font = "Zapfino",
		size = 64,
		align = ui.TEXT_ALIGN_CENTER,
		x = display.cx,
		y = display.cy + 50,
		color = ccc3(0, 0, 255)
		})
	self:addChild(label, 1)
    -- 加载背景图片
	bg1 = display.newSprite("BG2.png")
	bg1:setAnchorPoint(ccp(0, 0))
	bg1:setPosition(ccp(0, 0))
	bg1:setScaleY(0.5)
	self:addChild(bg1, 0)
    
    -- 进度条
	timer = CCProgressTimer:create(CCSprite:create("progressbar.png"))
	timer:setType(kCCProgressTimerTypeBar)
	timer:setPosition(ccp(display.cx, 80))
	timer:setPercentage(0.0)
	timer:setScale(0.5)
    -- 这两句必须得写，才能实现进度条从左至右加载
	timer:setMidpoint(ccp(0, 0))
	timer:setBarChangeRate(ccp(1, 0))

    -- 加载空的进度条
	local bar = display.newSprite("progressbar1.png")
	bar:setPosition(ccp(display.cx, 80))
	bar:setScale(0.5)
	self:addChild(bar)
	self:addChild(timer)
    -- 加载loading标题
    lodingLable = ui.newTTFLabel({
		text = "loaing....",
		font = "Arial",
		size = 12,
		align = ui.TEXT_ALIGN_CENTER,
		x = display.cx,
		y = 60,
		color = ccc3(0, 0, 255)
		})
    self:addChild(lodingLable)
    -- 加载百分比显示标题
    percentlable = ui.newTTFLabel({
		text = "0%",
		font = "Arial",
		size = 12,
		align = ui.TEXT_ALIGN_CENTER,
		x = display.cx,
		y = 100,
		color = ccc3(0, 0, 255)
		})
    self:addChild(percentlable)
    -- 实现异步加载图片纹理
	for i=1,100 do
		CCTextureCache:sharedTextureCache():addImageAsync("load.png", loading)
	end
end
-- 通过加载图片纹理实现进度条和加载百分比
function loading()
	local c = timer:getPercentage()
	c = c + 1
	print(c)
	currentNumber = currentNumber + 1
	local tmp = ((currentNumber / totalNumber)*100) .. "%"
	--print(tmp)
    percentlable:setString(tmp)
	timer:setPercentage(c)
	if c == 100 then
		local hello = GameScene.new()
		CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(1, hello))
	end
end

function Loading:onEnter()
end
function Loading:onExit()
end


return Loading