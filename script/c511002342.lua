--Butterfly Fairy
function c511002342.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002342.spcon)
	e1:SetOperation(c511002342.spop)
	c:RegisterEffect(e1)
	aux.CallToken(420)
end
function c511002342.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),Card.IsPapillon,2,nil)
end
function c511002342.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,Card.IsPapillon,2,2,nil)
	Duel.Release(g,REASON_COST)
end
