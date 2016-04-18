function Initialize()
	bSO='!SetOption'
	bHMG='!HideMeterGroup'
	sT={'Temp','FH0','FL0','FH1','FL1','FH2','FL2'}
	sI={'Icon','FI0','FI1','FI2'}
	msMT={}
	msMI={}
	sMT={}
	for i=1,7 do
		msMT[i]=SKIN:GetMeasure('Measure'..sT[i])
	end
	for i=1,4 do
		msMI[i]=SKIN:GetMeasure('Measure'..sI[i])
	end
	if tonumber(SKIN:GetVariable('Forecast'))==0 then
		SKIN:Bang(bHMG,'Forecast')
	end
end

function F()
	for i=1,7 do
		sMT[i]=msMT[i]:GetStringValue()
		if sMT[i]~='N/A' then
			SKIN:Bang(bSO,'Meter'..sT[i],'Text',sMT[i]..'\'#WeatherTempUnit#')
		end
	end
	for i=1,4 do
		SKIN:Bang(bSO,'Meter'..sI[i],'ImageName','#@#Images\\Weather\\'..msMI[i]:GetStringValue())
	end
end