local M = {}

M.TRIGGER = hash("trigger_response")
M.SAVE = hash("save")
M.ENABLE = hash("enable")
M.DISABLE = hash("disable")

M.FADE_OUT = vmath.vector4(0)
M.FADE_FULL = vmath.vector4(1)
M.FADE_HALF = vmath.vector4(0.5)

function M.start_rand()
	math.randomseed(os.time())
	math.random() math.random() math.random() math.random() math.random()
end

function M.rand(min, max)
	assert(min)
	assert(max)
	return math.random() * max + min
end

function M.create_memories(no, url)
	assert(no)
	assert(url)
	local memories = {}
	for i = 1,no do
		local scale
		local color
		local pos = vmath.vector3(M.rand(100, 650), M.rand(150, 400), 0)
		if url == "#good" then
			scale= M.rand(1.5,2)
			color = vmath.vector4(0, M.rand(0.1,0.5), M.rand(0.6,1), 0.5)
		else
			scale = M.rand(2,2.5)
			color = vmath.vector4(M.rand(0.5,1), M.rand(0,0.5), 0, 0.5)
		end
		memories[i] = factory.create(url, pos, _, { my_tint = color , sound_no = i}, scale)
	end
	return memories
end

function M.tint_to(tint, dur, cb)
	go.animate("#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, tint, go.EASING_INOUTSINE, dur or 1, 0, cb)
end

function M.follow(cb, dur)
	go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, go.get_position("/Player"), go.EASING_INOUTSINE, dur or 1, 0, cb)
end

function M.vibrate()
	go.set(".", "position.x", go.get_position().x - 10)
	go.animate(".", "position.x", go.PLAYBACK_LOOP_PINGPONG, go.get_position().x + math.random()*3,
	go.EASING_INOUTSINE, math.random() + 1, math.random()*0.5 + 0.5)
	go.set(".", "position.y", go.get_position().y - 10)
	go.animate(".", "position.y", go.PLAYBACK_LOOP_PINGPONG, go.get_position().y + math.random()*3,
	go.EASING_INOUTSINE, math.random() + 1, math.random()*0.5 + 0.5)
end

function M.shake()
	go.set(".", "position.x",go.get_position().x - 10)
	go.animate(".", "position.x", go.PLAYBACK_LOOP_PINGPONG, go.get_position().x + math.random()*4 + 1,
	go.EASING_INOUTSINE, math.random()*0.4 + 0.2, math.random()*0.5 + 0.5)
	go.set(".", "position.y", go.get_position().y - 10)
	go.animate(".", "position.y", go.PLAYBACK_LOOP_PINGPONG, go.get_position().y + math.random()*4 + 1,
	go.EASING_INOUTSINE, math.random()*0.4 + 0.2, math.random()*0.5 + 0.5)
end

return M