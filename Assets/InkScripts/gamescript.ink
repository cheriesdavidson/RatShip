VAR leftslot = "empty"
VAR rightslot = "empty"
VAR elias = 1
VAR textspeed = 1

VAR paddlingsection = false

VAR rowland = "alive"
VAR cheddar = "alive"
VAR arat = "alive"
VAR mordecai = "alive"

-> chapter1

=== chapter1 ===

= event1
~ elias = 1
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
Rowland lets go of the side of the boat, holding his paws to his face to stop the tears.
A great wave overtakes you all.
Roland falls beneath it, swept from the side of the boat.
Cheddar cries out, but says nothing. He's gone.
~ leftslot = "Emmental"
~ rightslot = "Cheddar"
EMMENTAL: Mum, we have to go back! Mum! Rowland, he's --
Cheddar is just quiet. 
-
~ leftslot = "You"
~ rightslot = "Cheddar"
*[COMFORT]
YOU: I'm sorry, there's nothing we could have done.
Cheddar pauses, closing her eyes briefly before opening them again, dulled with pain.
CHEDDAR: Let's just -- let's just paddle. 
*[SAY NOTHING]
There is silence for a moment, the sounds of screaming and the tug of waves all around you. 
The ship is almost beneath the surface of the water.
CHEDDAR: We...
Cheddar pauses, closing her eyes briefly before opening them again, dulled with pain.
CHEDDAR: We need to get out of here...
-
-> ending_swim



= event2_rowlandalive
~ leftslot = "You"
~ rightslot = "Rowland"
~ rowland = "alive"

YOU: For god's sake man, paddle or you'll kill us all!
ROWLAND: I -- I'm trying, oh God, I --
You just make it away from the tug of the sinking ship.
~ leftslot = "Cheddar"
~ rightslot = "Rowland"
ROWLAND: We -- we made it! I -- I -- 
CHEDDAR: No thanks to you, you cretin.
ROWLAND: Why do you always put me down? You're always --
~ leftslot = "Cheddar"
~ rightslot = "Emmental"
Emmental begins to cry, and Cheddar comforts her.
~ leftslot = "Cheddar"
~ rightslot = "Rowland"
CHEDDAR: Now's not the time, Rowly. We need to get clear of this wreck.
ROWLAND: But I'm -- I'm not sure I can paddle anymore, I --
Cheddar pauses, and after a moment smiles at Rowland softly.
CHEDDAR: It'll... it'll be OK. You'll do your best, like you always do. Now come on! Let's go.
-> ending_swim


= ending_swim

~ leftslot = "empty"
~ rightslot = "empty"
You need to get away from the wreckage. Press X repeatedly to build momentum, and release to ride the wave away. 
Failure can have unexpected consequences.
-> chapter2

=== chapter2 ===
= initialsetup
~ paddlingsection = true 
*[SUCCEED] ->success
*[FAIL] -> fail


= fail
The ship disappears beneath the surface of the waves with a great groan. 
You are almost caught in its wake. Almost. 
Those who are not so lucky are dragged beneath the dark seas.
{ rowland == "alive":
~ leftslot = "Cheddar"
~ rightslot = "Rowland"
ROWLAND: We -- we're alive!
CHEDDAR: We are.
Cheddar pauses.
CHEDDAR: Well done, mate. You tried.
As you celebrate, the sounds of screams emerge clearly against the growing peace. 
There are rats still in the water, in the darkness. 
~ leftslot = "empty"
~ rightslot = "empty"
- else:
~ leftslot = "Cheddar"
~ rightslot = "empty"
Cheddar is quiet, but for her laboured breathing. After a moment, she just says a single word, slowly and sadly.
CHEDDAR: Rowland...
The moment is broken by the sounds of screams emerging clearly against the growing peace. 
There are rats still in the water, in the darkness.
CHEDDAR: Rowland! 
But it's not. 
}
You see two figures struggling in the water. One of them, a gentleman, is struggling to stay afloat. He swims towards you
~ leftslot = "Mordecai"
MORDECAI: I say! Please, good fellow! Help me on to your craft!
~ leftslot = "Cheddar"
CHEDDAR: Give me your arm, I'll -- hghh - Christ, you're heavy...
MORDECAI: Oh, thank you, m'lady! I --
The shouts continue, however. In the distance, you see another figure splashing around.
It cries out with an unratly sound.
~ rightslot = "Arat"
ARAT: Meow! I can't swim, help me!!! Meow!! 
You can save the figure before they drown. Go!
-> chapter2_aratmordecai




= success
The ship disappears beneath the surface of the waves with a great groan. 
Those who did not move away quickly enough are caught in its wake and dragged beneath the waves.
{ rowland == "alive":
~ leftslot = "Cheddar"
~ rightslot = "Rowland"
ROWLAND: We made it!
CHEDDAR: We did.
Cheddar pauses.
CHEDDAR: Well done, mate.
As you celebrate, the sounds of screams emerge clearly against the growing peace. 
There are rats still in the water, in the darkness. 
~ leftslot = "Cheddar"
~ rightslot = "empty"
CHEDDAR: Over there!
- else:
~ leftslot = "Cheddar"
~ rightslot = "empty"
Cheddar is quiet, but for her laboured breathing. After a moment, she just says a single word, slowly and sadly.
CHEDDAR: Rowland...
The moment is broken by the sounds of screams emerging clearly against the growing peace. 
There are rats still in the water, in the darkness.
CHEDDAR: Rowland! 
But it's not. 
}

You look back to see two figures struggling in the water. One of them is a gentleman, struggling to stay afloat.
~ leftslot = "Mordecai"
MORDECAI: I say! Please, good fellow! Help me on to your craft!
You can also see a much larger, fatter figure splashing around.
It cries out with an unratly sound.
~ rightslot = "Arat"
ARAT: Meow! I can't swim, help me!!! Meow!! 
There is only time to save one of them before the other drowns. 
If you take too long, both will die. Choose.
*[SAVE MORDECAI]
~ leftslot = "Mordecai"
~ rightslot = "empty"
~ arat = "dead"
MORDECAI: Hurry, please! My shoes are being damaged, good sirs!
-> chapter2_mordecai
*[SAVE ARAT]
~ leftslot = "empty"
~ rightslot = "Arat"
~ mordecai = "dead"
MORDECAI: Meooow!!! Meoww!!!
-> chapter2_arat


= chapter2_mordecai
*currentend
-> END

= chapter2_arat
*currentend
-> END

= chapter2_aratmordecai
*currentend
-> END


