# author: Justin Sheathelm
# title: The Algernon Sequiter


//*****************************    VARIABLES    ********************************

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


//************************    INVENTORY COMBINATIONS    ************************


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

//*******************************    TESTING    **********************************


== testing ==

    ~ algernon_inventory = (Revolver, Drugs, Gear)
    ~ player_inventory = algernon_inventory
    ~ current_scene = "ProloguePlanet"
    -> END


== testing2 ==

    ~ algernon_inventory = player_inventory
    ~ ren_inventory = (M1911, Scanner)
    ~ player_inventory = ren_inventory
    -> END


//*******************************    STORY    **********************************


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


== prologue_al ==

    ~ algernon_inventory = (Revolver, Drugs, Gear)
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



    = collect_stone

        Stone collected.

            * [-x-]
            ~ player_inventory += Stone
            ~ has_stone = true
            -> END



    = animal_encounter

        Animal encounter!

            * [-x-]
            ~ animal_encountered = true
            -> END



    = beast_rock

        Rock thrown.

            * [-x-]
            ~ player_inventory -= Stone
            ~ stage_cue = "rock_thrown"
            ~ animal_gone = true
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


    = too_dark

        The path ahead melts into a hazy mass of rock and shadow. Time to set up camp.

            * [-x-]
            ~ looked_ahead = true
            -> END

    = end

        ~ stage_cue = "camp"
        
        Algernon sets up camp for the night.

            * [-x-]
                ~ scene_transition = "PrologueShip"
                ~ current_scene = "PrologueShip"
                -> END










== prologue_ren ==

    ~ algernon_inventory = player_inventory
    ~ ren_inventory = (M1911, Scanner)
    ~ player_inventory = ren_inventory
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
            // This could be a choice to go to his cabin right away or wander around first



    = end

        Ren sits at the desk, brings up the notepad interface, and looks at the blank screen
        for a few moments before beginning to type awkwardly on the desk's surface.
        `
        `
        To be continued...

            * [-x-]
            ~ stage_cue = "quit"
            ->END