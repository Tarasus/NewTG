//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "Wiki"
	set desc = "Пойти на wiki билда."
	set hidden = 1
	if(config.wikiurl)
		if(alert("Это откроет страницу Wiki в Вашем браузере.Вы уверены?",,"Да","Нет")=="Нет")
			return
		src << link(config.wikiurl)
	else
		src << "<span class='danger'>Ссылка на вики не указана в конфигурации сервера.</span>"
	return

/client/verb/forum()
	set name = "Форум"
	set desc = "Посетить форум."
	set hidden = 1
	if(config.forumurl)
		if(alert("Это откроет страницу Форума в Вашем браузере.Вы уверены?",,"Да","Нет")=="Нет")
			return
		src << link(config.forumurl)
	else
		src << "<span class='danger'>Ссылка на форум не указана в конфигурации сервера.</span>"
	return

/client/verb/rules()
	set name = "Правила"
	set desc = "Показать Правила Сервера."
	set hidden = 1
	if(config.rulesurl)
		if(alert("Это откроет страницу с правилами в Вашем браузере.Вы уверены?",,"Да","Нет")=="Нет")
			return
		src << link(config.rulesurl)
	else
		src << "<span class='danger'>Ссылка на правила не указана в конфигурации сервера.</span>"
	return

/client/verb/github()
	set name = "Github"
	set desc = "Visit Github"
	set hidden = 1
	if(config.githuburl)
		if(alert("This will open the Github repository in your browser. Are you sure?",,"Yes","No")=="No")
			return
		src << link(config.githuburl)
	else
		src << "<span class='danger'>The Github URL is not set in the server configuration.</span>"
	return

/client/verb/reportissue()
	set name = "Репорт"
	set desc = "Сообщить о проблеме"
	set hidden = 1
	if(config.githuburl)
		if(alert("This will open the Github issue reporter in your browser. Are you sure?",,"Yes","No")=="No")
			return
		src << link("[config.githuburl]/issues/new")
	else
		src << "<span class='danger'>The Github URL is not set in the server configuration.</span>"
	return

/client/verb/hotkeys_help()
	set name = "Горячие клавиши"
	set category = "OOC"

	var/adminhotkeys = {"<font color='purple'>
Админские команды:
\tF5 = Aghost (admin-ghost)
\tF6 = player-panel-new
\tF7 = admin-pm
\tF8 = Invisimin
</font>"}

	mob.hotkey_help()

	if(holder)
		src << adminhotkeys


/mob/proc/hotkey_help()
	var/hotkey_mode = {"<font color='purple'>
Режим с гор&#255;чими клавишами: (должны быть включены)
\tTAB = включить режим гор&#255;чих клавиш
\ta = влево
\ts = вниз
\td = вправо&#255;
\tw = вверх
\tq = положить
\te = экипировать
\tr = бросить
\tm = me
\tt = say
\to = OOC
\tx = сменить-руки
\tz = использовать-объект-в-руках-(или y)
\tf = сменить-намерени&#255;-влево
\tg = сменить-намерени&#255;-вправо
\t1 = намерени&#255;-помочь
\t2 = намерени&#255;-разоружить
\t3 = намерени&#255;-схватить
\t4 = намерени&#255;-вредить
</font>"}

	var/other = {"<font color='purple'>
Любой режим: (Гор&#255;чие клавиши не должны быть включены)
\tCtrl+a = влево
\tCtrl+s = вниз
\tCtrl+d = вправо
\tCtrl+w = вверх
\tCtrl+q = положить
\tCtrl+e = экипировать
\tCtrl+r = бросить
\tCtrl+x = сменить-руки
\tCtrl+z = использовать-объект-в-руках (или Ctrl+y)
\tCtrl+f = сменить-намерени&#255;-влево
\tCtrl+g = сменить-намерени&#255;-вправо
\tCtrl+1 = намерени&#255;-помочь
\tCtrl+2 = намерени&#255;-разоружить
\tCtrl+3 = намерени&#255;-схватить
\tCtrl+4 = намерени&#255;-вредить
\tDEL = тащить
\tINS = сменить-намерени&#255;-вправо
\tHOME = положить
\tPGUP = сменить руки
\tPGDN = использовать объект в руках
\tEND = бросить
</font>"}

	src << hotkey_mode
	src << other

/mob/living/silicon/robot/hotkey_help()
	var/hotkey_mode = {"<font color='purple'>
Hotkey-Mode: (hotkey-mode must be on)
\tTAB = toggle hotkey-mode
\ta = влево
\ts = вниз
\td = вправо
\tw = вверх
\tq = сн&#255;ть-активный-модуль
\tt = сказать
\tx = сменить-модуль (циклически)
\tz = использовать объект в руках (или y)
\tf = сменить-намерени&#255;-влево
\tg = сменить-намерени&#255;-вправо
\t1 = активировать-модуль 1
\t2 = активировать-модуль 2
\t3 = активировать-модуль 3
\t4 = включить намерени&#255;
</font>"}

	var/other = {"<font color='purple'>
Любой режим: (Гор&#255;чие клавиши не должны быть включены)
\tCtrl+a = влево
\tCtrl+s = вниз
\tCtrl+d = вправо
\tCtrl+w = вверх
\tCtrl+q = сн&#255;ть активный модуль
\tCtrl+x = сменить модуль (циклически)
\tCtrl+z = использовать объект в руках (или Ctrl+y)
\tCtrl+f = сменить-намерени&#255;-влево
\tCtrl+g = сменить-намерени&#255;-вправо
\tCtrl+1 = активировать модуль1
\tCtrl+2 = активировать модуль 2
\tCtrl+3 = активировать модуль 3
\tCtrl+4 = включить намарени&#255;
\tDEL = nfobnm
\tINS = сменить-намерени&#255;
\tPGUP = сменить модуль (циклически)
\tPGDN = использовать объект в руках
</font>"}

	src << hotkey_mode
	src << other