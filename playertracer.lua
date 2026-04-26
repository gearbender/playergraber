local detector = peripheral.find("playerDetector")
local chatBox = peripheral.find("chatBox")

if not detector then
    error("No Player Detector found!")
end

if not chatBox then
    error("No ChatBox found!")
end

local range = 10
local seenPlayers = {}

while true do
    local players = detector.getPlayersInRange(range)

    for _, player in ipairs(players) do
        if not seenPlayers[player] then
            seenPlayers[player] = true

            -- Send toast (Advanced Peripherals chatBox supports this)
            chatBox.sendToast(player, "Welcome!", "You are near the computer!")
        end
    end

    -- cleanup players who left range
    for player, _ in pairs(seenPlayers) do
        local stillNear = false
        for _, p in ipairs(players) do
            if p == player then
                stillNear = true
                break
            end
        end

        if not stillNear then
            seenPlayers[player] = nil
        end
    end

    sleep(1)
end