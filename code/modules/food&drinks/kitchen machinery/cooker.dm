/obj/machinery/cooker
	name = "cooker"
	desc = "Fry yummy for the crew!"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "cooker"
	layer = 2.9
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 5
	active_power_usage = 100
	var/turn = 0
	var/efficiency = 1
	var/cookerpower = 1
	var/global/max_n_of_items = 5

	var/tool = null
	var/tool_name = null
	var/contented = list()
	var/contented_all = 0

	var/addcont = list()

	var/process = 0
	var/time = 60

/********************
*   	Adding		*
********************/
/obj/machinery/cooker/attackby(var/obj/item/O as obj, var/mob/user as mob, params)
		//tools
	if(istype(O, /obj/item/weapon/pan))
		if(tool == null)
			user.unEquip(O)
			tool = O
			O.loc = src
			O.dropped(user)
			tool_name = O.name
			update()
			user << "You placed [O]"
		else
			user << "<small>Cooker not aviable!"
	if(istype(O, /obj/item/weapon/skillet))
		if(tool == null)
			user.unEquip(O)
			tool = O
			O.loc = src
			O.dropped(user)
			tool_name = O.name
			update()
			user << "You placed [O]"
		else
			user << "<small>Cooker not aviable!"

		//ingridients
	if(istype(O,/obj/item/weapon/reagent_containers/food/snacks))
		if (contented_all>=max_n_of_items)
			user << "<span class='warning'>[src] is full, you cannot put more.</span>"
			return 1
		if (turn)
			user << "<span class='warning'>[src] is started, you cannot put now.</span>"
			return 1
		else
			if(!user.drop_item())
				user << "<span class='notice'>\the [O] is stuck to your hand, you cannot put it in \the [src]</span>"
				return 0
			O.loc = src
			src.contented += O
			contented_all++
			user.visible_message( \
				"<span class='notice'>[user] has added \the [O] to \the [src].</span>", \
				"<span class='notice'>You add \the [O] to \the [src].</span>")

	updateUsrDialog()

/********************
*      Updating		*
********************/
/obj/machinery/cooker/proc/update()
	icon_state = "cooker"
	if(tool)
		icon_state += "_"+tool_name
	if(turn)
		icon_state += "_1"
/********************
*     Interface		*
********************/
/obj/machinery/cooker/attack_hand(mob/user as mob)
	user.set_machine(src)
	interact(user)

/obj/machinery/cooker/interact(mob/user as mob)
	var/dat = "<div class='statusDisplay'>"

	dat += "Place: "
	dat += "<A href='?src=\ref[src];action=tool_off'>[tool_name]</A> <BR>"
	dat += "Contents: <BR>"
		//contents list
	var/list/items_counts = new
	for (var/obj/O in contented)
		items_counts[O.name]++

	for (var/O in items_counts)
		var/N = items_counts[O]
		if(N == 1)
			dat += "*[capitalize(O)]</A> <BR>"
		else
			dat += "*[capitalize(O)]: [N]</A> <BR>"

	if (items_counts.len==0)
		dat += "No."

	dat += "</div><BR>"

	dat += "<A href='?src=\ref[src];action=off'>OFF</A>"
	dat += "<A href='?src=\ref[src];action=on'>ON</A>"
	if(!turn)
		dat += "<A href='?src=\ref[src];action=dispose'>Eject ingredients</A>"

	var/datum/browser/popup = new(user, "cooker", name, 300, 300)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/cooker/Topic(href, href_list)
	usr.set_machine(src)

	switch(href_list["action"])
		if ("off")
			turn = 0
			update()
		if ("on")
			turn = 1
			processing()
			update()
		if ("dispose")
			dispose_all()
			update()

	updateUsrDialog()
	return

/obj/machinery/cooker/proc/dispose_all()
	for (var/obj/O in contented)
		O.loc = src.loc
	contented_all = 0
	contented = list()
	addcont = list()
	usr << "<span class='notice'>You dispose of the cooker contents.</span>"
	updateUsrDialog()

/********************
*     Processing	*
********************/
/obj/machinery/cooker/proc/processing()
	while(process == time)
		spawn(1)
		if(turn)
			process += efficiency
		else
			process = 0
			break