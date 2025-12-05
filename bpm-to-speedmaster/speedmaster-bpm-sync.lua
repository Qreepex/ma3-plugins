-- Select a SpeedMaster and sync it to the current BPM
local function BPMToSpeedMaster(display_handle)
  local items = {}

  for i = 1, 15 do
    local speed = ShowData().Masters[3][i]
    local name = speed.name
    items[i] = name
  end

  local popupData = {} -- this table will contain all the options for the PopupInput
  popupData["title"] = "SpeedMaster to sync"
  popupData["caller"] = display_handle
  popupData["items"] = items
  popupData["target"] = nil
  popupData["render_options"] = { left_icon = "arrow_right.tga", number = 0, right_icon = "arrow_left" } -- Not sure how to use, Needs more info
  popupData["useTopLeft"] = false                                                                        -- changes dialog origin, but not sure how
  popupData["properties"] = nil                                                                          -- not sure of valid properties.

  local choiceIndex, _ = PopupInput(popupData)                                                  --calls the popup with our options

  local value = (ShowData().Masters[3][16].Normedvalue * 0.17118) ^ 1.917

  local bpm = math.sqrt(value/240)*100
  Cmd("Master 3." .. choiceIndex .. " at " .. bpm)
end

return BPMToSpeedMaster
