local overseer = require("overseer")

overseer.register_template({
	name = "podman status",
	builder = function()
		return { cmd = { "podman", "ps", "-a", "-f", "name=zmk", "--format", '"Status: {{.Status}}"' } }
	end,
})

overseer.register_template({
	name = "podman start",
	builder = function()
		return { cmd = { "podman", "start", "zmk" } }
	end,
})

overseer.register_template({
	name = "podman stop",
	builder = function()
		return { cmd = { "podman", "stop", "zmk" } }
	end,
})

overseer.register_template({
	name = "build left",
	builder = function()
		return {
			cmd = {
				"podman",
				"exec",
				"-w=/workspaces/app",
				"zmk",
				"west",
				"build",
				"-d",
				"build/left",
				"-b",
				"nice_nano_v2",
				"--",
				"-DSHIELD=waterfowl_left",
				'-DZMK_CONFIG="/workspaces/zmk-config"',
			},
		}
	end,
})

overseer.register_template({
	name = "build right",
	builder = function()
		return {
			cmd = {
				"podman",
				"exec",
				"-w=/workspaces/app",
				"zmk",
				"west",
				"build",
				"-d",
				"build/right",
				"-b",
				"nice_nano_v2",
				"--",
				"-DSHIELD=waterfowl_right",
				'-DZMK_CONFIG="/workspaces/zmk-config"',
			},
		}
	end,
})

overseer.register_template({
	name = "build both",
	builder = function()
		return {
			name = "build both",
			strategy = {
				"orchestrator",
				tasks = { "build left", "build right" },
			},
		}
	end,
})
