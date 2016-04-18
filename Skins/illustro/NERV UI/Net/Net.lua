function Initialize()
	bWKV='!WriteKeyValue'
	bSVG='!SetVariableGroup'
	bHM='!HideMeter'
	SKIN:Bang(bWKV,'Variables','Wireless',0,'#CUSFILE#')
	SKIN:Bang(bSVG,'Wireless',0,'NonePower')
	SKIN:Bang(bHM,'MeterWiFi','NERV UI\\Ani')
end