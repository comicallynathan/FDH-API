--[[ RULES ]]

local autoconvert = true;

--[[ SCRIPT ]]

local players = game:GetService("Players");
local Entity = require("./Entity");

if autoconvert then
    players.PlayerAdded:Connect(function(player: Player)
        player.CharacterAdded:Connect(function(character)
            Entity.Replace(character);
        end);
    end);
end

return nil;