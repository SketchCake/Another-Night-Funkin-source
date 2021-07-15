local swayboi = false

local camerabeat = false

function update (elapsed)
local currentBeat = (songPos / 1000)*(bpm/60)
	if lockzoom then
		setCamZoom(1)
	end
	if swayboi then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 8 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 3 * math.cos((currentBeat + i*0.50) * math.pi), i)
		end
	end
end

function beatHit (beat)
	if camerabeat then
		setCamZoom(0.1)
	end
end

function stepHit (step)
	if step == 1 then
	end
	if step == 127 then
	swayboi = true
	camerabeat = true
		for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			setActorY(_G['defaultStrum'..i..'Y'],i)
		end	
	end
	if step == 639 then
	camerabeat = false 
	swayboi = false
	end
	if step == 751 then
	camerabeat = true
	swayboi = true
	end
end