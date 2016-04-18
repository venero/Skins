function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bU='!Update'
	bUG='!UpdateGroup'
	bRD='!Redraw'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	bTMG='!ToggleMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bCM='!CommandMeasure'
	sP=tostring(SKIN:GetVariable('AC'))
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('AlphaTrans'..sP))/51),'FontColor','#*FontColor1*#')
	if tonumber(SKIN:GetVariable('NERV'..sP))==0 then
		SKIN:Bang(bTMG,'NERV')
	end
	if tonumber(SKIN:GetVariable('Wall'..sP))==0 then
		SKIN:Bang(bTMG,'Wall')
		AWON()
	else
		AWOFF()
	end
end

function CM()
	SKIN:Bang('[\"#@#RainRGB4.exe\" \"VarName=ColorMain'..sP..'\" \"FileName=#CUSFILE#\"]')
end

function CB()
	SKIN:Bang('[\"#@#RainRGB4.exe\" \"VarName=ColorBack'..sP..'\" \"FileName=#CUSFILE#\"]')
end

function LA(a)
	SKIN:Bang(bSO,'MeterAlpha'..(1+a/51),'FontColor','#*FontColor2*#,100')
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('Alpha'..sP))/51),'FontColor','#*FontColor1*#')
	SKIN:Bang(bU)
end

function MA(a)
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('Alpha'..sP))/51),'FontColor','#*FontColor2*#,100')
	SKIN:Bang(bWKV,'Variables','Alpha',a,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Alpha'..sP,a,'#CUSFILE#')
	SKIN:Bang(bWKV,'Variables','AlphaTrans'..sP,a,'#CUSFILE#')
	SKIN:Bang(bSVG,'Alpha',a,'Wall')
	SKIN:Bang(bUG,'Wall')
	SKIN:Bang(bUMTG,'Wall','NERV UI\\Ani')
	SKIN:Bang(bUMTG,'B','NERV UI\\Launcher')
	SKIN:Bang(bRD,'NERV UI\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Launcher')
	SKIN:Bang(bSV,'Alpha'..sP,a)
	SKIN:Bang(bSV,'AlphaTrans'..sP,a)
	SKIN:Bang(bSO,'MeterAlpha'..(1+a/51),'FontColor','#*FontColor2*#')
	SKIN:Bang(bU)
end

function MNON()
	SKIN:Bang(bWKV,'Variables','NERV'..sP,0,'#CUSFILE#')
	SKIN:Bang(bSVG,'NERV'..sP,0,'Wall')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Wall')
	SKIN:Bang(bRD,'NERV UI\\Wall')
	SKIN:Bang(bSM,'MeterNERVON')
	SKIN:Bang(bHM,'MeterNERVOFF')
	SKIN:Bang(bRD)
end

function MNOFF()
	SKIN:Bang(bWKV,'Variables','NERV'..sP,1,'#CUSFILE#')
	SKIN:Bang(bSVG,'NERV'..sP,1,'Wall')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Wall')
	SKIN:Bang(bRD,'NERV UI\\Wall')
	SKIN:Bang(bHM,'MeterNERVON')
	SKIN:Bang(bSM,'MeterNERVOFF')
	SKIN:Bang(bRD)
end

function MWON()
	SKIN:Bang(bWKV,'Variables','Alpha',255,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Wall'..sP,0,'#CUSFILE#')
	SKIN:Bang(bWKV,'Variables','Alpha'..sP,255,'#CUSFILE#')
	SKIN:Bang(bSVG,'Alpha',255,'Wall')
	SKIN:Bang(bSVG,'Wall'..sP,0,'Wall')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Wall')
	SKIN:Bang(bUG,'Wall')
	SKIN:Bang(bUMTG,'Wall','NERV UI\\Ani')
	SKIN:Bang(bUMTG,'B','NERV UI\\Launcher')
	SKIN:Bang(bRD,'NERV UI\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Launcher')
	SKIN:Bang(bSV,'Alpha'..sP,255)
	SKIN:Bang(bSM,'MeterWallON')
	SKIN:Bang(bHM,'MeterWallOFF')
	AWON()
	SKIN:Bang(bU)
end

function MWOFF()
	iAT=tonumber(SKIN:GetVariable('AlphaTrans'..sP))
	SKIN:Bang(bWKV,'Variables','Alpha',iAT,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Wall'..sP,1,'#CUSFILE#')
	SKIN:Bang(bWKV,'Variables','Alpha'..sP,iAT,'#CUSFILE#')
	SKIN:Bang(bSVG,'Alpha',iAT,'Wall')
	SKIN:Bang(bSVG,'Wall'..sP,1,'Wall')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Wall')
	SKIN:Bang(bUG,'Wall')
	SKIN:Bang(bUMTG,'Wall','NERV UI\\Ani')
	SKIN:Bang(bUMTG,'B','NERV UI\\Launcher')
	SKIN:Bang(bRD,'NERV UI\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Launcher')
	SKIN:Bang(bSV,'Alpha'..sP,iAT)
	SKIN:Bang(bHM,'MeterWallON')
	SKIN:Bang(bSM,'MeterWallOFF')
	AWOFF()
	SKIN:Bang(bU)
end

function AWON()
	SKIN:Bang(bSO,'MeterAlphaLabel','FontColor','#*FontColor2*#,100')
	for i=1,6 do
		SKIN:Bang(bSO,'MeterAlpha'..i,'FontColor','#*FontColor2*#,100')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseOverAction','')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseLeaveAction','')
		SKIN:Bang(bSO,'MeterAlpha'..i,'LeftMouseUpAction','')
	end
end

function AWOFF()
	SKIN:Bang(bSO,'MeterAlphaLabel','FontColor','#*FontColor1*#')
	for i=1,6 do
		SKIN:Bang(bSO,'MeterAlpha'..i,'FontColor','#*FontColor2*#,100')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseOverAction','['..bSO..' #*CURRENTSECTION*# FontColor #*FontColor2*#]['..bU..']')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseLeaveAction',bCM..' MeasureScript LA('..((i-1)*51)..')')
		SKIN:Bang(bSO,'MeterAlpha'..i,'LeftMouseUpAction',bCM..' MeasureScript MA('..((i-1)*51)..')')
	end
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('Alpha'..sP))/51),'FontColor','#*FontColor1*#')
end