function Initialize()
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bSVG='!SetVariableGroup'
	bSM='!ShowMeter'
	bHMG='!HideMeterGroup'
	msMQ=SKIN:GetMeasure('MeasureQuality')
	SKIN:Bang(bWKV,'Variables','Wireless',1,'#CUSFILE#')
	SKIN:Bang(bSVG,'Wireless',1,'NonePower')
	SKIN:Bang(bSM,'MeterWiFi','NERV UI\\Ani')
	if tonumber(SKIN:GetVariable('WiFi'))==0 then
		SKIN:Bang(bHMG,'WiFi')
	end
end

function Update()
	iMQ=msMQ:GetValue()
	if iMQ==0 then
		SKIN:Bang(bSOG,'Q5','SolidColor','#*FontColor2*#,100')
	else
		for i=1,5 do
			if (iMQ>(i-1)*20)and(iMQ<=i*20) then
				SKIN:Bang(bSOG,'Q'..i,'SolidColor','#*FontColor2*#,160')
				SKIN:Bang(bSOG,'NQ'..i,'SolidColor','#*FontColor2*#,100')
			end
		end
	end
end