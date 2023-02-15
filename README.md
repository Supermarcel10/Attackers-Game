# 2D "Attackers" Game Prototype
This game was created within 3 days as part of a Java Bootcamp at my University.<br>

Due to the small time frame, only the basic features have been built upon.<br>
The most complicated part of this project was collision detection as well as a basic AI to follow the player around.<br>
The collision detection when shooting is still currently broken, making the game unplayable.

![image](https://user-images.githubusercontent.com/47798787/219222076-448cdec0-9826-42ee-b700-ec7c1bbd9148.png)

## Controls
`W` Move up.<br>
`A` Move left.<br>
`S` Move down.<br>
`D` Move right.<br>
`SPACE` Shoot in the direction walking.<br>
`L` (DEBUG) Temporary debug command to force next wave.<br>
`K` (DEBUG) Kill a random enemy in the wave.

## General Concept
Due to the short time frame of this project, I was unable to get the majority of the features I wanted to in the time I had.<br>
The game is fairly far from playable, and should be considered more of a prototype.

The game is intended to be a never ending rougelike game, the main purpose is to see which player can get the highest wave and beat high scores.
When the game is started at wave 0, the countdown will begin to start wave 1.<br>
A certain number of mobs based on the wave will spawn. Once all enemies are killed, the wave is cleared.<br>

Every few rounds a shop will come to visit with upgrades - such as:
- Additional Health
- Shooting Speed
- Damage
- Penetration power (how many enemies can be killed with one shot)

How often the shop arrives is determined by the wave, so with time the game will get more complex and harder.<br>

Players can collect coins and powerups.
- Coins can be used to spend in the shop.
- Powerups are temporary and increase shooting speed, damage or penetration power.

There are multiple types of mobs that spawn:
- "Normal": Average, average HP, normal DMG
- "Speedy": Fast, low HP, normal DMG
- "Tanky": Slow, high HP, high DMG
- "Frosty": Slow, low HP, normal DMG, Freezes player if in range when killed
- "Blazie": Fast, low HP, high DMG, Highly damages player with fire when killed.

The difficulty and number of difficult mobs is determined by the wave.
