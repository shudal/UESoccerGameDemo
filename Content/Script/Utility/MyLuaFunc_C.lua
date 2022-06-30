
_G.MyLuaFunc_C = Class()

function MyLuaFunc_C:SetDefaultCtxObj(ctxObj)
    self.defCtxObj = ctxObj
end

function MyLuaFunc_C:GetMyPlayerController()
    UE.UGameplayStatics.GetPlayerController(self.defCtxObj,self:GetMyPlayerIdx())
end

function MyLuaFunc_C:GetMyPlayerIdx()
    return 0
end

function MyLuaFunc_C:GetPlayerCharacter()
    return UE.UGameplayStatics.GetPlayerCharacter(self.defCtxObj,0)
end