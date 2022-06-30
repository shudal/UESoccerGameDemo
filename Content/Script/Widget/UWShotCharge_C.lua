--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

require "UnLua"
require "Utility.MyLuaFunc_C"

---@class UWShotCharge_C : BP_UW_ShotCharge
local UWShotCharge_C = Class()

--function UWShotCharge_C:Initialize(Initializer)
--end

--function UWShotCharge_C:PreConstruct(IsDesignTime)
--end

function UWShotCharge_C:ConstructInLua()
    self.MIShotCharge:SetScalarParameterValue("percent",0.6)

end

--function UWShotCharge_C:Tick(MyGeometry, InDeltaTime)
--end

return UWShotCharge_C
