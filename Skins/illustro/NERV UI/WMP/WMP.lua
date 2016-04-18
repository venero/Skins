function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bRF='!Refresh'
	bU='!Update'
	bMM='!MoveMeter'
	bCM='!CommandMeasure'
	msMC=SKIN:GetMeasure('MeasureCover')
	msMS=SKIN:GetMeasure('MeasureState')
	msMV=SKIN:GetMeasure('MeasureVolume')
	mtMP=SKIN:GetMeter('MeterPosition')
	mtMD=SKIN:GetMeter('MeterDuration')
	iP=tonumber(SKIN:GetVariable('PlayerNow'))
	iPN=tonumber(SKIN:GetVariable('PlayerNum'))
	sM={'Title','Artist','Album'}
	msM={}
	mtM={}
	iC={}
	sMT={}
	sP={}
	sPP={}
	sPT={}
	for i=1,3 do
		msM[i]=SKIN:GetMeasure('Measure'..sM[i])
		mtM[i]=SKIN:GetMeter('Meter'..sM[i]..'Test')
	end
	for i=1,iPN do
		sP[i]=tostring(SKIN:GetVariable('Player'..i))
		sPP[i]=tostring(SKIN:GetVariable('PlayerPath'..i))
		sPT[i]=tostring(SKIN:GetVariable('PlayerTag'..i))
	end
	if iP>iPN then
		iP=1
		SKIN:Bang(bWKV,'Variables','PlayerNow',1,'#CUSFILE#')
	end
	if (tostring(SKIN:GetVariable('Player'))~=sP[iP])or(tostring(SKIN:GetVariable('PlayerPath'))~=sPP[iP]) then
		SKIN:Bang(bWKV,'Variables','Player',sP[iP],'#WMPFILE#')
		SKIN:Bang(bWKV,'Variables','PlayerPath',sPP[iP],'#WMPFILE#')
		SKIN:Bang(bRF)
	end
	SKIN:Bang(bSVG,'PlayerTag','sPT[iP]','NonePower')
	SKIN:Bang(bSO,'MeterTag','Text',sPT[iP])
	iCL=-1
	iMC=0
	iMP=0
	iMD=0
	iMM=0
	iTL=192
	iVP=100
end

function Update()
	if msMC:GetStringValue()=='' then
		iMC=0
	else
		iMC=1
	end
	if iCL~=iMC then
		iCL=iMC
		iMP=0
		iMD=0
		iTL=248-56*iCL
		SKIN:Bang(bSVG,'WMPTextL',iTL,'NonePower')
		for i=1,3 do
			sMT[i]=''
			SKIN:Bang(bSO,'Meter'..sM[i],'W',iTL)
		end
		SKIN:Bang(bMM,25+iTL,78,'MeterDuration')
	else
		for i=1,3 do
			if sMT[i]~=msM[i]:GetStringValue() then
				sMT[i]=msM[i]:GetStringValue()
				iC[i]=2
				SKIN:Bang(bSO,'Meter'..sM[i]..'Test','Text',sMT[i])
			end
			if iC[i]==1 then
				iC[i]=0
				if mtM[i]:GetW()<iTL then
					SKIN:Bang(bSVG,sM[i],'','NonePower')
				else
					SKIN:Bang(bSVG,sM[i],sMT[i],'NonePower')
				end
			elseif iC[i]==2 then
				iC[i]=1
			end
		end
		if (iMP~=mtMP:GetW())or(iMD~=mtMD:GetW()) then
			iMP=mtMP:GetW()
			iMD=mtMD:GetW()
			SKIN:Bang(bMM,26+iMP,83,'MeterProgressBar')
			SKIN:Bang(bSO,'MeterProgressBar','W',iTL-4-iMP-iMD)
		end
	end
	iMV=msMV:GetValue()
	if iMV>0 then
		iVP=iMV
	end
	if iMM==1 then
		SKIN:Bang(bSO,'MeterMute','ImageAlpha',255)
	else
		SKIN:Bang(bSO,'MeterMute','ImageAlpha',4+iMV*2)
	end
	if msMS:GetValue()==1 then
		SKIN:Bang(bSVG,'PlayerState','Pause','NonePower')
		SKIN:Bang(bSO,'MeterPP','ImageName','#@#Images\\Pause')
	else
		SKIN:Bang(bSVG,'PlayerState','Play','NonePower')
		SKIN:Bang(bSO,'MeterPP','ImageName','#@#Images\\Play')
	end
end

function MM()
	if iMV>0 then
		SKIN:Bang(bCM,'MeasureArtist','SetVolume 0')
	else
		SKIN:Bang(bCM,'MeasureArtist','SetVolume '..iVP)
	end
end

function MP()
	iP=iP%iPN+1
	SKIN:Bang(bWKV,'Variables','PlayerNow',iP,'#CUSFILE#')
	SKIN:Bang(bWKV,'Variables','Player',sP[iP],'#WMPFILE#')
	SKIN:Bang(bWKV,'Variables','PlayerPath',sPP[iP],'#WMPFILE#')
	SKIN:Bang(bSV,'PlayerTag',sPT[iP],'NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	SKIN:Bang(bSO,'MeasureArtist','PlayerName',sP[iP])
	SKIN:Bang(bSO,'MeasureArtist','PlayerPath',sPP[iP])
	SKIN:Bang(bSO,'MeterTag','Text',sPT[iP])
	SKIN:Bang(bU)
end