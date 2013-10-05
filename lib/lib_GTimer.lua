
--
-- lib_GTimer
--	by: Granite
--
--	Calls a function with a formatted text timer at intervals as needed for updates
		

--[[ INTERFACE
	GTIMER = GTimer.Create(Func,Format_String,Scale)   ---creates a GTimer entity
			originally intended to create a timer running in a UI text widget
			ex. TIMER = GTimer.Create(function(TextTime) TEXTWIDGET:SetText(TextTime) end,Format_String,Scale)
			Func allows alternative parsing or other periodic uses
			only works for positive time counter values  (reformat and run backwards if needed)
			
	GTIMER:SetFormat(Format_String)   --------------------defines output format     ex. "%02iq3600p:%02iq60p:%02iq1p.%02iq0.01p" => HH:MM:SS.ss clock
			multipliers between q and p ---> "q(%d.-)p" ---> any values 1>x>0 must include 0 before decimal point
			numbers are formated with string.format using standard code preceding each multiplier group
			other characters remain in output string as separators etc
				
	GTIMER:SetScale(Scale)   -----------------------------defines time scale (1 = 1 second per tick) (-2 counts down double normal speed) 
	
	GTIMER:StartTimer([Initial_Time], [Scale])   ---------starts the timer at Initial_Time with [Scale]
	
	GTIMER:SetTime(Intial_Time)   ------------------------sets and displays start time on the counter (no effect if timer is running)
	
	GTIMER:SetAlarm(Name, AlarmTime, AFunc, [args])   ----set AFunc(args) to be called when timer passes AlarmTime
	
	GTIMER:KillAlarm(Name)   -----------------------------remove an alarm
	
	GTIMER:StopTimer()   ---------------------------------stop a running timer
															can resume with GTIMER:StartTimer()
															
	GTIMER:Destroy()   -----------------------------------removes a GTimer entity
	
	GTIMER:GetTime()   -----------------------------------returns the value of the internal counter (usually time in seconds)
	
	GTIMER:IsRunning()   ---------------------------------returns "true" if the timer is currently running
	
	GTIMER:ShowTimer([show = false])   -------------------activates output string to Func unless false
	
	GTIMER:HideTimer([hide = false])   -------------------cancels output string to Func unless false (timer continues running in background) 
	
--]]
if GTimer then
	-- only include once
	return;
end

--require "lib/lib_Liaison"
require "lib/lib_Callback2"
--require "lib/lib_EventDispatcher"

GTimer = {};	-- external interface

-- constants
local COMP_ID = Component.GetInfo();
local minCB = 0.01
local PRIVATE = {};
local GTIMER_API = {};
local o_GTIMERS = {};
--local CB2FIX = Callback2.Create()
--CB2FIX:Bind(function() end)


-------------------
-- GTimer API --
-------------------

function GTimer.Create(Func,FormatString,Scale,Id)         --Id?
	local GTIMER = {
		Func = Func,
		CurrentTime = 0,
		InitialTime = 0,
		StartTime = 0,
		Format = nil,
		Scale = 1,
		Data = {},
		Alarm = {},
		Show=true,
		Running=false
		}
	-- method binding
	for k,v in pairs(GTIMER_API) do
		GTIMER[k] = v;
	end
	
	GTIMER:SetScale(Scale)
	GTIMER:SetFormat(FormatString)
	return GTIMER;
end



------------------
-- GTIMER API --
------------------

function GTIMER_API.Destroy(GTIMER)
	GTIMER:StopTimer()
		
	-- gut it
	for _,Alarm in pairs(GTIMER.Alarm) do
		GTIMER:KillAlarm(Alarm.Name)
	end
	for k,v in pairs(GTIMER) do
		GTIMER[k] = nil;
	end
end

function GTIMER_API.SetFormat(GTIMER, FormatString)
	local Data = {}
	local i = 0
	if (not FormatString) or (FormatString == "") then
		FormatString = "%iq1p"  --integer seconds if nothing better
	end
	GTIMER.Format = FormatString:gsub("q(%d.-)p", function(m) 
														i=i+1 
														Data[i]={index=i, mult=m+0} 
														return ""
													end)
	table.sort(Data, function(a,b) return a.mult>b.mult end)    
	GTIMER.Data = Data
	if GTIMER.Show and GTIMER.Running then
		cancel_callback(GTIMER.Running)
		GTIMER.Running = callback(RunTimer, GTIMER, minCB)
	end
end

function GTIMER_API.SetScale(GTIMER, Scale)
	if Scale and Scale ~= 0 then GTIMER.Scale = Scale end
end

function GTIMER_API.StartTimer(GTIMER, InitialTime, Scale)
	if GTIMER:IsRunning() then
		--warn("attempt to start gtimer while still running-->STOPPING")
		GTIMER:StopTimer()
	end
	GTIMER.StartTime = System.GetClientTime()
	GTIMER.InitialTime = math.max(InitialTime or GTIMER.InitialTime, 0)
	GTIMER:SetScale(Scale)
	--if Callback2.CountCallbacks(true) == 0 then log("CB2FIXing") CB2FIX:Schedule(1) end	--CB2 fix, if first CB2>3600 then error, so this loads a safe one
	for _,Alarm in pairs(GTIMER.Alarm) do
		local CbTime = (Alarm.Time-GTIMER.InitialTime)/GTIMER.Scale
		--if CbTime >= minCB then Alarm.CB:Schedule(CbTime) end
		if CbTime > 0 then Alarm.CB:Schedule(CbTime) end    --release version 2.3 had >=. now changed to >
	end
	if GTIMER.Show then
		GTIMER.Running = callback(RunTimer, GTIMER, minCB);
	else
		GTIMER.Running = true
	end	
end

function GTIMER_API.SetTime(GTIMER, InitialTime)
	if not GTIMER:IsRunning() then
		GTIMER.InitialTime = math.max(InitialTime, 0)
		GTIMER.CurrentTime = GTIMER.InitialTime
		if GTIMER.Show then
			ShowTime(GTIMER)
		end
	end
end

function GTIMER_API.SetAlarm(GTIMER, Name, AlarmTime, Func, ...)
	if GTIMER.Alarm[Name] then GTIMER:KillAlarm(Name) end
	GTIMER.Alarm[Name] = {Time = AlarmTime, CB = Callback2.Create()}
	GTIMER.Alarm[Name].CB:Bind(Func, unpack(arg))
	if GTIMER:IsRunning() then GTIMER:StopTimer() GTIMER:StartTimer() end
end

function GTIMER_API.KillAlarm(GTIMER, Name)
	if GTIMER.Alarm[Name] then
		GTIMER.Alarm[Name].CB:Release()
		GTIMER.Alarm[Name] = nil
	end
	if GTIMER:IsRunning() then GTIMER:StopTimer() GTIMER:StartTimer() end
end

function GTIMER_API.StopTimer(GTIMER)
	if GTIMER:IsRunning() then
		ProcTime(GTIMER)
		for _,Alarm in pairs(GTIMER.Alarm) do
			Alarm.CB:Pause()
		end
		if GTIMER.Show then	
			cancel_callback(GTIMER.Running)
			ShowTime(GTIMER)
		end
		GTIMER.Running = false;
		GTIMER.InitialTime = GTIMER.CurrentTime
	end
end

function GTIMER_API.GetTime(GTIMER)
	if GTIMER:IsRunning() then ProcTime(GTIMER) end
	return GTIMER.CurrentTime
end

function GTIMER_API.IsRunning(GTIMER)
	return GTIMER.Running
end

function GTIMER_API.ShowTimer(GTIMER,show)
	if show == false then
		GTIMER:HideTimer()
	else
		if not GTIMER.Show then
			GTIMER.Show = true
			if GTIMER:IsRunning() then
				GTIMER.Running = callback(RunTimer, GTIMER, minCB);
			else
				ShowTime(GTIMER)
			end
		end
	end
end

function GTIMER_API.HideTimer(GTIMER,hide)
	if hide == false then
		GTIMER:ShowTimer()
	else
		if GTIMER.Show then
			GTIMER.Show = false
			if GTIMER:IsRunning() then
				cancel_callback(GTIMER.Running);
				GTIMER.Running = true
			end
		end
	end
end


--------------------
-- MISC FUNCTIONS --
--------------------

function RunTimer(GTIMER)
	local Time = ProcTime(GTIMER)
	local Next = ShowTime(GTIMER)
	if Time == 0 then
		GTIMER:StopTimer()
	else
		if GTIMER.Scale > 0 then
			Next = math.min(3600,(GTIMER.Data[#GTIMER.Data].mult-Next)/GTIMER.Scale+minCB)
		else
			Next = math.min(3600,(-Next)/GTIMER.Scale+minCB)
		end
		GTIMER.Running = callback(RunTimer, GTIMER, Next)
	end
end

function ProcTime(GTIMER)
	local Time=math.max(GTIMER.InitialTime + System.GetElapsedTime(GTIMER.StartTime)*GTIMER.Scale,0)
	GTIMER.CurrentTime = Time
	return Time
end

function ShowTime(GTIMER)
	local Value  = GTIMER.CurrentTime
	local Result={}
	for _,data in ipairs(GTIMER.Data) do
		Result[data.index],Value = math.modf(Value/data.mult)
		Value=Value*data.mult
	end
	GTIMER.Func(GTIMER.Format:format(unpack(Result)))
	return Value            
end