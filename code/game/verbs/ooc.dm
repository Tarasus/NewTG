/client/verb/ooc(msg as text)
	set name = "OOC" //Gave this shit a shorter name so you only have to time out "ooc" rather than "ooc message" to use it --NeoFite
	set category = "OOC"

	if(say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>ООС выключен админом.</span>"
		return

	if(!mob)	return
	if(IsGuestKey(key))
		src << "Гости не могут использовать ООС."
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)	return

	if(!(prefs.chat_toggles & CHAT_OOC))
		src << "<span class='danger'>Вам запретили использовать ООС.</span>"
		return

	if(!holder)
		if(!ooc_allowed)
			src << "<span class='danger'>ООС заблокирован.</span>"
			return
		if(!dooc_allowed && (mob.stat == DEAD))
			usr << "<span class='danger'>ООС для мёртвых мобов выключен.</span>"
			return
		if(prefs.muted & MUTE_OOC)
			src << "<span class='danger'>Ты не можешь использовать ООС (muted).</span>"
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			src << "<B>Advertising other servers is not allowed.</B>"
			log_admin("[key_name(src)] has attempted to advertise in OOC: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in OOC: [msg]")
			return

	log_ooc("[mob.name]/[key] : [msg]")

	var/keyname = key
	if(prefs.unlock_content)
		if(prefs.toggles & MEMBER_PUBLIC)
			keyname = "<font color='[prefs.ooccolor]'><img style='width:9px;height:9px;' class=icon src=\ref['icons/member_content.dmi'] iconstate=blag>[keyname]</font>"

	msg = emoji_parse(msg)

	for(var/client/C in clients)
		if(C.prefs.chat_toggles & CHAT_OOC)
			if(holder)
				if(!holder.fakekey || C.holder)
					if(check_rights_for(src, R_ADMIN))
						C << "<font color=[config.allow_admin_ooccolor ? prefs.ooccolor :"#b82e00" ]><b><span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message'>[msg]</span></b></font>"
					else
						C << "<span class='adminobserverooc'><span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message'>[msg]</span></span>"
				else
					C << "<font color='[normal_ooc_colour]'><span class='ooc'><span class='prefix'>OOC:</span> <EM>[holder.fakekey ? holder.fakekey : key]:</EM> <span class='message'>[msg]</span></span></font>"
			else
				C << "<font color='[normal_ooc_colour]'><span class='ooc'><span class='prefix'>OOC:</span> <EM>[keyname]:</EM> <span class='message'>[msg]</span></span></font>"

/proc/toggle_ooc()
	ooc_allowed = !( ooc_allowed )
	if (ooc_allowed)
		world << "<B>ООС был включен!</B>"
	else
		world << "<B>ООС-канал был заблокирован!</B>"

/proc/auto_toggle_ooc(var/on)
	if(!config.ooc_during_round && ooc_allowed != on)
		toggle_ooc()

var/global/normal_ooc_colour = "#002eb8"

/client/proc/set_ooc(newColor as color)
	set name = "Назначить игроку цвет ООС"
	set desc = "Модимицировать игроку цвет ООС"
	set category = "Веселье"
	normal_ooc_colour = sanitize_ooccolor(newColor)

/client/verb/colorooc()
	set name = "Выставьте свой цвет ООС"
	set category = "Предпочтения"

	if(!holder || check_rights_for(src, R_ADMIN))
		if(!is_content_unlocked())	return

	var/new_ooccolor = input(src, "Пожалуйста, выберите свой цвет ООС.", "Цвет ООС", prefs.ooccolor) as color|null
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
	set category = "ООС"
	set desc ="Проверить Сообщение Дня"

	if(join_motd)
		src << "<div class=\"motd\">[join_motd]</div>"
	else
		src << "<span class='notice'>Сообщение дня не было установлено.</span>"

/client/proc/self_notes()
	set name = "Посмотреть администраторские заметки"
	set category = "OOC"
	set desc = "Посмотрите заметки, которые админы оставили в ваш адрес"

	if(!config.see_own_notes)
		usr << "<span class='notice'>Извините, эта функция не работает на этом сервере</span>"
		return

	see_own_notes()
