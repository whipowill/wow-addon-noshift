local _, L = ...;

local HOTS = {
  "Rejuvenation",
};

-- From LoseControl (https://wotlkaddons.com/addon/losecontrol)
local SPELLS = {
  -- Death Knight
  [47481] = "CC",   -- Gnaw (Ghoul)
  [51209] = "CC",   -- Hungering Cold
  [47476] = "Silence",  -- Strangulate
  [45524] = "Snare",  -- Chains of Ice
  [55666] = "Snare",  -- Desecration (no duration, lasts as long as you stand in it)
  [58617] = "Snare",  -- Glyph of Heart Strike
  [50436] = "Snare",  -- Icy Clutch (Chilblains)
  -- Druid
  [5211]  = "CC",   -- Bash (also Shaman Spirit Wolf ability)
  [33786] = "CC",   -- Cyclone
  [2637]  = "CC",   -- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
  [22570] = "CC",   -- Maim
  [9005]  = "CC",   -- Pounce
  [339]   = "Root", -- Entangling Roots
  [19675] = "Root", -- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
  [58179] = "Snare",  -- Infected Wounds
  [61391] = "Snare",  -- Typhoon
  -- Hunter
  [60210] = "CC",   -- Freezing Arrow Effect
  [3355]  = "CC",   -- Freezing Trap Effect
  [24394] = "CC",   -- Intimidation
  [1513]  = "CC",   -- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
  [19503] = "CC",   -- Scatter Shot
  [19386] = "CC",   -- Wyvern Sting
  [34490] = "Silence",  -- Silencing Shot
  [53359] = "Disarm", -- Chimera Shot - Scorpid
  [19306] = "Root", -- Counterattack
  [19185] = "Root", -- Entrapment
  [35101] = "Snare",  -- Concussive Barrage
  [5116]  = "Snare",  -- Concussive Shot
  [13810] = "Snare",  -- Frost Trap Aura (no duration, lasts as long as you stand in it)
  [61394] = "Snare",  -- Glyph of Freezing Trap
  [2974]  = "Snare",  -- Wing Clip
  -- Hunter Pets
  [50519] = "CC",   -- Sonic Blast (Bat)
  [50541] = "Disarm", -- Snatch (Bird of Prey)
  [54644] = "Snare",  -- Froststorm Breath (Chimera)
  [50245] = "Root", -- Pin (Crab)
  [50271] = "Snare",  -- Tendon Rip (Hyena)
  [50518] = "CC",   -- Ravage (Ravager)
  [54706] = "Root", -- Venom Web Spray (Silithid)
  [4167]  = "Root", -- Web (Spider)
  -- Mage
  [44572] = "CC",   -- Deep Freeze
  [31661] = "CC",   -- Dragon's Breath
  [12355] = "CC",   -- Impact
  [118]   = "CC",   -- Polymorph
  [18469] = "Silence",  -- Silenced - Improved Counterspell
  [64346] = "Disarm", -- Fiery Payback
  [33395] = "Root", -- Freeze (Water Elemental)
  [122]   = "Root", -- Frost Nova
  [11071] = "Root", -- Frostbite
  [55080] = "Root", -- Shattered Barrier
  [11113] = "Snare",  -- Blast Wave
  [6136]  = "Snare",  -- Chilled
  [120]   = "Snare",  -- Cone of Cold
  [116]   = "Snare",  -- Frostbolt
  [47610] = "Snare",  -- Frostfire Bolt
  [31589] = "Snare",  -- Slow
  -- Paladin
  [853]   = "CC",   -- Hammer of Justice
  [2812]  = "CC",   -- Holy Wrath
  [20066] = "CC",   -- Repentance
  [20170] = "CC",   -- Stun (Seal of Justice proc)
  [10326] = "CC",   -- Turn Evil
  [63529] = "Silence",  -- Shield of the Templar
  --[20184] = "Snare",  -- Judgement of Justice (unshiftable, commented out by whipowill)
  -- Priest
  [605]   = "CC",   -- Mind Control
  [64044] = "CC",   -- Psychic Horror
  [8122]  = "CC",   -- Psychic Scream
  [9484]  = "CC",   -- Shackle Undead
  [15487] = "Silence",  -- Silence
  --[64058] = "Disarm", -- Psychic Horror
  --[15407] = "Snare",  -- Mind Flay (unshiftable, commented out by whipowill)
  -- Rogue
  [2094]  = "CC",   -- Blind
  [1833]  = "CC",   -- Cheap Shot
  [1776]  = "CC",   -- Gouge
  [408]   = "CC",   -- Kidney Shot
  [6770]  = "CC",   -- Sap
  [1330]  = "Silence",  -- Garrote - Silence
  [18425] = "Silence",  -- Silenced - Improved Kick
  [51722] = "Disarm", -- Dismantle
  [31125] = "Snare",  -- Blade Twisting
  [3409]  = "Snare",  -- Crippling Poison
  [26679] = "Snare",  -- Deadly Throw
  -- Shaman
  [39796] = "CC",   -- Stoneclaw Stun
  [51514] = "CC",   -- Hex
  [64695] = "Root", -- Earthgrab
  [63685] = "Root", -- Freeze
  [3600]  = "Snare",  -- Earthbind
  [8056]  = "Snare",  -- Frost Shock
  [8034]  = "Snare",  -- Frostbrand Attack
  -- Warlock
  [710]   = "CC",   -- Banish
  [6789]  = "CC",   -- Death Coil
  [5782]  = "CC",   -- Fear
  [5484]  = "CC",   -- Howl of Terror
  [6358]  = "CC",   -- Seduction (Succubus)
  [30283] = "CC",   -- Shadowfury
  [24259] = "Silence",  -- Spell Lock (Felhunter)
  [18118] = "Snare",  -- Aftermath
  [18223] = "Snare",  -- Curse of Exhaustion
  -- Warrior
  [7922]  = "CC",   -- Charge Stun
  [12809] = "CC",   -- Concussion Blow
  [20253] = "CC",   -- Intercept (also Warlock Felguard ability)
  [5246]  = "CC",   -- Intimidating Shout
  [12798] = "CC",   -- Revenge Stun
  [46968] = "CC",   -- Shockwave
  [18498] = "Silence",  -- Silenced - Gag Order
  [676]   = "Disarm", -- Disarm
  [58373] = "Root", -- Glyph of Hamstring
  [23694] = "Root", -- Improved Hamstring
  [1715]  = "Snare",  -- Hamstring
  [12323] = "Snare",  -- Piercing Howl
  [63757] = "Snare", -- Thunderclap (added by whipowill)
  -- Other
  [30217] = "CC",   -- Adamantite Grenade
  [67769] = "CC",   -- Cobalt Frag Bomb
  [30216] = "CC",   -- Fel Iron Bomb
  [20549] = "CC",   -- War Stomp
  [25046] = "Silence",  -- Arcane Torrent
  [39965] = "Root", -- Frost Grenade
  [55536] = "Root", -- Frostweave Net
  [13099] = "Root", -- Net-o-Matic
  [15609] = "Root", -- Hooked Net (added by whipowill)
  [29703] = "Snare",  -- Dazed
  -- Immunities
  [46924] = "Immune", -- Bladestorm (Warrior)
  [642]   = "Immune", -- Divine Shield (Paladin)
  [45438] = "Immune", -- Ice Block (Mage)
  [34692] = "Immune", -- The Beast Within (Hunter)
};

local STUNS = {};
local SNARES = {};
local i = 1;
local j = 1;
for k, v in pairs(SPELLS) do
  local name = GetSpellInfo(k);
  if (name) then
    if (v == "Snare" or v == "Root") then
      SNARES[i] = name;
      i=i+1;
    elseif (v == "CC") then
      STUNS[j] = name;
      j=j+1;
    end
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
  self:register_slash_action('health', 'on_slash_health', '|cffffff00<> <value>|r Disable shifting if health is above/below value');
  self:register_slash_action('mana', 'on_slash_mana', '|cffffff00<> <value>|r Disable shifting if mana is above/below value');
  self:register_slash_action('rage', 'on_slash_rage', '|cffffff00<> <value>|r Disable shifting if rage is above/below value');
  --self:register_slash_action('focus', 'on_slash_focus', '|cffffff00<> <value>|r Disable shifting if focus is above/below value');
  self:register_slash_action('energy', 'on_slash_energy', '|cffffff00<> <value>|r Disable shifting if energy is above/below value');
  --self:register_slash_action('combo', 'on_slash_combo', '|cffffff00<> <value>|r Disable shifting if combo points is above/below value');
  self:register_slash_action('!snare', 'off_slash_snare', 'Enable shifting if snared (and not stunned)');
  self:register_slash_action('!proc', 'off_slash_pred', 'Enable shifting if Predator\'s Swiftness has procced');
  self:register_slash_action('!int', 'off_slash_int', 'Enable shifting if enemy is casting/interuptable');
  --self:register_slash_action('!hot', 'on_slash_hot', 'Enable shifting if you are missing Rejuvenation');
  self:register_slash_action('on', 'on_slash_on', 'Set shifting to off');
  self:register_slash_action('off', 'on_slash_off', 'Reset shifting to on');
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

  --self:log_debug("Slash command called: ", unpack(parameters));

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
  if (self:is_gcd() or self:is_stunned()) then
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

function NoShift:is_stunned()
  for i = 1, #STUNS do
    local check = UnitDebuff("player", STUNS[i]);
    if (check) then
      self:log_debug("Refused to shift bc of "..STUNS[i]);
      return true; -- do not attempt to break form when stunned
    end
  end
  return false;
end

function NoShift:is_snared()
  for i = 1, #SNARES do
    local check = UnitDebuff("player", SNARES[i]);
    if (check) then
      self:log_debug("Shifting out of "..STUNS[i]);
      return true;
    end
  end
  return false;
end

function NoShift:off_slash_snare()
  if (self:is_gcd() or self:is_stunned()) then
    self:deactivate();
    return;
  end
  if (self:is_snared()) then
    self:activate();
    return;
  end
end

function NoShift:off_slash_pred()
  if (self:is_gcd() or self:is_stunned()) then
    self:deactivate();
    return;
  end
  local check = UnitBuff("player", "Predator's Swiftness");
  if (check) then
    self:activate();
  end
end

function NoShift:off_slash_int()
  if (self:is_gcd() or self:is_stunned()) then
    self:deactivate();
    return;
  end
  --local spell, _, _, _, _, _, _, _, is_interruptable = UnitCastingInfo("target"); <-- no worky?
  local check = UnitCastingInfo("target");
  if (check) then
    self:activate();
  end
end

function NoShift:on_slash_hot()
  if (self:is_gcd() or self:is_stunned()) then
    self:deactivate();
    return;
  end
  for i = 1, #HOTS do
    local check = UnitDebuff("player", HOTS[i]);
    if (check == nil) then
      self:activate();
    end
  end
end

function NoShift:is_gcd()
  if (GetSpellCooldown(768) > 0) then
    return true;
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