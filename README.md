# NoShift

An addon for World of Warcraft v3.3.5 to assist w/ Druid powershifting macros.

## Problem

There is an internal console variable called ``AutoUnshift`` which governs if the game will automatically unshift you when you cast certain spells.  When crafting Druid macros there are times when we want to disable ``AutoUnshift`` to prevent this from happening.  This addon provides some helpful macro commands to assist in this decision making process.

## Usage

### Powershifting

For reshifting into current form to trigger [Wolfshead Helm](https://www.wowhead.com/classic/item=8345/wolfshead-helm) or to break snares:

```
/stopmacro [mounted] [stealth] [nocombat] [noform]
/ns on 				<-- disable, set AutoUnshift to 0
/ns !snare			<-- if snared, set AutoUnshift to 1
/cast [form:1] !Dire Bear Form
/ns off				<-- restore default, set AutoUnshift to 1
/stopmacro [noform:3]
/ns energy > 30			<-- if energy is more than 30%, set AutoUnshift to 0
/ns !snare			<-- if snared, set AutoUnshift to 1
/cast [form:3] !Cat Form
/ns off				<-- restore default, set AutoUnshift to 1
```

### Bearweaving

For shifting between cat and bear while regenerating energy:

```
/stopmacro [mounted] [stealth] [nocombat] [noform]
/ns energy < 90			<-- if energy is less than 90%, set AutoUnshift to 0
/ns rage > 15			<-- if rage is more than 15%, set AutoUnshift to 0
/ns !snare			<-- if snared, set AutoUnshift to 1
/cast [form:1] !Cat Form
/ns off				<-- restore default, set AutoUnshift to 1
/stopmacro [noform:3]
/ns energy > 30			<-- if energy is more than 30%, set AutoUnshift to 0
/ns !snare			<-- if snared, set AutoUnshift to 1
/cast [form:3] !Dire Bear Form
/ns off				<-- restore default, set AutoUnshift to 1
```

### Predatory Strikes

For breaking form to use [Predator's Swiftness](https://www.wowhead.com/wotlk/spell=69369/predators-swiftness) to instant self heal:

```
/stopmacro [mounted] [stealth] [noform]
/ns on 				<-- disable, set AutoUnshift to 0
/ns !pred 			<-- if procced, set AutoUnshift to 1
/ns health > 90 		<-- if health is more than 90%, set AutoUnshift to 0
/cast [@player] Regrowth
/ns off				<-- restore default, set AutoUnshift to 1
```

## Notes

- The addon will never allow shifting during a GCD.
- The addon will never allow shifting while stunned.

## History

This addon began as a fork of [DruidMacroHelper](https://github.com/ForsakenNGS/DruidMacroHelper) and became my own complete overhaul.  My version does far less and does it far better inasmuch as I have removed all the laggy logic operations.  DMH was totally unviable on WOTLK v3.3.5.

## Credits

- Special thanks to [LoseControl](https://wotlkaddons.com/addon/losecontrol) for the list of shiftable debuffs.