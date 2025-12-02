baby = {
	bounces = 0,
	feeling = 0,
	feelings = { "lonely", "board", "awake", "sick", "sleepy" },
	asleep = false,
}
maxbounces = 30

vomits = {
	{
		{ 0, 0, 0 },
		{ 0, 0, 0 },
		{ 0, 0, 1 },
	},
	{
		{ 0, 0, 1 },
		{ 0, 1, 1 },
		{ 0, 1, 1 },
	},
	{
		{ 0, 1, 0 },
		{ 1, 1, 1 },
		{ 0, 1, 1 },
	},
	{
		{ 0, 1, 0 },
		{ 1, 1, 1 },
		{ 1, 1, 1 },
	},
	{
		{ 1, 1, 1 },
		{ 1, 1, 1 },
		{ 1, 1, 1 },
	},
}
clean = true
running = true

function cleanfloor()
	dirt = 0
	print("-----")
	for _, row in ipairs(floor) do
		strip = "|"
		for _, n in ipairs(row) do
			if n == 1 then
				strip = strip .. "#"
				dirt = dirt + 1
			else
				strip = strip .. " "
			end
		end
		print(strip .. "|")
	end
	print("-----")
	print("")

	if dirt <= 0 then
		clean = true
		return
	end

	-- inputY and inputX will need to be checked against length of array before accessing
	print("clean the mess: " .. dirt .. " patches to clean")
	y = -1
	x = -1
	while not (y >= 0 and y <= 3) do
		print("cord Y:")
		inputY = io.read()
		checkY = tonumber(inputY)
		if checkY ~= nil then
			if checkY == 0 then
				print("Choose a tile: 1, 2, 3")
			else
				y = checkY
			end
		end
	end
	while not (x >= 0 and x <= 3) do
		print("cord X:")
		inputX = io.read()
		checkX = tonumber(inputX)
		if checkX ~= nil then
			if checkX == 0 then
				print("Choose a tile: 1, 2, 3")
			else
				x = checkX
			end
		end
	end
	if (not (x >= 1 and x <= 3)) or not (y >= 1 and y <= 3) then
		print("Oops, somehting went wrong, keep going :D")
	else
		floor[y][x] = 0
	end
end

function feeling()
	-- check if player has won
	bounces = 0
	while not (bounces >= 1 and bounces <= 3) do
		print("")
		print("pick a number: 1, 2, 3")
		input = io.read()
		check = tonumber(input)
		if check ~= nil then
			bounces = check
		end
	end
	baby.bounces = baby.bounces + tonumber(input)

	return ((baby.bounces - 1) % 5) + 1
end

function log()
	print("log:")
	print("  bounces:", baby.bounces)
	print("  index:", baby.feeling)
	print("  baby:", baby.feelings[baby.feeling])
	print("  floor:", clean)
end

function wincondition()
	if baby.asleep then
		print(":D YAY, baby is asleep :D")
		running = false
	end
end

function gameloop()
	while running do
		wincondition()
		if not running then
			break
		end

		-- if clean ask for input check floor for voimt
		if clean then
			baby.feeling = feeling()
			if baby.bounces < maxbounces then
				print("Baby is feeling " .. baby.feelings[baby.feeling])
			end

			if baby.feelings[baby.feeling] == "sick" then
				vomitIndex = math.random(1, 5)
				floor = vomits[vomitIndex]
				clean = false
				print('"Urrrgh"')
				print("")
				baby.feeling = baby.feeling + 1
			end

			if baby.bounces >= maxbounces then
				baby.asleep = true
			end
		else
			-- clean floor minigame
			print("The floor is dirty")
			cleanfloor()
		end
		--	log()
	end
end

print("\t+=======================+")
print("\t||  :D Baby Bounce :D  ||")
print("\t+=======================+")
print("")
print("Baby is awake")
print("\tbounce baby untill they fall asleep.")
print("\tWARNING: Baby may vomit!")
gameloop()
