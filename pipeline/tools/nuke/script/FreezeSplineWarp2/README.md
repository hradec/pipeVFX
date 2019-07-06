FreezeSplineWarp2 - Nuke Warper Trick Automation, aka "FreezeWarp"
===============


This Nuke script will freeze the shapes of a SplineWarp on a desired frame, by deleting keyframes or using an expression.   
[The video will explain how to use the technique](http://www.youtube.com/watch?v=rFP4jgfXpjM&feature=player_embedded)    
<a href="http://www.youtube.com/watch?feature=player_embedded&v=rFP4jgfXpjM" target="_blank"><img src="http://img.youtube.com/vi/rFP4jgfXpjM/mqdefault.jpg"
alt="Click to Watch the video" width="240" height="135" border="10" /></a>





If you like it, use it frequently, or want to support further development please consider a small donation to the author.   
<a href='http://www.pledgie.com/campaigns/21123'><img alt='Click here to lend your support to: VFX tools coding project and make a donation at www.pledgie.com !' src='http://www.pledgie.com/campaigns/21123.png?skin_name=chrome' border='0' /></a>

#### COMPATIBILITY ####

Nukev7 and up

#### KNOW LIMITATIONS ####

Multithreading can crash Nuke on some cases, disable it if you experience crashes

#### USAGE ####

Select a SplineWarp3 node and fill the freeze frame pop-up with the desired "Freezeframe"   
Limitations: if the animated shape is inside a transformed layer or matrix, you may need to bake the shape points positions with 
the http://github.com/magnoborgo/RotoPaintToSplineWarp2

#### Licensing ####

This script is made avalable under a BSD Style license that is included in the package.
