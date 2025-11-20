# NoShift

An addon for World of Warcraft v3.3.5 to assist w/ Druid powershifting macros.

## Problem

There is an internal console variable called ``AutoUnshift`` which governs if the game will let you change forms or not.  When crafting Druid macros there are times when we want to disable this to prevent shifting.

## Usage

The default state of the game is ``/ns off``, which means "no-shift off, druids are allowed to shapeshift".  The double negative of this logic makes it mentally tricky.

This mod fundamentally is **blocking** shifting.

All the commands in this addon are designed to turn off shifting, unless they have a ``!`` in them.  In that case, it's an inverted process that will turn on shifting (if it was off).

### Powershifting

For reshifting into current form to trigger [Wolfshead Helm](https://www.wowhead.com/classic/item=8345/wolfshead-helm) or to break snares:

```
/stopmacro [mounted] [stealth] [nocombat] [noform]
/ns on 				<-- shifting is disabled
/ns !snare          <-- if snared, shifting is enabled (inverted command)
/cast [form:1] !Dire Bear Form
/ns off				<-- restore default, shifting is enabled
/stopmacro [noform:3]
/ns energy > 30     <-- if energy is more than 30%, shifting is disabled
/ns !snare          <-- if snared, shifting is enabled (inverted command)
/cast [form:3] !Cat Form
/ns off				<-- restore default, shifting is enabled
```

### Bearweaving

For shifting between cat and bear while regenerating energy:

```
/stopmacro [mounted] [stealth] [nocombat] [noform]
/ns energy < 90     <-- if energy is less than 90%, shifting is disabled
/ns rage > 15       <-- if rage is more than 15%, shifting is disabled
/ns off snare       <-- if snared, shifting is enabled
/cast [form:1] !Cat Form
/ns off				<-- restore default, shifting is enabled
/stopmacro [noform:3]
/ns energy > 30     <-- if energy is more than 30%, set AutoUnshift to 0
/ns !snare          <-- if snared, shifting is disabled (inverted command)
/cast [form:3] !Dire Bear Form
/ns off				<-- restore default, shifting is enabled
```

### Predatory Strikes

For breaking form to use [Predator's Swiftness](https://www.wowhead.com/wotlk/spell=69369/predators-swiftness) to instant self heal:

```
/stopmacro [mounted] [stealth] [noform]
/ns on 				<-- shifting is disabled
/ns !proc           <-- if procced, shifting is enabled
/ns health > 90     <-- if health is more than 90%, shifting is disabled
/cast [@player] Regrowth
/ns off				<-- restore default, shifting is enabled
```

**This sadly does not work in WOTLK, bc you can't cast Regrowth while in form.**

## Notes

- The addon will never allow shifting during a GCD.
- The addon will never allow shifting while stunned.

## History

This addon began as a fork of [DruidMacroHelper](https://github.com/ForsakenNGS/DruidMacroHelper) and became my own complete overhaul.  My version does far less and does it far better inasmuch as I have removed all the laggy logic operations.  DMH was totally unviable on WOTLK v3.3.5.

## Credits

- Special thanks to [LoseControl](https://wotlkaddons.com/addon/losecontrol) for the list of shiftable debuffs.