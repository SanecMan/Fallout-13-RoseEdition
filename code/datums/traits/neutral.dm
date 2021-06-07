//traits with no real impact that can be taken freely
//MAKE SURE THESE DO NOT MAJORLY IMPACT GAMEPLAY. those should be positive or negative traits.

/datum/quirk/no_taste
	name = "Агевзия"
	desc = "Вы не чуствуете вкус еды или реагентов."
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = "<span class='notice'>Не чуствую язык.</span>"
	lose_text = "<span class='notice'>Чуствую язык снова.</span>"
	medical_record_text = "Пациент страдает агевзией и не может пробовать пищу или реагенты."

/datum/quirk/pineapple_liker
	name = "Ананасовый Любитель"
	desc = "Вы очень наслаждаетесь ананасами или продуктами из ананасов."
	value = 0
	gain_text = "<span class='notice'>Хочу сьесть ананас.</span>"
	lose_text = "<span class='notice'>Не чуствую такой привязаности а ананасам.</span>"

/datum/quirk/pineapple_liker/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food &= ~PINEAPPLE

/datum/quirk/pineapple_hater
	name = "Ananas Aversion"
	desc = "Ананас зло. Блядь вы реально думаете что ананас вкусный?"
	value = 0
	gain_text = "<span class='notice'>Ненавижу ананас.</span>"
	lose_text = "<span class='notice'>Не думаю что ананасы такие уж и плохие.</span>"

/datum/quirk/pineapple_hater/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food &= ~PINEAPPLE

/datum/quirk/deviant_tastes
	name = "Девиантные Вкусы"
	desc = "Вы не любите пищу, которая нравится большинству людей, и находите вкусной то, что им не нравится."
	value = 0
	gain_text = "<span class='notice'>Странная еда мне нравится больше чем нормальная.</span>"
	lose_text = "<span class='notice'>Теперь я люблю нормальную еду.</span>"

/datum/quirk/deviant_tastes/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	var/liked = species.liked_food
	species.liked_food = species.disliked_food
	species.disliked_food = liked

/datum/quirk/deviant_tastes/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food = initial(species.liked_food)
		species.disliked_food = initial(species.disliked_food)

/datum/quirk/prosthetic_limb
	name = "Протез"
	desc = "Ваша конечность была заменена на протез."
	value = 0
	var/slot_string = "limb"

/datum/quirk/prosthetic_limb/on_spawn()
	var/limb_slot = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/bodypart/old_part = H.get_bodypart(limb_slot)
	var/obj/item/bodypart/prosthetic
	switch(limb_slot)
		if(BODY_ZONE_L_ARM)
			prosthetic = new/obj/item/bodypart/l_arm/robot/surplus(quirk_holder)
			slot_string = "left arm"
		if(BODY_ZONE_R_ARM)
			prosthetic = new/obj/item/bodypart/r_arm/robot/surplus(quirk_holder)
			slot_string = "right arm"
		if(BODY_ZONE_L_LEG)
			prosthetic = new/obj/item/bodypart/l_leg/robot/surplus(quirk_holder)
			slot_string = "left leg"
		if(BODY_ZONE_R_LEG)
			prosthetic = new/obj/item/bodypart/r_leg/robot/surplus(quirk_holder)
			slot_string = "right leg"
	prosthetic.replace_limb(H)
	qdel(old_part)
	H.regenerate_icons()

/datum/quirk/prosthetic_limb/post_add()
	to_chat(quirk_holder, "<span class='boldannounce'>К вашему телу была приделана ''Rob'co [slot_string] surplus'' вместо старой конечности, \
	используйте провода и сварку вместо мазей и бинтов соответственно. Также протез соединён с кровеносной системой, так что \
	рекомендуется устранять поломку конечности как можно быстрее.</span>")

/datum/quirk/family_heirloom
	name = "Семейная Реликвия"
	desc = "Вы - нынешний владелец семейной реликвии, передаваемой из поколения в поколение. Вы должны сохранить реликвию в бзопасности!"
	value = 0
	mood_quirk = TRUE
	var/obj/item/heirloom
	var/where

/datum/quirk/family_heirloom/on_spawn() //Добавить к каждой проффессии реликвию
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/heirloom_type
	switch(quirk_holder.mind.assigned_role)
		if("Clown")
			heirloom_type = /obj/item/bikehorn/golden
		if("Mime")
			heirloom_type = /obj/item/reagent_containers/food/snacks/baguette
		if("Lawyer")
			heirloom_type = /obj/item/gavelhammer
		if("Janitor")
			heirloom_type = /obj/item/mop
		if("Security Officer")
			heirloom_type = /obj/item/book/manual/wiki/security_space_law
		if("Scientist")
			heirloom_type = /obj/item/toy/plush/slimeplushie
		if("Assistant")
			heirloom_type = /obj/item/storage/toolbox/mechanical/old/heirloom
	if(!heirloom_type)
		heirloom_type = pick(
		/obj/item/toy/cards/deck,
		/obj/item/lighter,
		/obj/item/dice/d20)
	heirloom = new heirloom_type(get_turf(quirk_holder))
	var/list/slots = list(
		"в левом кармане" = SLOT_L_STORE,
		"в правом кармане" = SLOT_R_STORE,
		"в сумке" = SLOT_IN_BACKPACK
	)
	where = H.equip_in_one_of_slots(heirloom, slots, FALSE) || "at your feet"

/datum/quirk/family_heirloom/post_add()
	if(where == "в сумке")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, "<span class='boldnotice'>[heirloom.name], являющиеся семейной реликвией, сейчас лежит [where]. Сохраните её в безопасности!</span>")
	var/list/family_name = splittext(quirk_holder.real_name, " ")
	heirloom.name = "\improper [family_name[family_name.len]] family [heirloom.name]"

/datum/quirk/family_heirloom/on_process()
	if(heirloom in quirk_holder.GetAllContents())
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom_missing")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom", /datum/mood_event/family_heirloom)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom_missing", /datum/mood_event/family_heirloom_missing)

/datum/quirk/family_heirloom/clone_data()
	return heirloom

/datum/quirk/family_heirloom/on_clone(data)
	heirloom = data

/datum/quirk/nearsighted //t. errorage
	name = "Близорукость"
	desc = "У вас проблемы со зрением, из-за чего у вас появляется пара очков для глаз без рецепта."
	value = 0
	gain_text = "<span class='danger'>Глаза болят.</span>"
	lose_text = "<span class='notice'>Начинаю нормально видеть.</span>"
	medical_record_text = "Пациенту требуются очки по рецепту, чтобы противодействовать близорукости."

/datum/quirk/nearsighted/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nearsighted/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/regular/glasses = new(get_turf(H))
	H.put_in_hands(glasses)
	H.equip_to_slot_if_possible(glasses, SLOT_GLASSES)
	H.regenerate_icons() //this is to remove the inhand icon, which persists even if it's not in their hands

/datum/quirk/monochromatic
	name = "Монохромность"
	desc = "У вас полный дальтонизм и воспринимаете почти весь мир в черно-белых тонах."
	value = 0
	medical_record_text = "Пациент страдает ахроматопсией и видит весь мир в чёрно-белых оттенках."

/datum/quirk/monochromatic/add()
	quirk_holder.add_client_colour(/datum/client_colour/monochrome)

/datum/quirk/monochromatic/post_add()
	if(quirk_holder.mind.assigned_role == "Detective") //Добавить сюда шерифа
		to_chat(quirk_holder, "<span class='boldannounce'>Жизнь была прекрасна... Закат освещает прекрасный летний вечер, в воздухе висит запах свежескошенной травы с газонов, где-то смеются и кричат дети. Дом за рекой... где тебя ждут красавица-жена и чудесная маленькая дочка. Настоящий воздушный замок, ставший реальностью. Вот только если бы воздушные замки не разрушались так быстро, пока на них не смотрят.</span>")
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	if(quirk_holder)
		quirk_holder.remove_client_colour(/datum/client_colour/monochrome)
