--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

require "UnLua"
require "Utility.MyLuaFunc_C"

---@class GameplayMgr_C : BP_SoccerGameMgr
local GameplayMgr_C = Class()

--function GameplayMgr_C:Initialize(Initializer)
--end

--function GameplayMgr_C:UserConstructionScript()
--end

function GameplayMgr_C:ReceiveBeginPlay()  
    self.uwShotCharge = NewObject(self.clsUWShotCharge,self)  
    MyLuaFunc_C:SetDefaultCtxObj(self)
    self.uwShotCharge:SetOwningPlayer(MyLuaFunc_C:GetMyPlayerController()) 
    self.uwShotCharge:AddToViewPort()
end

--function GameplayMgr_C:ReceiveEndPlay()
--end

-- function GameplayMgr_C:ReceiveTick(DeltaSeconds)
-- end

--function GameplayMgr_C:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
--end

--function GameplayMgr_C:ReceiveActorBeginOverlap(OtherActor)
--end

--function GameplayMgr_C:ReceiveActorEndOverlap(OtherActor)
--end

return GameplayMgr_C
