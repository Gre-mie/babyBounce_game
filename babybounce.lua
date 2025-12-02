baby = {
	bounces = 0,
	feeling = 0,
	feelings = { "board", "nothing", "awake", "sick", "sleepy" },
	asleep = false,
}
maxbounces = 10

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

function log()
	print("log:")
	print("  bounces:", baby.bounces)
	print("  index:", baby.feeling)
	print("  baby:", baby.feelings[baby.feeling])
	print("  floor:", clean)
end

function wincondition()
	if baby.asleep then
		print("Baby is asleep :D")
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
			-- check if player has won

			print("pick a number: 1, 2, 3")
			input = io.read()
			baby.bounces = baby.bounces + tonumber(input)

			baby.feeling = ((baby.bounces - 1) % 5) + 1

			print("Check baby:", baby.feelings[baby.feeling])

			if baby.feelings[baby.feeling] == "sick" then
				floor = vomits[baby.feeling]
				clean = false
				print("baby vomited")
				baby.feeling = baby.feeling + 1
			end

			if baby.bounces >= maxbounces then
				baby.asleep = true
			end
		else
			-- clean floor minigame
			print("clean the floor")
		end
		log()
	end
end

gameloop()
