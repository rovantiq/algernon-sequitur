# author: Justin Sheathelm
# title: The Algernon Sequiter




//********************************************************************************
//********************************************************************************
//*******************************    VARIABLES    ********************************
//********************************************************************************
//********************************************************************************





// All possible items
LIST items = Nothing, Revolver, Drugs, Gear, Stone, Rations, Water, Rope, Harpoon_Kit, Rope_Dart, M1911, Scanner
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
VAR looked_back = false
VAR noticed_stones = false
VAR has_stone = false
VAR animal_encountered = false
VAR ledge_approached = false
VAR animal_gone = false
VAR animal_shot = false
VAR climbed_ledge = false
VAR looked_ahead = false
// PrologueShip
VAR welcomed_home = false





//********************************************************************************
//********************************************************************************
//*************************    INVENTORY COMBINATIONS    *************************
//********************************************************************************
//********************************************************************************





== open_gear ==

    Algernon rummages through his pack and takes inventory. He is pleased to find
    precisely what he needs. Just a small amount of assembly required.
    `
    \*** Combine two inventory items by selecting both with INVENTORY/SELECT ***

    ~ player_inventory -= Gear
    ~ player_inventory += Rations
    ~ player_inventory += Water
    ~ player_inventory += Rope
    ~ player_inventory += Harpoon_Kit
         * [-x-] -> END

== combine_rope_harpoonkit ==

    He feeds the rope through an opening in the chassis, then pulls a length through
    and knots it securely to the stem of the hook. Then he pulls the the rope back
    through until the hook latches into the bore with a click. He admires the device
    proudly, feeling ready to tackle any vertical obstacle (within reason).
    `
    Algernon: "I've always maintained that rock climbing is an utter waste of time."

    ~ player_inventory -= Rope 
    ~ player_inventory -= Harpoon_Kit
    ~ player_inventory += Rope_Dart

         * [-x-] -> END





//********************************************************************************
//********************************************************************************
//*********************************    STORY    **********************************
//********************************************************************************
//********************************************************************************
/*
TABLE OF CONTENTS:

    PROLOGUE-AL
    PROLOGUE-REN
    CH.1

*/


== testing ==

    ~ algernon_inventory = (Revolver, Drugs, Gear)
    ~ player_inventory = algernon_inventory
    ~ current_scene = "ProloguePlanet"
    -> END


== testing2 ==

    ~ algernon_inventory = player_inventory
    ~ ren_inventory = (M1911, Scanner)
    ~ player_inventory = ren_inventory
    ~ current_scene = "PrologueShip"
    -> END





== opening ==

    = one

        An aging shuttle sits alone in a vast, empty landscape. Inside, two men wearing
        hats stare somberly ahead to a distant dust storm on the horizon. The cloud must
        have been miles across but took up little of the view; it was vaguely semisphere
        and contained a deeper darkness at its core, like a rotten fruit pit swarming
        with insects. The man in the passenger seat, who wears a wide-brimmed hat and a
        mustache, speaks first.
        `
        “Well.”
        `
        “Well,” says the man in the driver seat, wearing a simple military cap.
        `
        After a few more moments of silence, the driver adds: “You want me to drop a
        grave marker off on my way back?” 
        `
        “Algernon the Intrepid, plumbing The Depths of the Unknown to the bitter end.”
        `
        “Al the Mad Jackass wandered off here for no reason, never to be heard from
        again.”
        `
        “Comforting in the end, to hear Ren the Morose at his most inspiring.”
        `
        Ren shakes his head. “I’m coming back to pick you up. Might take a week but you
        have the supplies.”

            * [\->] -> two

    = two

        Algernon’s mustache curls in a little smile below the brim of his hat and his red,
        tired eyes. “Don’t do it partner, I probably won’t come, assuming I even see you.
        I'll stash the transmitter here so I can shout if things somehow go different than
        expected. Anyway she’d lose her shit if you told her they had to come back for me.”
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
        back a few paces. Ren initiates the takeoff sequence, they wave goodbye and a few
        minutes later the shuttle is leaving atmosphere.

            * [-x-] -> END





//********************************************************************************
//********************************   PROLOGUE-AL   *******************************
//********************************************************************************





== prologue_al ==

    ~ algernon_inventory = (Revolver, Drugs, Gear)
    ~ player_inventory = algernon_inventory
    ~ current_scene = "ProloguePlanet"
    -> start


    = start

        Algernon watches the receding shuttle for a while before adjusting the straps
        of his pack and announcing his intentions to the surrounding wilderness.
        `
        Algernon: "Well, time to get on with it!"

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





    = notice_stones

        ~ noticed_stones = true
        
        A curious, purposefully-arranged pile of stones to the side of the path catches
        Algernon’s eye.

            * [-x-]
            -> END
    

    = look_stones

        The arrangement appears to have taken no small amount of time and concentration.
        The crown jewel is a perfectly smooth and symmetrical geologic wonder; Algernon
        cannot help but imagine it being flung, singing, through the air.

            + [-x-]
            -> END


    = collect_stone

        The stone sits in Algernon's grip as if it was made for his hand. He slips it into
        his pocket with a deep satisfaction.

            * [-x-]
            ~ player_inventory += Stone
            ~ has_stone = true
            -> END





    = animal_encounter

        The way is blocked by an unfamiliar beast rooting around in the path.

            * [-x-]
            ~ animal_encountered = true
            -> END



    = beast_look

        Algernon eyes the animal warily, and the animal does the same right back.
        It seems be asking for a projectile to the head, by Algernon's reckoning.

            + [-x-]
            -> END


    = beast_use

        Algernon shakes his fist with all the menacing he can muster, but the beast
        remains.

            + [-x-]
            -> END


    = beast_talk

        Algernon yells and waves his arms wildly. He gets a twitch of an ear for his
        trouble.

            + [-x-]
            -> END


    = beast_rock

        ~ stage_cue = "rock_thrown"
        ~ player_inventory -= Stone
        ~ animal_gone = true

        Algernon withdraws the stone from his pocket and considers it's weighted
        perfection once more. Suddenly he is slinging his arm, quick as a whip, 
        and the stone sails true until it lands between the beasts eyes and is
        sent clattering to parts unknown.
        `
        The beast stares aghast with shock and outrage, likely never having
        suffered such an affront in it's desolate habitat. Algernon stares
        back, his hand resting importantly on his revolver. The beast can
        take a hint; it lopes off the path and down the rocky ledge, glancing 
        back once with what Algernon imagines is a vengeful expression.

            * [-x-]
            -> END
    

    = beast_gun

        ~ stage_cue = "beast_shot"
        ~ animal_shot = true
        ~ animal_gone = true

        In no mood for any bullshit today, Algernon quickdraws his pistol and
        fires off a shot. The bullet sinks into the beast's shoulder, sending
        it tumbling and howling out of Algernon's hair forever.

            * [-x-]
            -> END





    = ledge_approach

        He approaches the ledge beaming with satisfaction, as he had come prepared
        for just such an occasion! He vividly recalled packing the necessary
        components in the main compartment of his backpack while the others mocked
        him for it.
        `
        \*** Open the inventory by pressing INVENTORY/SELECT. Then move to the
        backpack and select it TWICE with INVENTORY/SELECT to use it. ***

            * [-x-]
            ~ ledge_approached = true
            -> END


    = ledge_look

        That's well within harpooning distance.

            + [-x-]
            -> END
    

    = ledge_use

        Algernon would prefer not to scale rock faces. Besides, he's packed for this.

            + [-x-]
            -> END


    = ledge_harpoon

        ~ player_inventory -= Rope_Dart

        The blades sink into the wood with a satisfying thud, but it's quickly
        followed by the sharp sound of air under pressure quickly escaping.
        Must be the pneumatics are shot. Algernon squints sourly skyward.
        `
        Algernon: Already this journey is tainted with sacrifice and injustice.

            * [-x-]
            -> END
    

    = climb

        ~ climbed_ledge = true
        ~ player_inventory += Rope

        After a few clumsy attempts, Algernon manages to pull himself up the rope
        and scramble over the ledge.

            * [-x-]
            ~ stage_cue = "climb_ledge"
            -> END





    = getting_late

        The surroundings grow menacing angles as twilight sets in.

            * [-x-]
            -> END


    = too_dark

        ~ looked_ahead = true
        ~ stage_cue = "looking_for_camp"
        The path ahead melts into a hazy mass of rock and shadow. Better turn back and
        find a spot to set up camp.

            * [-x-]
            -> END


    = look_clearing

        Decent spot, flat.

            + [-x-]
            -> END


    = go_clearing

        Algernon sets to work pitching his tent and starting a fire.

            * [-x-]
            -> END


    = end

        ~ stage_cue = "camp"
        
        Algernon begins to hear the familiar whispering behind his ears. At first it's
        like most nights but sharper somehow, and a little nauseating. He glances down
        at his pistol and thinks a thought for the thousandth time, then swallows a
        capsule preemptively and closes his eyes, trying to filter out the sounds as
        he'd practiced.
        `
        Before long he is overcome with a new and terrible fear, and spends the next
        half-hour chasing glimpses of shadowy figures darting in and out of his
        peripheral vision. By the time he succumbs to chemical slumber, any remaining
        doubts regarding the connection between this planet and his affliction are
        gone.

            * [-x-]
                ~ scene_transition = "PrologueShip"
                -> END





//********************************************************************************
//*******************************   PROLOGUE-REN   *******************************
//********************************************************************************





== prologue_ren ==

    ~ algernon_inventory = player_inventory
    ~ ren_inventory = (M1911, Scanner)
    ~ player_inventory = ren_inventory
    ~ current_scene = "PrologueShip"
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

        Enri: "Listen...it's no secret Al and I didn't get along, but I want you to know
        I haven't enjoyed any of this. And for things to end this way, I just--"
        `
        She stops short, opting instead for a quick but earnest look of pained sympathy,
        and turns to go. She stops at the doorway for a moment before leaving and looks
        back over her shoulder.
        `
        Enri: "Welcome home, Ren."

            * [\->]
                ~ stage_cue = "enri_leaves"
                -> left_alone


    = left_alone

        As Ren watches Enri go he feels compelled to record something, to bear witness.
        He hasn't written much as an adult beyond formal reports and coded messages,
        but organizing the facts and filing a report to no one is the only non-violent
        outlet he can think of for his current energy.
        `
        He decides to start later on tonight in his cabin after he clears his head. Ren
        traditionally relied on perimeter checks to calm his moods, a remnant from more
        violent times. He pats the diagnostic scanner in his pocket and plans his route
        around the ship.

            * [-x-]
            ~ welcomed_home = true
            ->END





    = engine_door_look

        Ren: The bulkhead doors seperating the engine module from the cargo module. 

            * [-x-]
            ->END


    = engine_door_use

        Ren: The ship is under heavy thrust, too much radiation to go inside. The
        doors are on lockdown even if I was crazy enough to suicide by drive core.

            * [-x-]
            ->END


    = engine_door_scan

        The scanner briefly fires a purple cone of light as Ren runs a quick rad
        reading before plugging the it into the diagnostic port near the locking
        collar controls.
        `
        The readings are nominal, but higher than the prior reading, which was 
        higher than the one before that. They're close to paying off the ship, 
        so repairs are being delayed. Important ones.

            * [\->]
            -> engine_door_scan2
    
    = engine_door_scan2

        The scanner blinks steadily as it accumulates data. Ren had only ever been
        inside the engine module with Enri, to assist with repairs. Not that he
        wasn't allowed, but it wasn't his ship and he never had a reason. Ren was
        handy enough but Enri knew ship-tech, went to school for it somewhere. She
        came from money, that was obvious, but the details of her past, including
        how she ended up running a freighter with someone like the captain, were
        never offered.
        `
        The scanner finishes its business. It notes some weaknesses in the seal,
        confirming the rad scan, but otherwise the engine systems come back green.
        Ren pockets the scanner.

            * [-x-]
            ->END



    = mooney_look

        Lorem ipsum.

            * [-x-]
            ->END


    = mooney_talk

        Lorem ipsum.

            * [-x-]
            ->END



    = enri_look

        Lorem ipsum.

            * [-x-]
            ->END


    = enri_talk

        Lorem ipsum.

            * [-x-]
            ->END



    = shuttle_bay_look

        Lorem ipsum.

            * [-x-]
            ->END


    = shuttle_bay_use

        Lorem ipsum.

            * [-x-]
            ->END


    = shuttle_bay_scan

        Lorem ipsum.

            * [-x-]
            ->END



    = big_shuttle_look

        Lorem ipsum.

            * [-x-]
            ->END


    = big_shuttle_use

        Lorem ipsum.

            * [-x-]
            ->END


    = big_shuttle_scan

        Lorem ipsum.

            * [-x-]
            ->END



    = small_shuttle_look

        Lorem ipsum.

            * [-x-]
            ->END


    = small_shuttle_use

        Lorem ipsum.

            * [-x-]
            ->END


    = small_shuttle_scan

        Ren: I'll leave that to Enri. Feels like an invasion of privacy.

            + [-x-]
            ->END



    = mess_look

        Lorem ipsum.

            * [-x-]
            ->END


    = mess_use

        Lorem ipsum.

            * [-x-]
            ->END


    = mess_scan

        Lorem ipsum.

            * [-x-]
            ->END



    = storage_look

        Lorem ipsum.

            * [-x-]
            ->END


    = storage_use

        Lorem ipsum.

            * [-x-]
            ->END


    = medical_look

        Lorem ipsum.

            * [-x-]
            ->END


    = medical_use

        Lorem ipsum.

            * [-x-]
            ->END


    = medical_scan

        Lorem ipsum.

            * [-x-]
            ->END



    = cargo_look

        Lorem ipsum.

            * [-x-]
            ->END


    = cargo_use

        Lorem ipsum.

            * [-x-]
            ->END


    = cargo_scan

        Lorem ipsum.

            * [-x-]
            ->END



     hoverbike_look

        Lorem ipsum.

            * [-x-]
            ->END


    = hoverbike_use

        Lorem ipsum.

            * [-x-]
            ->END


    = hoverbike_scan

        Lorem ipsum.

            * [-x-]
            ->END
    


    = dorm_look

        Lorem ipsum.

            * [-x-]
            ->END


    = dorm_use

        Lorem ipsum.

            * [-x-]
            ->END



    = al_room_look

        Lorem ipsum.

            * [-x-]
            ->END


    = al_room_use

        Lorem ipsum.

            * [-x-]
            ->END



    = ren_room_look

        Lorem ipsum.

            * [-x-]
            ->END


    = ren_room_use

        Lorem ipsum.

            * [-x-]
            ->END




    = desk_look

        Lorem ipsum.

            * [-x-]
            ->END


    = desk_use

        Lorem ipsum.

            * [-x-]
            ->END


    = end

        Ren sits at the desk, brings up the notepad interface, and looks at the blank screen.
        Eventually he begins typing with slow and cumbersome movements on the desk's surface.

            * [-x-]
            ~ stage_cue = "quit"
            ->END





//********************************************************************************
//********************************      CH.1      ********************************
//********************************************************************************





    == chapter1

        = start

            ->END





//********************************************************************************
//********************************************************************************
//*********************************    NOTES    **********************************
//********************************************************************************
//********************************************************************************
/*




Planet - Rewrite as tutorial


* Trigger		    - see a pile of stones (explain/suggest "look" & "use")
* Interactions		- pick up stone
                    - look at stones
* Trigger		    - animal encounter (explain/suggest "use with" & "talk")
* Interactions		- throw rock to progress
                    - (optional) shoot revolver instead
                    - look at beast
                    - use
                    - talk to beast ("talk" example, try to scare it off)
* Trigger		    - Encounter ledge (explain opening inventory and using item on itself)
* Inventory		    - Open gear, revealing more items (explain item combinations)
* Inventory		    - Combine two of the revealed items (suggest final step?)
* Interaction		- Use combined item on the ledge (explain/suggest "go")
* Interaction       - "Go" up the 
* Trigger		    - Getting dark.
* Trigger		    - Can't go further.
* Trigger		    - see clearing after turning back
* Interactions		- go to clearing and end
                    - look at clearing
* End			    - Hearing whispers, subtle struggle with sanity; drugs to sleep



Ship - Add interactions and rework intro as needed


	* Chat with Mooney 	- look, talk
	* Chat with Enri 	- look, talk
	* Shuttles 		    - look, use, scan
	* Mess 			    - look, use, scan
	* Storage 		    - look, use (inventory supplies)
	* Medical 		    - look, use, scan
* Engineering doors - look, use, scan
	* Cargo 		    - look, use, scan (door?)
	* Hoverbike 		- look, use, scan
	* Lounge 	    	- look, use
	* Al's old room 	- look, use
	* Ren's room? 		- look, use
	* Desk 			    - look, use


*/


== example_knot

    = example_stitch

        Lorem Ipsum.

            * [\->] 
            #~ variable = value
            -> END
            * [-x-] -> END



    = example_look

        Lorem ipsum.

            * [-x-]
            ->END


    = example_use

        Lorem ipsum.

            * [-x-]
            ->END


    = example_use_with

        Lorem ipsum.

            * [-x-]
            ->END
