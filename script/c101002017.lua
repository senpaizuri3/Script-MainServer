--クローラー・アクソン
--Crawler Axon
--Scripted by Eerie Code
function c101002017.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101002017,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,101002017)
	e1:SetTarget(c101002017.target)
	e1:SetOperation(c101002017.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101002017,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCountLimit(1,101002117)
	e2:SetCondition(c101002017.spcon)
	e2:SetTarget(c101002017.sptg)
	e2:SetOperation(c101002017.spop)
	c:RegisterEffect(e2)
end
function c101002017.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsType(TYPE_SPELL+TYPE_TRAP) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c101002017.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c101002017.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:GetLocation()~=LOCATION_DECK
		and c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp
end
function c101002017.filter1(c,e,tp)
	return c:IsSetCard(0x204) and not c:IsCode(101002017) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c101002017.filter2(c,g)
	return g:IsExists(c101002017.filter3,1,c,c:GetCode())
end
function c101002017.filter3(c,code)
	return not c:IsCode(code)
end
function c101002017.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then return false end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return false end
		local g=Duel.GetMatchingGroup(c101002017.filter1,tp,LOCATION_DECK,0,nil,e,tp)
		return g:IsExists(c101002017.filter2,1,nil,g)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c101002017.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c101002017.filter1,tp,LOCATION_DECK,0,nil,e,tp)
	local dg=g:Filter(c101002017.filter2,nil,g)
	if dg:GetCount()>=1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=dg:Select(tp,1,1,nil)
		local tc1=sg:GetFirst()
		dg:Remove(Card.IsCode,nil,tc1:GetCode())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc2=dg:Select(tp,1,1,nil):GetFirst()
		Duel.SpecialSummonStep(tc1,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.SpecialSummonStep(tc2,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.SpecialSummonComplete()
		local g=Group.FromCards(tc1,tc2)
		Duel.ConfirmCards(1-tp,g)
	end
end
