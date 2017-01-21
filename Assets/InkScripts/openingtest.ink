=== start ===
VAR leftslot = "empty"
VAR rightslot = "empty"

VAR rowland = "alive"
VAR cheddar = "alive"



-> scene

=== scene ===

= event1
~ leftslot = "Cheddar"
~ rightslot = "Rowland"

CHEDDAR: Hurry! For god's sake, paddle!
ROWLAND: I'm trying as fast as I can, please, stop criticising me...
*[ENCOURAGE] -> event2_rowlanddead
*[SCARE] -> event2_rowlandalive


= event2_rowlanddead
~ leftslot = "You"
~ rightslot = "Rowland"
~ rowland = "dead"

YOU: You can do it, Rowland! Come on, chap!
ROWLAND: I can't, I -- 
~ rightslot = "empty"
<i>Rowland falls beneath the waves. Cheddar cries out, but says nothing. He's gone.</i>
~ leftslot = "You"
~ rightslot = "Cheddar"
*[COMFORT]
YOU: I'm sorry, there's nothing we could have done.
CHEDDAR: Let's just -- let's just swim. 
*[SAY NOTHING]
<i>There is silence for a moment, the sounds of screaming and the tug of waves all around you. The ship is almost beneath the surface of the water.</i>
-
*end of test

-

= event2_rowlandalive
~ leftslot = "You"
~ rightslot = "Rowland"
~ rowland = "alive"

YOU: For god's sake man, swim or you'll kill us all!
ROWLAND: I -- I'm trying, oh God, I --
<i>(You just make it away from the tug of the sinking ship).</i>
*End of Test


