# author: Justin Sheathelm
# title: The Algernon Sequiter


//*****************************    VARIABLES    ********************************

// All possible items
LIST items = Nothing, Gun, Blaster, Gear, Rations, Water, Drugs, Dirty_Orb, Clean_Orb
// Current Player inventory (update from character inventories based on who's currently playable)
LIST player_inventory = (Nothing)
// Character Inventories
LIST algernon_inventory = (Nothing)
LIST ren_inventory = (Nothing)


// Player State
VAR player_speed = 100


// Scene State
VAR current_scene = ""
VAR scene_transition = ""
VAR stage_cue = ""


// Scene Tracking Variables

// ProloguePlanet
VAR intro_complete = false
VAR has_orb = false
VAR looked_back = false
VAR time_passed = false
// PrologueShip
VAR welcomed_home = false


//************************    INVENTORY COMBINATIONS    ************************


== combine_water_dirtyorb ==

    It's clean now.
    ~ player_inventory -= Dirty_Orb
    ~ player_inventory += Clean_Orb
         * [-x-] -> END

//*******************************    STORY    **********************************


== opening ==

    = one

        An aging shuttle sits alone in a vast, empty landscape. Inside, two men wearing hats
        stare somberly out through the expanse to a dark semi-sphere in the distance, 
        half-obscured by dust-filled air. The taller, thinner man in the passenger seat, 
        wearing a wide-brimmed hat and mustache, speaks first.
        `
        “Well.”
        `
        “Well,” says the man in the driver’s seat, wearing a simple military cap.
        `
        The ground quakes and the air a few hundred yards ahead is suddenly opaque with fine, 
        purple-grey dust.
        `
        “Cutting it a little close, eh partner?” says the wide-brimmed man.
        `
        “She can still take a good reading,” says the other, patting the panel of dials on 
        in front of them. After a few more moments of silence, he adds: “You want me to dump
        a grave marker off on my way back through?”
        `
        “Algernon the Intrepid, Hero of the common man! He really took one for humanity’s team
        when, on this very shithole, he made his last stand against the very embodiment of the
        unknown.”
        `
        “Al the Mad Jackass wandered off here for no reason, never to be heard from again.”
        `
        “Comforting in the end, to hear Ren the Morose at his most inspiring.”
        `
        Ren shakes his head. “I’m coming back to pick you up. Might take a week but you have
        the supplies.”

            * [\->] -> two

    = two

        Algernon’s mustache curls in a little smile below his brim and red, tired eyes.
        “Don’t do it partner, I probably won’t come if I see ya. I'll stash the comm right
        here so I can shout if things somehow go different than expected. Besides, she’d
        lose her shit if you told her they had to come back for me.”
        `
        “She’d do it, though.”
        `
        “Yeah, reckon she would just so she could be loud about it later.”
        `
        Another short silence passes before Algernon opens the door, grabs his pack and
        steps outside.”
        `
        “Well.”
        `
        “Well.”
        `
        Algernon closes the door, gives the wall panel a double-tap with his palm and steps
        back a few paces. Ren takes a breath and initiates the takeoff sequence. They wave
        goodbye and a few minutes later the shuttle is leaving atmosphere.

            * [-x-] -> END


== prologue_al ==

    ~ algernon_inventory = (Gun, Gear, Rations, Water, Drugs)
    ~ player_inventory = algernon_inventory
    ~ current_scene = "ProloguePlanet"
    -> start

    = start

        Algernon watches the receding shuttle for a while before adjusting the straps
        of his pack and speaking to the emptiness around him.
        `
        Algernon: "Time to get on with it, the suspense is killing me."

            * [-x-]
            ~ intro_complete = true
            -> END


    = look_back

        The landing site is already indistinguishable from the vastness around it, save
        for a vaguely circular absence of stones where the shuttle's discharge has
        displaced them.

            * [-x-]
            ~ looked_back = true
            -> END



    = item_use

        Algernon scoops it up and peers at it more closely. This doesn't yield much in
        the way of fresh data,  but it does looks rather pretty so he stuffs it into
        his pocket before moving on.

            ~ player_inventory += Dirty_Orb
            ~ has_orb = true
            * [-x-] -> END



    = time_forward

        Algernon glances around at his darkening surroundings.
        ~ time_passed = true

            * [Just what I need.] Algernon: "Lago must have forgotten 'erratic solar cycles' in his
            list of horrible things about this place."
                ~ player_speed = 150
                `
                -> time_forward_choice1

            * [No big deal.] Algernon: "No matter, dimly perceived danger is my favorite sort!"
                `
                -> time_forward_choice2



    = time_forward_choice1

        As he quickens his pace, the fading light seems to do the same.

            * [-x-] -> END



    = time_forward_choice2

        As if in response, the rocky masses along the horizon grow menacing shadowy
        forms in the strange, sudden twilight.

            * [-x-] -> END



    = end

        Algernon trudges recklessly through the gritty darkness until an imposing
        prominence of deeper blackness looms suddenly ahead. Algernon approaches
        brightly through squinted eyes and gritted teeth and spreads his arms wide.
        `
        Algernon: "Here we are, my lovely!"
        `
        He squints his eyes against the darkness and feels around the metallic
        surface for a few moments, finding nothing but unbroken smoothness in every
        direction.
        `
        Algernon: "...Shit."
        `
        He sighs heavily and rests 
        both himself and his pack on the ground. He stays that way, staring far away
        and barely moving, for some time.

            * [\->] -> end2
        // Will eventually need stage cues here


    = end2

        Eventually the familiar, H-shaped pain begins to throb in the back of his skull,
        and the sound of growing whispers emanate from behind his eardrums.
        `
        Algernon: "Here we go. I was starting to worry that I'd spend an evening in
        peace!" His words carry a manic tinge, the sound of slipping sanity.
        `
        An ephemeral, dripping personage begins to takes shape clearly in front of
        Algernon's eyes, either ignorant of--or unconcerned with--any laws governing
        visible light. It materializes making a bizarre combination of gibbering and
        chuckles, still from within Algernon's head.
        `
        "What the fuck?!" Algernon tries to shove himself through the wall at his back
        but only succeeds in kicking up dust.

            * [\->] -> end3



    = end3

        The figure, now basically formed above the waist and perpetually melting onto
        the ground below, bobs and weaves through the air almost drunkenly, wearing
        an enormous and serene ear-to-ear smile. It begins an interminable chant in
        a raspy sing-song, or at least it seems to: its mouth never moves but its
        movements match the timing of the voice in his brain.
        `
        Apparition: "He-ere! He-ere!"
        `
        Algernon: "Nope! I was sufficiently tormented with voices, thank
        you. Think I'll go for one more decent night's sleep."
        `
        Algernon frantically fishes out the last of the precious capsules he'd saved
        for the end and swallows them as quickly as he can.
        ~ player_inventory -= Drugs
            * [\->] -> end4



    = end4

        Apparition: "Yes, yes, star-dust for Algernonnnn."
        `
        The drugs begin their work as quickly as ever, and the nightmare around him
        softens mercifully. Algernon stares wild-eyed at the thing, and before his
        faculties begin to fade a sickening revelation takes shape. What was once
        only whispers and pain is now visible, and seemingly cognizant. It knows
        his name. He imagines some horrible parasite burrowing through his synapses
        these past months, growing and learning how to speak and learning HIM, from
        the inside out. He is vaguely aware of vomiting as his head lolls to the
        side and things go fuzzy.

            * [-x-]
                ~ scene_transition = "PrologueShip"
                ~ current_scene = "PrologueShip"
                -> END










== prologue_ren ==

    ~ algernon_inventory = player_inventory
    ~ ren_inventory = (Blaster)
    ~ player_inventory = ren_inventory
    ~ player_speed = 100
    -> start

    = start

        Ren descends the stairs from the shuttle bay airlock to find the captain and Enri
        waiting for him. The captian looks uneasy but relieved.
        `
        Ren: "Brought your shuttle back."
        `
        Mooney: "Wasnt's worried about that, chief. So, ah...you get him where he needed
        to go?"

            * [Direct] Ren: "Yeah."
                `
                -> start_choice1
            
            * [Sullen] Ren: "I got him where he thought he needed to go."
                `
                -> start_choice2


    = start_choice1

        The captain nods slowly and scratches the back of his neck.
        `
        Mooney: "Well...I just..."
        `
        Ren can't help but smirk a little in spite of his mood. The captain never was
        any good at delicate moments, and Ren had never seen him try harder to pull
        it off than right now.
        `
        Mooney: "...I'm glad you're back."

            * [Show gratitude] Ren: "Thanks, Cap."
                `
                -> cap_leaves
            
            * [Stay silent] Ren: "..."
                `
                -> cap_leaves

    = start_choice2

        The captain's discomfort grows visibly.
        `
        Mooney: "Mmm...you know, sometimes...ah, forget it."
        `
            * [\->] -> cap_leaves


    = cap_leaves

        Clearly exhausted from the effort, the captain retreats back to the bridge.
        ~ stage_cue = "cap_leaves"

            * [\->] -> enri_chat


    = enri_chat

        Enri stays behind and scrutinizes Ren, seeing what she can read.
        `
        Enri: *nodding in the direction the captain fled* "He does his best."
        `
        Ren: "I know it."
        
            * [\->]
                ~ stage_cue = "enri_approaches"
                -> enri_chat2


    = enri_chat2

        Enri: "Listen...it's no secret Al & I didn't get along, but I want you to know
        I haven't enjoyed the situation. At all. And for it to end like this, I--"
        `
        She gives a short expression of sympathy and turns to go. She stops at the
        doorway for a moment before leaving and looks back over her shoulder.
        `
        Enri: "Welcome home, Ren."

            * [\->]
                ~ stage_cue = "enri_leaves"
                -> left_alone


    = left_alone

        As Ren watches Enri go he feels compelled to write something down, to bear witness.
        This is not a common urge for Ren, but it is the only non-violent outlet he can
        think of for his current energy.
        `
        He decides to start tonight in his cabin, though it might help to try and clear
        his head first. Ren's preferred activity for clearing the mind has long been
        perimeter checks; might help to check out the state of things around the ship,
        take inventory of what needs patching up.

            * [-x-]
            ~ welcomed_home = true
            ->END
            // This could be a choice to go to his cabin right away or wander around first



    = end

        Ren stares at the screen in front of him for a few seconds, blinks, and 
        begins typing at a steady pace.
        `
        "I first met Algernon five years ago..."
        `
        (To be continued)

            * [-x-]
            ~ stage_cue = "quit"
            ->END