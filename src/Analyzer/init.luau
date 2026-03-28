type Data = {
    ["Name"]: string,
    ["Decal"]: string
}

local HttpService = game:GetService("HttpService");

local url = "https://raw.githubusercontent.com/comicallynathan/ScrewDynamicHeads/refs/heads/main/database.json";

local analyzer = {};

local database : {
    [string]: Data
};

do
    local result
    for i = 1, 3 do
        local success;

        success, result = pcall(function()
            return HttpService:GetAsync(url);
        end);

        if not success then warn(`[FDH/Analyzer]: Got error \`{result}\` on attempt {i} while trying to retrieve classic faces database.`) end;

        if success and result then database = HttpService:JSONDecode(result); break end
    end
end

function analyzer.Query(id: string): Data | nil
    return database and database[id] or nil;
end

return analyzer;