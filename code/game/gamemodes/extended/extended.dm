/datum/game_mode/extended
	name = "extended"
	config_tag = "extended"
	required_players = 0
	reroll_friendly = 1

/datum/game_mode/announce()
	world << "<B>Текущий режим - Обычный Отыгрыш!</B>"
	world << "<B>Просто получайте удовольствие от отыгрыша!</B>"

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/post_setup()
	..()