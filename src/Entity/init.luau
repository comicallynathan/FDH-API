local Analyzer = require("./Analyzer");
local entity = {};

local _private = {
    R15Head = script.Parent["R15"]["Head"]
}

function entity.Replace(character: Model): (boolean, string?)
    local humanoid = character:FindFirstChild("Humanoid");

    if humanoid and humanoid:IsA("Humanoid") then
        local description = humanoid:FindFirstChild("HumanoidDescription");

        if description and description:IsA("HumanoidDescription") then
            local query = Analyzer.Query(tostring(description.Head));

            if query then
                if humanoid.RigType == Enum.HumanoidRigType.R6 then
                    description.Head = 0;
                    humanoid:ApplyDescriptionAsync(description);
                    
                    local head = character:FindFirstChild("Head");

                    if head and head:IsA("Part") then
                        local mesh = Instance.new("SpecialMesh");
                        mesh.MeshType = Enum.MeshType.Head;
                        mesh.Scale = Vector3.new(1.25, 1.25, 1.25);
                        mesh.Parent = head;

                        local decal = head:FindFirstChild("face") :: Decal? or Instance.new("Decal");
                        decal.Texture = `rbxassetid://{query.Decal}`;
                        decal.Parent = head;

                        return true;
                    end
                elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
                    local head = character:FindFirstChild("Head");

                    if head and head:IsA("MeshPart") then
                        head:ApplyMesh(_private.R15Head)

                        local decal = head:FindFirstChild("face") :: Decal? or Instance.new("Decal");
                        decal.Texture = `rbxassetid://{query.Decal}`;
                        decal.Parent = head;

                        return true;
                    end
                end
            end
        end
    end

    return false;
end

return entity;