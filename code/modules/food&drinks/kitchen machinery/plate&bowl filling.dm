/obj/item/weapon/plate
	name = "plate"
	desc = "Plate. For food."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "plate"

/obj/item/weapon/storage/box/platestack
	name = "box of plates"
	desc = "Plate. For food."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "platestack"

/obj/item/weapon/storage/box/platestack/New()
	..()
	new /obj/item/weapon/plate(src)
	new /obj/item/weapon/plate(src)
	new /obj/item/weapon/plate(src)
	new /obj/item/weapon/plate(src)
	new /obj/item/weapon/plate(src)
	new /obj/item/weapon/plate(src)
	new /obj/item/weapon/plate(src)

/obj/item/weapon/plate/attackby(var/obj/item/O as obj, var/mob/user as mob, params)
	if(istype(O, /obj/item/weapon/skillet))
		O.name = "skillet"
		for (var/obj/X in O.contents)
			if(user.l_hand == src)
				user.unEquip(src)
				user.put_in_l_hand(X)
			else if(user.r_hand == src)
				user.unEquip(src)
				user.put_in_r_hand(X)
			else
				X.loc = src.loc
			del (src)