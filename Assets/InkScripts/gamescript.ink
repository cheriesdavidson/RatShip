VAR leftslot = "empty"
VAR rightslot = "empty"
VAR audiolevel = 0
VAR audiotheme = "dialogue"
VAR textspeed = 1

VAR paddlingsection = "false"
VAR rescuetarget = ""
VAR difficulty = 0
VAR distance = 0

VAR rowland = "alive"
VAR cheddar = "alive"
VAR arat = "alive"
VAR mordecai = "alive"

VAR rowland_onboat = "yes"
VAR cheddar_onboat = "yes"
VAR arat_onboat = "no"
VAR mordecai_onboat = "no"


VAR location = "wreck"

-> chapter1

=== chapter1 ===

TITLE: You were drowning, and they pulled you from beneath the surface. 
TITLE: Survive, at all costs.
-> event1

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
~ rowland_onboat = "no"
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
You need to get away from the wreckage. 
When the prompt shows, press any key repeatedly to paddle.
Failure to reach the end can have unexpected consequences.
-> chapter2

=== chapter2 ===
= initialsetup
~ difficulty = 0.4
~ distance = 0.4
~ paddlingsection = "true"
*[SUCCEED] ->success
*[FAIL] -> fail


= fail
~ paddlingsection = "false"
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
~ leftslot = "empty"
~ rightslot = "empty"
You see two figures struggling in the water. One of them, a gentleman, is struggling to stay afloat. He swims towards you
~ leftslot = "Mordecai"
MORDECAI: I say! Please, good fellow! Help me on to your craft!
~ rightslot = "Cheddar"
CHEDDAR: Give me your arm, I'll -- hghh - Christ, you're heavy...
~ mordecai_onboat = "yes"
MORDECAI: Oh, thank you, m'lady! I --
The shouts continue, however. In the distance, you see another figure splashing around.
It cries out with an unratly sound.
~ leftslot = "Arat"
ARAT: Meow! I can't swim, help me!!! Meow!! 
You can save the figure before they drown. Go!
~ difficulty = 0.6
~ distance = 0
~ rescuetarget = "arat"
~ paddlingsection = "true"
*[SUCCEED] -> chapter3.aratmordecai_success
*[FAIL] -> chapter3.aratmordecai_fail

= success
~ paddlingsection = "false"
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
~ difficulty = 0.6
~ distance = 0
~ rescuetarget = "mordecai"
~ paddlingsection = "true"
**[SUCCEED] -> chapter3.mordecai_success
**[FAIL] -> chapter3.mordecai_fail

*[SAVE ARAT]
~ leftslot = "empty"
~ rightslot = "Arat"
~ mordecai = "dead"
ARAT: Meooow!!! Meoww!!!
~ difficulty = 0.6
~ distance = 0
~ rescuetarget = "arat"
~ paddlingsection = "true" 
-
**[SUCCEED] -> chapter3.arat_success
**[FAIL] -> chapter3.arat_fail


=== chapter3 ===

= mordecai_success
~ paddlingsection = "false"
You reach Mordecai in good time, and he swims towards your boat.

~ leftslot = "Mordecai"
MORDECAI: I say! Please, good fellow! Help me on to your craft!
~ rightslot = "Cheddar"
CHEDDAR: Give me your arm, I'll -- hghh - Christ, you're heavy...
~ mordecai_onboat = "yes"
MORDECAI: Oh, thank you, m'lady! I --
The shouts continue, however. In the distance, you see the other figure cry out.
~ leftslot = "Arat"
~ rightslot = "empty"
ARAT: Meoww!!! Help me!
They fall beneath the waves. They are gone.
-> postrescue



= mordecai_fail
~ paddlingsection = "false"
You just reach Mordecai in time, managing to grab him before he falls beneath the waves. 

~ leftslot = "Mordecai"
MORDECAI: I say! You took your sweet time!
~ rightslot = "Cheddar"
CHEDDAR: Give me your arm you ungrateful twit, I'll -- hghh - Christ, you're heavy...
~ mordecai_onboat = "yes"
MORDECAI: I could say the same about you, but I am a gentleman!
The shouts continue, however. In the distance, you see the other figure cry out.
~ leftslot = "Arat"
~ rightslot = "empty"
ARAT: Meoww!!! Help me!
They fall beneath the waves. They are gone.
-> postrescue


= arat_success
~ paddlingsection = "false"
You reach Arat in good time, and they swim happily towards your boat.
~ leftslot = "Arat"
ARAT: Meow!!! Pick me up! Stroke me!
~ rightslot = "Cheddar"
CHEDDAR: Give me your arm! Oww, you're -- I need help!
~ leftslot = "You"
CHEDDAR: Three, two, one, pull!!!
You help Cheddar pull the "rat" onto to the raft. 
~ rightslot = "Arat"
~ arat_onboat = "yes"
ARAT: Meowwww.
The stranger starts to rub their cheeks over all of you, purring.
The shouts continue, however. In the distance, you see the other figure cry out.
~ leftslot = "Mordecai"
~ rightslot = "empty"
MORDECAI: I -- I -- oh, oh dash it all!
He falls beneath the waves. He is gone.
-> postrescue

= arat_fail
~ paddlingsection = "false"
You just reach Arat in time, managing to grab them before they fall beneath the waves. 
~ leftslot = "Arat"
ARAT: Meow!!! MEOWW!!!!!
~ rightslot = "Cheddar"
CHEDDAR: Give me your arm! Oww, you're -- I need help!
~ leftslot = "You"
CHEDDAR: Three, two, one, pull!!!
You help Cheddar pull the "rat" onto to the raft. 
~ rightslot = "Arat"
~ arat_onboat = "yes"
ARAT: Meowwww.
The stranger starts to rub their cheeks over all of you, purring.
The shouts continue, however. In the distance, you see the other figure cry out.
~ leftslot = "Mordecai"
~ rightslot = "empty"
MORDECAI: I -- I -- oh, oh dash it all!
He falls beneath the waves. He is gone.
-> postrescue

= aratmordecai_success
~ paddlingsection = "false"
You reach Arat in good time, and they swim happily towards your boat.
~ leftslot = "Arat"
ARAT: Meow!!! Pick me up! Stroke me!
~ rightslot = "Cheddar"
CHEDDAR: Give me your arm! Oww, you're -- I need help!
~ leftslot = "Mordecai"
MORDECAI: Don't look at me! I'm not touching them, look how dirty they are!
CHEDDAR: Lovely. How about you? You going to help me?
~ leftslot = "You"
CHEDDAR: Three, two, one, pull!!!
You help Cheddar pull the "rat" onto to the raft. 
~ leftslot = "empty"
~ rightslot = "Arat"
~ arat_onboat = "yes"
ARAT: Meowwww.
The stranger starts to rub their cheeks over all of you, purring.
Mordecai winces and moves back from the stranger.
~ leftslot = "Mordecai"
MORDECAI: Get away from me, you filthy rat!
ARAT: Yes. I am Arat.
-> postrescue

= aratmordecai_fail
~ paddlingsection = "false"
You just reach Arat in time, managing to grab them before they fall beneath the waves. 
~ leftslot = "Arat"
ARAT: Meow!!! MEOWW!!!!!
~ rightslot = "Cheddar"
CHEDDAR: Give me your arm! Oww, you're -- I need help!
~ leftslot = "Mordecai"
MORDECAI: Don't look at me! I'm not touching them, look how dirty they are!
CHEDDAR: Lovely. How about you? You going to help me?
~ leftslot = "You"
CHEDDAR: Three, two, one, pull!!!
You help Cheddar pull the "rat" onto to the raft. 
~ arat_onboat = "yes"
~ leftslot = "empty"
~ rightslot = "Arat"
ARAT: Meowwww.
The stranger starts to rub their cheeks over all of you, purring.
Mordecai winces and moves back from the stranger.
~ leftslot = "Mordecai"
MORDECAI: Get away from me, you filthy rat!
ARAT: Yes. I am Arat.
-> postrescue


= postrescue
~ leftslot = "empty"
~ rightslot = "empty"
At least some people made it. You didn't think you would. 
You're not sure if you deserved to.
Cheddar takes control. She could be a problem. 
~ leftslot = "Cheddar"
~ rightslot = "empty"
CHEDDAR: Is everyone OK? Is anyone injured?
~ rightslot = "Emmental" 
EMMENTAL: I'm OK, mumma!

{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: I - I suppose so! But my arms are pretty darn tired!
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: My suit! I'm absolutely soaked!
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
ARAT: Please give me treat. I am scared and lost. 
}

~ leftslot = "You"
~ rightslot = "empty"
YOU: Who are all of you, anyway?



{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: My name is Rowly. Pleased to meet you! 
ROWLAND: Despite the, er, circumstances...
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: Mordecai Johnson, at your service. 
MORDECAI: I do business all over the world.
MORDECAI: I'm a big deal, you know.
MORDECAI: Perhaps you've heard of me?
*[IMPRESSIVE]
YOU: Um, impressive...
MORDECAI: I sell the best in anti-cat detectors, my good chap!
{ arat_onboat == "yes":
~ leftslot = "Arat"
ARAT: I think rats are best friends.
MORDECAI: I like your optimistic attitude, sir!
~ leftslot = "You"
}
*[STOP BOASTING]
YOU: Stop boasting. Rats have just died.
MORDECAI: Why I -- I never! This is really the height of -- of --
MORDECAI: Dash it all!
}
-
{ arat_onboat == "yes":
~ rightslot = "Arat"
ARAT: I am Arat.
*[GOOD TO MEET YOU]
YOU: It's nice to meet you, Arat.
ARAT: Yes. Hello. I like, I like cheese and rat things.
*[WHAT DO YOU DO?]
ARAT: I do rat things. I eat cheese and run in mazes. Hello.
}
-
~ rightslot = "Cheddar"
CHEDDAR: And I'm Cheddar. This is my pup Emmental.
~ rightslot = "Emmental"
EMMENTAL: Hi!
~ rightslot = "Cheddar"
CHEDDAR: Who are -you-, anyway? You haven't said.
-
*[TRUTH]
YOU: I don't have a name.

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: That's, well gosh, why don't you have one, old fellow?
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
ARAT: I have name. I am Arat. I like to hide in boxes.
}

*[LIE]
YOU: I'm Nibbles.


{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: Pleased to make your acquaintance, Nibbles!
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
ARAT: I do not nibbles rats. Rats are not food. 
}
-
~ leftslot = "empty"
~ rightslot = "empty"
Cheddar is about to say something when another noise bursts from the wreckage.
Something on board just exploded.
~ leftslot = "You"
~ rightslot = "empty"
YOU: We need to go. 
~ rightslot = "Cheddar"
CHEDDAR: Shouldn't we stay and wait for help?
*[TRUTH]
YOU: Help won't come.
*[LIE]
YOU: It feels dangerous here. We should get clear of the wreck.
-
Succeed at the next section to leave the wreck.
Fail the next section to stay here.

-> chapter4

=== chapter4 ===
= initialsetup
~ difficulty = 0.2
~ distance = 1
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED] -> left
*[FAIL] -> remained


= left
~ leftslot = "empty"
~ rightslot = "empty"
TITLE: TWO DAYS LATER...
TITLE: It has been two days since you left the wreck.
TITLE: You have no food or water left. 
TITLE: There is no land in sight. 
TITLE: You will all die soon without sustenance. 
~ location = "left"
-> 2dayslater

= remained
~ leftslot = "empty"
~ rightslot = "empty"
TITLE: TWO DAYS LATER...
TITLE: It has been two days since the sinking.
TITLE: You have no food or water left. 
TITLE: Help has not come.
TITLE: You will all die soon without sustenance.
~ location = "wreck"
-> 2dayslater

= 2dayslater

{ arat_onboat == "yes":
-> 2dayslater_arat

- else:
-> 2dayslater_mordecai
}
 
= 2dayslater_arat
In the night, you stay awake to keep watch.
Things were not supposed to happen like this.
Arat wakes up, stretching and arching their back.
~ leftslot = "You"
~ rightslot = "Arat"
ARAT: Hello.
*[HELLO]
*[GO BACK TO SLEEP]
-> END









= 2dayslater_mordecai

-> END
