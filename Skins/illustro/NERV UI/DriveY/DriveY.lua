function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bU='!Update'
	bUMSG='!UpdateMeasureGroup'
	iDY=tonumber(SKIN:GetVariable('DriveY'))
	iDYN=tonumber(SKIN:GetVariable('DriveYNum'))
	sM={'Label','Free','Total'}
	sDY={}
	for i=1,iDYN do
		sDY[i]=tostring(SKIN:GetVariable('DriveY'..i))
	end
	if iDY>iDYN then
		iDY=1
		SKIN:Bang(bWKV,'Variables','DriveY',1,'#CUSFILE#')
	end
	SKIN:Bang(bSVG,'DriveY',sDY[iDY],'NonePower')
	for i=1,3 do
		SKIN:Bang(bSO,'MeasureDisk'..sM[i],'Drive',sDY[iDY]..':')
	end
	SKIN:Bang(bSO,'MeterDisk','Text',sDY[iDY])
end

function M()
	iDY=iDY%iDYN+1
	SKIN:Bang(bWKV,'Variables','DriveY',iDY,'#CUSFILE#')
	SKIN:Bang(bSV,'DriveY',sDY[iDY],'NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	for i=1,3 do
		SKIN:Bang(bSO,'MeasureDisk'..sM[i],'Drive',sDY[iDY]..':')
	end
	SKIN:Bang(bUMSG,'Drive')
	SKIN:Bang(bSO,'MeterDisk','Text',sDY[iDY])
	SKIN:Bang(bU)
end