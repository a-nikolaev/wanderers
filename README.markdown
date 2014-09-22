
## Wanderers

An open world adverture / dungeon crawling game. Although the final version is not ready yet,
many of the characteristic features of the game are already implemented.

[![](http://i.imgur.com/S8syczzs.png)](http://i.imgur.com/S8syczz.png) 
[![](http://i.imgur.com/LQgZCbVs.png)](http://i.imgur.com/LQgZCbV.png) 
[![](http://i.imgur.com/pKucMxvs.png)](http://i.imgur.com/pKucMxv.png) 
[![](http://i.imgur.com/0QB9Ibzs.png)](http://i.imgur.com/0QB9Ibz.png) 

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

  * Economics of the world.     
  * Fully functional player-like NPC actors and their hierarchical organizations.   
  * Special attacking techniques for some weapons (such as long swords, spears, mauls etc.).   
  * Complex overworld topology.

Not implemented yet:    

  * Spell casting.   
  * Rumors, information spreading, reputation.    
  * Shops. More interesting NPCs and locations. More complex world topology.   
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
`v` Look mode (`v` or `Enter` to open/close doors, `f` for ranged attack, `Esc` to cancel)   
`<` `>` Use stairs   
`+` `-` Faster or slower movement speed    
`Esc` or `q` Cancel   
`Ctrl+q` Save and quit   

To pick up an item, open the inventory `i`, choose the item with the arrow keys,
then press `1` to put it on, `2` to put it in the inventory, or `0` to drop it.
Press `Esc` or `q` to close the inventory. Also, don't put a lot of stuff in 
the inventory. 

### License
The game is distributed under GPL3 license. 
Included GLCaml library is distributed under BSD 2-clause license.
