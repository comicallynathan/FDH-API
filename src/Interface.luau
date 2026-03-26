local interface = {};

--[[ RULES ]]

local autoconvert = true;

--[[ SCRIPT ]]

local RunService = game:GetService("RunService");
local players = game:GetService("Players");
local Entity = require("./Entity");

function interface.Start()
    players.PlayerAdded:Connect(function(player: Player)
        player.CharacterAppearanceLoaded:Connect(function(character)
            Entity.Replace(character);
        end);
    end);
end



if RunService:IsClient() then
    warn("[FDH]: Roblox removed FilteringDisabled five years ago, so it's recommended that you actually run this thing on a real server. Thanks!");
else
    if RunService:IsServer() then
        if autoconvert then
            interface.Start();
        end
    end
end

return interface;