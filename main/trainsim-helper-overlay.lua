-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
-----------------  Overlay configuration  -----------------
-----------------------------------------------------------

function ConfigureOverlay()

   -- Define strings for warning messages. You can override them per loco.
   -- Or comment out / redefine to nil if you don't want specific one.
   -- NO SPACES IN THE STRINGS ALLOWED (will fix that later, use '_')
   TextAlarm =       "AWS"
   TextVigilAlarm =  "DSD"
   TextEmergency =   "Emergency"
   TextStartup =     "Engine"
   TextDoors =       "Doors"

   -- Set UK gradient format. Can be set per loco.
   --GradientUK = 1

   if DetectInterfaceGerman() then
      TextAlarm = "PZB"
      TextVigilAlarm = "Sifa"
   end

   if DetectInterfaceUK() then
      --GradientUK = 1
   end

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   -- Find ControlValues to display

   -- Units

   if Call("ControlExists", "SpeedometerMPH", 0) == 1 then
      tshStaticValues["Units"] = "M"
   elseif Call("ControlExists", "SpeedometerKPH", 0) == 1 then
      tshStaticValues["Units"] = "K"
   end

   -- Loco's controls

   if Call("ControlExists", "AFB_Speed", 0) == 1 then                -- New PZB
      tshControlValues["TargetSpeed"] = "AFB_Speed"
   elseif Call("ControlExists", "SpeedControlSpeed", 0) == 1 then    -- BR266
      tshControlValues["TargetSpeed"] = "SpeedControlSpeed"
   elseif Call("ControlExists", "AFBTargetSpeed", 0) == 1 then       -- BR442 Talent 2
      tshControlValues["TargetSpeed"] = "AFBTargetSpeed"
   elseif Call("ControlExists", "SpeedSet", 0) == 1 then             -- Class 90 AP
      tshControlValues["TargetSpeed"] = "SpeedSet"
   elseif Call("ControlExists", "CruiseControlSpeed", 0) == 1 then   -- Acela
      tshControlValues["TargetSpeed"] = "CruiseControlSpeed"
   elseif Call("ControlExists", "VSoll", 0) == 1 then                -- German
      tshControlValues["TargetSpeed"] = "VSoll"
   elseif Call("ControlExists", "SpeedTarget", 0) == 1 then          -- Class 365
      tshControlValues["TargetSpeed"] = "SpeedTarget"
   elseif Call("ControlExists", "TargetSpeed", 0) == 1 then          -- Class 375/377
      tshControlValues["TargetSpeed"] = "TargetSpeed"
   end

   if Call("ControlExists", "UserVirtualReverser", 0) == 1 then  -- BR155, UPGasTurbine
      tshControlValues["Reverser"] = "UserVirtualReverser"
   elseif Call("ControlExists", "Reverser", 0) == 1 then
      tshControlValues["Reverser"] = "Reverser"
   end

   if Call("ControlExists", "GearLever", 0) == 1 then
      tshControlValues["GearLever"] = "GearLever"
   end

   if Call("ControlExists", "PowerSelector", 0) == 1 then
      tshControlValues["Power"] = "PowerSelector"
   end

   -- Shamelessly use Joystick configuration, it should be adapted per loco already
   tshControlValues["CombinedThrottle"] = tshControl["CombinedThrottle"]
   tshControlValues["Throttle"]         = tshControl["Throttle"]
   tshControlValues["TrainBrake"]       = tshControl["TrainBrake"]
   tshControlValues["LocoBrake"]        = tshControl["LocoBrake"]
   tshControlValues["DynamicBrake"]     = tshControl["DynamicBrake"]
   tshControlValues["HandBrake"]        = tshControl["HandBrake"]

   -- Loco's indicators

   if Call("ControlExists", "BoilerPressureGaugePSI",0) == 1 then
      tshControlValues["BoilerPressure"] = "BoilerPressureGaugePSI"
   elseif Call("ControlExists", "BoilerPressureGauge", 0) == 1 then
      tshControlValues["BoilerPressure"] = "BoilerPressureGauge"
   end

   if Call("ControlExists", "BackPressure", 0) == 1 then  -- FEF-3
      tshControlValues["BackPressure"] = "BackPressure"
   end

   if Call("ControlExists", "RealSteamChestPressure", 0) == 1 then  -- Connie
      tshControlValues["SteamChestPressure"] = "RealSteamChestPressure"
   elseif Call("ControlExists", "VWSteamChestPressureGauge", 0) == 1 then  -- K1
      tshControlValues["SteamChestPressure"] = "VWSteamChestPressureGauge"
   elseif Call("ControlExists", "SteamChestGaugePSI", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestGaugePSI"
   elseif Call("ControlExists", "SteamChestGauge", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestGauge"
   elseif Call("ControlExists", "SteamChestPressureGaugePSI", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestPressureGaugePSI"
   elseif Call("ControlExists", "SteamChestPressureGauge", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestPressureGauge"
   end

   if Call("ControlExists", "VWSteamHeatingPressureGauge", 0) == 1 then  -- K1
      tshControlValues["SteamHeatingPressure"] = "VWSteamHeatingPressureGauge"
   elseif Call("ControlExists", "Steam Heat Gauge", 0) == 1 then  -- J50
      tshControlValues["SteamHeatingPressure"] = "Steam Heat Gauge"
   elseif Call("ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 then
      tshControlValues["SteamHeatingPressure"] = "SteamHeatingPressureGaugePSI"
   elseif Call("ControlExists", "SteamHeatGauge", 0) == 1 then
      tshControlValues["SteamHeatingPressure"] = "SteamHeatGauge"
   end

   if Call("ControlExists", "FrontSandBox", 0) == 1 then  -- 2F
      tshControlValues["Sandbox"] = "FrontSandBox"
   elseif Call("ControlExists", "SandLevel", 0) == 1 then  -- Q1
      tshControlValues["Sandbox"] = "SandLevel"
   end

   if Call("ControlExists", "RearSandBox", 0) == 1 then  -- 2F
      tshControlValues["SandboxRear"] = "RearSandBox"
   end

   if Call("ControlExists", "Voltage", 0) == 1 then  -- FEF-3
      tshControlValues["Voltage"] = "Voltage"
   end

   if Call("ControlExists", "VirtualRPM", 0) == 1 then  -- GT3
      tshControlValues["RPM"] = "VirtualRPM"
   elseif Call("ControlExists", "RPM", 0) == 1 then
      tshControlValues["RPM"] = "RPM"
   end

   if Call("ControlExists", "Ammeter", 0) == 1 then
      tshControlValues["Ammeter"] = "Ammeter"
   end

   -- Brake's indicators

   if Call("ControlExists", "VacuumTest", 0) == 1 then  -- 5700 Pannier DA
      tshControlValues["VacuumBrakePipePressure"] = "VacuumTest"
      tshStaticValues["VacuumBrakePipeUnits"] = "Inches"
   elseif Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 then
      tshControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressureINCHES"
      tshStaticValues["VacuumBrakePipeUnits"] = "Inches"
   elseif Call("ControlExists", "VacuumBrakePipePressureBAR", 0) == 1 then
      tshControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressureBAR"
      tshStaticValues["VacuumBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "VacuumBrakePipePressurePSI", 0) == 1 then
      tshControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressurePSI"
      tshStaticValues["VacuumBrakePipeUnits"] = "PSI"
   end

   -- Do not add VacuumBrakeChamberPressureINCHES here, it's mostly useless
   if Call("ControlExists", "VacuumChamberSide", 0) == 1 then  -- 5700 Pannier DA
      tshControlValues["VacuumBrakeChamberPressure"] = "VacuumChamberSide"
      tshStaticValues["VacuumBrakeChamberUnits"] = "Inches"
   elseif Call("ControlExists", "Vacuum Chamber Side", 0) == 1 then  -- J50
      tshControlValues["VacuumBrakeChamberPressure"] = "Vacuum Chamber Side"
      tshStaticValues["VacuumBrakeChamberUnits"] = "Inches"
   end

   if Call("ControlExists", "aTrainBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressureBAR"
      tshStaticValues["TrainBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "aTrainBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressurePSI"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "aTrainBrakeCylinderPressure", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressure"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressureBAR"
      tshStaticValues["TrainBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressurePSI"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "TrainBrakeCylinderPressure", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressure"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   end

   if Call("ControlExists", "MyLocoBrakeCylinderPressurePSI", 0) == 1 then  -- FEF-3
      tshControlValues["LocoBrakeCylinderPressure"] = "MyLocoBrakeCylinderPressurePSI"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
      tshUSAdvancedBrakes = true
   elseif Call("ControlExists", "LocoBrakeCylinderPressurePSIDisplayed", 0) == 1 then  -- US Advanced
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressurePSIDisplayed"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
      tshUSAdvancedBrakes = true
   elseif Call("ControlExists", "LocoBrakeCylinderPressurePSIAdvanced", 0) == 1 then  -- US Advanced
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressurePSIAdvanced"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
      tshUSAdvancedBrakes = true
   elseif Call("ControlExists", "BrakeCylinderDial1", 0) == 1 then  -- Class 50
      tshControlValues["TrainBrakeCylinderPressure"] = "BrakeCylinderDial1"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "LocoBrakeNeedle", 0) == 1 then  -- Duchess of Sutherland community patch
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeNeedle"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressureBAR"
      tshStaticValues["LocoBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressurePSI"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressure", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressure"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressureBAR"
      tshStaticValues["LocoBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressurePSI"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressure", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressure"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   end

   if Call("ControlExists", "AirBrakePipePressurePSIDisplayed", 0) == 1 then  -- US Advanced
      tshControlValues["AirBrakePipePressure"] = "AirBrakePipePressurePSIDisplayed"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aAirBrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aAirBrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "aBrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aBrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "aAirBrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aAirBrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aBrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aBrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aAirBrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aAirBrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aBrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aBrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "AirBrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "AirBrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "BrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "BrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "AirBrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "AirBrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "BrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "BrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "AirBrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "AirBrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "BrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "BrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   end

   if Call("ControlExists", "HLB", 0) == 1 then  -- vR103
      tshControlValues["MainReservoirPressure"] = "HLB"
      tshStaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "MRPSI", 0) == 1 then  -- FEF-3
      tshControlValues["MainReservoirPressure"] = "MRPSI"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "MainReservoirPressurePSIDisplayed", 0) == 1 then  -- US Advanced
      tshControlValues["MainReservoirPressure"] = "MainReservoirPressurePSIDisplayed"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aMainReservoirPressureBAR", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "aMainReservoirPressureBAR"
      tshStaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "aMainReservoirPressurePSI", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "aMainReservoirPressurePSI"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aMainReservoirPressure", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "aMainReservoirPressure"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "MainReservoirPressureBAR"
      tshStaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "MainReservoirPressurePSI", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "MainReservoirPressurePSI"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "MainReservoirPressure", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "MainReservoirPressure"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   end

   if Call("ControlExists", "MyEqReservoirPressurePSI", 0) == 1 then  -- FEF-3
      tshControlValues["EqReservoirPressure"] = "MyEqReservoirPressurePSI"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "EqReservoirPressurePSIAdvanced", 0) == 1 then  -- US Advanced
      tshControlValues["EqReservoirPressure"] = "EqReservoirPressurePSIAdvanced"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aEqReservoirPressureBAR", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "aEqReservoirPressureBAR"
      tshStaticValues["EqReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "aEqReservoirPressurePSI", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "aEqReservoirPressurePSI"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aEqReservoirPressure", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "aEqReservoirPressure"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "EqReservoirPressureBAR", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "EqReservoirPressureBAR"
      tshStaticValues["EqReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "EqReservoirPressurePSI", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "EqReservoirPressurePSI"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "EqReservoirPressure", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "EqReservoirPressure"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   end

   -- Steamers (driver)

   if Call("ControlExists", "BlowOffCockShutOffR", 0) == 1 then  -- FEF-3
      tshControlValues["BlowOffCockShutOffRight"] = "BlowOffCockShutOffR"
   end

   if Call("ControlExists", "Dynamo", 0) == 1 then  -- FEF-3
      tshControlValues["Dynamo"] = "Dynamo"
   elseif Call("ControlExists", "GeneratorThrottle", 0) == 1 then  -- Connie
      tshControlValues["Dynamo"] = "GeneratorThrottle"
   end

   if Call("ControlExists", "CompressorThrottle", 0) == 1 then  -- FEF-3
      tshControlValues["AirPump"] = "CompressorThrottle"
   elseif Call("ControlExists", "SteamShutOffL", 0) == 1 then  -- Q1
      tshControlValues["AirPump"] = "SteamShutOffL"
   elseif Call("ControlExists", "AirPumpOnOff", 0) == 1 then
      tshControlValues["AirPump"] = "AirPumpOnOff"
   end

   if Call("ControlExists", "SteamHeatShutOff", 0) == 1 then  -- Q1
      tshControlValues["SteamHeatingShutOff"] = "SteamHeatShutOff"
   end

   if Call("ControlExists", "Steam Heat Valve", 0) == 1 then  -- J50
      tshControlValues["SteamHeating"] = "Steam Heat Valve"
   elseif Call("ControlExists", "SteamHeatingValve", 0) == 1 then
      tshControlValues["SteamHeating"] = "SteamHeatingValve"
   elseif Call("ControlExists", "SteamHeat", 0) == 1 then
      tshControlValues["SteamHeating"] = "SteamHeat"
   end

   if Call("ControlExists", "MasonsValve", 0) == 1 then
      tshControlValues["MasonsValve"] = "MasonsValve"
   end

   if Call("ControlExists", "Steam Manifold", 0) == 1 then  -- 2F
      tshControlValues["SteamManifold"] = "Steam Manifold"
   end

   if Call("ControlExists", "LubricatorSteamThrottle", 0) == 1 then  -- Connie
      tshControlValues["LubricatorSteam"] = "LubricatorSteamThrottle"
   elseif Call("ControlExists", "LubricatorSteamValve", 0) == 1 then  -- 2F
      tshControlValues["LubricatorSteam"] = "LubricatorSteamValve"
   end

   if Call("ControlExists", "LubricatorMainValve", 0) == 1 then  -- Connie
      tshControlValues["LubricatorValve"] = "LubricatorMainValve"
   end

   if Call("ControlExists", "LubricatorOpenClose", 0) == 1 then  -- Connie
      tshControlValues["Lubricator"] = "LubricatorOpenClose"
   elseif Call("ControlExists", "LubricatorOilValve", 0) == 1 then  -- 2F
      tshControlValues["Lubricator"] = "LubricatorOilValve"
   elseif Call("ControlExists", "SteamShutOffR", 0) == 1 then  -- Q1
      tshControlValues["Lubricator"] = "SteamShutOffR"
   elseif Call("ControlExists", "Lubricator", 0) == 1 then
      tshControlValues["Lubricator"] = "Lubricator"
   end

   if Call("ControlExists", "LubricatorWarming", 0) == 1 then
      tshControlValues["LubricatorWarming"] = "LubricatorWarming"
   end

   tshControlValues["SmallEjector"] = tshControl["SmallEjector"]
   tshControlValues["LargeEjector"] = tshControl["LargeEjector"]

   if Call("ControlExists", "SteamBrakeHook", 0) == 1 then  -- 3F
      tshControlValues["BrakeHook"] = "SteamBrakeHook"
   end

   if Call("ControlExists", "SanderSteam", 0) == 1 then  -- Q1
      tshControlValues["SanderSteam"] = "SanderSteam"
   end

   if Call("ControlExists", "SanderLever", 0) == 1 then  -- Connie
      tshControlValues["Sander"] = "SanderLever"
   elseif Call("ControlExists", "FrontSander", 0) == 1 then  -- J50
      tshControlValues["Sander"] = "FrontSander"
   elseif Call("ControlExists", "VirtualSander", 0) == 1 then  -- 2F
      tshControlValues["Sander"] = "VirtualSander"
   elseif Call("ControlExists", "Sander", 0) == 1 then
      tshControlValues["Sander"] = "Sander"
   end

   if Call("ControlExists", "Sander2", 0) == 1 then  -- FEF-3
      tshControlValues["SanderRear"] = "Sander2"
   elseif Call("ControlExists", "RearSander", 0) == 1 then  -- J50
      tshControlValues["SanderRear"] = "RearSander"
   end

   if Call("ControlExists", "SandCaps", 0) == 1 then  -- Q1
      tshControlValues["SanderCaps"] = "SandCaps"
   end

   if Call("ControlExists", "SandFill", 0) == 1 then  -- Q1
      tshControlValues["SanderFill"] = "SandFill"
   end

   if Call("ControlExists", "AshpanSprinkler", 0) == 1 then
      tshControlValues["AshpanSprinkler"] = "AshpanSprinkler"
   end

   if Call("ControlExists", "CylinderCockMaster", 0) == 1 then  -- FEF-3
      tshControlValues["CylinderCockMaster"] = "CylinderCockMaster"
   end

   if Call("ControlExists", "CylinderCock", 0) == 1 then
      tshControlValues["CylinderCock"] = "CylinderCock"
   end

   if Call("ControlExists", "WaterScoop", 0) == 1 then
      tshControlValues["WaterScoop"] = "WaterScoop"
   elseif Call("ControlExists", "WaterScoopRaiseLower", 0) == 1 then  -- I think this one was never functional
      tshControlValues["WaterScoop"] = "WaterScoopRaiseLower"
   end

   -- Steamers (fireman)

   if Call("ControlExists", "BlowOffCockShutOffL", 0) == 1 then  -- FEF-3
      tshControlValues["BlowOffCockShutOffLeft"] = "BlowOffCockShutOffL"
   end

   if Call("ControlExists", "FWPumpShutOff", 0) == 1 then  -- FEF-3
      tshControlValues["FeedWaterPumpShutOff"] = "FWPumpShutOff"
   end

   if Call("ControlExists", "ControlValve", 0) == 1 then  -- FEF-3
      tshControlValues["ControlValve"] = "ControlValve"
   end

   if Call("ControlExists", "BlowerSteamThrottle", 0) == 1 then  -- Connie
      tshControlValues["BlowerSteam"] = "BlowerSteamThrottle"
   end

   if Call("ControlExists", "InjectorSteamThrottleL", 0) == 1 then  -- Connie
      tshControlValues["ExhaustInjectorShutOff"] = "InjectorSteamThrottleL"
   elseif Call("ControlExists", "Tender_WaterLeverR", 0) == 1 then  -- Q1
      tshControlValues["ExhaustInjectorShutOff"] = "Tender_WaterLeverR"
   end

   if Call("ControlExists", "InjectorSteamThrottleR", 0) == 1 then  -- Connie
      tshControlValues["LiveInjectorShutOff"] = "InjectorSteamThrottleR"
   elseif Call("ControlExists", "Tender_WaterLeverL", 0) == 1 then  -- Q1
      tshControlValues["LiveInjectorShutOff"] = "Tender_WaterLeverL"
   end

   if Call("ControlExists", "Tender_WaterShutOff", 0) == 1 then  -- Q1
      tshControlValues["TenderWaterShutOff"] = "Tender_WaterShutOff"
   end

   -- FireboxMass from the functions

   if Call("ControlExists", "AtomizerPressure", 0) == 1 then  -- FEF-3
      tshControlValues["AtomizerPressure"] = "AtomizerPressure"
   end

   if Call("ControlExists", "TankTemperature", 0) == 1 then  -- FEF-3
      tshControlValues["TankTemperature"] = "TankTemperature"
   end

   if Call("ControlExists", "FireboxDoor", 0) == 1 then
      tshControlValues["FireboxDoor"] = "FireboxDoor"
   end

   if Call("ControlExists", "Stoking", 0) == 1 then
      tshControlValues["Stoking"] = "Stoking"
   end

   if Call("ControlExists", "Firing", 0) == 1 then  -- FEF-3
      tshControlValues["OilRegulator"] = "Firing"
   end

   if Call("ControlExists", "Atomizer", 0) == 1 then  -- FEF-3
      tshControlValues["Atomizer"] = "Atomizer"
   end

   if Call("ControlExists", "TankHeater", 0) == 1 then  -- FEF-3
      tshControlValues["TankHeater"] = "TankHeater"
   end

   tshControlValues["Blower"] = tshControl["Blower"]

   if Call("ControlExists", "FiredoorDamper", 0) == 1 then  -- FEF-3
      tshControlValues["Damper"] = "FiredoorDamper"
   elseif Call("ControlExists", "VWDamper", 0) == 1 then  -- Small Prairies
      tshControlValues["Damper"] = "VWDamper"
   elseif Call("ControlExists", "Damper", 0) == 1 then
      tshControlValues["Damper"] = "Damper"
   end

   if Call("ControlExists", "DamperLeft", 0) == 1 then  -- J94
      tshControlValues["DamperLeft"] = "DamperLeft"
   end

   if Call("ControlExists", "DamperRight", 0) == 1 then  -- J94
      tshControlValues["DamperRight"] = "DamperRight"
   end

   if Call("ControlExists", "DamperFront", 0) == 1 then  -- Q1
      tshControlValues["DamperFront"] = "DamperFront"
   end

   if Call("ControlExists", "DamperRear", 0) == 1 then  -- Q1
      tshControlValues["DamperRear"] = "DamperRear"
   end

   if Call("ControlExists", "WaterGauge", 0) == 1 then
      tshControlValues["WaterGauge"] = "WaterGauge"
   end

   if Call("ControlExists", "FWHpressure", 0) == 1 then  -- FEF-3
      tshControlValues["FeedWaterPressure"] = "FWHpressure"
   end

   if Call("ControlExists", "FWPump", 0) == 1 then  -- FEF-3
      tshControlValues["FeedWaterPump"] = "FWPump"
   end

   if Call("ControlExists", "InjectorLeverL", 0) == 1 then  -- Connie
      tshControlValues["ExhaustInjectorSteam"] = "InjectorLeverL"
   elseif Call("ControlExists", "Left Steam", 0) == 1 then  -- 2F, 3F
      tshControlValues["ExhaustInjectorSteam"] = "Left Steam"
   elseif Call("ControlExists", "ExhaustInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      tshControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamLever"
   elseif Call("ControlExists", "ExhaustInjectorSteamOnOff", 0) == 1 then
      tshControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
   end

   if Call("ControlExists", "Left Water", 0) == 1 then  -- 2F, 3F
      tshControlValues["ExhaustInjectorWater"] = "Left Water"
   elseif Call("ControlExists", "ExhaustInjectorWaterLever", 0) == 1 then  -- 14xx
      tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWaterLever"
   elseif Call("ControlExists", "ExhaustInjectorWaterFineControl", 0) == 1 then  -- Q1
      tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWaterFineControl"
   elseif Call("ControlExists", "VirtualExhaustInjectorWater", 0) == 1 then  -- A2
      tshControlValues["ExhaustInjectorWater"] = "VirtualExhaustInjectorWater"
   elseif Call("ControlExists", "ExhaustInjectorWater", 0) == 1 then
      tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
   end

   if Call("ControlExists", "InjectorLeverR", 0) == 1 then  -- FEF-3, Connie
      tshControlValues["LiveInjectorSteam"] = "InjectorLeverR"
   elseif Call("ControlExists", "Right Steam", 0) == 1 then  -- 2F, 3F
      tshControlValues["LiveInjectorSteam"] = "Right Steam"
   elseif Call("ControlExists", "LiveInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      tshControlValues["LiveInjectorSteam"] = "LiveInjectorSteamLever"
   elseif Call("ControlExists", "LiveInjectorSteamOnOff", 0) == 1 then
      tshControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
   end

   if Call("ControlExists", "Right Water", 0) == 1 then  -- 2F
      tshControlValues["LiveInjectorWater"] = "Right Water"
   elseif Call("ControlExists", "LiveInjectorWaterLever", 0) == 1 then  -- 14xx
      tshControlValues["LiveInjectorWater"] = "LiveInjectorWaterLever"
   elseif Call("ControlExists", "LiveInjectorWaterFineControl", 0) == 1 then  -- Q1
      tshControlValues["LiveInjectorWater"] = "LiveInjectorWaterFineControl"
   elseif Call("ControlExists", "VirtualLiveInjectorWater", 0) == 1 then  -- A2
      tshControlValues["LiveInjectorWater"] = "VirtualLiveInjectorWater"
   elseif Call("ControlExists", "LiveInjectorWater", 0) == 1 then
      tshControlValues["LiveInjectorWater"] = "LiveInjectorWater"
   end

   if Call("ControlExists", "SafetyValveEngineer", 0) == 1 then  -- FEF-3
      tshControlValues["SafetyValve1"] = "SafetyValveEngineer"
   elseif Call("ControlExists", "SafetyValveVolume", 0) == 1 then  -- Connie
      tshControlValues["SafetyValve1"] = "SafetyValveVolume"
   elseif Call("ControlExists", "SafetyValve1", 0) == 1 then
      tshControlValues["SafetyValve1"] = "SafetyValve1"
   end

   if Call("ControlExists", "SafetyValveFireman", 0) == 1 then  -- FEF-3
      tshControlValues["SafetyValve2"] = "SafetyValveFireman"
   elseif Call("ControlExists", "SafetyValve2", 0) == 1 then
      tshControlValues["SafetyValve2"] = "SafetyValve2"
   end

   -- Warning values

   if Call("ControlExists", "AlerterCountdown", 0) == 1 then
      tshControlValues["Alarm"] = "AlerterCountdown"
   elseif Call("ControlExists", "AWSWarnCount", 0) == 1 then
      tshControlValues["Alarm"] = "AWSWarnCount"
   end

   if Call("ControlExists", "SifaWarnung", 0) == 1 then  -- BR420, BR103, BR111
      tshControlValues["VigilAlarm"] = "SifaWarnung"
   elseif Call("ControlExists", "SiFaWarning", 0) == 1 then  -- BR442
      tshControlValues["VigilAlarm"] = "SiFaWarning"
   elseif Call("ControlExists", "DSDAlarm", 0) == 1 then
      tshControlValues["VigilAlarm"] = "DSDAlarm"
   elseif Call("ControlExists", "VigilAlarm", 0) == 1 then
      tshControlValues["VigilAlarm"] = "VigilAlarm"
   elseif Call("ControlExists", "DSD", 0) == 1 then
      tshControlValues["VigilAlarm"] = "DSD"
   end

   if Call("ControlExists", "BrakeDemandLamp", 0) == 1 then  -- Class 37/4
      tshControlValues["EmergencyBrake"] = "BrakeDemandLamp"
   elseif Call("ControlExists", "EmergencyAlarm", 0) == 1 then
      tshControlValues["EmergencyBrake"] = "EmergencyAlarm"
   elseif Call("ControlExists", "EmergencyBrake", 0) == 1 then
      tshControlValues["EmergencyBrake"] = "EmergencyBrake"
   end

   if Call("ControlExists", "Startup", 0) == 1 then
      tshControlValues["Startup"] = "Startup"
   end

   -- Doors Values

   if Call("ControlExists", "DoorsOpenClose", 0) == 1 then
      tshDoorsValues["Doors"] = "DoorsOpenClose"
   end

   if Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 then
      tshDoorsValues["DoorsLeft"] = "DoorsOpenCloseLeft"
   end

   if Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 then
      tshDoorsValues["DoorsRight"] = "DoorsOpenCloseRight"
   end

   -- Do some common automagic, this way we don't need to do that per loco
   -- This section tries to autodetect several commonly used things
   -- based on the ControlValues detected above

   -- For SmokeBox brakes (FEF-3, Connie and US Advanced), TrainBrake pressures are internal
   if tshUSAdvancedBrakes then
      tshControlValues["TrainBrakeCylinderPressure"] = nil
      tshStaticValues["TrainBrakeCylinderUnits"] = nil
   end

   -- Rescale CombinedThrottle to (-1,1) if it's (0,1) or to (-x/y,1) if it's (-x,y)
   if tshControlValues["CombinedThrottle"] then
      tshRescaleCombinedThrottle = GetControlRange(tshControlValues["CombinedThrottle"])
      if not tshRescaleCombinedThrottle[1] then  -- Meaning it's (0,1)
         tshControlValuesFunctions["CombinedThrottle"] = function(value) return value * 2 - 1 end
      elseif tshRescaleCombinedThrottle[1] < 0 and tshRescaleCombinedThrottle[2] >= 2 then
         tshControlValuesFunctions["CombinedThrottle"] = function(value) return value / tshRescaleCombinedThrottle[2] end
      end
   end

   -- Rescale Throttle to (x,1)
   if tshControlValues["Throttle"] then
      tshRescaleThrottle = GetControlRange(tshControlValues["Throttle"])
      if tshRescaleThrottle[1] and tshRescaleThrottle[2] >= 2 then
         tshControlValuesFunctions["Throttle"] = function(value) return value / tshRescaleThrottle[2] end
      end
   end

   -- Disable regular damper if it's split (l/r or f/r)
   if tshControlValues["DamperLeft"] or tshControlValues["DamperRight"] or tshControlValues["DamperFront"] or tshControlValues["DamperRear"] then
      tshControlValues["Damper"] = nil
   end

   -- For CombinedThrottleSplit hide the other element
   if tshControlValues["TrainBrake"] == tshControlValues["CombinedThrottle"] then
      tshControlValues["TrainBrake"] = nil
   end
   if tshControlValues["DynamicBrake"] == tshControlValues["CombinedThrottle"] then
      tshControlValues["DynamicBrake"] = nil
   end   

   -- Override defaults for custom locos. Detect functions are in the main script.
   -- Sometimes I have to do this as a loco might have a control value that is
   -- detected but it should not be displayed. E.g. it's internal to the
   -- implementation or is basically useless for this loco.

   -- Steamers

   if DetectFEF3_ADV_Smokebox(true) or DetectFEF3_HUD_Smokebox(true) then
      -- Hide the internal values
      tshControlValues["SteamChestPressure"] = nil
      tshControlValues["FireboxDoor"] = nil
      tshControlValues["Stoking"] = nil
      tshControlValues["ExhaustInjectorSteam"] = nil
      tshControlValues["ExhaustInjectorWater"] = nil
      -- Fix the Sander
      tshControlValues["Sander"] = "Sander"
      -- Firebox is 0-5%, make it full range (0-100%)
      tshControlValuesFunctions["FireboxMass"] = function(value) return value * 20 end
      -- BackPressure needs to be converted
      tshControlValuesFunctions["BackPressure"] = function(value)
         value = value - 0.3
         if (value < 0) then value = value * 100 else value = value * 50 end
         return value
      end

   elseif DetectConnie_ADV_Smokebox(true) then
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value * 2 - 1 end
      -- BackPressure needs to be converted
      tshControlValuesFunctions["BackPressure"] = function(value)
         value = value - 0.3332
         if (value < 0) then value = value * 90 else value = value * 45 end
         return value
      end

   elseif DetectConnie_HUD_Smokebox(true) then
      -- BackPressure needs to be converted
      tshControlValuesFunctions["BackPressure"] = function(value)
         value = value - 0.3332
         if (value < 0) then value = value * 90 else value = value * 45 end
         return value
      end

   elseif Detect2FDockTank_ADV_MeshTools(true) then
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end

   elseif Detect3FJintyTrain_ADV_MeshTools(true) then
      -- Correct levers for steam (push/pull) brake
      tshControlValues["LocoBrake"] = "SteamBrakeSpindle"
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end

   elseif Detect3FJintySteam_ADV_MeshTools(true) then
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end
      -- It doesn't have vacuum brakes, hide
      tshControlValues["VacuumBrakePipePressure"] = nil
      tshStaticValues["VacuumBrakePipeUnits"] = nil

   elseif DetectBulleidQ1_VictoryWorks(true) then
      -- Make the sandbox {0,1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 900 end

      -- Uncomment all if you want to display simple water controls
      -- Keyboard controls those, advanced are controlled from the cab
      --tshControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
      --tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
      --tshControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
      --tshControlValues["LiveInjectorWater"] = "LiveInjectorWater"
      --tshControlValues["ExhaustInjectorShutOff"] = nil
      --tshControlValues["LiveInjectorShutOff"] = nil
      --tshControlValues["TenderWaterShutOff"] = nil

   elseif DetectGWRRailmotor_VictoryWorks(true) or DetectGWRRailmotorBoogie_VictoryWorks(true) then
      -- Not functional, hide
      tshControlValues["SmallEjector"] = nil

   -- UK

   elseif DetectClass365(true) then
      -- Make the CruiseCtl {0, 120}
      tshControlValuesFunctions["TargetSpeed"] = function(value) return value * 120 end

   -- German

   elseif DetectBR103TEE_vRailroads(true) then
      -- Not functional, hide
      tshControlValues["TargetSpeed"] = nil

   elseif DetectBR442Talent2(true) then
      -- Not functional, hide
      tshControlValues["LocoBrakeCylinderPressure"] = nil

   -- US


   end

   -- Set at the very end to be a mark whether the configuration has been successful.
   OverlayConfigured = 1
end

-----------------------------------------------------------
----------------  Main overlay function  ------------------
-----------------------------------------------------------

function GetOverlayData()
   local data = "" -- data storage for data to write to output file

   -- SIM values

   local Clock = SysCall("ScenarioManager:GetTimeOfDay")
   if Clock then data = data.."Clock: "..Clock.."\n" end

   local Speed = Call("GetSpeed")
   if Speed then data = data.."Speed: "..Speed.."\n" end

   local SpeedLimit = Call("GetCurrentSpeedLimit")
   if SpeedLimit then data = data.."SpeedLimit: "..SpeedLimit.."\n" end

   local NextSpeedLimitType, NextSpeedLimit, NextSpeedLimitDistance = Call("GetNextSpeedLimit", 0)
   if NextSpeedLimitType then data = data.."NextSpeedLimitType: "..NextSpeedLimitType.."\n" end
   if NextSpeedLimit then data = data.."NextSpeedLimit: "..NextSpeedLimit.."\n" end
   if NextSpeedLimitDistance then data = data.."NextSpeedLimitDistance: "..NextSpeedLimitDistance.."\n" end

   local NextSpeedLimitBackType, NextSpeedLimitBack, NextSpeedLimitBackDistance = Call("GetNextSpeedLimit", 1)
   if NextSpeedLimitBackType then data = data.."NextSpeedLimitBackType: "..NextSpeedLimitBackType.."\n" end
   if NextSpeedLimitBack then data = data.."NextSpeedLimitBack: "..NextSpeedLimitBack.."\n" end
   if NextSpeedLimitBackDistance then data = data.."NextSpeedLimitBackDistance: "..NextSpeedLimitBackDistance.."\n" end

   -- Overlay is not using this, it calculates its own that behaves a little bit better
   -- Leaving this exported though if someone is using it
   local Acceleration = Call("GetAcceleration")
   if Acceleration then data = data.."Acceleration: "..string.format("%.6f", Acceleration).."\n" end

   local Gradient = Call("GetGradient")
   if Gradient then data = data.."Gradient: "..Gradient.."\n" end

   local FireboxMass = Call("GetFireboxMass")
   if FireboxMass and tshControlValuesFunctions["FireboxMass"] then FireboxMass = tshControlValuesFunctions["FireboxMass"](FireboxMass) end
   if FireboxMass then data = data.."FireboxMass: "..FireboxMass.."\n" end

   -- Static Values loop
   for key, value in pairs(tshStaticValues) do
      data = data..key..": "..value.."\n"
   end

   -- Control Values loop
   for key, name in pairs(tshControlValues) do
      local value = Call("GetControlValue", name, 0)
      if tshControlValuesFunctions[key] then
         value = tshControlValuesFunctions[key](value)
      end
      data = data..key..": "..value.."\n"
   end

   -- Doors Values loop, doesn't matter which
   local doors = 0
   for key, name in pairs(tshDoorsValues) do
      local value = Call("GetControlValue", name, 0)
      if value ~= 0 then
         doors = value
         break
      end
   end
   data = data.."Doors: "..doors.."\n"

   -- Config values

   if TextAlarm then data = data.."TextAlarm: "..TextAlarm.."\n" end
   if TextVigilAlarm then data = data.."TextVigilAlarm: "..TextVigilAlarm.."\n" end
   if TextEmergency then data = data.."TextEmergency: "..TextEmergency.."\n" end
   if TextStartup then data = data.."TextStartup: "..TextStartup.."\n" end
   if TextDoors then data = data.."TextDoors: "..TextDoors.."\n" end
   if GradientUK then data = data.."GradientUK: "..GradientUK.."\n" end

   -- SimulationTime is used to show script is running as clock updates in real time
   local SimulationTime = Call("GetSimulationTime", 0)
   if SimulationTime then data = data.."SimulationTime: "..SimulationTime.."\n" end

   data = data.."\n"

   -- Write data to file
   WriteFile("trainsim-helper-overlay.txt", data)
end

-----------------------------------------------------------
------------  Detections used for Interface  --------------
-----------------------------------------------------------

function DetectInterfaceGerman(DisablePopup) -- Used for Warnings
   if Call("ControlExists", "AFB", 0) == 1 or
      Call("ControlExists", "AFBTargetSpeed", 0) == 1 or
      Call("ControlExists", "PZBFrei", 0) == 1
   then
      if not DisablePopup then DisplayPopup("German Interface") end
      return 1
   end
end

function DetectInterfaceUK(DisablePopup) -- MPH and BAR, should be UK, hopefully, used for Gradient
   if Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      (
         Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "aTrainBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "aLocoBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "AirBrakePipePressureBAR", 0) == 1 or
         Call("ControlExists", "aAirBrakePipePressureBAR", 0) == 1 or
         Call("ControlExists", "BrakePipePressureBAR", 0) == 1 or
         Call("ControlExists", "aBrakePipePressureBAR", 0) == 1
      )
   then
      if not DisablePopup then DisplayPopup("UK Interface") end
      return 1
   end
end

-----------------------------------------------------------
-------------------  Helper functions  --------------------
-----------------------------------------------------------
-----  Here be dragons, careful with modifications  -------
-----------------------------------------------------------

function WriteFile(name, data)
   local file = io.open("plugins/"..name, "w")
   file:write(data)
   file:flush()
   file:close()
end
