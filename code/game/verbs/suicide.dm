/mob/var/suiciding = 0

/mob/living/carbon/human/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		var/obj/item/held_item = get_active_hand()
		if(held_item)
			var/damagetype = held_item.suicide_act(src)
			if(damagetype)
				var/damage_mod = 1
				switch(damagetype) //Sorry about the magic numbers.
								   //brute = 1, burn = 2, tox = 4, oxy = 8
					if(15) //4 damage types
						damage_mod = 4

					if(6, 11, 13, 14) //3 damage types
						damage_mod = 3

					if(3, 5, 7, 9, 10, 12) //2 damage types
						damage_mod = 2

					if(1, 2, 4, 8) //1 damage type
						damage_mod = 1

					else //This should not happen, but if it does, everything should still work
						damage_mod = 1

				//Do 175 damage divided by the number of damage types applied.
				if(damagetype & BRUTELOSS)
					adjustBruteLoss(175/damage_mod)

				if(damagetype & FIRELOSS)
					adjustFireLoss(175/damage_mod)

				if(damagetype & TOXLOSS)
					adjustToxLoss(175/damage_mod)

				if(damagetype & OXYLOSS)
					adjustOxyLoss(175/damage_mod)

				//If something went wrong, just do normal oxyloss
				if(!(damagetype | BRUTELOSS) && !(damagetype | FIRELOSS) && !(damagetype | TOXLOSS) && !(damagetype | OXYLOSS))
					adjustOxyLoss(max(175 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))

				updatehealth()
				return

		var/suicide_message = pick("[src] пытаетс&#255; откусить себе &#255;зык! Он(а) пытаетс&#255; совершить суицид!.", \
							"[src] пытаетс&#255; выдавить себе глаза! Он(а) пытаетс&#255; совершить суицид!.", \
							"[src] пытаетс&#255; свернуть себе шею. Он(а) пытаетс&#255; совершить суицид!.", \
							"[src] задерживает дыхание! Он(а) пытаетс&#255; совершить суицид!.")

		visible_message("<span class='danger'>[suicide_message]</span>", "<span class='userdanger'>[suicide_message]</span>")

		adjustOxyLoss(max(175 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		updatehealth()

/mob/living/carbon/brain/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		visible_message("<span class='danger'>[src]'s мозг выцветает и погибает!. Оно потер&#255;ло волю к жизни.</span>", \
						"<span class='userdanger'>[src]'s мозг выцветает и погибает!. Оно потер&#255;ло волю к жизни.</span>")
		spawn(50)
			death(0)
			suiciding = 0

/mob/living/carbon/monkey/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		//instead of killing them instantly, just put them at -175 health and let 'em gasp for a while
		visible_message("<span class='danger'>[src] пытаетс&#255; откусить себе &#255;зык. Он(а) пытаетс&#255; совершить суицид.</span>", \
				"<span class='userdanger'>[src] пытаетс&#255; откусить себе &#255;зык. Он(а) пытаетс&#255; совершить суицид.</span>")
		adjustOxyLoss(max(175- getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		updatehealth()

/mob/living/silicon/ai/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		visible_message("<span class='danger'>[src] выключаетс&#255;. Он(а) пытаетс&#255; совершить суицид.</span>", \
				"<span class='userdanger'>[src] выключаетс&#255;. Он(а) пытаетс&#255; совершить суицид.</span>")
		//put em at -175
		adjustOxyLoss(max(maxHealth * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		updatehealth()

/mob/living/silicon/robot/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		visible_message("<span class='danger'>[src] выключает питание. Он(а) пытаетс&#255; совершить суицид.</span>", \
				"<span class='userdanger'>[src] выключает питание. Он(а) пытаетс&#255; совершить суицид.</span>")
		//put em at -175
		adjustOxyLoss(max(maxHealth * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		updatehealth()

/mob/living/silicon/pai/verb/suicide()
	set category = "pAI Commands"
	set desc = "Самоубитьс&#255; чтобы стать призраком (Будет предложен выбор)"
	set name = "pAI Suicide"
	var/answer = input("РЕАЛЬНО самоубитьс&#255;? Это действие не отменить!.", "Суицид", "Нет") in list ("Да", "Нет")
	if(answer == "Да")
		card.removePersonality()
		var/turf/T = get_turf(src.loc)
		T.visible_message("<span class='notice'>[src] Выводит сообщение на экран, \"Форматирую &#255;дро. Получите новую личность, чтобы продолжить пользоватьс&#255; функци&#255;ми устройства ПИИ.\"</span>", "<span class='notice'>[src] электрически пищит.</span>")
		death(0)
	else
		src << "Отмена попытки суицида."

/mob/living/carbon/alien/humanoid/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		visible_message("<span class='danger'>[src] Молотит сам себ&#255;! Он(а) пытаетс&#255; совершить суицид.</span>", \
				"<span class='userdanger'>[src] Молотит сам себ&#255;! Он(а) пытаетс&#255; совершить суицид.</span>", \
				"<span class='notice'>Ты слышишь хруст!</span>")
		//put em at -175
		adjustOxyLoss(max(175 - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		updatehealth()


/mob/living/carbon/slime/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		visible_message("<span class='danger'>[src] Обм&#255;к. Похоже он(а) потер&#255;л(а) волю к жизни.</span>", \
						"<span class='userdanger'>[src] Обм&#255;к. Похоже он(а) потер&#255;л(а) волю к жизни.</span>")
		setOxyLoss(100)
		adjustBruteLoss(100 - getBruteLoss())
		setToxLoss(100)
		setCloneLoss(100)

		updatehealth()

/mob/living/simple_animal/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Вы уверены, что хотите совершить суицид?", "Подтвердить суицид", "Да", "Нет")
	if(!canSuicide())
		return
	if(confirm == "Да")
		suiciding = 1
		visible_message("<span class='danger'>[src] сбрасывает листву.Похоже он(а) потер&#255;л(а) волю к жизни.</span>", \
						"<span class='userdanger'>[src] сбрасывает листву.Похоже он(а) потер&#255;л(а) волю к жизни.</span>")
		death(0)


/mob/living/proc/canSuicide()
	if(stat == CONSCIOUS)
		return 1
	else if(stat == DEAD)
		src << "Ты уже мертв(а)!"
	else if(stat == UNCONSCIOUS)
		src << "Ты должен(а) быть в сознании, чтобы самоубитьс&#255;."
	return

/mob/living/carbon/canSuicide()
	if(!..())
		return
	if(!canmove || restrained())	//just while I finish up the new 'fun' suiciding verb. This is to prevent metagaming via suicide
		src << "Ты не можешь самоубитьс&#255;, будучи св&#255;занным!"
		return
	return 1