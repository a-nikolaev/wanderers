
## Wanderers

An open world roguelike. Currently, at a rather early development stage. 
Nevertheless, many characteristic features of the game are already implemented, and it is playable.

[![](http://i.imgur.com/S8syczzs.png)](http://i.imgur.com/S8syczz.png) 
[![](http://i.imgur.com/LQgZCbVs.png)](http://i.imgur.com/LQgZCbV.png) 
[![](http://i.imgur.com/pKucMxvs.png)](http://i.imgur.com/pKucMxv.png) 
[![](http://i.imgur.com/0QB9Ibzs.png)](http://i.imgur.com/0QB9Ibz.png) 

### Features
  * *Multi-scale simulation of a big, but finite, world.* 
    This means that the area around the player is
    simulated in detail, while the rest of the world is updated 
    less precisely. It runs fast too.    
  * *Semi-continuous grid-based movement and reasonably realistic physics.*
    It helps to avoid ad hoc discrete time systems, which are
    usually quite "peculiar".
    All objects move simulateneously. However, their movement is tied to the grid, 
    largely preserving the feel of familiar discrete grid-based games.    
  * Countries and tribes can be at war if their people don't like each other. The underground dungeons 
    are filled with monsters. A lot of stuff is happening even without your participation. 
    However, your actions also can change the world. You can try to defend your village surrounded by
    enemies, or genocide a small neighboring country, if you wish.        

Half-done:     

  * Economics of the world.     
  * Fully functional player-like NPCs and their hierarchical organizations.   
  * Special attacking techniques for some weapons (such as long swords, spears, mauls etc.).   

Not implemented yet:    

  * Spell casting.   
  * Shops. Interesting NPCs and locations. More complex world topology.   
  * Rumors, information spreading, reputation.    
  * Apocalyptic events, villains, and winning conditions.    

### How to build
On Linux and (probably) OSX. Install the latest `ocaml` package for your system.
Make sure you have OpenGL drivers installed. Then just execute make.    
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
`Esc` or `q` Cancel   
`Ctrl+Q` Save and quit   

To pick up an item, open the inventory `i`, choose the item with the arrow keys,
then press `1` to put it on, `2` to put it in the inventory, or `0` to drop it.
Press `Esc` or `q` to close the inventory. Also, don't put a lot of stuff in 
the inventory. 

### License
The game is distributed under GPL3 license. 
Included GLCaml library is distributed under BSD 2-clause license.
