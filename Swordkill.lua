local swordName = "ClassicSword" -- Change this to your sword's name
local player = game.Players.LocalPlayer
local friends = {} -- Table to store your friends dynamically

-- Function to update the friend list
local function updateFriends()
    friends = {} -- Clear the table
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v:IsFriendsWith(player.UserId) then
            table.insert(friends, v)
        end
    end
end

-- Check for sword equip and loop functionality
local equipped = false
player.Character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and child.Name == swordName then
        equipped = true
        updateFriends() -- Update the friend list dynamically
        while equipped do
            for _, v in ipairs(game.Players:GetPlayers()) do
                if v ~= player and not table.find(friends, v) then
                    local char = v.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.Health = 0 -- Kill players who aren't friends
                    end
                end
            end
            wait(0.1) -- Repeat every 0.1 seconds
        end
    end
end)

-- Stop loop on unequip
player.Character.ChildRemoved:Connect(function(child)
    if child:IsA("Tool") and child.Name == swordName then
        equipped = false
    end
end)
