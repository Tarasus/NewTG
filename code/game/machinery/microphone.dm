/obj/machinery/microphone
	name = "microphone"
	icon = 'icons/exs_for_me.dmi'
	icon_state = "microphone"
	anchored = 0
	density = 1

/obj/machinery/microphone/attack_hand(mob/living/carbon/human/user as mob)
	if(user.client)
		if(user.client.prefs.muted & MUTE_IC)
			src << "<span class='warning'>Вы не можете говорить в IC (muted).</span>"
			return
	if(!ishuman(user))
		user << "<span class='warning'>Вы не знаете как это использовать!</span>"
		return
	if(user.can_speak())
		user << "<span class='warning'>Вы не в состоянии говорить.</span>"
		return

	var/message = copytext(sanitize(input(user, "Ваша речь", "Микрофон", null)  as text),1,MAX_MESSAGE_LEN)
	if(!message)
		return
	message = capitalize(message)
	src.audible_message("<B>[user]</B> говорит в микрофон, <FONT size=3>\"[message]\"</FONT>", null, 1) // 2 stands for hearable message

	playsound(loc, 'sound/items/megaphone.ogg', 100, 0, 1)
	return