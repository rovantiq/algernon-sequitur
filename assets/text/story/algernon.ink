# author: Justin Sheathelm
# title: The Algernon Sequiter



//********************************************************************************
//********************************************************************************
//********************************   VARIABLES   *********************************
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
//********************************   INVENTORY   *********************************
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
    //********************************************************************************
    //********************************      INTRO      *******************************
    //********************************************************************************





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



        == testing ==

            ~ algernon_inventory = (Revolver, Drugs, Gear)
            ~ player_inventory = algernon_inventory
            ~ current_scene = "ProloguePlanet"
            -> END


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

                Algernon aims for an overhanging tree, and the blades sink into the wood
                with a satisfying thud, but it's quickly followed by the sharp sound of
                air under pressure quickly escaping. Not a good sound. Algernon squints
                sourly skyward.

                    * [-x-]
                    -> END
            

            = climb

                ~ climbed_ledge = true
                ~ player_inventory += Rope

                After a few clumsy attempts, Algernon manages to pull himself up the rope
                and scramble over the ledge. Once at the top, he inspects the device
                somberly before working it out of the wood and salvaging the remains. 

                    * [-x-]
                    ~ stage_cue = "climb_ledge"
                    -> END





            = getting_late

                ~ stage_cue = "getting_late"

                The surroundings grow menacing angles as twilight sets in.

                    * [-x-]
                    -> END


            = too_dark

                ~ looked_ahead = true
                ~ stage_cue = "looking_for_camp"

                The path ahead melts into a hazy mass of rock and shadow. Better turn back
                and find a spot to set up camp.

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
                at his pistol and thinks a thought for the thousandth time. Then he swallows a
                capsule preemptively and closes his eyes, trying to filter out the sounds like
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
    //********************************   PROLOGUE-REN   ******************************
    //********************************************************************************


        == testing2 ==

            ~ algernon_inventory = player_inventory
            ~ ren_inventory = (M1911, Scanner)
            ~ player_inventory = ren_inventory
            ~ current_scene = "PrologueShip"
            -> END


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

                    + [-x-]
                    ->END


            = engine_door_use

                Ren: The ship is under heavy thrust, too much radiation to go inside. The
                doors are on lockdown even if I was crazy enough to suicide by drive core.

                    + [-x-]
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

                Ren: The captain, sitting in the pilot's chair where he spends most of his
                time, far away with his ship and his music.

                    + [-x-]
                    ->END
            
            = mooney_look2

                Ren: He says the music helps with his migraines. He was a jack-junkie in his
                younger days, still has a working port & adapters for most common stuff.
                Must have tried interfacing with some weird shit back then, he's a mess when
                the migraines come around.

                    + [-x-]
                    ->END
            
            = mooney_look3

                Ren: He goes by 'Mooney' but it's not his real name. Guess it's supposed to
                be some kind of a call-sign, but it's a shit one so I just call him 'the
                captain', or 'cap'. 

                    + [-x-]
                    ->END


            = mooney_talk

                Ren: "Hey cap."
                `
                Mooney: "Hey chief, what's up?"

                    * [Ask about him.] Ren: "Just checking in. Wanna say again how much I appreciate
                    you going out of your way for this crazy business of ours. Things good
                    with you?" -> mooney_check_cap
                    * [Ask about ship.] Ren: "Just doing the rounds, trying to keep myself busy.
                    She's been flying right?" -> mooney_check_ship


            = mooney_check_cap

                Mooney: "Yeah chief, of course. You know she might not come out & say it but I will,
                and she feels the same: we've been lucky to have you. Both of you. This next haul
                puts us in the black, and without you two we'd probably be hauling produce and
                cheap labor for another 10 years to pay it off. So that makes me feel alright,
                but I'd rather be doing it with a full crew."
                `
                Ren: "Not bad, captain. Now all you gotta do is learn to talk like that without a
                spaceship in your head."
                `
                Mooney grins, sheepish now that he's once again self-conscious. He compulsively
                adjusts the cable in his dated interface port--as he does anytime attention is
                called to it--and shifts his attention back to the comfort of his consoles.

                    * [\->] -> mooney_end


            = mooney_check_ship

                Mooney: "No complaints. No new ones, anyway. Figure we'll put in the order for new
                grapple assemblies when we load up in Pyks. ."
                `
                Ren: "And the new seal for the engine collar?""
                `
                Mooney: "Oh, right. You bet, chief."
                `
                Ren: "Well. I'll get back to it."

                    * [\->] -> mooney_end


            = mooney_end

                Ren turns away. He imagines there must be a diagnostic port around the bridge somewhere,
                but he'd never used it as the captain was a better source for the state of things in the
                bridge. He spends most of his life there, with a direct link to the ship dangling behind
                his ear.
                
                    * [-x-]
                    ->END


            = enri_look

                Enri is deep in a book.

                    + [-x-]
                    ->END


            = enri_talk

                Enri stops Ren short with a warning look, as if to say: "What the fuck are you doing in
                my room?"

                    * [-x-]
                    ->END



            = mess_look

                The gathering space. Ren likes it here; Harrinwright cargo modules weren't known for their
                comfort, but he figures the starboard view from the upper deck of a R0-D10 was as nice a
                place to eat a meal while watching the stars as any he'd come across.

                    + [-x-]
                    ->END


            = mess_use

                Ren opens and shuts a few cabinets pointlessly. He doesn't feel like eating.

                    * [-x-]
                    ->END


            = mess_scan

                Ren plugs the scanner into the port. After a few minutes the readings come back clear.

                    * [-x-]
                    ->END



            = storage_look

                Secure storage. Most of the weapons and portable equipment on the ship are kept here.

                    + [-x-]
                    ->END


            = storage_use

                Ren briefly considers taking inventory, but his last count hadn't even been a week ago. 
                Reviewing the inventory log, with one long column filled with his initials and the rest
                with barely changing numbers, makes him feel uneasy.

                    * [-x-]
                    ->END


            = medical_look

                The med bay. One of the beds is in disarray, while the others look as if they've never
                been used.

                    + [-x-]
                    ->END


            = medical_use

                Ren straightens up the messy bed, distancing himself from the related memories.

                    + [-x-]
                    ->END


            = medical_scan

                Ren plugs the scanner into the port. After a few minutes the readings come back clear.

                    * [-x-]
                    ->END



            = shuttle_bay_look

                The shuttle bay controls.

                    + [-x-]
                    ->END


            = shuttle_bay_use

                Space is better with spacesuits.

                    + [-x-]
                    ->END


            = shuttle_bay_scan

                Ren plugs the scanner into the port. After a few minutes the readings come back clear.

                    * [-x-]
                    ->END
            


            = big_shuttle_look

                The Harrinwright base model shuttle. You hear plenty of complaints about them, but Ren has
                long maintained it's only because they're so ubiquitous. The added price of including one
                with the purchase of a Harrinwright cargo module was too reasonable to refuse. It's true
                they can be ornery and fly like a brick but, when treated well, they will outlive most
                people.

                    + [-x-]
                    ->END


            = big_shuttle_use

                Ren has nowhere he needs to go.

                    + [-x-]
                    ->END


            = big_shuttle_scan

                Ren plugs the scanner into the port. After a few minutes the readings come back clear.

                    * [-x-]
                    ->END
            


            = small_shuttle_look

                Enri's Skjold Cobra cruiser.

                    + [-x-]
                    ->END


            = small_shuttle_use

                Ren had always wanted to give it a spin, but never asked; he was pretty sure Enri didn't
                even let the captain fly it, and the captain could fly with the best of em when he put
                his mind to it.

                    + [-x-]
                    ->END


            = small_shuttle_scan

                Running diagnostics on someone else's private shuttle doesn't sit well with Ren.
                Feels like an invasion of privacy.

                    + [-x-]
                    ->END



            = cargo_look

                The cargo bay door. Looking pretty beat up.

                    + [-x-]
                    ->END


            = cargo_use

                Ren imagines the carnage that would ensue if the the failsafes malfunctioned, allowing
                the cargo door to unseal under heavy thrust.

                    + [-x-]
                    ->END


            = cargo_scan

                Ren plugs the scanner into the port. After a few minutes the readings come back clear.

                    * [-x-]
                    ->END



            = hoverbike_look

                Ren's hoverbike. In a way it is Ren's oldest friend. He purchased a few years before
                teaming up with Al.

                    + [-x-]
                    ->END


            = hoverbike_use

                As much as he'd enjoy a ride right now, laps around the cargo bay would only end in tears.

                    + [-x-]
                    ->END


            = hoverbike_scan

                Ren plugs the scanner into the port. After a few minutes the readings come back clear.

                    * [-x-]
                    ->END
            


            = dorm_look

                The passenger dorms. It wasn't uncommon for this part of the ship to become an impromptu
                hostel when the ship left a busy port. Ferrying passengers isn't a bad side hustle for
                a cargo ship; if you're already heading somewhere for a job and people want to pay to
                come ride along, it's an easy choice. It also made Ren and Al de-facto concierges. Ren
                hated it, but Al loved a captive audience.

                    + [-x-]
                    ->END


            = dorm_use

                The dorm hasn't been used in a while, and all the bunks are fastened securely to the
                walls. Nothing needs doing here.

                    + [-x-]
                    ->END



            = al_room_look

                Lorem ipsum.

                    + [-x-]
                    ->END


            = al_room_use

                Lorem ipsum.

                    + [-x-]
                    ->END



            = ren_room_look

                Lorem ipsum.

                    + [-x-]
                    ->END


            = ren_room_use

                Lorem ipsum.

                    + [-x-]
                    ->END




            = desk_look

                A small surface built into the wall with a standard desk-interface.

                    + [-x-]
                    ->END


            = desk_use

                Without meaning to Ren begins to remember his life in Ibico five years prior, shortly
                before he first met Algernon.

                    * [Try to write.]
                    -> prologue_end
                    + [Later.]
                    ->END


            = prologue_end

                Ren sits at the desk, brings up the notepad interface, and looks at the blank screen.
                Eventually he begins typing with slow and cumbersome movements on the desk's surface.

                    * [-x-]
                    ~ stage_cue = "quit"
                    ->END





    //********************************************************************************
    //********************************      CH.1      ********************************
    //********************************************************************************





        == chapter1 ==

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



    Tutorial messages:


        (Pile of stones trigger) \*** When you see an indicator for an interaction, press ACCEPT to see
        the available options. Press ACCEPT again to select the highlighted option or
        press CANCEL to back out of the menu. Press CANCEL outside of the menu to
        access the game options and controls.
        `
        Try the LOOK and USE options on the nearby pile of stones.***


        (Wild beast trigger) \*** Other common options include TALK and USE WITH.
        `
        Get rid of the animal using the available options. ***
        

        (Ledge trigger) \*** Open the inventory by pressing SELECT. Highlight Algernon's backpack
        and press SELECT two more times to use it. ***


        (Inventory - open backpack) \*** You can combine items by pressing SELECT on two different items in the
        inventory.
        `
        Combine two of the items in the inventory to climb the ledge. ***


        (Inventory - combine rope/harpoon) \***  Now approach the ledge and use the new item to progress. ***
        

        (Ledge Interaction - use Rope-dart) \*** The final interaction option is GO. It represents a transition to
        a new screen or location. Use the ledge's GO option to climb up. ***
        


    */




//********************************************************************************
//********************************************************************************
//*********************************     DEV     **********************************
//********************************************************************************
//********************************************************************************

    == example_knot ==

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
