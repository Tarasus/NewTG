/obj/item/weapon/pan
	name = "pan"
	desc = "Pan. Need for cooker."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "pan"

/obj/item/weapon/skillet
	name = "skillet"
	desc = "Skillet. Need for cooker."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "skillet"

/obj/machinery/env_holder
	name = "holder tool"
	desc = "Holding a tools."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "skillet1&pan1"
	var/skillet_slot = /obj/item/weapon/skillet
	var/pan_slot = /obj/item/weapon/pan

/obj/machinery/env_holder/proc/update()
	var/state
	if(skillet_slot == null)
		state += "skillet0&"
	else
		state += "skillet1&"
	if(pan_slot == null)
		state += "pan0"
	else
		state += "pan1"
	icon_state = state

/obj/machinery/env_holder/attack_hand(mob/user as mob)
	user.set_machine(src)
	interact(user)

/obj/machinery/env_holder/interact(mob/user as mob)
	var/dat = "<div class='statusDisplay'>"
	if(skillet_slot == null)
		dat += "No Skillet"
	else
		dat += "<A href='?src=\ref[src];action=skillet'>Skillet</A>"
	dat += " | "
	if(pan_slot == null)
		dat += "No Pan"
	else
		dat += "<A href='?src=\ref[src];action=pan'>Pan</A>"

	var/datum/browser/popup = new(user, "cooker", name, 300, 300)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/env_holder/Topic(href, href_list)
	usr.set_machine(src)
	switch(href_list["action"])
		if ("skillet")
			new /obj/item/weapon/skillet(src.loc)
			skillet_slot = null
			updateUsrDialog()
		if ("pan")
			new /obj/item/weapon/pan(src.loc)
			pan_slot = null
			updateUsrDialog()

	update()

	updateUsrDialog()
	return

/obj/machinery/env_holder/attackby(var/obj/item/O as obj, var/mob/user as mob, params)
	if(pan_slot == null)
		if(istype(O, /obj/item/weapon/pan))
			pan_slot = /obj/item/weapon/pan
			updateUsrDialog()
			update()
			del(O)
	if(skillet_slot == null)
		if(istype(O, /obj/item/weapon/skillet))
			skillet_slot = /obj/item/weapon/skillet
			updateUsrDialog()
			update()
			del(O)