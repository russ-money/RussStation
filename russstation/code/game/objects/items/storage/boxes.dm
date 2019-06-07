/obj/item/storage/box/ingredients/italian/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/food/snacks/grown/tomato(src)
		new /obj/item/reagent_containers/food/snacks/meatball(src)
	new /obj/item/reagent_containers/food/drinks/bottle/wine(src)

/obj/item/storage/box/ingredients/american/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/food/snacks/grown/potato(src)
		new /obj/item/reagent_containers/food/snacks/grown/tomato(src)
		new /obj/item/reagent_containers/food/snacks/grown/corn(src)
	new /obj/item/reagent_containers/food/snacks/meatball(src)

/obj/item/storage/box/ingredients/carnivore/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/meat/slab/bear(src)
	new /obj/item/reagent_containers/food/snacks/meat/slab/spider(src)
	new /obj/item/reagent_containers/food/snacks/spidereggs(src)
	new /obj/item/reagent_containers/food/snacks/carpmeat(src)
	new /obj/item/reagent_containers/food/snacks/meat/slab/xeno(src)
	new /obj/item/reagent_containers/food/snacks/meat/slab/corgi(src)
	new /obj/item/reagent_containers/food/snacks/meatball(src)

/obj/item/storage/box/useless
	name = "extremely useful box"
	desc = "It's just an ordinary box."
	icon = 'russstation/icons/obj/storage.dmi'
	icon_state = "uselessbox"
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	illustration = null

/obj/item/storage/box/useless/PopulateContents()
	new /obj/item/clothing/mask/breath(src)
	new /obj/item/tank/internals/emergency_oxygen(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)

/obj/item/storage/box/useless/on_open(var/mob/M)
	if(isliving(M)) //Prevents ghosts from triggering the box to close.
		flick("uselessbox_close",src)
		addtimer(CALLBACK(src, .proc/close), 8)//As soon as you open the box, it snaps shut

/obj/item/storage/box/useless/proc/close() //Snap shut
	icon_state = initial(icon_state)
	var/datum/component/storage/our_storage = GetComponent(/datum/component/storage)
	visible_message("<span class='boldannounce'>[src] snaps shut!</span>")
	playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
	if(isliving(loc))
		var/mob/living/M = loc
		our_storage.hide_from(M)
		to_chat(M, "<span class='warning'>[src] snaps shut on your fingers!</span>")
		M.adjustStaminaLoss(2)
	sleep(2) //Sleeps that are this small have negligible performance impact
	playsound(src, 'sound/items/bikehorn.ogg', 100, TRUE)