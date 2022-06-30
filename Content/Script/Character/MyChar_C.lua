--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--
require "UnLua" 
require "Utility.MyDelegate_C"

---@class MyChar_C : TopDownCharacter
local MyChar_C = Class()

function MyChar_C:Initialize(Initializer)
    self.disCanKick = 300
    self.timeShotPressed = 0
    self.timeShotReleased = 0
    self.KICK_STREANGTH_SHOT_MIH = 1200
    self.KICK_STREANGTH_SHOT_MAX = 2500
    self.bLastKickIsShot = false

    self.delShotChargeStart = MyDelegate_C:New()
    self.delShotChargetEnd = MyDelegate_C:New()
end

-- function MyChar_C:UserConstructionScript()
-- end

function MyChar_C:ReceiveBeginPlay()
    print("hhhhhhhhh")
    self.MICharDir = UE.UKismetMaterialLibrary.CreateDynamicMaterialInstance(
                         self, self.SMCCharDir:GetMaterial(0))
    self.SMCCharDir:SetMaterial(0, self.MICharDir)
end

-- function MyChar_C:ReceiveEndPlay()
-- end

function MyChar_C:ReceiveTick(DeltaSeconds)
    self:tickKick()
    self.SMCCharDir:K2_SetWorldRotation(UE.UKismetMathLibrary.MakeRotator(0, 0,
                                                                          0),
                                        false, UE.FHitResult(), false)

end

-- function MyChar_C:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
-- end

-- function MyChar_C:ReceiveActorBeginOverlap(OtherActor)
-- end

-- function MyChar_C:ReceiveActorEndOverlap(OtherActor)
-- end

function MyChar_C:MoveForward(v)
    self.AxisValueY = v
    self:MoveForwardAndRight()
end

function MyChar_C:MoveRight(v)
    self.AxisValueX = v
    self:MoveForwardAndRight()
end

function MyChar_C:MoveForwardAndRight()
    -- print("kkkkkkkkkkkk")
    self.vecMove = UE.UKismetMathLibrary.MakeVector(self.AxisValueY,
                                                    self.AxisValueX, 0)
    UE.UKismetMathLibrary.Vector_Normalize(self.vecMove, 0.0001)

    local c = UE.FLinearColor()
    c.R = self.vecMove.X
    c.G = self.vecMove.Y
    c.B = self.vecMove.Z
    c.A = 0
    self.MICharDir:SetVectorParameterValue("ParamDir", c)
    self:Move()

end

function MyChar_C:ReleaseBallFunc()
    self.bHavingSoccer = false 
end

function MyChar_C:ReleaseBall_Pressed()
    self:ReleaseBallFunc()
end

function MyChar_C:SoccerTouched(S)
    if (self.bHavingSoccer == false) then
        self.bHavingSoccer = true
        self.mSoccer = S

        local rot = UE.UKismetMathLibrary.FindLookAtRotation(
                        self:K2_GetActorLocation(),
                        self.mSoccer:K2_GetActorLocation())
        self:K2_SetActorRotation(UE.UKismetMathLibrary
                                     .MakeRotator(0, 0, rot.Yaw), false)
    end
end
function math.clamp(v, minValue, maxValue)  
    if v < minValue then
        return minValue
    end
    if( v > maxValue) then
        return maxValue
    end
    return v 
end 
function MyChar_C:GetShotStrengthAccordingToTime(timeShotReleased,timeShotPressed)
    local x= timeShotReleased - timeShotPressed
    x = x / 3
    x = math.clamp(x,0,1)
    --print(x)
    local ans = self.KICK_STREANGTH_SHOT_MIH + x * (self.KICK_STREANGTH_SHOT_MAX - self.KICK_STREANGTH_SHOT_MIH)
    return ans
end
function MyChar_C:tickKick()
    local nowtime = UE.UGameplayStatics.GetTimeSeconds(self)
    if (self.lastKickEverKick == false) then
        if (UE.UKismetMathLibrary.VSize(self.vecMove) > 0.001) then
            if (nowtime - self.lastKickTime > (5 / 30)) then
                self.lastKickEverKick = true
    
                self:K2_SetActorRotation(UE.UKismetMathLibrary.MakeRotFromX(
                                             self.vecMove), false)
                self:AddMovementInput(self.vecMove, 1, false)
    
                if (UE.UKismetMathLibrary.Dot_VectorVector(
                    self.mSoccer:GetVelocity(), self.vecMove) > 0) then
                    self.kickStrength = self.kickStrengthSmall
                else
                    self.kickStrength = self.kickStrengthBig
                end
                --   print("12")
                if (nowtime - self.timeShotReleased < 0.5) then
                    local x = self:GetShotStrengthAccordingToTime(self.timeShotReleased, self.timeShotPressed) 
                    self.kickStrength = x
                    self.bLastKickIsShot = true
                else
                    self.bLastKickIsShot = false
                end
                UE.UPrimitiveComponent.AddImpulse(self.mSoccer.SMCSoccer,
                                                  self:GetActorForwardVector() *
                                                      self.kickStrength, "None",
                                                  true)
                UE.UGameplayStatics.PlaySound2D(self, self.SoundKick)
            else
                local x = (nowtime - self.lastKickTime) / (5 / 30)
                --print("14")
                local y = x * x * (3 - 2 * x)
                --print(y)
                -- print("13")
                -- print(self.oriCharDir)
                --print(self.vecMove)
                -- print("(self.vecMove-self.oriCharDir):")
                --    print((self.vecMove-self.oriCharDir))
                -- print(y * (self.vecMove-self.oriCharDir))
                local nowforward = self.oriCharDir +
                                       UE.UKismetMathLibrary
                                           .Multiply_VectorFloat(
                                           self.vecMove - self.oriCharDir, y)
                -- print("1")
                self:K2_SetActorRotation(UE.UKismetMathLibrary.MakeRotFromX(
                                             self.vecMove +
                                                 self:GetActorForwardVector()),
                                         false)
    
                -- print("15")
            end
        else
            self.lastKickEverKick = true
        end

        
    end
end

function MyChar_C:SetVarValueRelatedToSoccerAndChar()
    local locself = self:K2_GetActorLocation()
    -- print(self.mSoccer.SMCSoccer)
    local locball = self.mSoccer.SMCSoccer:K2_GetComponentLocation()
    self.vecBallToChar = UE.UKismetMathLibrary.MakeVector(locself.X,
                                                          locself.Y, 0) -
                             UE.UKismetMathLibrary
                                 .MakeVector(locball.X, locball.Y, 0)
    self.DistanceBallToCha = UE.UKismetMathLibrary.VSize(self.vecBallToChar)
    self.vecCharToBallNor = UE.UKismetMathLibrary.Normal(self.vecBallToChar,
                                                         0.0001) * -1
end

function MyChar_C:Move()
    self.CharacterMovement.MaxWalkSpeed = 600
    if (self.bHavingSoccer) then
        self:SetVarValueRelatedToSoccerAndChar()

        if (UE.UKismetMathLibrary.VSize(self.vecMove) > 0.001) then
            -- 玩家在主动移动

            if (UE.UGameplayStatics.GetTimeSeconds(self) - self.lastKickTime >
                0.4 and self.DistanceBallToCha < self.disNeedKick) then
                -- 可以踢球： 球离得近 && 离上次踢有一段时间了
                self.lastKickTime = UE.UGameplayStatics.GetTimeSeconds(self)

                self:PlayAnimMontage(self.AnimeMonTiQiu)

                self.lastKickEverKick = false
                local forwardnow = self:GetActorForwardVector()
                -- forwardnow.Z = 0
                self.oriCharDir = forwardnow
            else
                -- 不可以踢球
                if (self.DistanceBallToCha > self.disNeedKick and
                    UE.UKismetMathLibrary
                        .Dot_VectorVector(self.mSoccer:GetVelocity(),
                                          self.vecMove) < 0.996 and self.bLastKickIsShot==false) then
                    self.CharacterMovement.MaxWalkSpeed = 1000
                else
                    self.CharacterMovement.MaxWalkSpeed = 600
                end

                self:AddMovementInput(self.vecCharToBallNor)
            end
        else
            -- 玩家没移动行走的摇杆
            if (UE.UKismetMathLibrary.VSize(self.mSoccer:GetVelocity()) > 200 or
                self.DistanceBallToCha > 100) then
                -- 球离人较远 或 球速较大 时，人自动追球
                self:AddMovementInput(self.vecCharToBallNor, 1, false)
            end
        end
    else
        if (UE.UKismetMathLibrary.VSize(self.vecMove) > 0.001) then
            self:AddMovementInput(self.vecMove, 1, false)
        end
    end
end

function MyChar_C:ShotSoccer_Pressed() 
    if (self.bHavingSoccer) then  
        self.timeShotPressed = UE.UGameplayStatics.GetTimeSeconds(self) 
        self.delShotChargeStart:NotifyAll(self.timeShotPressed)
    end
end
function MyChar_C:ShotSoccer_Released()
    if (self.bHavingSoccer) then  
        self.timeShotReleased = UE.UGameplayStatics.GetTimeSeconds(self)
        self.delShotChargetEnd:NotifyAll(self.timeShotReleased)
    end
end

return MyChar_C
