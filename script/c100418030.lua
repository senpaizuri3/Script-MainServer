--スーパービークロイド－モビルベース
--Super Vehicroid Mobile Base
--Scripted by Eerie Code
function c100418030.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c100418030.matfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0x16),true)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100418030,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,100418030)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100418030.sptg)
	e1:SetOperation(c100418030.spop)
	c:RegisterEffect(e1)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100418030,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c100418030.mvtg)
	e2:SetOperation(c100418030.mvop)
	c:RegisterEffect(e2)
end
function c100418030.matfilter(c)
	return c:IsFusionType(TYPE_FUSION) and c:IsFusionSetCard(0x16)
end
function c100418030.spfilter1(c,e,tp,loc)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c100418030.spfilter2,tp,loc,0,1,nil,e,tp,c:GetAttack())
end
function c100418030.spfilter2(c,e,tp,atk)
	return c:IsSetCard(0x16) and c:IsAttackBelow(atk) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100418030.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local loc=0
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 then loc=loc+LOCATION_DECK end
	if not Duel.GetLocationCountFromEx or Duel.GetLocationCountFromEx(tp)>-1 then loc=loc+LOCATION_EXTRA end
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c100418030.spfilter1(chkc,e,tp,loc) end
	if chk==0 then return loc~=0 and Duel.IsExistingTarget(c100418030.spfilter1,tp,0,LOCATION_MZONE,1,nil,e,tp,loc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100418030.spfilter1,tp,0,LOCATION_MZONE,1,1,nil,e,tp,loc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,loc)
end
function c100418030.spop(e,tp,eg,ep,ev,re,r,rp)
	local loc=0
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 then loc=loc+LOCATION_DECK end
	if not Duel.GetLocationCountFromEx or Duel.GetLocationCountFromEx(tp)>-1 then loc=loc+LOCATION_EXTRA end
	local tc=Duel.GetFirstTarget()
	if loc~=0 and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100418030.spfilter2,tp,loc,0,1,1,nil,e,tp,tc:GetAttack())
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c100418030.mvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x16) and c:IsAbleToHand() and c:GetSequence()<4
end
function c100418030.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c100418030.mvfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c100418030.mvfilter,tp,LOCATION_MZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c100418030.mvfilter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c100418030.mvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local seq=tc:GetPreviousSequence()
		Duel.MoveSequence(c,seq)
	end
end
