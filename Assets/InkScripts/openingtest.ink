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
<i>Cheddar pauses, closing her eyes briefly before opening them again, dulled with pain.</i>
CHEDDAR: Let's just -- let's just swim. 
*[SAY NOTHING]
<i>There is silence for a moment, the sounds of screaming and the tug of waves all around you. The ship is almost beneath the surface of the water.</i>
CHEDDAR: We...
<i>Cheddar pauses, closing her eyes briefly before opening them again, dulled with pain.</i>
CHEDDAR: We need to get out of here...
-
-> ending_swim



= event2_rowlandalive
~ leftslot = "You"
~ rightslot = "Rowland"
~ rowland = "alive"

YOU: For god's sake man, swim or you'll kill us all!
ROWLAND: I -- I'm trying, oh God, I --
<i>You just make it away from the tug of the sinking ship.</i>
~ leftslot = "Cheddar"
~ rightslot = "Rowland"
ROWLAND: We -- we made it! I -- I -- 
CHEDDAR: No thanks to you, you cretin.
ROWLAND: Why do you always put me down? You're always --
CHEDDAR: Now's not the time. We need to get clear of this wreck.
ROWLAND: But I'm -- I'm not sure I can swim anymore, I --
<i>Cheddar pauses, and after a moment smiles at Rowland softly.</i>
CHEDDAR: It'll... it'll be OK. You'll do your best, like you always do. Now come on! Let's go.
-> ending_swim


= ending_swim

~ leftslot = "empty"
~ rightslot = "empty"
<i>You need to get away from the wreckage. Press X repeatedly to build momentum, and release to ride the wave away. Failure can have unexpected consequences.</i>
-> END