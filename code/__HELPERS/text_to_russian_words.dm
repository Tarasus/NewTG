//лист замены перевода профессий.
var/global/list/profs_list = list(
	"Captain"="Капитан",
	"Assistant"="Ассистент",
	"Chaplain"="Капеллан",
	"Security Officer"="Офицер Службы Безопасности",
	"Cook"="Повар",
	"Chief Engineer"="Главный Инженер",
	"Station Engineer"="Инженер",
	"Atmospheric Technician"="Атмосферный Техник",
	"Clown"="Клоун",
	"Mime"="Мим",
	"Botanist"="Ботаник",
	"Medical Doctor"="Медик",
	"Cargo Technician"="Грузчик",
	"Head of Personnel"="Глава Персонала",
	"Head of Security"="Глава Службы Безопасности",
	"Warden"="Надзиратель",
	"Detective"="Детектив",
	"Lawyer"="Адвокат",
	"Quartermaster"="Завхоз",
	"Scientist"="Ученый",
	"Shaft Miner"="Шахтер",
	"Chemist"="Химик",
	"Janitor"="Уборщик",
	"Geneticist"="Генетик",
	"Virologist"="Вирусолог",
	"Roboticist"="Роботист",
	"Bartender"="Бармен",
	"Research Director"="Глава Отдела Исследований",
	"Chief Medical Officer"="Главврач",
	)	//нужна доработка и тесты //|""="",| загатовочка

/proc/ranged_R(var/t, var/type, var/chars_ed) //процедура для перевода названия ПРОФЕССИИ
	if(!type)
		chars_ed = profs_list //возведение листа профессий
	if(type == "locates")
		chars_ed = locs_list //возведение листа локаций
	for(var/char in chars_ed)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + chars_ed[char] //замена
			index = findtext(t, char)
	return t

//лист замены перевода профессий.
var/global/list/locs_list = list(
	"Room"="Комната",	//тест
	)	//нужна доработка и тесты //|""="",| загатовочка