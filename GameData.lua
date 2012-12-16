-- window dimensions
width = love.graphics.getWidth()
height = love.graphics.getHeight()

-- font
font = love.graphics.newFont("img/UbuntuMono-R.ttf", 15)

--audio
music_background = love.audio.newSource("audio/Orbiting.mp3")
music_background:setVolume(0.7)
sfx_freighter_hit = love.audio.newSource("audio/hit3.wav", "static")
sfx_freighter_explosion = love.audio.newSource("audio/explosion2.wav", "static")
sfx_ftl = love.audio.newSource("audio/ftl.wav", "static")
sfx_conversation = love.audio.newSource("audio/conversation.wav", "static")
sfx_freighter_hit:setVolume(0.05)
sfx_freighter_explosion:setVolume(0.05)
sfx_ftl:setVolume(0.05)
sfx_conversation:setVolume(0.05)

-- Texr: menu
menu_instr_center = "Press [Enter] to play"
menu_instr_bottom = "Press [Esc] to exit. Press [F2] for credits."
menu_story_title = "Game Title Villian"
menu_story = "Story placeholder. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."


-- Text: stage 1
conv_stage1_1_title = "Incoming transmission ..."
conv_stage1_1_text = "Hail pilot, apparently the coordinates we sent to you, were off by a few lightyears.\n"
    .."According to our sensors, there's nothing but spacedust around you.\n"
    .."It will take a few moments until the new calculation is done.\n"
    .."You might want to use the time to get familiar with the controls of your ship.\n"
    .."\n\n Use w/a/s/d or the arrow keys to control your ship and space to fire."
conv_stage1_1_confirm = "Wait for coordinates (Press enter)"

-- Text: stage 2
conv_stage2_1_title = "Incoming transmissionn ..."
conv_stage2_1_text =
    "Our long range sensors are picking up activities in your original destination.\n"
    .."According to our sensors the fleet only consists of transport ships.\n"
    .."Kill them while their defenses are down."
conv_stage2_1_confirm = "Confirm your orders (Press enter)"

conv_stage2_2_title = "Incoming transmissionn ..."
conv_stage2_2_text =
    "Hail pilot, we have picked up communications between the remains of the transport fleet and Perry Rho-Dan.\n"
    .."Rho-Dan is readying an imperial class battleship. You have to keep your pressure up. Our jump drives are still recovering.\n"
    .."We will be there as soon as possible, but we cannot allow them to take a foothold in this system, so you have to keep fighting. \n"
    ..""
conv_stage2_2_confirm = "Continue fighting (Press enter)"

-- Text: credits
credits_bottom = "Press [Enter] to go to main menu."