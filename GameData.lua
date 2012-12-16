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
sfx_freighter_hit:setVolume(0.05)
sfx_freighter_explosion:setVolume(0.05)
sfx_ftl:setVolume(0.05)

-- Text: stage 1
conv_stage1_1_title = "Incoming transmission ..."
conv_stage1_1_text = "Hail pilot, apparently the coordinates we sent to you, were off by a few lightyears.\n"
    .."According to our sensors, there's nothing but space dust around you.\n"
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
conv_stage2_1_confirm = "Press enter to jump"