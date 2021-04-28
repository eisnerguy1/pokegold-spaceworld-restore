<img src="images/title.png" width="320" height="288">


# This is a fork of the [**Pokémon Gold Spaceworld 1997 Demo**][pokegold] disassembly.

The aim is to restore as much content in the demo as possible. For more information about the Spaceworld 1997 demo, check out the article on tcrf:
<br>
[Proto:Pokémon Gold and Silver/Spaceworld 1997 Demo](https://tcrf.net/Proto:Pokémon_Gold_and_Silver/Spaceworld_1997_Demo)
<br><br>
It builds the following ROMs:

- Gold_debug.sgb `sha1: (None yet)`
- Gold_debug.sgb (correct header) `sha1: (None yet)`

You will need to provide a copy of Gold_debug.sgb renamed **baserom.gb** to build the ROMs.  [Thanks to Polished Map](https://github.com/Rangi42/polished-map) for allowing me to correct the collision data and other issues with ease.

[pokegold]: https://github.com/pret/pokegold-spaceworld

<!-- TABLE OF CONTENTS -->
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
     <a href="#to-do">Things to work on</a>
  </li>
<li>
     <a href="#minimal_story_mode">Enabled Minimal Story Mode</a>
  </li>
  <li>
    <a href="#rival_battle">Fixed Rival battle in minimal story mode</a>
    </li>
    <li>
    <a href="#pokemart_widths">Fixed PokeMart widths</a>
    </li> 
      <li>
    <a href="#evolutions">Restored Disabled Evolutions</a>
    </li> 
        <li>
    <a href="#rival_end_demo">Moved the Rival at end of demo</a>
    </li> 
          <li>
    <a href="#gate">Correct collision data for the Gate buildings & Pkmn Center Battle & Trade rooms</a>
    </li>
            <li>
    <a href="#pokemart">Correct collision data for the PokéMart interior</a>
    </li>
  </ol>
  
<br>
<div id="to-do""> </div>
<h2>Things to work on</h2>
                
- [ ] Correct collision data for all of the towns
- [ ] Correct tall grass collision data
- [ ] Correct collision data for water
- [ ] Have fully functional 2F in all Pokémon Centers?
- [ ] Change end of game (when out of usable Pokémon) to having your party auto-healed and the game continues
- [ ] Fix Heart Stone & Poison Stone
- [ ] Verify that maps seamlessly connect?  If not, correct them?
- [ ] Fix Pokémon Storage?  Use Field Debug Menu item?
- [ ] Enable PokéMart? Field Debug Menu item?
- [ ] Enable Pikachu & Sunflora's send out animation for all shiny Pokémon and give those 2 Pokémon the default send out animation
- [ ] add stairs up for schools -> Gym: old
- [ ] add stairs down for gyms -> school: all
- [ ] remove school floor and lead directly to gym instead?  
- [ ] Give the starter Pokémon a berry to hold like in the final GSC?    
- [ ] Add missing buildings for Prince
- [ ] Fix Trading palette issues       
<br>
<div id="minimal_story_mode"></div>
<h2><a href="https://github.com/eisnerguy1/pokegold-spaceworld-restore/commit/49410368d68fd22434da73e8bbf02d48516d6d61">Enabled minimal story mode </a></h2>
<table>
  <tr>
    <td width="320" height="288"> <img src="images/1_Story_mode/Story_mode_01.png"></td>
    <td width="320" height="288"> <img src="images/1_Story_mode/Story_mode_02.png"></td> 
    <td width="320" height="288"> <img src="images/1_Story_mode/Story_mode_03.png"></td>
  </tr> 
  
   <tr>
     <td width="320" height="288"> <img src="images/1_Story_mode/Story_mode_04.png"></td>
     <td width="320" height="288"> <img src="images/1_Story_mode/Story_mode_05.png"></td>
     <td width="320" height="288"> <img src="images/1_Story_mode/Story_mode_06.png"></td>
  </tr> 
     <tr>
     <td width="320" height="288"> <img src="images/1_Story_mode/Story_mode_07.png"></td>
  </tr> 
</table>


<div id="rival_battle"></div>
<h2><a href="https://github.com/eisnerguy1/pokegold-spaceworld-restore/commit/971fd4f10ffccc18d2869dba3c4c5fe77d3e56aa">Fixed Rival battle in minimal story mode </a></h2>
<table>
  <tr>
        <td width="320" height="288"> <img src="images/2_Rival_Battle/Rival_Battle_01.png"></td> 
        <td width="320" height="288"> <img src="images/2_Rival_Battle/Rival_Battle_02.png"></td> 
        <td width="320" height="288"> <img src="images/2_Rival_Battle/Rival_Battle_03.png"></td>
      </tr>
    <tr>
        <td width="320" height="288"> <img src="images/2_Rival_Battle/Rival_Battle_04.png"></td> 
  </tr> 
</table>


<div id="pokemart_widths"></div>
<h2><a href="https://github.com/eisnerguy1/pokegold-spaceworld-restore/commit/538bef1988b1a43f24857db20f52152b3b2714b8">Fixed PokéMart widths</a></h2>
<table>
  <tr>
        <td width="384"> <img src="images/3_PokéMart/PKMNGS-SpaceWorld97-PokeMart.png"></td> 
        <td width="512"> <img src="images/3_PokéMart/PKMNGS-SpaceWorld97-PokeMart-Correct.png"></td> 
      </tr>
  </table>
  <table>
    <tr>
        <td width="320" height="288"> <img src="images/3_PokéMart/Old_PokéMart_01.png"></td> 
        <td width="320" height="288"> <img src="images/3_PokéMart/Old_PokéMart_02.png"></td> 
        <td width="320" height="288"> <img src="images/3_PokéMart/Old_PokéMart_03.png"></td> 
  </tr>
    <tr>
        <td width="320" height="288"> <img src="images/3_PokéMart/High_Tech_PokéMart_01.png"></td> 
        <td width="320" height="288"> <img src="images/3_PokéMart/High_Tech_PokéMart_02.png"></td> 
        <td width="320" height="288"> <img src="images/3_PokéMart/High_Tech_PokéMart_03.png"></td> 
  </tr> 
  <tr>
        <td width="320" height="288"> <img src="images/3_PokéMart/North_PokéMart_01.png"></td> 
        <td width="320" height="288"> <img src="images/3_PokéMart/North_PokéMart_02.png"></td> 
        <td width="320" height="288"> <img src="images/3_PokéMart/North_PokéMart_03.png"></td> 
  </tr>
</table>



<div id="evolutions"></div>
<h2><a href="https://github.com/eisnerguy1/pokegold-spaceworld-restore/commit/e0abfe6db4f4ce4061f80d196883f4f6998221d2">Restored Disabled Evolutions</a></h2>
<table>
  <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_01.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_02.png"></td> 
      </tr>
 
  <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_03.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_04.png"></td> 
      </tr>
        <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_05.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_06.png"></td> 
      </tr>
      <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_07.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_08.png"></td> 
      </tr>
        <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_09.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_10.png"></td> 
      </tr>
    <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_09.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_11.png"></td> 
      </tr>
          <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_09.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_12.png"></td> 
      </tr>
          <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_09.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_13.png"></td> 
      </tr>
          <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_14.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_15.png"></td> 
      </tr>
                <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_16.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_17.png"></td> 
      </tr>
                <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_18.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_19.png"></td> 
      </tr>
                      <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_20.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_21.png"></td> 
      </tr>
                            <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_22.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_23.png"></td> 
      </tr>
                            <tr>
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_24.png"></td> 
        <td width="320" height="288"> <img src="images/4_Evolutions/Evolutions_25.png"></td> 
      </tr>
</table>

Heart Stone & Poison Stone doen't work for some reason.   I'm still <a href="https://pastebin.com/7m0eeRh3">looking into</a> why they don't work.

<b>Heart Stone Evolutions</b>
<table>
     <tr>
        <td width="112"> <img src="images/4_Evolutions/Heart_Stone/GS-Proto-Normal-061-Front.png"></td> 
        <td width="112"> <img src="images/4_Evolutions/Heart_Stone/GS-Proto-Normal-199-Front.png"></td> 
      </tr>
       <tr>
        <td width="112"> <img src="images/4_Evolutions/Heart_Stone/GS-Proto-Normal-133-Front.png"></td> 
        <td width="112"> <img src="images/4_Evolutions/Heart_Stone/GS-Proto-Normal-205-Front.png"></td> 
      </tr>
         <tr>
        <td width="112"> <img src="images/4_Evolutions/Heart_Stone/GS-Proto-Normal-176-Front.png"></td> 
        <td width="112"> <img src="images/4_Evolutions/Heart_Stone/GS-Proto-Normal-177-Front.png"></td> 
      </tr>
</table>

<b>Poison Stone Evolutions</b>
<table>
     <tr>
        <td width="112"> <img src="images/4_Evolutions/Poison_Stone/GS-Proto-Normal-044-Front.png"></td> 
        <td width="112"> <img src="images/4_Evolutions/Poison_Stone/GS-Proto-Normal-221-Front.png"></td> 
      </tr>
       <tr>
        <td width="112"> <img src="images/4_Evolutions/Poison_Stone/GS-Proto-Normal-070-Front.png"></td> 
        <td width="112"> <img src="images/4_Evolutions/Poison_Stone/GS-Proto-Normal-222-Front.png"></td> 
      </tr>
         <tr>
        <td width="112"> <img src="images/4_Evolutions/Poison_Stone/GS-Proto-Normal-133-Front.png"></td> 
        <td width="112"> <img src="images/4_Evolutions/Poison_Stone/GS-Proto-Normal-206-Front.png"></td> 
      </tr>
</table>


<div id="rival_end_demo"></div>
<h2><a href="https://github.com/eisnerguy1/pokegold-spaceworld-restore/commit/eea90e4d2319249f43b7494136c3cc5eadc928a5">Moved the Rival at end of demo</a></h2>
<table>
  <tr>
        <td width="320" height="288"> <img src="images/5_Rival_Demo_End/Rival_Demo_End_01.png"></td> 
        <td width="320" height="288"> <img src="images/5_Rival_Demo_End/Rival_Demo_End_02.png"></td> 
      </tr>
</table>


<div id="gate"></div>
<h2><a href="https://github.com/eisnerguy1/pokegold-spaceworld-restore/commit/619483a6d718b622bc037cf5ea5701009f115588">Correct collision data for the Gate buildings & Pkmn Center Battle & Trade rooms.</a></h2>
<table>
  <tr>
        <td width="320" height="288"> <img src="images/6_Gate_PKMN_trade_battle/Gate_PKMN_trade_battle_01.png"></td> 
        <td width="320" height="288"> <img src="images/6_Gate_PKMN_trade_battle/Gate_PKMN_trade_battle_02.png"></td>
            <td width="320" height="288"> <img src="images/6_Gate_PKMN_trade_battle/Gate_PKMN_trade_battle_03.png"></td>
      </tr>
  
  <tr>
          <td width="320" height="288"> <img src="images/6_Gate_PKMN_trade_battle/Gate_PKMN_trade_battle_04.png"></td>
          <td width="320" height="288"> <img src="images/6_Gate_PKMN_trade_battle/Gate_PKMN_trade_battle_05.png"></td>
  </tr>
</table>


<div id="pokemart"></div>
<h2><a href="https://github.com/eisnerguy1/pokegold-spaceworld-restore/commit/669b3b7e513b87acf0533e94490d04edaa7e7dc6">Correct collision data for the PokéMart interior.</a></h2>
<table>
  <tr>
                <td width="512"> <img src="images/3_PokéMart/PKMNGS-SpaceWorld97-PokeMart-Correct.png"></td> 
      </tr>
</table>
