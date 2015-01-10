
## Wanderers

An open world adventure / dungeon crawling game. Although the final version is not ready yet,
many of the characteristic features of the game are already implemented.

[![](http://i.imgur.com/kCdu5qL.png)](http://i.imgur.com/RGIn9hn.png) 
[![](http://i.imgur.com/ARCqRzW.png)](http://i.imgur.com/bRqoNNG.png) 

### Features
  * *Multi-scale simulation of a big, but finite, world.* 
    The player and the surrounding area are simulated accurately. 
    Simulteneously, less precise macroscopic scale simulation updates the rest of the world.
    All actions of each individual actor (including the player) 
    become seemlessly incorporated into the big picture of the living and evolving world.    
  * *Semi-continuous grid-based movement and physics.*
    To avoid ad hoc discrete time systems, which are frequently quite "peculiar",
    the time is absolutele and continuous, all objects move simulateneously. 
    However, their movement is tied to the grid, largely preserving the precision and the feel 
    of familiar grid-based games. The model naturally supports physical interactions between
    game objects, leading to fun and complex tactical combat.    
  * The game features multiple civilizations, which may be at war with each other. 
    You may take part in these wars, or you may go explore underground dungeons
    and forests infested with monsters.
    A lot of stuff is happening even without your participation.     
  * The game is designed to be light on computer resources.   

Half-done:     

  * Economics of the world. Merchants and trade.
  * Fully functional player-like NPC actors and their hierarchical organizations.   
  * Special attacking techniques for some weapons (such as long swords, spears, mauls etc.).   
  * Complex overworld topology.

Not implemented yet:    

  * Spell casting.   
  * Rumors, information spreading, reputation.    
  * More interesting NPCs and locations. More complex world topology.   
  * Apocalyptic events, villains, and winning conditions.    

### How to build
On Linux and (probably) OSX. Install the latest `ocaml` package for your system.
Make sure you have your SDL1.2 and OpenGL libraries installed. Then just execute make.    
  `make`

### Command line
  `./wanderers` loads the saved game if it exists, otherwise starts a new game.   
  `./wanderers <seed>` starts a new game with the given seed.   
  `./wanderers ?` starts a new game with a random seed.

### Controls
`Arrow keys` or `h` `j` `k` `l` Movement  
`w` `a` `s` `d` or `Ctrl+direction` Melee attack   
`t` Rest   
`Space` Wait   
`i` or `Enter` Inventory mode (`0`, `1`, `2` to move items between sections, `Esc` to cancel)   
`f` Ranged attack mode (`f` to fire, `Esc` to cancel)   
`v` Interaction mode (`v` or `Enter` to open/close doors or barter, `f` for ranged attack)   
`m` Map (`arrow keys` and `<`, `>` to move, `Esc` to cancel)    
`<` `>` Use stairs   
`+` `-` Faster or slower movement speed    
`Esc` or `q` Cancel   
`Ctrl+q` Save and quit   

#### Inventory
To pick up an item, open the inventory `i`, choose the item with the arrow keys,
then press `1` to put it on, `2` to put it in the inventory, or `0` to drop it on the ground.
Press `Esc` or `q` to close the inventory. There are 5 specialized slots in the equipment 
container: 1) left hand, 2) torso, 3) right hand, 4) head, 5) slot for coins. (There is no 
difference between the left and the right hand).

![](http://i.imgur.com/8jVzEue.png)

#### Merchants and barter
A merchant can be identified by the **cloak-like symbol on their shoulder**. 
They often can be found in the regions with markets (such regions are marked by a golden ring on the map),
Small nations may have no or very few merchants. 

![](http://i.imgur.com/wGMhzY2.png)

To trade with a merchant, stand next to him or her, switch to the interation mode `v`, and
press `v` or `Enter` again. The barter mode works the same way as the inventory mode.
To confirm your purchase, press `Enter`.

### Tips for new players
When you start playing, first, take a look at your `CNS` (Constitution).
This is your mass in kilograms, and your max HP. It is better if `CNS` is in the range 65-85.
Too heavy characeters are a little too slow, and too light characters a a bit too weak.
In the future, really light characters will get better magical abilities, but it is not in 
the game yet.

The very first goal is to find some weapon, even a simple stick or a knife will make a big 
difference. You also may find a good random seed, where you start with weapons. To rest, 
press `t`, you will recover some HP.

When equipping new items, pay attention to `MBL` (Mobility). When it drops down (say below 0.9), 
your damage also goes down considerably, and this is not what you want.

### Attributes and properties
#### Main attributes
`ATL (Athletic)`. Athletic abilities, physical strength. Affects both the damage you deal,
and the speed you move. However, strong characters are also heavy, and so don't move very fast.   
`RCT (Reaction)`. Reaction delay. Determines all movement and attack delays. The smaller the better.    
`CNS (Constitution)`. Mass in kilograms. Max HP.  

#### Mobility
`MBL (Mobility)`. Is equal to 1.0 when not wearing anything. Goes down when encumbered by equipment. 
Affects the speed of movement, reaction time, the strength and the duration of your attacks.    
`WGT (Total weight)`. The mass of the character, plus the total mass of everything they are carrying.

#### Melee attack
`DMG (Damage)`. Damage rate factor (the damage dealt per unit of time).  
`DUR (Duration)`. Melee attack duration.

#### Ranged attack
`DMG (Damage)`. Damage factor of a projectile.   
`FRC (Force)`. The momentum a projectile gets.  

#### Defense
`DEF (Defense)`. The probability to block an attack. All momentum of the attack is still absorbed,
so defense does not improve evasion.

### License
The game is distributed under GPL3 license. 
Included GLCaml library is distributed under BSD 2-clause license.

### More screenshots
[![](http://i.imgur.com/gm0e3Sv.png)](http://i.imgur.com/t4jiXQA.png) 
[![](http://i.imgur.com/g2d95a4.png)](http://i.imgur.com/KQTFw5g.png) 
[![](http://i.imgur.com/CS3wUVw.png)](http://i.imgur.com/qzAvnpq.png) 
[![](http://i.imgur.com/MjwGhlD.png)](http://i.imgur.com/c7chiWd.png) 
