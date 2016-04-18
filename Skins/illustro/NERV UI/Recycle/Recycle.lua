function Initialize()
	bSO='!SetOption'
	bSVG='!SetVariableGroup'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	msMC=SKIN:GetMeasure('MeasureCount')
	iMC=-1
end

function Update()
	if iMC~=msMC:GetValue() then
		iMC=msMC:GetValue()
		if iMC==0 then
			SKIN:Bang(bSVG,'Recycle',0,'NonePower')
			SKIN:Bang(bHMG,'Count')
			SKIN:Bang(bSM,'MeterEmpty')
		else
			SKIN:Bang(bSVG,'Recycle',1,'NonePower')
			SKIN:Bang(bSMG,'Count')
			SKIN:Bang(bHM,'MeterEmpty')
		end
		if iMC<2 then
			SKIN:Bang(bSO,'MeterItemLabel','Text','Item')
		else
			SKIN:Bang(bSO,'MeterItemLabel','Text','Items')
		end
	end
end