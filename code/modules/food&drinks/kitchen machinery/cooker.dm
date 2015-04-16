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

	var/process = 0
	var/time = 60

/********************
*   	Adding		*
********************/
/obj/machinery/cooker/attackby(var/obj/item/O as obj, var/mob/user as mob, params)
		//tools
	if(istype(O, /obj/item/weapon/pan))
		if(tool == null)
			if(O.name == "pan")
				user.unEquip(O)
				src.tool = O
				O.loc = src
				O.dropped(user)
				tool_name = O.name
				update()
				user << "You put [O] on cooker"
			else
				user << "<small>Tool not aviable!"
		else
			user << "<small>Cooker not aviable!"
	if(istype(O, /obj/item/weapon/skillet))
		if(tool == null)
			if(O.name == "skillet")
				user.unEquip(O)
				src.tool = O
				O.loc = src
				O.dropped(user)
				tool_name = O.name
				update()
				user << "You put [O] on cooker"
			else
				user << "<small>Tool not aviable!"
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

	//if no power
	if(stat & (NOPOWER))
		dat += "No power"
		var/datum/browser/popup = new(user, "cooker", name, 300, 300)
		popup.set_content(dat)
		popup.open()
		return

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
			dat += "  -[capitalize(O)]</A> <BR>"
		else
			dat += "  -[capitalize(O)]: [N]</A> <BR>"

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
			if(turn)
				process = 0
				turn = 0
				update()
		if ("on")
			if(!turn)
				cook()
		if ("dispose")
			dispose_all()
			update()
		if ("tool_off")
			if(!turn)
				if(contented_all == 0)
					tool_off()
				else
					usr << "<small>Before eject contents of cooker"
			else
				usr << "<small>Before turn off the cooker"
	updateUsrDialog()
	return

/obj/machinery/cooker/proc/dispose_all()
	for (var/obj/O in contented)
		O.loc = src.loc
	contented_all = 0
	contented = list()
	usr << "<span class='notice'>You dispose of the cooker contents.</span>"
	updateUsrDialog()

/obj/machinery/cooker/proc/tool_off()
	var/obj/O = tool
	O.loc = src.loc
	tool_name = null
	tool = null
	usr << "<span class='notice'>You dispose of the cooker tool.</span>"
	updateUsrDialog()
	update()

/********************
*     Processing	*
********************/
/obj/machinery/cooker/proc/cook()
	if(stat & (NOPOWER))
		return
	if(!tool)
		usr << "<small>No tool."
		return
	if(!contented)
		usr << "<small>Nothing for cooking"
		return

	turn = 1
	update()
	updateUsrDialog()
	cooking(15)
	if(!turn)
		return
	else
		turn = 0
		update()
		updateUsrDialog()

	for(var/obj/item/weapon/reagent_containers/food/snacks/F in contented)
		var/obj/T = tool
		//жарка
		if(tool == /obj/item/weapon/skillet)
			if(F.cooked_skillet)
				var/obj/item/weapon/reagent_containers/food/snacks/S = new F.cooked_skillet (T)
				F.initialize_cooked_food(S, efficiency)
				T.name += "with [S.name]"
			else
				new /obj/item/weapon/reagent_containers/food/snacks/badrecipe(T)
				T.name += "with unknown garbage"
			qdel(F)
			//clear contents
			contented = list()
			contented_all = 0
			//eject tool
			T.loc = src.loc
			tool = null
			tool_name = null

		//варка
		if(tool == /obj/item/weapon/pan)
			if(F.cooked_pan)
				var/obj/item/weapon/reagent_containers/food/snacks/S = new F.cooked_pan (T)
				F.initialize_cooked_food(S, efficiency)
				T.name += "with [S.name]"
			else
				new /obj/item/weapon/reagent_containers/food/snacks/badrecipe(T)
				T.name += "with unknown garbage"
			qdel(F)
			//clear contents
			contented = list()
			contented_all = 0
			//eject tool
			T.loc = src.loc
			tool = null
			tool_name = null


		update()
		updateUsrDialog()

	return

/obj/machinery/cooker/proc/cooking(var/seconds as num)
	for (var/i=1 to seconds)
		if (stat & (NOPOWER))
			return 0
		if(!turn)
			return 0
		use_power(500)
		sleep(max(14-2*cookerpower-2*efficiency,2)) // standard power means sleep(10). The higher the power and the better the efficiency, the faster the cooking
	return 1