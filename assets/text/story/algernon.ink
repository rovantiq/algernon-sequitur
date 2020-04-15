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
VAR has_stone = false
VAR animal_encountered = false
VAR ledge_approached = false
VAR animal_gone = false
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

    Algernon rummages through his pack and takes inventory.
    ~ player_inventory -= Gear
    ~ player_inventory += Rations
    ~ player_inventory += Water
    ~ player_inventory += Rope
    ~ player_inventory += Harpoon_Kit
         * [-x-] -> END

== combine_rope_harpoonkit ==

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


== example_knot

    = example_stitch

        Lorem Ipsum.

            * [\->] 
            #~ variable = value
            -> END
            * [-x-] -> END


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

        An aging shuttle sits alone in a vast, empty landscape. Inside, two men wearing hats
        stare somberly through the expansive landscape ahead to a distant dust storm on the 
        horizon. The cloud must have been miles across but took up little of the view; it
        was vaguely semi-sphere shaped and held a vague semisphere of deeper darkness at its
        center. The man in the passenger seat, who wears a wide-brimmed hat and mustache,
        speaks first.
        `
        “Well.”
        `
        “Well,” says the man in the driver seat, wearing a simple military cap.
        `
        After a few more moments of silence, the driver adds: “You want me to drop a grave
        marker off on my way back?” 
        `
        “Algernon the Intrepid, plumbing The Depths of the Unknown to the bitter end.”
        `
        “Al the Mad Jackass wandered off here for no reason, never to be heard from again.”
        `
        “Comforting in the end, to hear Ren the Morose at his most inspiring.”
        `
        Ren shakes his head. “I’m coming back to pick you up. Might take a week but you have
        the supplies.”

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

        A curious, purposefully-arranged pile of stones to the side of the path catches
        Algernon’s eye.
        `
        \*** When you see an indicator for an interaction, press ACCEPT to see the
        available options. Press ACCEPT again to select the highlighted option.
        Try the LOOK and USE options on the nearby pile of stones.***

            * [-x-]
            -> END
    

    = look_stones

        The arrangement appears to have taken no small amount of time and concentration.
        The crown jewel is a prefectly smooth and symmetrical geologic wonder; Algernon
        cannot help but imagine it being flung singing through the air.

            + [-x-]
            -> END


    = collect_stone

        The stone sits in Algernon's grip as if it was made for his hand. He slips it into
        his pocket with preternatural satisfaction.

            * [-x-]
            ~ player_inventory += Stone
            ~ has_stone = true
            -> END





    = animal_encounter

        The way is blocked by an unfamiliar beast feeding on something in the path.
        Algernon eyes the animal warily, and the animal does the same right back.
        It seems be asking for a projectile to the head, by Algernon's reckoning.
        `
        \*** Other common options include TALK and USE WITH. Get rid of the animal
        using the available options. ***

            * [-x-]
            ~ animal_encountered = true
            -> END



    = beast_look

        text
            + [-x-]
            -> END


    = beast_use

        text
            * [-x-]
            -> END


    = beast_talk

        text
            * [-x-]
            -> END


    = beast_rock

        Rock thrown.

            * [-x-]
            ~ player_inventory -= Stone
            ~ stage_cue = "rock_thrown"
            ~ animal_gone = true
            -> END
    

    = beast_gun

        text
            * [-x-]
            -> END





    = ledge_approach

        A big ledge! Open the backpack in the inventory by selecting it twice,
        then combine the rope and harpoon kit by selecting one then the other.
        Finally, use the new item on the ledge to continue.

            * [-x-]
            ~ ledge_approached = true
            -> END


    = harpoon

        The blades sink into the wood with a satisfying thud, but it's quickly
        followed by the sharp sound of air under pressure escaping. Guess the 
        pneumatics are shot.

            * [-x-]
            ~ player_inventory -= Rope_Dart
            -> END
    

    = climb

        After a few clumsy attempts, Algernon manages to scramble over the ledge.

            * [-x-]
            ~ climbed_ledge = true
            ~ player_inventory += Rope
            ~ stage_cue = "climb_ledge"
            -> END





    = getting_late

        Getting dark...

            * [-x-]
            -> END


    = too_dark

        The path ahead melts into a hazy mass of rock and shadow. Time to set up camp.

            * [-x-]
            ~ looked_ahead = true
            -> END


    = look_clearing

        A good spot.

            * [-x-]
            -> END


    = go_clearing

        Algernon sets up camp for the night.

            * [-x-]
            -> END


    = end

        ~ stage_cue = "camp"
        
        Algernon begins to hear the familiar whispering behind his ears. At first it's
        like most nights but sharper somehow, and a little nauseating. He swallows a
        capsule preemptively and closes his eyes, trying to filter out the sounds as
        he'd practiced.
        `
        Before long he is overcome with a new and terrible fear, and spends the next
        half-hour chasing glimpses of shadowy figures darting in and out of his
        peripheral vision with a flashlight. By the time he succumbs to chemical
        slumber, any remaining doubts he had regarding the connection between this
        planet and his affliction were gone.

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
        He decides to start later on tonight in his cabin, once he clears his head. Ren
        usually found perimeter checks the most effective way to calm his moods, a remnant
        from more violent times. He pats the diagnostic scanner in his pocket and plans his
        route around the ship.

            * [-x-]
            ~ welcomed_home = true
            ->END





    = scan_interaction

        Lorem ipsum.

            * [-x-]
            ->END





    = end

        Ren sits at the desk, brings up the notepad interface, and looks at the blank screen
        for a few moments before beginning to type awkwardly on the desk's surface.
        `
        `
        \*** To be continued... ***

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
	* Trigger		    - animal encounter (explain/suggest "use with")

	* Interactions		- throw rock to progress
				        - (optional) shoot revolver instead
				        - look at beast
				        - use
				        - talk to beast ("talk" example, try to scare it off)
	* Trigger		    - Encounter ledge (explain opening inventory and using item on itself)
	* Inventory		    - Open gear, revealing more items (explain item combinations)
	* Inventory		    - Combine two of the revealed items (suggest final step?)
	* Interaction		- Use combined item on the ledge
	* Trigger		    - Getting dark.
	* Trigger		    - Can't go further.
	* Trigger		    - see clearing after turning back ("go" example)
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






He glances down at his pistol and thinks a thought for the thousandth time.

*/