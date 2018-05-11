--サッド・ストーリー ～揺るがない真実～
function c100000097.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetCost(c100000097.cost)
	c:RegisterEffect(e1)	
	--DP
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000097.tdcon)
	e2:SetTarget(c100000097.tdtg)
	e2:SetOperation(c100000097.tdop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(100000097,ACTIVITY_CHAIN,c100000097.chainfilter)
end
function c100000097.chainfilter(re,tp,cid)
	return not (re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL))
end
function c100000097.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(100000097,tp,ACTIVITY_CHAIN)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c100000097.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(e1,tp)
end
function c100000097.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
function c100000097.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_DRAW
end
function c100000097.tdfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsControler(Duel.GetTurnPlayer())
end
function c100000097.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c100000097.tdfilter,1,nil) end
	local g=eg:Filter(c100000097.tdfilter,nil)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c100000097.cfilter(c,e)
	return c:IsControler(Duel.GetTurnPlayer()) and c:IsRelateToEffect(e)
end
function c100000097.tdop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c100000097.cfilter,nil,e)
	local sg=g:Filter(Card.IsType,nil,TYPE_SPELL)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-Duel.GetTurnPlayer(),g)
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	end
end
