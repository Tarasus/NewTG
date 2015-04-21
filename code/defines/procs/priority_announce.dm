/proc/priority_announce(var/text, var/title = "", var/sound = 'sound/AI/attention.ogg', var/type)
	var/text_sani = sanitize(text)
	text_sani = sanitize_russian(text_sani) //текст для аннонса
	var/text_html = sanitize_html(text)//текст для газеток

	if(!text)
		return

	var/announcement

	if(type == "Priority")
		announcement += "<h1 class='alert'>Важное Объ&#255;вление</h1>"

	else if(type == "Captain")
		announcement += "<h1 class='alert'>Объ&#255;вление Капитана</h1>"
		news_network.SubmitArticle(text_sani, "Captain's Announcement", "Station Announcements", null)

	else
		announcement += "<h1 class='alert'>[command_name()] Обновление</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"
		if(title == "")
			news_network.SubmitArticle(text_sani, "Central Command Update", "Station Announcements", null)
		else
			news_network.SubmitArticle(title + "<br><br>" + text_html, "Central Command", "Station Announcements", null)

	announcement += "<br><span class='alert'>[text_sani]</span><br>"
	announcement += "<br>"

	for(var/mob/M in player_list)
		if(!istype(M,/mob/new_player) && !M.ear_deaf)
			M << sanitize_russian(announcement)
			M << sound(sound)

/proc/print_command_report(var/text = "", var/title = "Обновление от Центрального Коммандовани&#255")
	for (var/obj/machinery/computer/communications/C in machines)
		if(!(C.stat & (BROKEN|NOPOWER)) && C.z == ZLEVEL_STATION)
			var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( C.loc )
			P.name = "paper- '[title]'"
			P.info = text
			C.messagetitle.Add("[title]")
			C.messagetext.Add(text)

/proc/minor_announce(var/message, var/title/* = "Внимание:"*/, var/alert) //убрал внимание. вдруг да поможет.
	if(!message)
		return

	for(var/mob/M in player_list)
		if(!istype(M,/mob/new_player) && !M.ear_deaf)
			message = sanitize_russian(sanitize(message)) //санитайз аннонсов.
			title = sanitize_russian(sanitize(title)) //санитайз титтла.
			M << "<b><font size = 3><font color = red>[title]</font color><BR>[message]</font size></b><BR>"
			if(alert)
				M << sound('sound/misc/notice1.ogg')
			else
				M << sound('sound/misc/notice2.ogg')