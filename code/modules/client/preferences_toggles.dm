//toggles
/client/verb/toggle_ghost_ears()
	set name = "Показать/Нет разговоры существ призраку"
	set category = "Настройки"
	set desc = ".Показывать разговоры существ в зоне видимости или вообще всех дл&#255; призрака"
	prefs.chat_toggles ^= CHAT_GHOSTEARS
	src << "Сейчас за призрака вы [(prefs.chat_toggles & CHAT_GHOSTEARS) ? "видите все разговоры в мире" : "видите только разговоры в зоне видимости"]."
	prefs.save_preferences()
	feedback_add_details("admin_verb","TGE") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/toggle_ghost_sight()
	set name = "Показывать/Нет эмоции всех существ призраку"
	set category = "Настройки"
	set desc = ".Показывать эмоции всех существ или только в зоне видимости дл&#255; призрака"
	prefs.chat_toggles ^= CHAT_GHOSTSIGHT
	src << "Сейчас за призрака вы [(prefs.chat_toggles & CHAT_GHOSTSIGHT) ? "видите все эмоции в мире" : "видите только эмоции в зоне видимости"]."
	prefs.save_preferences()
	feedback_add_details("admin_verb","TGS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/toggle_ghost_whispers()
	set name = "Показать/Нет шепот призраку"
	set category = "Настройки"
	set desc = ".Переключение между тем, показывать весь шепот в мире или только в зоне видимости дл&#255; призрака"
	prefs.chat_toggles ^= CHAT_GHOSTWHISPER
	src << "Сейчас за призрака вы [(prefs.chat_toggles & CHAT_GHOSTWHISPER) ? "видите весь шепот " : "видите шепот только в зоне видимости"]."
	prefs.save_preferences()
	feedback_add_details("admin_verb","TGW") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/toggle_ghost_radio()
	set name = "Показать/Нет радио призраку"
	set category = "Настройки"
	set desc = ".Включить или выключить слышимость радио будучи призраком"
	prefs.chat_toggles ^= CHAT_GHOSTRADIO
	src << "Сейчас за призрака вы [(prefs.chat_toggles & CHAT_GHOSTRADIO) ? "видите радио" : "не видите радио"]."
	prefs.save_preferences()
	feedback_add_details("admin_verb","TGR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc! //social experiment, increase the generation whenever you copypaste this shamelessly GENERATION 1

/client/verb/toggle_ghost_pda()
	set name = "Показать/Нет сообщения ПДА призраку"
	set category = "Настройки"
	set desc = ".Переключение между тем, видеть или нет сообщени&#255; ПДА призраку"
	prefs.chat_toggles ^= CHAT_GHOSTPDA
	src << "Сейчас за призрака вы [(prefs.chat_toggles & CHAT_GHOSTPDA) ? "видите все сообщени&#255; ПДА в мире" : "видите сообщени&#255; ПДА только в зоне видимости"]."
	prefs.save_preferences()
	feedback_add_details("admin_verb","TGP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggle_hear_radio()
	set name = "Показать/Нет радио"
	set category = "Настройки"
	set desc = ".Слышать/Нет радио из ближайших колонок, спикеров"
	if(!holder) return
	prefs.chat_toggles ^= CHAT_RADIO
	prefs.save_preferences()
	usr << "Теперь вы[(prefs.chat_toggles & CHAT_RADIO) ? "" : " больше не"] слышите речь из спикеров."
	feedback_add_details("admin_verb","THR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggleadminhelpsound()
	set name = "Слышать/Нет звук админских сообщений"
	set category = "Настройки"
	set desc = ".Переключить между тем, чтобы слышать или нет звук админских сообщений"
	if(!holder)	return
	prefs.toggles ^= SOUND_ADMINHELP
	prefs.save_preferences()
	usr << "Теперь вы[(prefs.toggles & SOUND_ADMINHELP) ? "" : " больше не"] слышите звук при получении сообщений от админинстрации."
	feedback_add_details("admin_verb","AHS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/deadchat()
	set name = "Показать/Нет чат мертвых"
	set category = "Настройки"
	set desc =".Переключение видимости чата мертвых"
	prefs.chat_toggles ^= CHAT_DEAD
	prefs.save_preferences()
	src << "Теперь вы[(prefs.chat_toggles & CHAT_DEAD) ? "" : " больше не"] видите чат мертвых."
	feedback_add_details("admin_verb","TDV") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggleprayers()
	set name = "Показать/Нет чат"
	set category = "Настройки"
	set desc = "Переключение видимости чата игроков"
	prefs.chat_toggles ^= CHAT_PRAYER
	prefs.save_preferences()
	src << "Теперь вы[(prefs.chat_toggles & CHAT_PRAYER) ? "" : " больше не"] видите чат игроков."
	feedback_add_details("admin_verb","TP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/togglePRs()
	set name = "Показать/Нет уведомления"
	set category = "Настройки"
	set desc = "Показывать уведомлени&#255; при из по&#255;влении."
	prefs.chat_toggles ^= CHAT_PULLR
	prefs.save_preferences()
	src << "Теперь вы[(prefs.chat_toggles & CHAT_PULLR) ? "" : " больше не"] видите уведомлени&#255;."
	feedback_add_details("admin_verb","TPullR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/togglemidroundantag()
	set name = "Переключить возможность роли"
	set category = "Настройки"
	set desc = "Переключить возможность получени&#255; роли в этом раунде."
	prefs.toggles ^= MIDROUND_ANTAG
	prefs.save_preferences()
	src << "Теперь вы[(prefs.toggles & MIDROUND_ANTAG) ? "" : " больше не"] можете стать антагонистом в этом раунде."
	feedback_add_details("admin_verb","TMidroundA") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/toggletitlemusic()
	set name = "Слышать/Нет музыку в Лобби"
	set category = "Настройки"
	set desc = "Переключить слышимость музыки в Лобби"
	prefs.toggles ^= SOUND_LOBBY
	prefs.save_preferences()
	if(prefs.toggles & SOUND_LOBBY)
		src << "Теперь вы слышите музыку в Лобби."
		if(istype(mob, /mob/new_player))
			playtitlemusic()
	else
		src << "Вы больше не слышите музыку в Лобби."
		if(istype(mob, /mob/new_player))
			src << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1) // stop the jamsz
	feedback_add_details("admin_verb","TLobby") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/togglemidis()
	set name = "Слышать/Нет музыку админинстрации"
	set category = "Настройки"
	set desc = "Переключение слышимости музыки поставленной админами."
	prefs.toggles ^= SOUND_MIDI
	prefs.save_preferences()
	if(prefs.toggles & SOUND_MIDI)
		src << "Теперь вы слышите музыку поставленную админами."
		if(admin_sound)
			src << admin_sound
	else
		src << "Вы больше не слышите музыку поставленную админами; любые играющие сейчас звуки были отключены."
		if(admin_sound && !(admin_sound.status & SOUND_PAUSED))
			admin_sound.status |= SOUND_PAUSED
			src << admin_sound
			admin_sound.status ^= SOUND_PAUSED
	feedback_add_details("admin_verb","TMidi") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/listen_ooc()
	set name = "Показать/Нет OOC"
	set category = "Настройки"
	set desc = "Переключение видимости ВнеИгровогоЧата."
	prefs.chat_toggles ^= CHAT_OOC
	prefs.save_preferences()
	src << "Теперь вы[(prefs.chat_toggles & CHAT_OOC) ? "" : " больше не"] видите сообщени&#255; в OOC канале."
	feedback_add_details("admin_verb","TOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/Toggle_Soundscape() //All new ambience should be added here so it works with this verb until someone better at things comes up with a fix that isn't awful
	set name = "Слышать/Нет звуки окружения"
	set category = "Настройки"
	set desc = "Переключить слышимость звуков окружения."
	prefs.toggles ^= SOUND_AMBIENCE
	prefs.save_preferences()
	if(prefs.toggles & SOUND_AMBIENCE)
		src << "Теперь вы слышите звуки окружения."
	else
		src << "Вы больше не слышите звуков окружения."
		src << sound(null, repeat = 0, wait = 0, volume = 0, channel = 1)
		src << sound(null, repeat = 0, wait = 0, volume = 0, channel = 2)
	feedback_add_details("admin_verb","TAmbi") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

// This needs a toggle because you people are awful and spammed terrible music
/client/verb/toggle_instruments()
	set name = "Слышать/Нет музыкальные инструменты"
	set category = "Настройки"
	set desc = "Переключить слышимость музыкальных инструментов, таких как пианино"
	prefs.toggles ^= SOUND_INSTRUMENTS
	prefs.save_preferences()
	if(prefs.toggles & SOUND_INSTRUMENTS)
		src << "Теперь вы слышите игру людей на музыкальных инструментах."
	else
		src << "Вы больше не слышите игру людей на музыкальных инструментах."
	feedback_add_details("admin_verb","TInstru") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

//be special
/client/verb/toggle_be_special(role in be_special_flags)
	set name = "Переключить вызможность получения роли"
	set category = "Настройки"
	set desc = "Переключение возможности получени&#255; специальных ролей при событи&#255;х, созданными админами."
	var/role_flag = be_special_flags[role]
	if(!role_flag)	return
	prefs.be_special ^= role_flag
	prefs.save_preferences()
	src << "Теперь вы [(prefs.be_special & role_flag) ? "можете " : "больше не можете "]быть рассмотрены как [role] при событии (когда возможно)."
	feedback_add_details("admin_verb","TBeSpecial") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/verb/toggle_member_publicity()
	set name = "Переключение BYOND конфиденциальности"
	set category = "Настройки"
	set desc = "Переключение того, могут ли люди увидеть Вас как участника BYOND (OOC иконка/цвета)."
	prefs.toggles ^= MEMBER_PUBLIC
	prefs.save_preferences()
	src << "Остальные [(prefs.toggles & MEMBER_PUBLIC) ? "могут" : "не могут"] видеть Вас как участника BYOND."

var/list/ghost_forms = list("ghost","ghostking","ghostian2","skeleghost","ghost_red","ghost_black", \
							"ghost_blue","ghost_yellow","ghost_green","ghost_pink", \
							"ghost_cyan","ghost_dblue","ghost_dred","ghost_dgreen", \
							"ghost_dcyan","ghost_grey","ghost_dyellow","ghost_dpink")
/client/verb/pick_form()
	set name = "Выбрать форму призрака"
	set category = "Настройки"
	set desc = "Выберите предпочитаемую форму призрака."
	if(!is_content_unlocked())	return
	var/new_form = input(src, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in ghost_forms
	if(new_form)
		prefs.ghost_form = new_form
		prefs.save_preferences()
		if(istype(mob,/mob/dead/observer))
			mob.icon_state = new_form

/client/verb/toggle_intent_style()
	set name = "Переключить стиль выбора"
	set category = "Настройки"
	set desc = "Переключение стил&#255; выбора между непосредственно на цели или череду&#255;"
	prefs.toggles ^= INTENT_STYLE
	src << "[(prefs.toggles & INTENT_STYLE) ? "Clicking directly on intents selects them." : "Clicking on intents rotates selection clockwise."]"
	prefs.save_preferences()
	feedback_add_details("admin_verb","ITENTS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!