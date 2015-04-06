//мелкий перевод ~QB
/client/verb/who()
	set name = "Кто?"
	set category = "OOC"

	var/msg = "<b>Текущие Игроки:</b>\n"

	var/list/Lines = list()

	if(holder)
		if(check_rights(R_ADMIN,0))//If they have +ADMIN, show hidden admins, player IC names and IC status
			for(var/client/C in clients)
				var/entry = "\t[C.key]"
				if(C.holder && C.holder.fakekey)
					entry += " <i>(- [C.holder.fakekey])</i>"
				entry += " - Играет за [C.mob.real_name]"
				switch(C.mob.stat)
					if(UNCONSCIOUS)
						entry += " - <font color='darkgray'><b>Без сознания</b></font>"
					if(DEAD)
						if(isobserver(C.mob))
							var/mob/dead/observer/O = C.mob
							if(O.started_as_observer)
								entry += " - <font color='gray'>Наблюдающий</font>"
							else
								entry += " - <font color='black'><b>МЕРТВ</b></font>"
						else
							entry += " - <font color='black'><b>МЕРТВ</b></font>"
				if(is_special_character(C.mob))
					entry += " - <b><font color='red'>Антагонист</font></b>"
				entry += " (<A HREF='?_src_=holder;adminmoreinfo=\ref[C.mob]'>?</A>)"
				Lines += entry
		else//If they don't have +ADMIN, only show hidden admins
			for(var/client/C in clients)
				var/entry = "\t[C.key]"
				if(C.holder && C.holder.fakekey)
					entry += " <i>(- [C.holder.fakekey])</i>"
				Lines += entry
	else
		for(var/client/C in clients)
			if(C.holder && C.holder.fakekey)
				Lines += C.holder.fakekey
			else
				Lines += C.key

	for(var/line in sortList(Lines))
		msg += "[line]\n"

	msg += "<b>Всего игроков: [length(Lines)]</b>"
	src << msg

/client/verb/adminwho()
	set category = "Админ"
	set name = "Админинстраторы"

	var/msg = "<b>Текущие Админинстраторы:</b>\n"
	if(holder)
		for(var/client/C in admins)
			msg += "\t[C] is a [C.holder.rank]"

			if(C.holder.fakekey)
				msg += " <i>(as [C.holder.fakekey])</i>"

			if(isobserver(C.mob))
				msg += " - Наблюдает"
			else if(istype(C.mob,/mob/new_player))
				msg += " - В лобби"
			else
				msg += " - Играет"

			if(C.is_afk())
				msg += " (АФК)"
			msg += "\n"
	else
		for(var/client/C in admins)
			if(!C.holder.fakekey)
				msg += "\t[C] - [C.holder.rank]\n"

	src << msg