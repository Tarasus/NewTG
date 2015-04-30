/************************************
	������ �������.	�� ��������
************************************
/mob/verb/achivke()
	set name = "����������"
	set category = "OOC"
	achivke_test(ckey)

var/achivkens_players[0]

/proc/load_achivkens()
	if(config.achivki_mode_on)
		var/savefile/S=new("data/achivkens.ban")
		S["keys[0]"] >> achivkens_players
		log_admin("Loading achivkens")

		if (!length(achivkens_players))
			achivkens_players=list()
			log_admin("achivkens_players was empty")

/mob/proc/achivke_test(var/ckey = usr.ckey, trigger)
	for(var/t in achivkens_players)
		var/r = t
		var/x = t
		if( findtext(r,"-") )
			r = copytext( r, 1, findtext(r,"-") )
		usr << "[r]"
		if(r == "#"+ckey)
		else
			return
		if( findtext(x,"#") )
			x = copytext( x, 1, findtext(x,"#") )
		usr << "[x]"
		usr << "[r], [x]"

/mob/proc/achivke_test_all(var/trigger)
	for(var/t in achivkens_players)
		var/r = t
		var/x = t
		if( findtext(r,"-") )
			r = copytext( r, 1, findtext(r,"-") )
		if( findtext(x,"[r]-") )
			x = copytext( x, 1, findtext(x,"[r]-") )
			usr << "[r],[x]"
			trigger = 1
	if(!trigger)
		usr << "�� ������� ��� ������"

/proc/achivkens_savebanfile()
	var/savefile/S=new("data/achivkens.ban")
	S["keys[0]"] << achivkens_players

/proc/add_achivke(augkey, type)
	if (!type || !augkey) return
	achivkens_players.Add(text("#[augkey]-[type]"))
	achivkens_savebanfile()

/mob/verb/achivke_add()
	set name = "���������� �������� /test/"
	set category = "OOC"
	var/augkey = input(src,"�������� ckey:","ckey",null) as null|message
	var/type = input(src,"�������� type:","type",null) as null|message
	add_achivke(augkey, type)

/mob/verb/achivke_test_allu()
	set name = "���������� ��������� /test/"
	set category = "OOC"
	achivke_test_all()
*//********************************
������ �������, ��� ����� ���������
***********************************
/datum/achivments
	var/name = "achivment"
	var/cost = 10
	var/color = "FFFFFF"
	var/text
	var/path

/datum/achivments/novice
	name = "����������"
	cost = 2
	color = "green"
	text = "������� �� ��, ��� ����� �� ��� ������."

client/verb/achivments()
	var/client/C
	var/datum/achivments/S

	set name = "����������"
	set category = "OOC"

	S.load_achivments_path(C.ckey)
	S.load_achivments()

client/verb/add_achiv()
	set name = "+Achiv"
	set category = "OOC"

	var/datum/achivments/L

	if(!L.path)				return 0
	var/savefile/S = new /savefile(L.path)
	if(!S)					return 0
	S.cd = "/"

	S["novice"]	<< 1

/datum/achivments/proc/load_achivments_path(ckey,filename="achivments.sav")
	if(!ckey)	return
	path = "data/achivments/[copytext(ckey,1,2)]/[ckey]/[filename]"

/datum/achivments/proc/load_achivments()
	check_achivments("novice")

/datum/achivments/proc/check_achivments(type, y_n)
	if(!path)				return 0
	if(!fexists(path))		return 0
	var/savefile/S = new /savefile(path)
	if(!S)					return 0
	S.cd = "/"

	S["[type]"]	>> y_n
	if(y_n)
		for(var/datum/achivments/X in /datum/achivments)
			if(X.name == type)
				usr << "[X.name]"
				usr << "[X.text]"

/datum/achivments/New(client/C)
	..()
	load_achivments_path(C.ckey)
	*/
//*********************************
//******* ������� ����� ��� *******
//*********************************
/client/proc/achievements_show_type(var/type)
	var/cost
	var/resul = 0
	resul = achievements_check(type)
	if(resul)
		return resul
	if(type == "novice")
		src << "<b>����, &#255; � �������!</b>"
		cost = 1
		src << "�� ��&#255;������ � �������� �����... ��� ������ �� ����������� �������.|<i>���������: <b>[cost] XP</b></i>"
	return resul

/client/verb/achievements()
	set name = "����������"
	set category = "OOC"
	achievements_show()

/client/proc/achievements_show()
	var/trigger = 0
	src << "***{����������}***"
	if(config.achivki_mode_on)
		var/resul = achievements_show_type("novice")
		if(!resul)
			trigger = 1

		if(!trigger)
			src << "� ��� ��� ����������"
		src << "***---------***"

/client/proc/achievements_add(var/name)
	var/check = achievements_check(name)	//�������� �� �������
	if(!check)
		return
	if(config.achivki_mode_on)
		var/savefile/S=new("data/achievements/[ckey]/[name]")
		S["["received"]"] << 1
		src << "<b>�� �������� ����������!</b>"

/client/proc/achievements_check(var/name, var/resul)
	if(config.achivki_mode_on)
		var/savefile/S=new("data/achievements/[ckey]/[name]")
		var/received = 0
		S["["received"]"] >> received
		if(received)
			return resul
		else
			resul = 1
			return resul

//������, ���