function Initialize()
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	sP=tostring(SKIN:GetVariable('AC'))
	P()
end

function P()
	if tonumber(SKIN:GetVariable('NERV'..sP))==0 then
		SKIN:Bang(bSMG,'NERV')
	else
		SKIN:Bang(bHMG,'NERV')
	end
	if tonumber(SKIN:GetVariable('Wall'..sP))==0 then
		SKIN:Bang(bSM,'MeterWall')
	else
		SKIN:Bang(bHM,'MeterWall')
	end
end