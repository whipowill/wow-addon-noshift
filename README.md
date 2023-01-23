# NoShift

An addon for World of Warcraft v3.3.5 to assist w/ Druid powershifting macros.

## Problem

There is an internal console variable called ``AutoUnshift`` which governs if the game will automatically unshift you when you cast certain spells.  When crafting Druid macros there are times when we want to disable ``AutoUnshift`` to prevent this from happening.  This addon provides some helpful macro commands to assist in this decision making process.

## Example

```
#showtooltip
/stopmacro [nocombat]
/ns energy > 30
/ns mana < 20
/ns health < 20
/cast !Cat Form
/ns off
```

The above macro example will disable ``AutoUnshift`` if energy is over 30%, mana is under 20%, or health is under 20%.  All values are considered on a percentage basis.

## History

This addon began as a fork of [DruidMacroHelper](https://github.com/ForsakenNGS/DruidMacroHelper) and became my own complete overhaul.  My version does far less and does it far better inasmuch as I have removed all the laggy logic operations.