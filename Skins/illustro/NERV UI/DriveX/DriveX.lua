function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bU='!Update'
	bUMSG='!UpdateMeasureGroup'
	iDX=tonumber(SKIN:GetVariable('DriveX'))
	iDXN=tonumber(SKIN:GetVariable('DriveXNum'))
	sM={'Label','Free','Total'}
	sDX={}
	for i=1,iDXN do
		sDX[i]=tostring(SKIN:GetVariable('DriveX'..i))
	end
	if iDX>iDXN then
		iDX=1
		SKIN:Bang(bWKV,'Variables','DriveX',1,'#CUSFILE#')
	end
	SKIN:Bang(bSVG,'DriveX',sDX[iDX],'NonePower')
	for i=1,3 do
		SKIN:Bang(bSO,'MeasureDisk'..sM[i],'Drive',sDX[iDX]..':')
	end
	SKIN:Bang(bSO,'MeterDisk','Text',sDX[iDX])
end

function M()
	iDX=iDX%iDXN+1
	SKIN:Bang(bWKV,'Variables','DriveX',iDX,'#CUSFILE#')
	SKIN:Bang(bSV,'DriveX',sDX[iDX],'NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	for i=1,3 do
		SKIN:Bang(bSO,'MeasureDisk'..sM[i],'Drive',sDX[iDX]..':')
	end
	SKIN:Bang(bUMSG,'Drive')
	SKIN:Bang(bSO,'MeterDisk','Text',sDX[iDX])
	SKIN:Bang(bU)
end