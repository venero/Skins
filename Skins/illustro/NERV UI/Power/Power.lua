function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bU='!Update'
	bCM='!CommandMeasure'
	msMAC=SKIN:GetMeasure('MeasureAC')
	msMC=SKIN:GetMeasure('MeasureCPU')
	sP=tostring(SKIN:GetVariable('AC'))
	sA={'B','W'}
	sC={'ON','OFF'}
	sB={'B','TC'}
	sT={'T','Life','Percent'}
	sO={'ImageTint','FontColor','FontColor'}
	iP=-1
	iW=-1
	iC=0
end

function Update()
	iMC=msMC:GetValue()
	if iC==0 then
		iC=1
		SKIN:Bang(bSO,'MeterB1','ImageName','#@#Images\\B'..sP..'1')
		SKIN:Bang(bSO,'MeterB2','ImageName','#@#Images\\B'..sP..'2')
		if (tonumber(SKIN:GetVariable('Wall'..sP))==0) then
			if sP=='B' then
				T00()
			else
				T01()
			end
			for i=1,2 do
				SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor3*#')
				SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,51')
			end
		else
			if sP=='B' then
				T10()
			else
				T11()
			end
			for i=1,2 do
				SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor1*#')
				SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,#*Alpha*#')
			end
		end
	else
		if iP~=msMAC:GetValue() then
			iP=msMAC:GetValue()
			P(iP+1)
		end
		if iW~=tonumber(SKIN:GetVariable('Wall'..sA[iP+1])) then
			iW=tonumber(SKIN:GetVariable('Wall'..sA[iP+1]))
			W(iW)
		end
	end
	SKIN:Bang(bSO,'MeterTC1','ImageName','#@#Images\\TT'..math.ceil(iMC/25))
	SKIN:Bang(bSO,'MeterTC2','ImageName','#@#Images\\TB'..math.ceil(iMC/25))
end

function P(p)
	SKIN:Bang(bWKV,'Variables','AC',sA[p],'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','FontColor1','#ColorMain'..sA[p]..'#,204','#VARFILE#')
	SKIN:Bang(bWKV,'Variables','FontColor2','#ColorMain'..sA[p]..'#','#VARFILE#')
	SKIN:Bang(bWKV,'Variables','FontColor3','#ColorBack'..sA[p]..'#','#VARFILE#')
	SKIN:Bang(bSVG,'FontColor1','#ColorMain'..sA[p]..'#,204','NonePower')
	SKIN:Bang(bSVG,'FontColor2','#ColorMain'..sA[p]..'#','NonePower')
	SKIN:Bang(bSVG,'FontColor3','#ColorBack'..sA[p]..'#','NonePower')
	SKIN:Bang(bSV,'FontColor1','#ColorMain'..sA[p]..'#,204')
	SKIN:Bang(bSV,'FontColor2','#ColorMain'..sA[p]..'#')
	SKIN:Bang(bSV,'FontColor3','#ColorBack'..sA[p]..'#')
	SKIN:Bang(bSO,'MeterB1','ImageName','#@#Images\\B'..sA[p]..'1')
	SKIN:Bang(bSO,'MeterB2','ImageName','#@#Images\\B'..sA[p]..'2')
	SKIN:Bang(bCM,'MeasureScript','sP=\''..sA[p]..'\';P()','NERV UI\\Wall')
	SKIN:Bang(bCM,'MeasureScript','sP=\''..sA[p]..'\';MN'..sC[tonumber(SKIN:GetVariable('NERV'..sA[p]))+1]..'();MW'..sC[tonumber(SKIN:GetVariable('Wall'..sA[p]))+1]..'()','NERV UI\\Settings')
	if (tonumber(SKIN:GetVariable('Wall'..sA[p]))==0) then
		if p==1 then
			T00()
		else
			T01()
		end
	else
		if p==1 then
			T10()
		else
			T11()
		end
	end
end

function W(w)
	if w==0 then
		if iP==0 then
			T00()
		else
			T01()
		end
		for i=1,2 do
			SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor3*#')
			SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,51')
		end
	else
		if iP==0 then
			T10()
		else
			T11()
		end
		for i=1,2 do
			SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor1*#')
			SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,#*Alpha*#')
		end
	end
end

function T00()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i]..'1',sO[i],'0,0,0,0')
		SKIN:Bang(bSO,'Meter'..sT[i]..'2',sO[i],'#*FontColor3*#')
	end
end

function T01()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i]..'1',sO[i],'0,0,0,0')
		SKIN:Bang(bSO,'Meter'..sT[i]..'2',sO[i],'#*FontColor3*#,51')
	end
end

function T10()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i]..'1',sO[i],'#*FontColor2*#,204')
		SKIN:Bang(bSO,'Meter'..sT[i]..'2',sO[i],'#*FontColor3*#,#*Alpha*#')
	end
end

function T11()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i]..'1',sO[i],'0,0,0,0')
		SKIN:Bang(bSO,'Meter'..sT[i]..'2',sO[i],'#*FontColor3*#,#*Alpha*#')
	end
end