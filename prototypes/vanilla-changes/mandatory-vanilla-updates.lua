-- -- -- Mandatory vanilla updates
-- This script update the base game objects with some adjustment

local modifications =
{	
	"entities-changes",        -- Entities/prototypes definition modifications
	"icons-changes",           -- Modify aspect of vanilla items (like science pack icons..)
	"improve-inserters",       -- Improve inserters, new functions	
	"items-changes",           -- Modify vanilla items
	"rebalance-nuclear-power", -- Rebalance nuclear power	
	"recipes-changes",         -- All modification to vanilla recipes	
	"renaming-vanillas",       -- Localization changes to vanilla objects
	"smelting-overmodule-fix", -- Multiply smelting recipes stat for fix overmodule bug
	"technologies-changes",    -- Modifications to vanilla technologies
	"vanilla-lab-changes"      -- Modify stat and accepted science packs of vanilla lab
}

-- Application of the modifications
for _, modification_name in pairs(modifications) do 
	require("mandatory/" .. modification_name)
end