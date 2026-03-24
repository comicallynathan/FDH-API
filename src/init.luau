local RunService = game:GetService("RunService")
if not RunService:IsServer() then
    warn("[FDH]: Roblox removed FilteringDisabled five years ago, so it's recommended that you actually run this thing on a real server. Thanks!");
else
    require("@self/Start");
end

local fdh = {};

fdh.Analyzer = require("@self/Analyzer");
fdh.Entity = require("@self/Entity");

return fdh;