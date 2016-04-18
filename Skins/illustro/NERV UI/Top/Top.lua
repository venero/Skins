function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bRF='!Refresh'
	bRD='!Redraw'
	bHM='!HideMeter'
	bTM='!ToggleMeter'
	bHMG='!HideMeterGroup'
	bTMG='!ToggleMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bUMSG='!UpdateMeasureGroup'
	bCM='!CommandMeasure'
	iCT=tonumber(SKIN:GetVariable('CPUTemp'))
	sCTU={'C','F'}
	sWTU={'C','F'}
	sWUU={'m','f'}
	SKIN:Bang(bRF,'NERV UI\\DriveX')
	SKIN:Bang(bRF,'NERV UI\\DriveY')
	SKIN:Bang(bRF,'NERV UI\\Recycle')
	SKIN:Bang(bRF,'NERV UI\\WMP')
	SKIN:Bang(bSV,'Recycle',0)
	if iCT==0 then
		SKIN:Bang(bHM,'MeterCPUTemp')
	end
	if tonumber(SKIN:GetVariable('Launcher'))==0 then
		SKIN:Bang(bHMG,'Page')
		SKIN:Bang(bSO,'MeterLauncherT','ToolTipText','Open Launcher')
	end
	if tostring(SKIN:GetVariable('CPUTempUnit'))=='C' then
		iCTU=1
	else
		iCTU=2
	end
	if tostring(SKIN:GetVariable('WeatherTempUnit'))=='C' then
		iWTU=1
	else
		iWTU=2
	end
	iR=-1
	iW=-1
end

function Update()
	if iR~=tonumber(SKIN:GetVariable('Recycle')) then
		iR=tonumber(SKIN:GetVariable('Recycle'))
		if iR==0 then
			SKIN:Bang(bSO,'MeterRecycle','ToolTipText','Open Recycle Bin')
			SKIN:Bang(bSO,'MeterRecycle','RightMouseUpAction','[]')
		else
			SKIN:Bang(bSO,'MeterRecycle','ToolTipText','Open Recycle Bin#CRLF#(Right-Click to Empty Recycle Bin)')
			SKIN:Bang(bSO,'MeterRecycle','RightMouseUpAction',bCM..' MeasureCount EmptyBin \"NERV UI\\Recycle\"')
		end
		SKIN:Bang(bRD)
	end
	if iW~=tonumber(SKIN:GetVariable('Wireless')) then
		iW=tonumber(SKIN:GetVariable('Wireless'))
		if iW==0 then
			SKIN:Bang(bSO,'MeterNet','ToolTipText','Open Network Connections#CRLF#[Mid-Click to Reset Stats]')
			SKIN:Bang(bSO,'MeterNet','RightMouseUpAction','[]')
		else
			SKIN:Bang(bSO,'MeterNet','ToolTipText','Open Network Connections#CRLF#(Right-Click to Toggle WiFi)#CRLF#[Mid-Click to Reset Stats]')
			SKIN:Bang(bSO,'MeterNet','RightMouseUpAction',bCM..' MeasureScript MW() \"NERV UI\\Ani\"')
		end
		SKIN:Bang(bRD)
	end
end

function MCT()
	iCT=1-iCT
	SKIN:Bang(bWKV,'Variables','CPUTemp',iCT,'#CUSFILE#')
	SKIN:Bang(bTMG,'Temp','NERV UI\\CPU')
	SKIN:Bang(bRD,'NERV UI\\CPU')
	SKIN:Bang(bTM,'MeterCPUTemp')
	SKIN:Bang(bRD)
end

function MCTU()
	iCTU=3-iCTU
	SKIN:Bang(bWKV,'Variables','CPUTempUnit',sCTU[iCTU],'#CUSFILE#')
	SKIN:Bang(bSV,'CPUTempUnit',sCTU[iCTU],'NERV UI\\CPU')
	SKIN:Bang(bSO,'MeasureCalcTemp','Formula','(MeasureTemp-#MinCPUTemp'..sCTU[iCTU]..'#)/(#MaxCPUTemp'..sCTU[iCTU]..'#-#MinCPUTemp'..sCTU[iCTU]..'#)','NERV UI\\CPU')
	SKIN:Bang(bUMSG,'Temp','NERV UI\\CPU')
	SKIN:Bang(bUMTG,'Temp','NERV UI\\CPU')
	SKIN:Bang(bRD,'NERV UI\\CPU')
end

function MWTU()
	iWTU=3-iWTU
	SKIN:Bang(bWKV,'Variables','WeatherTempUnit',sWTU[iWTU],'#CUSFILE#')
	SKIN:Bang(bWKV,'Variables','UrlUnit',sWUU[iWTU],'#WEAFILE#')
	SKIN:Bang(bRF,'NERV UI\\Weather')
end