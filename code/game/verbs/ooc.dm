/mob/verb/looc(mess as text)
	set name = "LOOC"
	set category = "OOC"

	for(var/mob/C in view(16))	//мобы в видимости
		C << "<font color='#E6E6FA'><span class='ooc'><span class='prefix'>LOOC:</span> [src.name]: <span class='message'>[mess]</span></span></font>"
	src << "<font color='#E6E6FA'><span class='ooc'><span class='prefix'>LOOC:</span> [src.name]:</EM> <span class='message'>[mess]</span></span></font>"
			//для себя тоже, ммм

/client/verb/ooc(mess as text)	//ХМММ
	set name = "OOC" //Gave this shit a shorter name so you only have to time out "ooc" rather than "ooc message" to use it --NeoFite
	set category = "OOC"
	//var/client/U = usr.client	//клиент. на деле он не нужен, но для инпута - да	|временно отключено
	//usr << "|[mess]|"	//для тестов.

	if(say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>OOC выключен админом.</span>"
		return

	if(!mob)	return
	if(IsGuestKey(key))
		src << "Гости не могут использовать OOC."
		return

	mess = copytext(sanitize(mess), 1, MAX_MESSAGE_LEN)	//мне кажется, что OOC-verb был сломан вот здесь	//шучу, он сломан не здесь)0)
	mess = sanitize_russian(sanitize_uni(mess))	//перестроил под новые санитайзы							в целом вроде починил
	if(!mess)	return

	if(!(prefs.chat_toggles & CHAT_OOC))
		src << "<span class='danger'>Вам запретили использовать OOC.</span>"
		return

	if(!holder)
		if(!ooc_allowed)
			src << "<span class='danger'>OOC заблокирован.</span>"
			return
		if(!dooc_allowed && (mob.stat == DEAD))
			usr << "<span class='danger'>OOC дл&#255; мёртвых мобов выключен.</span>"
			return
		if(prefs.muted & MUTE_OOC)
			src << "<span class='danger'>Вы не можеште использовать OOC (мут).</span>"
			return
		if(handle_spam_prevention(mess,MUTE_OOC))
			return
		if(findtext(mess, "byond://"))
			src << "<B>Рекламировать другие серверы нехорошо..</B>"
			log_admin("[key_name(src)] попыталс&#255; прорекламить другой сервер в OOC: [mess]")
			message_admins("[key_name_admin(src)] попыталс&#255; прорекламить другой сервер в OOC: [mess]")
			return

	log_ooc("[mob.name]/[key] : [mess]")

	var/keyname = key
	if(prefs.unlock_content)
		if(prefs.toggles & MEMBER_PUBLIC)
			keyname = "<font color='[prefs.ooccolor]'><img style='width:9px;height:9px;' class=icon src=\ref['icons/member_content.dmi'] iconstate=blag>[keyname]</font>"

	mess = emoji_parse(mess)

	var/deb = check_debug_OOC(mess)
	if(deb == 1)
		mess = input(src, "Пожалуйста, выберите текст OOC.", "Текст OOC", mess) as message
	for(var/client/C in clients)
		if(C.prefs.chat_toggles & CHAT_OOC)
			if(holder)
				if(!holder.fakekey || C.holder)
					if(check_rights_for(src, R_ADMIN))
						C << "<font color=[config.allow_admin_ooccolor ? prefs.ooccolor :"#b82e00" ]><b><span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message'>[mess]</span></b></font>"
					else
						C << "<span class='adminobserverooc'><span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message'>[mess]</span></span>"
				else
					C << "<font color='[normal_ooc_colour]'><span class='ooc'><span class='prefix'>OOC:</span> <EM>[holder.fakekey ? holder.fakekey : key]:</EM> <span class='message'>[mess]</span></span></font>"
			else
				C << "<font color='[normal_ooc_colour]'><span class='ooc'><span class='prefix'>OOC:</span> <EM>[keyname]:</EM> <span class='message'>[mess]</span></span></font>"

/proc/check_debug_OOC(var/t,var/list/repl_chars = "&#34;") //убрано, чтобы попробовать. мне кажется, что это вызывает баг.
	var/counts = 0
	for(var/char in repl_chars)
		counts++
	return counts

/proc/toggle_ooc()
	ooc_allowed = !( ooc_allowed )
	if (ooc_allowed)
		world << "<B>OOC был включен! </B>"
	else
		world << "<B>OOC-канал был заблокирован!</B>"

/proc/auto_toggle_ooc(var/on)
	if(!config.ooc_during_round && ooc_allowed != on)
		toggle_ooc()

var/global/normal_ooc_colour = "#002eb8"

/client/proc/set_ooc(newColor as color)
	set name = "Назначить игроку цвет OOC"
	set desc = "Модифицировать игроку цвет OOC"
	set category = "OOC"
	normal_ooc_colour = sanitize_ooccolor(newColor)

/client/verb/colorooc()
	set name = "Выставьте свой цвет OOC"
	set category = "Настройки"

	if(!holder || check_rights_for(src, R_ADMIN))
		if(!is_content_unlocked())	return

	var/new_ooccolor = input(src, "Пожалуйста, выберите свой цвет OOC.", "Цвет OOC", prefs.ooccolor) as color|null
	if(new_ooccolor)
		prefs.ooccolor = sanitize_ooccolor(new_ooccolor)
		prefs.save_preferences()
	feedback_add_details("admin_verb","OC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

//Checks admin notice
/client/verb/admin_notice()
	set name = "Администраторские заметки"
	set category = "Админ"
	set desc ="Посмотрите администраторские заметки, если они были установлены"

	if(admin_notice)
		src << "<span class='boldnotice'>Админ-заметки:</span>\n \t [admin_notice]"
	else
		src << "<span class='notice'>На данный момент заметок нет.</span>"

/client/verb/motd()
	set name = "MOTD"
	set category = "OOC"
	set desc ="Проверить Сообщение Дня"

	if(join_motd)
		src << "<div class=\"motd\">[join_motd]</div>"
	else
		src << "<span class='notice'>Сообщение дн&#255; не было установлено.</span>"

/client/proc/self_notes()
	set name = "Посмотреть администраторские заметки"
	set category = "OOC"
	set desc = "Посмотрите заметки, которые админы оставили в ваш адрес"

	if(!config.see_own_notes)
		usr << "<span class='notice'>Извините, эта функция не работает на этом сервере</span>"
		return

	see_own_notes()
