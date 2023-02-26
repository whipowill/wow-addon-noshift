local _, L = ...;

-- https://wowpedia.fandom.com/wiki/Snare
local SPELLIDS = {
  -- Death Knights
  45524,  -- Chains of Ice
  55666,  -- Desecration (no duration, lasts as long as you stand in it)
  58617,  -- Glyph of Heart Strike
  50436,  -- Icy Clutch (Chilblains)

  -- Druids
  339, -- Entangling Roots
  19675, -- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
  58179,  -- Infected Wounds
  61391,  -- Typhoon

  -- Hunters
  19306, -- Counterattack
  19185, -- Entrapment
  35101,  -- Concussive Barrage
  5116,  -- Concussive Shot
  13810,  -- Frost Trap Aura (no duration, lasts as long as you stand in it)
  61394,  -- Glyph of Freezing Trap
  2974,  -- Wing Clip
  54644,  -- Froststorm Breath (Chimera)
  50245, -- Pin (Crab)
  50271,  -- Tendon Rip (Hyena)
  54706, -- Venom Web Spray (Silithid)
  4167, -- Web (Spider)

  -- Mages
  33395, -- Freeze (Water Elemental)
  122, -- Frost Nova
  11071, -- Frostbite
  55080, -- Shattered Barrier
  11113,  -- Blast Wave
  6136,  -- Chilled (generic effect, used by lots of spells [looks weird on Improved Blizzard, might want to comment out])
  120,  -- Cone of Cold
  116,  -- Frostbolt
  47610,  -- Frostfire Bolt
  31589,  -- Slow

  -- Paladins
  --20184,  -- Judgement of Justice (100% movement snare; druids and shamans might want this though)

  -- Preists
  --15407,  -- Mind Flay

  -- Rogues
  31125,  -- Blade Twisting
  3409,  -- Crippling Poison
  26679,  -- Deadly Throw

  -- Shamans
  64695, -- Earthgrab (Storm, Earth and Fire)
  63685, -- Freeze (Frozen Power)
  3600,  -- Earthbind (5 second duration per pulse, but will keep re-applying the debuff as long as you stand within the pulse radius)
  8056,  -- Frost Shock
  8034,  -- Frostbrand Attack

  -- Warlocks
  18118,  -- Aftermath
  18223,  -- Curse of Exhaustion

  -- Warriors
  58373, -- Glyph of Hamstring
  23694, -- Improved Hamstring
  1715,  -- Hamstring
  12323,  -- Piercing Howl
  63757, -- Thunderclap (not in LoseControl?)

  -- NPCs
  39965, -- Frost Grenade
  55536, -- Frostweave Net
  13099, -- Net-o-Matic
  29703,  -- Dazed
};

local SHIFTABLE = {};
for i = 1, #SPELLIDS do
  local name = GetSpellInfo(SPELLIDS[i]);
  if (name) then
    SHIFTABLE[i] = name;
  end
end

NoShift = {};

function NoShift:activate()
  SetCVar("AutoUnshift", 1);
end

function NoShift:deactivate()
  SetCVar("AutoUnshift", 0);
end

function NoShift:init()
  self:register_slash_command("/ns");
  self:register_slash_action('help', 'on_slash_help', 'Show list of slash actions (or description for the given action)');
  self:register_slash_action('health', 'on_slash_health', '|cffffff00<> <value>|r Disable AutoUnshift if health is above/below value');
  self:register_slash_action('mana', 'on_slash_mana', '|cffffff00<> <value>|r Disable AutoUnshift if mana is above/below value');
  self:register_slash_action('rage', 'on_slash_rage', '|cffffff00<> <value>|r Disable AutoUnshift if rage is above/below value');
  --self:register_slash_action('focus', 'on_slash_focus', '|cffffff00<> <value>|r Disable AutoUnshift if focus is above/below value');
  self:register_slash_action('energy', 'on_slash_energy', '|cffffff00<> <value>|r Disable AutoUnshift if energy is above/below value');
  --self:register_slash_action('combo', 'on_slash_combo', '|cffffff00<> <value>|r Disable AutoUnshift if combo points is above/below value');
  self:register_slash_action('!snare', 'on_slash_snare', 'Disable AutoUnshift if slowed or snared');
  self:register_slash_action('!pred', 'on_slash_pred', 'Disable AutoUnshift if missing Predator\'s Swiftness');
  self:register_slash_action('on', 'on_slash_on', 'Set AutoUnshift to 0');
  self:register_slash_action('off', 'on_slash_off', 'Reset AutoUnshift back to normal');
  self:register_slash_action('debug', 'on_slash_debug', 'Enable or disable debugging output');
  self:set_macro(null, null);
end

function NoShift:log_output(...)
  print("|cffff0000NoShift|r", ...);
end

function NoShift:log_debug(...)
  if self.debug then
    print("|cffff0000NoShift|r", "|cffffff00Debug|r", ...);
  end
end

function NoShift:on_slash_command(parameters)
  if not self.slash_actions then
    self:log_output("No slash actions registered!");
    return;
  end

  self:log_debug("Slash command called: ", unpack(parameters));

  local action = tremove(parameters, 1);
  if not self.slash_actions[action] then
    self:log_output("Slash action |cffffff00"..action.."|r not found!");
  else
    local actionData = self.slash_actions[action];
    if type(actionData.callback) == "function" then
      actionData.callback(parameters);
    else
      self[actionData.callback](self, parameters);
    end
  end
end

function NoShift:on_slash_help(parameters)
  if (#(parameters) > 0) then
    local action = tremove(parameters, 1);
    if not self.slash_actions[action] then
      self:log_output("Slash action |cffffff00"..action.."|r not found!");
    else
      self:log_output("|cffffff00"..action.."|r", self.slash_actions[action].description);
    end
  else
    self:log_output("Available slash commands:");
    for action in pairs(self.slash_actions) do
      self:log_output("|cffffff00/ns "..action.."|r", self.slash_actions[action].description);
    end
  end
end

function NoShift:power_check(method, parameters)
  if (self:is_gcd()) then
    self:deactivate();
    return;
  end

  local v = 0;
  if (method == "health") then
    local current = UnitHealth("player");
    local max = UnitHealthMax("player");
    v = current / max * 100;
  elseif (method == "mana") then
    local current = UnitPower("player", 0);
    local max = UnitPowerMax("player", 0);
    v = current / max * 100;
  elseif (method == "rage") then
    v = UnitPower("player", 1);
  elseif (method == "focus") then
    v = UnitPower("player", 2);
  elseif (method == "energy") then
    v = UnitPower("player", 3);
  elseif (method == "combo") then
    v = UnitPower("player", 4);
  end

  if (#(parameters) > 0) then
    local operator = tostring(tremove(parameters, 1));
    local value = tonumber(tremove(parameters, 1));
    if (operator == ">") then
      if (v > value) then
        self:deactivate();
      end
    elseif (operator == "<") then
      if (v < value) then
        self:deactivate();
      end
    end
  end
end

function NoShift:on_slash_snare()
  if (self:is_gcd()) then
    self:deactivate();
    return;
  end
  if (self:is_shiftable_cc()) then
    self:activate();
  end
end

function NoShift:on_slash_pred()
  if (self:is_gcd()) then
    self:deactivate();
    return;
  end
  check = UnitBuff("player", "Predator's Swiftness");
  if (check) then
    self:activate();
  end
end

function NoShift:is_gcd()
  if (GetSpellCooldown(768) > 0) then
    return true;
  end

  return false;
end

function NoShift:is_shiftable_cc()
  local check;

  for debuff = 1, #SHIFTABLE do
    check = UnitDebuff("player", SHIFTABLE[debuff]);
    if (check) then
      return true;
    end
  end

  return false;
end

function NoShift:on_slash_health(parameters)
  self:power_check("health", parameters);
end

function NoShift:on_slash_mana(parameters)
  self:power_check("mana", parameters);
end

function NoShift:on_slash_rage(parameters)
  self:power_check("rage", parameters);
end

function NoShift:on_slash_focus(parameters)
  self:power_check("focus", parameters);
end

function NoShift:on_slash_energy(parameters)
  self:power_check("energy", parameters);
end

function NoShift:on_slash_on(parameters)
  SetCVar("AutoUnshift", 0);
end

function NoShift:on_slash_off(parameters)
  SetCVar("AutoUnshift", 1);
end

function NoShift:on_slash_debug(parameters)
  if (#(parameters) > 0) then
    local status = tremove(parameters, 1);
    if (status == "on") then
      self.debug = true;
    else
      self.debug = false;
    end
  else
    if not self.debug then
      self.debug = true;
    else
      self.debug = false;
    end
  end
  if self.debug then
    self:log_output("Debug output enabled");
  else
    self:log_output("Debug output disabled");
  end
end

function NoShift:register_slash_action(action, callback, description)
  if (type(callback) ~= "function") and (type(callback) ~= "string") then
    self:log_output("Invalid callback for slash action:", action);
    return;
  end
  if not description then
    description = "No description available";
  end
  if not self.slash_actions then
    self.slash_actions = {};
  end
  self.slash_actions[action] = {
    ["callback"] = callback, ["description"] = description
  };
end

function NoShift:register_slash_command(cmd)
  if not self.slash_commands then
    self.slash_commands = {};
    -- Add to SlashCmdList when the first command is added
    SlashCmdList["KOTJ"] = function(parameters)
      if (parameters == "") then
        parameters = "help";
      end
      NoShift:on_slash_command({ strsplit(" ", parameters) });
    end;
  end
  if not tContains(self.slash_commands, cmd) then
    local index = #(self.slash_commands) + 1;
    tinsert(self.slash_commands, cmd);
    _G["SLASH_KOTJ"..index] = cmd;
  end
end

-- init
NoShift:init();