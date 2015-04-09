/obj/item/weapon/gun/energy/portalgun
	name = "portal gun"
	icon = 'icons/exs_for_me.dmi'
	icon_state = "portalgun"
	item_state = "c20r"
	w_class = 3.0
	m_amt = 10000
	ammo_type = list(/obj/item/projectile/bullet/portalball)
	var/charge_tick = 0
	var/recharge_time = 5 //Time it takes for shots to recharge (in ticks)

/obj/item/ammo_casing/portalball/blue
	name = "blue portal casing"
	desc = "It's amwesome!"
	projectile_type = /obj/item/projectile/bullet/portalball/blue

/obj/item/ammo_casing/portalball/orange
	name = "orange portal casing"
	desc = "It's amwesome!"
	projectile_type = /obj/item/projectile/bullet/portalball/orange

/obj/item/ammo_casing/portalball/blue/newshot()
	projectile_type = /obj/item/projectile/bullet/portalball/blue

/obj/item/ammo_casing/portalball/orange/newshot()
	projectile_type = /obj/item/projectile/bullet/portalball/orange

/obj/item/projectile/bullet/portalball/on_hit(var/atom/target, var/blocked = 0)
	..()
	if(istype(target, /atom/movable))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.throw_at(throw_target, 3, 2)
		if(color == 1)
			new/obj/portal/blue(src.loc)
		else
			new/obj/portal/orange(src.loc)

/obj/portal
	icon = 'icons/exs_for_me.dmi'
/obj/portal/orange
	icon_state = "portal_o"
/obj/portal/blue
	icon_state = "portal_b"

/obj/item/projectile/bullet/portalball
	icon = 'icons/exs_for_me.dmi'
	damage = 0
	stamina = 0
	var/colortypemode

/obj/item/projectile/bullet/portalball/orange
	icon_state = "ball_o"
/obj/item/projectile/bullet/portalball/blue
	icon_state = "ball_o"