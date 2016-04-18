function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bRD='!Redraw'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bUMT='!UpdateMeter'
	bMM='!MoveMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bUMS='!UpdateMeasure'
	if tonumber(SKIN:GetVariable('Wireless'))==0 then
		SKIN:Bang(bHM,'MeterWiFi')
	end
	iMF=tonumber(SKIN:GetVariable('Forecast'))*6
	iMR=tonumber(SKIN:GetVariable('RSS'))*10
	iMW=tonumber(SKIN:GetVariable('WiFi'))*8
	SKIN:Bang(bSV,'MF',iMF)
	SKIN:Bang(bSV,'MR',iMR)
	SKIN:Bang(bSV,'MW',iMW)
	iGF=0
	iGR=0
	iGW=0
	iEF=1
	iER=1
	iEW=1
end

function Update()
	if iGF~=0 then
		UF()
		EF()
	end
	if iGR~=0 then
		UR()
		ER()
	end
	if iGW~=0 then
		UW()
		EW()
	end
end

function MF()
	if (iMF==0)or(iMF==6) then
		iGF=1-iMF/3
		iEF=0
		SKIN:Bang(bSO,'MeasureForecast','UpdateDivider',1)
		SKIN:Bang(bSO,'MeterForecast','UpdateDivider',1)
		SKIN:Bang(bUMS,'MeasureForecast')
		SKIN:Bang(bUMT,'MeterForecast')
	end
end

function MR()
	if (iMR==0)or(iMR==10) then
		iGR=1-iMR/5
		iER=0
		SKIN:Bang(bSO,'MeasureRSS','UpdateDivider',1)
		SKIN:Bang(bSO,'MeterRSS','UpdateDivider',1)
		SKIN:Bang(bUMS,'MeasureRSS')
		SKIN:Bang(bUMT,'MeterRSS')
	end
end

function MW()
	if (iMW==0)or(iMW==8) then
		iGW=1-iMW/4
		iEW=0
		SKIN:Bang(bSO,'MeasureWiFi','UpdateDivider',1)
		SKIN:Bang(bSO,'MeterWiFi','UpdateDivider',1)
		SKIN:Bang(bUMS,'MeasureWiFi')
		SKIN:Bang(bUMT,'MeterWiFi')
	end
end

function UF()
	iMF=iMF+iGF
	SKIN:Bang(bSV,'MF',iMF)
	if (iMF==3)and(iGF<0) then
		SKIN:Bang(bHMG,'Forecast','NERV UI\\Weather')
		SKIN:Bang(bRD,'NERV UI\\Weather')
	elseif iMF>3 then
		if (iMF==4)and(iGF>0) then
			SKIN:Bang(bSMG,'Forecast','NERV UI\\Weather')
		end
		for i=0,2 do
			SKIN:Bang(bSOG,'F'..i,'TransformationMatrix',-math.cos(iMF*math.pi/6)..';0;0;1;'..(37+i*55.5)*(1+math.cos(iMF*math.pi/6))..';0','NERV UI\\Weather')
			SKIN:Bang(bUMTG,'F'..i,'NERV UI\\Weather')
		end
		SKIN:Bang(bRD,'NERV UI\\Weather')
	end
end

function UR()
	iMR=iMR+iGR
	SKIN:Bang(bSV,'MR',iMR)
end

function UW()
	iMW=iMW+iGW
	SKIN:Bang(bSV,'MW',iMW)
	if (iMW==3)and(iGW<0) then
		SKIN:Bang(bHM,'MeterQualityBar5','NERV UI\\Net')
		SKIN:Bang(bRD,'NERV UI\\Net')
	elseif iMW>3 then
		if (iMW==4)and(iGW>0) then
			SKIN:Bang(bSM,'MeterQualityBar5','NERV UI\\Net')
		elseif (iMW==4)and(iGW<0) then
			SKIN:Bang(bHM,'MeterQualityBar4','NERV UI\\Net')
		else
			if (iMW==5)and(iGW>0) then
				SKIN:Bang(bSM,'MeterQualityBar4','NERV UI\\Net')
			elseif (iMW==5)and(iGW<0) then
				SKIN:Bang(bHM,'MeterQualityBar3','NERV UI\\Net')
			else
				if (iMW==6)and(iGW>0) then
					SKIN:Bang(bSM,'MeterQualityBar3','NERV UI\\Net')
				elseif (iMW==6)and(iGW<0) then
					SKIN:Bang(bHM,'MeterQualityBar2','NERV UI\\Net')
					SKIN:Bang(bHM,'MeterWiFiLabel','NERV UI\\Net')
					SKIN:Bang(bHM,'MeterEncryption','NERV UI\\Net')
				else
					if (iMW==7)and(iGW>0) then
						SKIN:Bang(bSM,'MeterQualityBar2','NERV UI\\Net')
						SKIN:Bang(bSM,'MeterWiFiLabel','NERV UI\\Net')
						SKIN:Bang(bSM,'MeterEncryption','NERV UI\\Net')
					elseif (iMW==7)and(iGW<0) then
						SKIN:Bang(bHM,'MeterQualityBar1','NERV UI\\Net')
						SKIN:Bang(bHM,'MeterSSID','NERV UI\\Net')
					else
						SKIN:Bang(bSM,'MeterQualityBar1','NERV UI\\Net')
						SKIN:Bang(bSM,'MeterSSID','NERV UI\\Net')
					end
					SKIN:Bang(bMM,59+iMW*74/8,67,'MeterQualityBar2','NERV UI\\Net')
					SKIN:Bang(bMM,74+iMW*74/8,36,'MeterWiFiLabel','NERV UI\\Net')
					SKIN:Bang(bMM,74+iMW*74/8,78,'MeterEncryption','NERV UI\\Net')
				end
				SKIN:Bang(bMM,69+iMW*74/8,61,'MeterQualityBar3','NERV UI\\Net')
			end
			SKIN:Bang(bMM,79+iMW*74/8,55,'MeterQualityBar4','NERV UI\\Net')
		end
		SKIN:Bang(bMM,89+iMW*74/8,49,'MeterQualityBar5','NERV UI\\Net')
		SKIN:Bang(bRD,'NERV UI\\Net')
	end
end

function EF()
	if (iEF==0)and(iMF==6) then
		iGF=0
		iEF=1
		SKIN:Bang(bWKV,'Variables','Forecast',1,'#CUSFILE#')
		SKIN:Bang(bSO,'MeasureForecast','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterForecast','UpdateDivider',50)
	elseif (iEF==0)and(iMF==0) then
		iGF=0
		iEF=1
		SKIN:Bang(bWKV,'Variables','Forecast',0,'#CUSFILE#')
		SKIN:Bang(bSO,'MeasureForecast','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterForecast','UpdateDivider',50)
	end
end

function ER()
	if (iER==0)and(iMR==10) then
		iGR=0
		iER=1
		SKIN:Bang(bWKV,'Variables','RSS',1,'#CUSFILE#')
		SKIN:Bang(bSO,'MeasureRSS','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterRSS','UpdateDivider',50)
	elseif (iER==0)and(iMR==0) then
		iGR=0
		iER=1
		SKIN:Bang(bWKV,'Variables','RSS',0,'#CUSFILE#')
		SKIN:Bang(bSO,'MeasureRSS','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterRSS','UpdateDivider',50)
	end
end

function EW()
	if (iEW==0)and(iMW==8) then
		iGW=0
		iEW=1
		SKIN:Bang(bWKV,'Variables','WiFi',1,'#CUSFILE#')
		SKIN:Bang(bSO,'MeasureWiFi','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterWiFi','UpdateDivider',50)
	elseif (iEW==0)and(iMW==0) then
		iGW=0
		iEW=1
		SKIN:Bang(bWKV,'Variables','WiFi',0,'#CUSFILE#')
		SKIN:Bang(bSO,'MeasureWiFi','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterWiFi','UpdateDivider',50)
	end
end