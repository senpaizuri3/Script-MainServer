function c20000101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	c:RegisterEffect(e1)
	--Add Effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20000101,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTarget(c20000101.target)
	e2:SetOperation(c20000101.activate)
	c:RegisterEffect(e2)
	--Add Card
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20000101,1))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetOperation(c20000101.operation)
	c:RegisterEffect(e3)
	--Shuffle in Deck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20000101,2))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetTarget(c20000101.target2)
	e4:SetOperation(c20000101.activate2)
	c:RegisterEffect(e4)
	--Draw
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(20000101,3))
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_SZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetTarget(c20000101.target3)
	e5:SetOperation(c20000101.activate3)
	c:RegisterEffect(e5)
	--Shuffle
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(20000101,4))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetRange(LOCATION_SZONE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetTarget(c20000101.target4)
	e6:SetOperation(c20000101.activate4)
	c:RegisterEffect(e6)
	--Take Card
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(20000101,5))
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetTarget(c20000101.target5)
	e7:SetOperation(c20000101.activate5)
	c:RegisterEffect(e7)
	--act in hand
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	c:RegisterEffect(e8)
	--cannot lose (deckout)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetCode(EFFECT_DRAW_COUNT)
	e9:SetTargetRange(1,0)
	e9:SetValue(0)
	e9:SetCondition(c20000101.surcon3)
	e9:SetRange(0xff)
	c:RegisterEffect(e9)
	--Activate
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_PREDRAW)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e10:SetRange(LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
	e10:SetTarget(c20000101.sttg)
	e10:SetOperation(c20000101.stop)
	c:RegisterEffect(e10)
end
function c20000101.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0xff,0,1,nil) end
	Duel.SelectTarget(tp,nil,tp,0xff,0,1,1,nil)
	Duel.SetChainLimit(aux.FALSE)
end
function c20000101.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ac=Duel.AnnounceCard(tp)
	local code=ac
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
	 tc:CopyEffect(code,RESET_EVENT+0x1fe0000)
	end
end
function c20000101.operation(e,tp,eg,ep,ev,re,r,rp)
local ac=Duel.AnnounceCard(tp)
local token=Duel.CreateToken(tp,ac,nil,nil,nil,nil,nil,nil)		
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(0xff)
		token:RegisterEffect(e1)
		Duel.SendtoHand(token,nil,REASON_EFFECT)
	Duel.SpecialSummonComplete()
end
function c20000101.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0xff,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetChainLimit(aux.FALSE)
end
function c20000101.activate2(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,Card.IsAbleToDeck,p,LOCATION_HAND,0,1,63,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	Duel.ShuffleDeck(p)
	Duel.BreakEffect()
end
function c20000101.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(lv)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,lv)
	Duel.SetChainLimit(aux.FALSE)
end
function c20000101.activate3(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c20000101.target4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetChainLimit(aux.FALSE)
end
function c20000101.activate4(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.ShuffleDeck(p)
	Duel.BreakEffect()
end
function c20000101.target5(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,0xff)>0 end
	Duel.SetChainLimit(aux.FALSE)
end
function c20000101.activate5(e,tp,eg,ep,ev,re,r,rp)
	local g2=Duel.GetFieldGroup(tp,0,0xff)
	if g2:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local ag1=g2:Select(tp,1,g2:GetCount(),nil)
	local tc=ag1:GetFirst()
	local dg=Group.CreateGroup()
	while tc do
	local code=tc:GetCode()
	Duel.SendtoDeck(tc,nil,-2,REASON_EFFECT)
	local token=Duel.CreateToken(tp,code,nil,nil,nil,nil,nil,nil)		
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEDOWN_ATTACK)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(0xff)
		token:RegisterEffect(e1)
		Duel.SendtoHand(token,nil,REASON_EFFECT)
	Duel.SpecialSummonComplete()
	tc=ag1:GetNext()
	end
	Duel.ShuffleHand(1-tp)
end
function c20000101.surcon3(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	return Duel.GetFieldGroupCount(p,LOCATION_DECK,0)==0
end
function c20000101.sttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAbleToHand()end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c20000101.stop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,e:GetHandler())
end