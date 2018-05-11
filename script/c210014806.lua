--
--designed and scripted by Larry126
function c210014806.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,210014806+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c210014806.cost)
	e1:SetTarget(c210014806.target)
	e1:SetOperation(c210014806.activate)
	c:RegisterEffect(e1)
end
c210014806.listed_names={0x9b,210014806}
function c210014806.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c210014806.filter1(c)
	return (c:IsCode(9113513,11493868,44256816,63804637) or aux.IsCodeListed(c,0x9b))
		and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c210014806.filter2(c)
	return c:IsSetCard(0x9b) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c210014806.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c210014806.filter1,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c210014806.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c210014806.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c210014806.filter1,tp,LOCATION_DECK,0,nil)
	local g2=Duel.GetMatchingGroup(c210014806.filter2,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.SendtoHand(sg1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
end