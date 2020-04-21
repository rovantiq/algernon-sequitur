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
    VAR animal_gone = false
    VAR animal_shot = false
    VAR ledge_approached = false
    VAR shot_harpoon = false
    VAR climbed_ledge = false
    VAR looked_ahead = false


    // PrologueShip

    VAR welcomed_home = false
    VAR scans = 0
    VAR engineering_scanned = false
    VAR bridge_scanned = false
    VAR mess_scanned = false
    VAR med_scanned = false
    VAR bay_scanned = false
    VAR cargo_scanned = false
    VAR shuttle_scanned = false
    VAR hoverbike_scanned = false




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

                    * [\->]
                    -> two

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
                steps outside.
                `
                “Well.”
                `
                “Well.”
                `
                Algernon closes the door, gives the wall panel a double-tap with his palm and steps
                back a few paces. Ren initiates the takeoff sequence, they wave goodbye, and a few
                minutes later the shuttle is leaving atmosphere.

                    * [-x-]
                    -> END





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

                ~ player_inventory += Stone
                ~ has_stone = true
                ~ stage_cue = "stone_taken"

                The stone sits in Algernon's grip as if it was made for his hand. He slips it into
                his pocket with a deep satisfaction.

                    * [-x-]
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
                ~ shot_harpoon = true
                ~ stage_cue = "harpoon_shot"

                Algernon aims for an overhanging tree, and the blades sink into the wood
                with a satisfying thud. It's soon followed by the sharp sound of
                pressurized air escaping the launcher in his hands. Not a good sound.
                Algernon tosses the broken remains and squints sourly skyward.

                    * [-x-]
                    -> END
            

            = climb

                ~ climbed_ledge = true
                ~ player_inventory += Rope

                After a few clumsy attempts, Algernon manages to pull himself up the rope
                and scramble over the ledge. Once at the top, he collects the rope, works
                the harpoon out of the tree, and returns them to his pack.

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
                Ren smirks a little, in spite of his mood. The captain never was any good at
                delicate moments, and Ren had never seen him try harder to pull it off than
                right now.
                `
                Mooney: "...We're glad to have you back."

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

                ~ engineering_scanned = true
                ~ stage_cue = "scanning"
                ~ scans += 1

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

                Ren: He says the music helps with his migraines. He was a patch-head in his
                younger days, still has a working port & adapters for all the common stuff.
                Comes in handy sometimes, but he must have interfaced with some weird shit
                back then, he's a mess when the migraines come around.

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
                    with you?" 
                    `
                    -> mooney_check_cap
                    * [Ask about ship.] Ren: "Just doing the rounds, trying to keep myself busy.
                    She's been flying right?"
                    `
                    -> mooney_check_ship


            = mooney_check_cap

                Mooney: "Yeah chief, of course. You know she might not come out & say it but I
                will, and she feels the same: we've been lucky to have you. Both of you. This
                next haul puts us in the black, and without you two we'd probably be hauling
                produce and cheap labor for another 10 years to pay it off. So that makes me
                feel alright, but I'd rather be doing it with a full crew."
                `
                Ren: "Not bad, captain. Now all you gotta do is learn to talk like that
                without a spaceship in your head."
                `
                Mooney grins, self-conscious once more. He adjusts the cable in his dated
                interface port and shifts his attention back to the comfort of his consoles.
                `
                    * [\->]
                    -> mooney_end


            = mooney_check_ship

                Mooney: "No complaints. No new ones, anyway. Figure I'll schedule an appointment
                for the last of the thruster refits when we load up in Pyks, since she'll be
                paid off by the time we get back."
                `
                Ren: "And the refurb for the engine collar. Right?"
                `
                Mooney: "Oh, right. You bet, chief."
                `
                Ren: "Well. I'll get back to it."
                `
                    * [\->]
                    -> mooney_end


            = mooney_end

                ~ bridge_scanned = true
                ~ scans += 1

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

                ~ mess_scanned = true
                ~ stage_cue = "scanning"
                ~ scans += 1

                Ren slots in the scanner and leans against the counter, watching the stars outside the window
                and the empty table and all of it looking lonely. He fills the seats by remembering them all
                there together, celebrating after the Ptolo's treason charges were dropped. The judge had
                ruled that their aid to the Toman geurrilas was unwitting. The fees were susbstantial, but all
                told it was still one of their most lucrative jobs.
                `
                Once their assets were unfrozen, they immediately left orbit and got drunk. They had had to
                keep Enri and Al apart for weeks or she would have killed him--or at least stabbed him again--
                for getting everyone into that kind of trouble. But once it had all worked out, she actually
                hugged him. Only time Ren ever saw it.
                `
                The scanner beeps, all clear.

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

                ~ med_scanned = true
                ~ stage_cue = "scanning"
                ~ scans += 1

                The scanner scans. Ren had only visited the med-bay a handful of times in his first two
                years of working on the ship, but it felt like he had spent more time in here with Al 
                than anywhere the past few months.
                `
                Ren looks down and thinks of nothing until he hears a beep. All clear.

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

                ~ bay_scanned = true
                ~ stage_cue = "scanning"
                ~ scans += 1

                The scanner port is beside the bay door controls. Ren looks up and is reminded of many space-
                walks. His skillset made him the natural choice for delicate and/or dangerous work, including
                any sort of EVA. That suited Ren just fine. He had been filling that role in various jobs
                before this one and they were rarely as comfortable.
                `
                Besides, he enjoyed working on Harrinwrights. They were practical, modular, and embraced the
                DIY approach for most repairs. Freighter-class models usually consisted of three modules:
                nav, base, engine. The nav module on this ship--the R0-D10nav, or R0-D10n--contained the bridge
                & captain's quarters and is designed to be detached and flown independently, in atmo if
                needed.
                
                    * [\->]
                    -> shuttle_bay_scan2

            = shuttle_bay_scan2

                The base modules offer a ton of customization, but generally consist of cargo, crew
                amenities, and a shuttle bay like the R0-D10 does. The engine module is necessary for long-
                distance travel, or even moving the base module, as the nav's onboard thrust is only enough 
                for itself. There were warp models that could get further faster than the Q2-W03, but it
                was rock-solid reliable in the right hands and Ren would take that trade-off any day.
                `
                The scanner finishes with a tone of disappointment, complaining that the airlock's bacterial
                sensors were unresponsive. Nothing new. If they were spreading exotic diseases from port to
                port, they would not be the first to know

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

                ~ shuttle_scanned = true
                ~ stage_cue = "scanning"
                ~ scans += 1

                Ren sits in the passenger seat and plugs the scanner into the port under the dash panel. He
                rarely sat in the passenger seat. The last time was probably the time the captain had come
                along with them planetside. He had arranged a meeting with an old contact he hadn't talked
                to in years, and wanted backup.
                `
                The situation was touch-and-go but an arrangement was eventually reached. The captain, in a
                rare display of whimsy, abruptly decided to fly some manoeuvres before re-docking. Ren had
                scoffed more than once as the captain began evasive actions meant for military fighters,
                only to sit quietly shaking his head in disbelief a few moments later.

                    * [\->]
                    -> big_shuttle_scan2
            

            = big_shuttle_scan2

                Algernon had often mocked the captain behind his back, syaing he was an "ineffectual leader,"
                "punching above his weight, even is she is a bitch", and so on. Ren figured some of that
                might be true, but he liked him well enough anyhow. In any case, Algernon didn't say much one
                way or the other about the captain after that day.
                `
                The scan beeps approval. Old Reliable. Ren pockets the scanner and hops out of the cabin.

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
                the cargo door to unseal under heavy thrust. He regrets it afterward.

                    + [-x-]
                    ->END


            = cargo_scan

                ~ cargo_scanned = true
                ~ stage_cue = "scanning"
                ~ scans += 1

                Ren inserts the scanner into the port next to the cargo door controls. There is some
                damage on the door where two of the panels meet. He recalls prying several of the
                panels off with Enri and Algernon. The exposed spaces were to be filled with class-4
                controlled substances before being handed over to a contact of Algernon's outside
                United Fed borders. Ren knew his share of questionable folk, but could never
                imagine how Algernon met his.
                `
                They rarely relied on blatantly illegal activity, preferring grey areas and obscure
                work more respectable outfits tended to avoid. This one was just too juicy, but Enri
                wasn't taking chances. They spent two days in total unsealing and resealing the door.
                The damaged seam was one of the last panels, and Algernon had rushed the work in
                exasperation. Enri was furious, and Ren finished the work while they argued.
                `
                The scanner beeps approval, oblivious to all of it.

                    * [-x-]
                    ->END



            = hoverbike_look

                Ren's trusty steed.

                    + [-x-]
                    ->END


            = hoverbike_use

                As much as he'd enjoy a ride right now, laps around the cargo bay would only end in tears.

                    + [-x-]
                    ->END


            = hoverbike_scan

                ~ hoverbike_scanned = true
                ~ stage_cue = "scanning"
                ~ scans += 1

                The scanner rests loosely in a divet above the lev-engine. The bike has been sitting for
                months, looking forlorn in spite of its good condition. In a way it is Ren's oldest
                friend. He had purchased it a few years before meeting Algernon, during one of his
                attempts at stability.
                `
                Having recently shunned violence, Ren made a modest life of agriculture for himself on
                an independent crop-share moon. Needing a short-term goal, he had decided a powerful
                ground vehicle would greatly improve his quality of life. It grew into an obsession by
                the time it was delivered, and was ultimately only used for the occasional joy-riding
                through neighboring expanses of flat, empty land.
            
                    * [\->]
                    -> hoverbike_scan2

            = hoverbike_scan2

                Eventually he made the drive to the moon's main trading hub, mainly because he could.
                While idling by the port, he learned his bike was a passable cargo-lift with the right
                attachments. Ren's next fixation was a lift attachment and passage off-world.
                `
                The scan was clear. Ren still thinks it looks sad.

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

                It's the guest room now.

                    + [-x-]
                    ->END


            = al_room_use

                Ren decides to clean up some other time. It's too soon to erase all traces.

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

                Ren considers the desk. {scans >= 5: He has already been recalling life in Ibico, and the job}
                    {scans >= 5: that introduced them.}

                    * {scans >= 5}[Type.]
                    -> prologue_end
                    + [Later.]
                    ->END


            = prologue_end

                Ren sits, brings up the notepad interface, and stares at the display for a few
                moments before beginning to type with stiff and deliberate movements.

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



    Tutorial messages:


        *(Pile of stones trigger) \*** When you see an indicator for an interaction, press ACCEPT to see
        the available options. Press ACCEPT again to select the highlighted option or
        press CANCEL to back out of the menu. Press CANCEL outside of the menu to
        access the game options and controls.
        `
        Try the LOOK and USE options on the nearby pile of stones.***

        *(Wild beast trigger) \*** Other common options include TALK and USE WITH.
        `
        Get rid of the animal using the available options. ***
        
        *(Ledge trigger) \*** Open the inventory by pressing SELECT. Highlight Algernon's backpack
        and press SELECT two more times to use it. ***

        *(Inventory - open backpack) \*** You can combine items by pressing SELECT on two different items in the
        inventory.
        `
        Combine two of the items in the inventory to climb the ledge. ***

        *(Inventory - combine rope/harpoon) \***  Now approach the ledge and use the new item to progress. ***

        *(Ledge Interaction - use Rope-dart) \*** The final interaction option is GO. It represents a transition to
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
