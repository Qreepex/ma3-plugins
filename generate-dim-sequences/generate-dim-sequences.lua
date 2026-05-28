local function main()
  local startSeq = 5455
  local startGroupFixtureID = 13 -- Gruppe 1 ist ID 13, Gruppe 8 ist ID 20

  -- Definition der Cues mit Verweisen auf deine Pool-Namen
  -- matricks = Name deines MAtricks-Pool-Objekts (oder nil für keins / Reset)
  local cueDefinitions = {
    { num = 1,  name = "Full",              preset = "1.11", matricks = nil, },
    { num = 2,  name = "Sinus No Ph",       preset = "21.1", matricks = nil, },
    { num = 3,  name = "Sinus",             preset = "21.1", matricks = "Phase 360", },
    { num = 4,  name = "Sinus Reverse",     preset = "21.1", matricks = "Phase -360", },
    { num = 5,  name = "Sinus Sym",         preset = "21.1", matricks = "2 XWings", },
    { num = 6,  name = "Sinus Rnd",         preset = "21.1", matricks = "XShuffle", },
    { num = 7,  name = "Sinus 1/3",         preset = "1.14", matricks = "Phase 360", },
    { num = 9,  name = "Snap On No Ph",     preset = "21.2", matricks = nil, },
    { num = 10, name = "Snap On",           preset = "21.2", matricks = "Phase 360", },
    { num = 11, name = "Snap On Rnd",       preset = "21.2", matricks = "XShuffle", },
    { num = 12, name = "Snap Off",          preset = "21.3", matricks = "Phase 360", },
    { num = 13, name = "Snap Off Rnd",      preset = "21.3", matricks = "XShuffle", },
    { num = 14, name = "Chase 1/4",         preset = "21.4", matricks = "Phase 360", },
    { num = 15, name = "Chase 1/4 Reverse", preset = "21.4", matricks = "Phase -360", },
  }

  Echo("--- Plugin Start: Cleanup & Build mit Pool-MAtricks ---")

  for i = 0, 7 do
    local currentSeq = startSeq + i
    local currentGroupID = startGroupFixtureID + i

    -- 1. Sequenz komplett leeren
    Cmd("Delete Sequence " .. currentSeq .. " Cue 1 Thru /NoConfirmation")

    for _, cue in ipairs(cueDefinitions) do
      -- 1. Alles leeren (Setzt auch aktive MAtricks im Programmer zurück)
      Cmd("ClearAll")

      -- 2. Gruppe anwählen
      Cmd("Group " .. currentGroupID)


      -- 4. Preset anwenden (holt die Attribute in den Programmer)
      Cmd("At Preset " .. cue.preset)

      -- 3. Grid/MAtricks anwenden (z.B. XWings oder XShuffle), bevor Werte reinkommen
      if cue.matricks then
        Cmd("MAtricks \"" .. cue.matricks .. "\"")
      end


      -- 6. Store & Label
      Cmd("Store Sequence " .. currentSeq .. " Cue " .. cue.num .. " /NoBlind")
      Cmd("Label Sequence " .. currentSeq .. " Cue " .. cue.num .. " \"" .. cue.name .. "\"")
    end
  end

  -- Am Ende alles sauber zurücksetzen
  Cmd("Matricks Reset")
  Cmd("ClearAll")
  Echo("--- Plugin erfolgreich beendet ---")
end

return main
