
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	-- 两全局变量实现统计分数和米数
	meterNum = 0
	scoreNum = 0

    --背景图片的加载(两张实现背景图片循环滚动)
 	bg1 = display.newSprite("BG2.png")
	bg1:setAnchorPoint(ccp(0, 0))
	bg1:setPosition(ccp(0, 0))
	bg1:setScaleY(0.5)
	self:addChild(bg1, 0)

	bg2 = display.newSprite("BG2.png")
	bg2:setAnchorPoint(ccp(0, 0))
	bg2:setPosition(ccp(bg1:getContentSize().width, 0))
	bg2:setScaleY(0.5)
	self:addChild(bg2, 0)
    
    -- 英雄图片的加载
	hero = Hero.new()
	hero:setPosition(ccp(50, 50))
	hero:setAnchorPoint(ccp(0, 0))
	hero:setScale(0.5)
	self:addChild(hero, 1)
	hero:StartRun()


    -- 加载触摸层
	local touchlayer = TouchLayer.new(hero)
	self:addChild(touchlayer, 0)
	-- hero = display.newSprite("coin2.png")
	-- hero:setPosition(ccp(50, display.cy))
	-- self:addChild(hero, 1)
    
    -- 显示分数的图片的加载
    local score1 = display.newSprite("scoreBg3.png")
    score1:setPosition(ccp(55, 310))
    score1:setScale(0.4)
    self:addChild(score1, 2)
    
    -- 显示米数的图片加载
    local score2 = display.newSprite("scoreBg4.png")
    score2:setPosition(ccp(155, 310))
    score2:setScale(0.4)
    self:addChild(score2, 2)
    
    -- 用label来接米数
    meter = ui.newTTFLabel({
    	text = "0",
		font = "Arial",
		size = 12,
		align = ui.TEXT_ALIGN_CENTER,
		x = 160,
		y = 310,
		--color = ccc3(0, 0, 255)
    	})
    self:addChild(meter, 2)
    
    -- 用label来接分数
    score = ui.newTTFLabel({
    	text = "0",
		font = "Arial",
		size = 12,
		align = ui.TEXT_ALIGN_CENTER,
		x = 60,
		y = 310,
		--color = ccc3(0, 0, 255)
    	})
    self:addChild(score, 2)
    
    -- 加载飞龙
    dragon = Dragon.new()
	dragon:setPosition(ccp(450, 250))
	self:addChild(dragon, 1)
	dragon:StartRun()

	-- local moveDra = cc.MoveTo:create(10,ccp(hero:getPositionX(), hero:getPositionY() + 40))
 --    local moveDra1 = cc.MoveTo:create(10,ccp(display.width, display.height))
 --    local seq = CCSequence:createWithTwoActions(moveDra, moveDra1)
 --    local rep = CCRepeatForever:create(seq)
	-- dragon:runAction(rep)

	-- local dargonMove = cc.MoveTo:create(10,ccp(hero:getPositionX(),hero:getPositionY()))
	-- dragon:runAction(dargonMove)
    
    -- 通过时间调度来实现计算英雄所跑米数和所得分数
    local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	self._schedule = sharedScheduler:scheduleScriptFunc(countMeter, 0.1, false)
    
    -- 暂停按钮
    local pauseBtn = cc.ui.UIPushButton.new({normal = "pause.png"},{scale9 = true})
	pauseBtn:setPosition(ccp(display.width - 10, display.height - 10))
	pauseBtn:setScale(0.5)
	self:addChild(pauseBtn, 1)
    
    -- 暂停按钮的点击事件
	pauseBtn:onButtonClicked(function( event )
        
		pausePic = display.newSprite("reBG.png")
		pausePic:setScale(0.4)
		pausePic:setPosition(ccp(display.cx, display.cy))
		self:addChild(pausePic,1)

		local okBtn = cc.ui.UIPushButton.new({normal = "reStart1.png"},{scale9 = true})
		local continueBtn = cc.ui.UIPushButton.new({normal = "continueGame1.png"},{scale9 = true})
		okBtn:setScale(0.3)
	    okBtn:setPosition(ccp(pausePic:getPositionX(), pausePic:getPositionY() - 70))
	    self:addChild(okBtn, 1)
        
	    okBtn:onButtonClicked(function( event )
	    	okBtn:removeFromParent()
	    	pausePic:removeFromParent()
	    	continueBtn:removeFromParent()
	    end)

		continueBtn:setScale(0.3)
	    continueBtn:setPosition(ccp(pausePic:getPositionX(), pausePic:getPositionY() - 20))
	    self:addChild(continueBtn, 1)

	    continueBtn:onButtonClicked(function( event )
	    	okBtn:removeFromParent()
	    	pausePic:removeFromParent()
	    	continueBtn:removeFromParent()
	    end)
	end)
    
    -- 瓦片地图
    -- for i=1,10 do
    --	local tmp = "tiledmap/" .. 1 .. ".tmx"
    	map1 = CCTMXTiledMap:create("tiledmap/1.tmx")
        map1:setPosition(ccp(0, 0))
        map1:setAnchorPoint(ccp(0, 0))
        self:addChild(map1, 0)

        map2 = CCTMXTiledMap:create("tiledmap/2.tmx")
        map2:setPosition(ccp(960, 0))
        map2:setAnchorPoint(ccp(0, 0))
        self:addChild(map2, 0)
        
        coin = map1:layerNamed("coin")
        coin1 = map2:layerNamed("coin")

         local x1=(hero:getPositionX() - map1:getPositionX())/(map1:getTileSize().width);
	local y1=((map1:getMapSize().height * map1:getTileSize().height) - hero:getPositionY())/map1:getTileSize().height;
	local tileCoin =ccp(x1,y1);
	local coinq = coin:tileAt(tileCoin);
	coinq:removeFromParent();
        -- print(daoju:getPositionY())
    -- end

    -- for i=1,9 do
    -- 	--local tmp 
    -- 	--printf(tmp, "tiledmap/%d.tmx" , i)
    -- 	local tmp = "tiledmap/" .. i .. ".tmx"
    -- 	map = CCTMXTiledMap:create(tmp)
    -- 	map:setAnchorPoint(ccp(0, 0))
    -- 	map:setPosition(ccp(960 * (i - 1), 0))
    -- 	self:addChild(map, 0)
    -- end
        
    -- 通过时间调度实现背景滚动
	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	self._schedule = sharedScheduler:scheduleScriptFunc(ScrollBG, 0.05, false)


end


-- 两背景图片循环滚动
function ScrollBG()
	-- 地图滚动
	local move1 = cc.MoveBy:create(0.001,ccp(-3, 0))
	local move2 = cc.MoveBy:create(0.001,ccp(-3, 0))
	bg1:runAction(move1)
	bg2:runAction(move2)
	if bg1:getPositionX() <= -bg1:getContentSize().width then
		bg1:setPositionX(bg2:getPositionX() + bg1:getContentSize().width)
	end

	if bg2:getPositionX() <= -bg2:getContentSize().width then
		bg2:setPositionX(bg1:getPositionX() + bg2:getContentSize().width)
	end

    -- 瓦片地图滚动
	map1:setPositionX(map1:getPositionX() - 6)
	map2:setPositionX(map2:getPositionX() - 6)
	if map1:getPositionX() <= -960 then
		map1:setPositionX(map2:getPositionX() + 960)
	end

	if map2:getPositionX() <= -960 then
		map2:setPositionX(map1:getPositionX() + 960)
	end


    local moveDra = cc.MoveTo:create(100,ccp(hero:getPositionX(), hero:getPositionY() + 40))
    local moveDra1 = cc.MoveTo:create(100,ccp(display.width, display.height))
    local seq = CCSequence:createWithTwoActions(moveDra, moveDra1)
    local rep = CCRepeatForever:create(seq)
	dragon:runAction(seq)
    -- if hero:getPositionY() > 78 then
    -- 	hero:setPositionY(hero:getPositionY() - 2)
    -- end
	
    -- 判断英雄是否和道具相撞
	-- if iscollision(hero, daoju) then
	-- 	print("撞了")
	-- end


    -- local point =ccp(hero:getPositionX() - map1:getPositionX(), hero:getPositionY() - map1:getPositionY())
    -- point.x = point.x / map1:getTileSize().width
    -- point.y =(map1:getMapSize().height * map1:getTileSize().height - point.y ) / map1:getTileSize().height
    
    -- if coin:tileAt(ccp(point.x, point.y)) then
    -- 	print("-----------------------------vcxvxvx----------------")
    -- 	coin:removeTileAt(ccp(point.x,point.y))
    -- end
    -- local point1 =ccp(hero:getPositionX() - map2:getPositionX(), hero:getPositionY() - map2:getPositionY())
    -- point1.x = point1.x / map2:getTileSize().width
    -- point1.y =( map2:getMapSize().height * map2:getTileSize().height - point1.y  ) / map2:getTileSize().height
    -- if coin1:tileAt(ccp(point1.x, point1.y)) then
    -- 	print("-----------------------------vcxvxvx----------------")
    -- 	coin1:removeTileAt(ccp(point1.x,point1.y))
    -- end
    

    -- if coin:tileAt(ccp(hero:getPositionX()/32, 9 - hero:getPositionY()/32)) then
    -- 	print("-----------------------------vcxvxvx----------------")
    -- 	coin:removeTileAt(ccp(hero:getPositionX()/32, 9 - hero:getPositionY()/32))
    -- end

    -- if coin:tileAt(ccp(hero:getPositionX()/32, 9 - hero:getPositionY()/32)) then
    -- 	print("-----------------------------vcxvxvx----------------")
    -- 	coin:removeTileAt(ccp(hero:getPositionX()/32, 9 - hero:getPositionY()/32))
    -- end

    
 --    local x1=(hero:getPositionX() - map1:getPositionX())/(map1:getTileSize().width);
	-- local y1=((map1:getMapSize().height * map1:getTileSize().height) - hero:getPositionY())/map1:getTileSize().height;
	-- local tileCoin =ccp(x1,y1);
	-- local coinq = coin:tileAt(tileCoin);
	-- coinq:removeFromParent();
end
-- 计算米数和所得分数
function countMeter()
	meterNum = meterNum + 1
	meter:setString(meterNum)
    scoreNum = scoreNum + 5
    score:setString(scoreNum)
end
-- 检测碰撞
function iscollision(sprite1, sprite2)
    print("检测碰撞")
	local rect1 = getRected(sprite1)
	print("2222222")
	local rect2 = getRected(sprite2)
	return CCRect.intersectsRect(rect1,rect2)
end
-- 获取精灵的Rect
function getRected( sprite)
	local s = sprite:getContentSize()
	local px = sprite:getPositionX()
	local py = sprite:getPositionY()
	local ap = sprite:getAnchorPoint()
	rect = cc.RectMake( px - ap.x * s.width , py - ap.y * s.height,s.width, s.height )
	return rect
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
