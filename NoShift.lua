local _, L = ...;

NoShift = {};

function NoShift:Init()
  self:RegisterSlashCommand("/ns");
  self:RegisterSlashAction('help', 'OnSlashHelp', 'Show list of slash actions (or description for the given action)');
  self:RegisterSlashAction('health', 'OnSlashHealth', '|cffffff00<> <value>|r Disable autoUnshift if health is above/below value');
  self:RegisterSlashAction('mana', 'OnSlashMana', '|cffffff00<> <value>|r Disable autoUnshift if mana is above/below value');
  --self:RegisterSlashAction('rage', 'OnSlashRage', '|cffffff00<> <value>|r Disable autoUnshift if rage is above/below value');
  --self:RegisterSlashAction('focus', 'OnSlashFocus', '|cffffff00<> <value>|r Disable autoUnshift if focus is above/below value');
  self:RegisterSlashAction('energy', 'OnSlashEnergy', '|cffffff00<> <value>|r Disable autoUnshift if energy is above/below value');
  --self:RegisterSlashAction('combo', 'OnSlashRage', '|cffffff00<> <value>|r Disable autoUnshift if combo points is above/below value');
  self:RegisterSlashAction('off', 'OnSlashOff', 'Reset autoUnshift back to normal');
  self:RegisterSlashAction('debug', 'OnSlashDebug', 'Enable or disable debugging output');
end

function NoShift:LogOutput(...)
  print("|cffff0000NoShift|r", ...);
end

function NoShift:LogDebug(...)
  if self.debug then
    print("|cffff0000NoShift|r", "|cffffff00Debug|r", ...);
  end
end

function NoShift:OnSlashCommand(parameters)
  if not self.slashActions then
    self:LogOutput("No slash actions registered!");
    return;
  end
  self:LogDebug("Slash command called: ", unpack(parameters));
  while (#(parameters) > 0) do
    local action = tremove(parameters, 1);
    if not self.slashActions[action] then
      self:LogOutput("Slash action |cffffff00"..action.."|r not found!");
    else
      local actionData = self.slashActions[action];
      if type(actionData.callback) == "function" then
        actionData.callback(parameters);
      else
        self[actionData.callback](self, parameters);
      end
    end
  end
end

function NoShift:OnSlashHelp(parameters)
  if (#(parameters) > 0) then
    local action = tremove(parameters, 1);
    if not self.slashActions[action] then
      self:LogOutput("Slash action |cffffff00"..action.."|r not found!");
    else
      self:LogOutput("|cffffff00"..action.."|r", self.slashActions[action].description);
    end
  else
    self:LogOutput("Available slash commands:");
    for action in pairs(self.slashActions) do
      self:LogOutput("|cffffff00/ns "..action.."|r", self.slashActions[action].description);
    end
  end
end

function NoShift:onPower(method, parameters)
  local v = 0;
  if (method == "health") then
    local current = UnitHealth("player");
    local max = UnitHealthMax("player");
    v = current / max * 100;
  elseif (method == "mana") then
    local current = UnitPower("player", 0);
    local max = UnitPowerMax("player", 0);
    v = current / max * 100;
  --elseif (method == "rage") then
    --v = UnitPower("player", 1);
  --elseif (method == "focus") then
    --v = UnitPower("player", 2);
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
        self:LogDebug("You have too much");
        SetCVar("autoUnshift", 0);
      end
    elseif (operator == "<") then
      if (v < value) then
        self:LogDebug("You don't have enough");
        SetCVar("autoUnshift", 0);
      end
    end
  end
end

function NoShift:OnSlashHealth(parameters)
  self:onPower("health", parameters);
end

function NoShift:OnSlashMana(parameters)
  self:onPower("mana", parameters);
end

function NoShift:OnSlashRage(parameters)
  self:onPower("rage", parameters);
end

function NoShift:OnSlashFocus(parameters)
  self:onPower("focus", parameters);
end

function NoShift:OnSlashEnergy(parameters)
  self:onPower("energy", parameters);
end

function NoShift:OnSlashOff(parameters)
  SetCVar("autoUnshift", 1);
end

function NoShift:OnSlashDebug(parameters)
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
    self:LogOutput("Debug output enabled");
  else
    self:LogOutput("Debug output disabled");
  end
end

function NoShift:RegisterSlashAction(action, callback, description)
  if (type(callback) ~= "function") and (type(callback) ~= "string") then
    self:LogOutput("Invalid callback for slash action:", action);
    return;
  end
  if not description then
    description = "No description available";
  end
  if not self.slashActions then
    self.slashActions = {};
  end
  self.slashActions[action] = {
    ["callback"] = callback, ["description"] = description
  };
end

function NoShift:RegisterSlashCommand(cmd)
  if not self.slashCommands then
    self.slashCommands = {};
    -- Add to SlashCmdList when the first command is added
    SlashCmdList["DRUID_MACRO_HELPER"] = function(parameters)
      if (parameters == "") then
        parameters = "help";
      end
      NoShift:OnSlashCommand({ strsplit(" ", parameters) });
    end;
  end
  if not tContains(self.slashCommands, cmd) then
    local index = #(self.slashCommands) + 1;
    tinsert(self.slashCommands, cmd);
    _G["SLASH_DRUID_MACRO_HELPER"..index] = cmd;
  end
end

NoShift:Init();