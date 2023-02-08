# NoShift

An addon for World of Warcraft v3.3.5 to assist w/ Druid powershifting macros.

## Problem

There is an internal console variable called ``AutoUnshift`` which governs if the game will automatically unshift you when you cast certain spells.  When crafting Druid macros there are times when we want to disable ``AutoUnshift`` to prevent this from happening.  This addon provides some helpful macro commands to assist in this decision making process.

## Usage

```
#showtooltip
/stopmacro [nocombat]
/ns energy > 30			<-- if energy is more than 30, set autoshift to 0
/ns mana < 20			<-- if mana is less than 20, set autoshift to 0
/ns health < 20			<-- if health is less than 20, set autoshift to 0
/ns !snare			<-- if snared, set autoshift to 1
/cast [form:3] !Cat Form
/ns off				<-- restore default, set autounshift to 1
```

```
#showtooltip
/stopmacro [nocombat]
/ns on				<-- disable, set autounshift to 0
/ns !snare			<-- if snared, set autoshift to 1
/cast [form:1] !Dire Bear Form
/ns off				<-- restore default, set autounshift to 1
```

## Notes

- The list of debuffs that are shiftable is not perfect, just the ones I've found so far.
- The addon will never process any conditions during a GCD bc it's a waste of time.

## History

This addon began as a fork of [DruidMacroHelper](https://github.com/ForsakenNGS/DruidMacroHelper) and became my own complete overhaul.  My version does far less and does it far better inasmuch as I have removed all the laggy logic operations.  This original addon was totally unviable on WOTLK 3.3.5.