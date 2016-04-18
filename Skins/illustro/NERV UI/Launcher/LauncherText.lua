function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bRF='!Refresh'
	bU='!Update'
	bRD='!Redraw'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bUMT='!UpdateMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bUMSG='!UpdateMeasureGroup'
	iLN=tonumber(SKIN:GetVariable('LauncherNum'))
	iP=tonumber(SKIN:GetVariable('Page'))
	iSM={}
	sLT={}
	sLP={}
	sEO={}
	sEP={}
	sEN={}
	for i=1,iLN do
		sLT[i]=tostring(SKIN:GetVariable('LauncherTag'..i))
		sLP[i]=tostring(SKIN:GetVariable('LauncherPath'..i))
		sEO[i]=tostring(SKIN:GetVariable('LauncherExe'..i))
		if sEO[i]=='' then
			sEP[i]=string.match(sLP[i],'(.*)\.exe')
			if type(sEP[i])=='nil' then
				sEN[i]=''
			else
				sEN[i]=string.gsub(sEP[i],'.*%\\','')
			end
		else
			sEN[i]=sEO[i]
		end
	end
	iPN=math.ceil(iLN/12)
	if iLN%12==0 then
		iPR=12
	else
		iPR=iLN%12
	end
	if iPN==1 then
		SKIN:Bang(bSO,'MeterPageLabel','Text','Page')
	else
		SKIN:Bang(bSO,'MeterPageLabel','Text','Pages')
	end
	if iP>iPN then
		iP=1
		SKIN:Bang(bWKV,'Variables','Page',1,'#CUSFILE#')
	end
	if iP==iPN then
		for i=iPR+1,12 do
			SKIN:Bang(bHM,'MeterL'..i)
			SKIN:Bang(bHM,'MeterP'..i)
		end
	end
	UD(0)
	for i=0,4 do
		SKIN:Bang(bSV,'GS'..i,0)
	end
	if tonumber(SKIN:GetVariable('Launcher'))==0 then
		iM=0
		for i=1,iS do
			SKIN:Bang(bHM,'MeterL'..i)
			SKIN:Bang(bHM,'MeterP'..i)
		end
		SKIN:Bang(bHMG,'Page')
		SKIN:Bang(bHMG,'PageLabel')
		SKIN:Bang(bSO,'MeterLauncherT','Text','OPEN')
	else
		iM=iSL*2
		for i=0,iSL do
			SKIN:Bang(bSV,'GS'..i,2)
		end
	end
	iG=0
	iE=1
	sNP='C'
	iC=0
	iPO=0
end

function Update()
	if iC<20 then
		iC=iC+1
	elseif iC==20 then
		if iPO==0 then
			iC=21
			SKIN:Bang(bRF,'NERV UI\\Launcher\\Process')
		end
	end
	if iG~=0 then
		S()
		U()
		E()
	end
end

function M()
	if iM==0 then
		iG=1
	else
		iG=-1
	end
	iE=0
	if sNP=='C' then
		SKIN:Bang(bHMG,'Page')
	end
	SKIN:Bang(bHMG,'LauncherTop','NERV UI\\Top')
	SKIN:Bang(bRD,'NERV UI\\Top')
	SKIN:Bang(bSOG,'Sub','UpdateDivider',1)
	SKIN:Bang(bSOG,'B','UpdateDivider',1)
	SKIN:Bang(bSO,'MeterLauncherT','FontColor','#*FontColor2*#,100')
	SKIN:Bang(bUMSG,'Sub')
	SKIN:Bang(bUMTG,'B')
	SKIN:Bang(bUMT,'MeterLauncherT')
end

function S()
	iM=iM+iG
	for i=0,4 do
		if (i==0)and(sNP~='C') then
			iSM[i]=2
		else
			if i==0 then
				j=1
			else
				j=i
			end
			if iM<=j*2-2 then
				iSM[i]=0
			elseif (iM>j*2-2)and(iM<=j*2) then
				iSM[i]=iM-j*2+2
			else
				iSM[i]=2
			end
		end
		SKIN:Bang(bSV,'GS'..i,iSM[i])
	end
end

function U()
	if sNP=='C' then
		if (iM==0)and(iG<0) then
			SKIN:Bang(bHMG,'PageLabel')
		elseif (iM>0)and(iM<=2) then
			if iM==1 then
				SKIN:Bang(bSMG,'PageLabel')
			end
			SKIN:Bang(bSOG,'PageLabel','TransformationMatrix',(0.2+iM*0.4)..';0;0;'..(0.2+iM*0.4)..';'..((0.8-iM*0.4)*166.5)..';'..(0.8-iM*0.4)*64)
			SKIN:Bang(bUMTG,'PageLabel')
		end
	end
	for i=1,12 do
		if iS>=i then
			iIL=math.ceil((i+2)/4)
			if (iIL-1)*4-2>0 then
				iI=i-((iIL-1)*4-2)
			else
				iI=i
			end
			if (iM==iIL*2-2)and(iG<0) then
				SKIN:Bang(bHM,'MeterL'..i)
				SKIN:Bang(bHM,'MeterP'..i)
			elseif (iM>iIL*2-2)and(iM<=iIL*2) then
				if (iM==iIL*2-1)and(iG>0) then
					SKIN:Bang(bSM,'MeterL'..i)
					SKIN:Bang(bSM,'MeterP'..i)
				end
				SKIN:Bang(bSO,'MeterL'..i,'TransformationMatrix',(0.2+iSM[iIL]*0.4)..';0;0;'..(0.2+iSM[iIL]*0.4)..';'..(111+(math.abs(1+math.sin((iI-2.5)*math.pi/3)*2)-1)*55.5)*(0.8-iSM[iIL]*0.4)..';'..(32+iIL*64+(-(iI-1)+math.floor(iI/3))*32)*(0.8-iSM[iIL]*0.4))
				SKIN:Bang(bSO,'MeterP'..i,'TransformationMatrix',(0.2+iSM[iIL]*0.4)..';0;0;'..(0.2+iSM[iIL]*0.4)..';'..(111+(math.abs(1+math.sin((iI-2.5)*math.pi/3)*2)-1)*55.5)*(0.8-iSM[iIL]*0.4)..';'..(32+iIL*64+(-(iI-1)+math.floor(iI/3))*32)*(0.8-iSM[iIL]*0.4))
				SKIN:Bang(bUMT,'MeterL'..i)
				SKIN:Bang(bUMT,'MeterP'..i)
			end
		end
	end
end

function E()
	if (iE==0)and(((iM==2)and(iSL==1))or((iM==4)and(iSL==2))or((iM==6)and(iSL==3))or((iM==8)and(iSL==4))) then
		iG=0
		iE=1
		SKIN:Bang(bWKV,'Variables','Launcher',1,'#CUSFILE#')
		SKIN:Bang(bSMG,'LauncherTop','NERV UI\\Top')
		SKIN:Bang(bSO,'MeterLauncherT','ToolTipText','Close Launcher','NERV UI\\Top')
		SKIN:Bang(bU,'NERV UI\\Top')
		SKIN:Bang(bSMG,'Page')
		SKIN:Bang(bSO,'MeterLauncherT','FontColor','#*FontColor1*#')
		SKIN:Bang(bSO,'MeterLauncherT','Text','CLOSE')
		SKIN:Bang(bSOG,'Sub','UpdateDivider',50)
		SKIN:Bang(bSOG,'B','UpdateDivider',50)
		SKIN:Bang(bUMT,'MeterLauncherT')
	elseif (iE==0)and(iM==0)and(sNP=='C') then
		iG=0
		iE=1
		SKIN:Bang(bWKV,'Variables','Launcher',0,'#CUSFILE#')
		SKIN:Bang(bSM,'MeterLauncherT','NERV UI\\Top')
		SKIN:Bang(bSO,'MeterLauncherT','ToolTipText','Open Launcher','NERV UI\\Top')
		SKIN:Bang(bU,'NERV UI\\Top')
		SKIN:Bang(bSO,'MeterLauncherT','FontColor','#*FontColor1*#')
		SKIN:Bang(bSO,'MeterLauncherT','Text','OPEN')
		SKIN:Bang(bSOG,'Sub','UpdateDivider',50)
		SKIN:Bang(bSOG,'B','UpdateDivider',50)
		SKIN:Bang(bUMT,'MeterLauncherT')
	elseif (iE==0)and(iM==0)and(sNP=='P') then
		iG=1
		if iP==1 then
			iP=iPN
		else
			iP=iP-1
		end
		SKIN:Bang(bWKV,'Variables','Page',iP,'#CUSFILE#')
		UD(1)
	elseif (iE==0)and(iM==0)and(sNP=='N') then
		iG=1
		iP=iP%iPN+1
		SKIN:Bang(bWKV,'Variables','Page',iP,'#CUSFILE#')
		UD(1)
	end
end

function UD(p)
	if iP<iPN then
		iS=12
	else
		iS=iPR
	end
	iSL=math.ceil((iS+2)/4)
	SKIN:Bang(bHMG,'B')
	SKIN:Bang(bSM,'MeterB0')
	for i=1,iS do
		SKIN:Bang(bWKV,'Variables','Exe'..i,sEN[(iP-1)*12+i],'#PCSFILE#')
		SKIN:Bang(bSO,'MeterL'..i,'Text',sLT[(iP-1)*12+i])
		SKIN:Bang(bSO,'MeterL'..i,'LeftMouseUpAction','[\"'..sLP[(iP-1)*12+i]..'\"]')
		SKIN:Bang(bSM,'MeterB'..i)
		SKIN:Bang(bUMT,'MeterL'..i)
	end
	if p==1 then
		SKIN:Bang(bRF,'NERV UI\\Launcher\\Process')
	end
	SKIN:Bang(bSO,'MeterPage','Text',iP..'/'..iPN)
	SKIN:Bang(bUMT,'MeterPage')
end