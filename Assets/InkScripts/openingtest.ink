=== start ===
VAR leftslot = "empty"
VAR rightslot = "empty"


-> scene

=== scene ===

= event1
~ leftslot = "Cheddar"
~ rightslot = "Rowland"

CHEDDAR: Hurry! For god's sake, paddle!
ROWLAND: I'm trying as fast as I can, please, stop criticising me...
*[ENCOURAGE] -> event2_encourage
*[SCARE] -> event2_scare


= event2_encourage
~ leftslot = "You"
~ rightslot = "Rowland"

YOU: You can do it, Rowland! Come on, chap!
ROWLAND: I can't, I -- 
~ rightslot = "empty"
<i>(Rowland falls beneath the waves)</i>
*End of Test

= event2_scare
~ leftslot = "You"
~ rightslot = "Rowland"

YOU: For god's sake man, swim or you'll kill us all!
ROWLAND: I -- I'm trying, oh God, I --
<i>(You just make it away from the tug of the sinking ship).</i>
*End of Test