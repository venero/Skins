function Initialize()
	bSO='!SetOption'
	bUMT='!UpdateMeter'
	bCM='!CommandMeasure'
	msMP={}
	iMP={}
	for i=1,12 do
		msMP[i]=SKIN:GetMeasure('MeasureProcess'..i)
		iMP[i]=0
	end
	SKIN:Bang(bCM,'MeasureScript','iPO=1','NERV UI\\Launcher')
end

function Update()
	for i=1,12 do
		if iMP[i]~=msMP[i]:GetValue() then
			iMP[i]=msMP[i]:GetValue()
			if iMP[i]==1 then
				SKIN:Bang(bSO,'MeterP'..i,'ImageName','#@#Images\\On','NERV UI\\Launcher')
			else
				SKIN:Bang(bSO,'MeterP'..i,'ImageName','','NERV UI\\Launcher')
			end
			SKIN:Bang(bUMT,'MeterP'..i,'NERV UI\\Launcher')
		end
	end
end