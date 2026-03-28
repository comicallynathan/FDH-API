local InsertService = game:GetService("InsertService")

local Analyzer = require("./Analyzer");

local entity = {};

local shapes = require("@self/Info/HeadShapes");

local _private = {
    R15Heads = (function()
        local this = {};

        for k, v in pairs(shapes) do
            this[k] = InsertService:CreateMeshPartAsync(v.R15, Enum.CollisionFidelity.Box, Enum.RenderFidelity.Precise);
        end

        return this;
    end)()
};

local function targetDescription(description: BodyPartDescription)
    for _, v in ipairs(description:GetChildren()) do
        if v:IsA("BodyPartDescription") and v.BodyPart == Enum.BodyPart.Head then
            return v;
        end
    end
    return nil;
end

function entity.Replace(character: Model): (boolean, string?)
    local humanoid = character:FindFirstChild("Humanoid");

    if humanoid and humanoid:IsA("Humanoid") then
        local description = humanoid:FindFirstChild("HumanoidDescription");

        if description and description:IsA("HumanoidDescription") then
            local query = Analyzer.Query(tostring(description.Head));
            local target = targetDescription(description);

            if query and target then
                if humanoid.RigType == Enum.HumanoidRigType.R6 then
                    local value = target.HeadShape;

                    description.Head = 0;
                    humanoid:ApplyDescriptionAsync(description);

                    local head = character:FindFirstChild("Head");

                    if head and head:IsA("Part") then
                        local mesh = Instance.new("SpecialMesh");
                        local meshId = table.pack(pcall(function() return shapes[value]["R6"] end))[2];

                        if value == "" or value == "RobloxClassic" then
                            mesh.MeshType = Enum.MeshType.Head;
                            mesh.Scale = Vector3.new(1.25, 1.25, 1.25);
                        elseif meshId then
                            mesh.MeshId = meshId;
                        else
                            return false, "This head shape is not supported";
                        end

                        mesh.Parent = head;

                        local decal = head:FindFirstChild("face") :: Decal? or Instance.new("Decal");
                        decal.Texture = `rbxassetid://{query.Decal}`;
                        decal.Parent = head;

                        return true;
                    end
                elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
                    local head = character:FindFirstChild("Head");

                    if head and head:IsA("MeshPart") then
                        head:ApplyMesh( _private.R15Heads[target.HeadShape] or _private.R15Heads["RobloxClassic"] );

                        local decal = head:FindFirstChild("face") :: Decal? or Instance.new("Decal");
                        decal.Texture = `rbxassetid://{query.Decal}`;
                        decal.Parent = head;

                        return true;
                    end
                end
                return false, "Query returned nil OR BodyPartDescription for Head is not found";
            end
        end
    end

    return false, "Humanoid is not found";
end

return entity;