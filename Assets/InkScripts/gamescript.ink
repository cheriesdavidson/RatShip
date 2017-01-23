VAR leftslot = "empty"
VAR rightslot = "empty"
VAR audiolevel = 0
VAR audiotheme = "dialogue"
VAR textspeed = 1
VAR blank = "blank"

VAR paddlingsection = "false"
VAR rescuetarget = ""
VAR difficulty = 0
VAR distance = 0

VAR rowland = "alive"
VAR cheddar = "alive"
VAR arat = "alive"
VAR mordecai = "alive"

VAR you_onboat = "yes"
VAR rowland_onboat = "yes"
VAR cheddar_onboat = "yes"
VAR emmental_onboat = "yes"
VAR arat_onboat = "no"
VAR mordecai_onboat = "no"


VAR location = "wreck"


VAR rescuecounter = 0

-> chapter1

=== chapter1 ===

TITLE: You were drowning, and they pulled you from beneath the surface. 
TITLE: Survive, at all costs.
~ audiolevel = 2

-> event1

= event1
~ leftslot = "Cheddar"
~ rightslot = "Rowland"

CHEDDAR: Hurry! For god's sake, paddle!
ROWLAND: I'm trying as fast as I can, please, stop criticising me...
*[ENCOURAGE] -> event2_rowlanddead
*[SCARE] -> event2_rowlandalive


= event2_rowlanddead
~ audiolevel = 7
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
~ audiolevel = 7
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
~ audiolevel = 5
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
~ audiolevel = 3
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
~ audiolevel = 3
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
~ audiolevel = 5
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
~ audiolevel = 3
~ leftslot = "Cheddar"
~ rightslot = "empty"
CHEDDAR: Over there!
- else:
~ leftslot = "Cheddar"
~ rightslot = "empty"
~ audiolevel = 3
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
~ mordecai_onboat = "yes"
~ audiolevel = 9
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
~ audiolevel = 9
~ mordecai_onboat = "yes"
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
~ audiolevel = 9
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
~ audiolevel = 9
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
~ mordecai_onboat = "yes"
~ arat_onboat = "yes"
~ audiolevel = 9
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
~ mordecai_onboat = "yes"
~ arat_onboat = "yes"
~ audiolevel = 9
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
~ audiolevel = 5
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
~ audiolevel = 9


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
~ audiolevel = 5
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
~ audiolevel = 3
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
~ audiolevel = 5
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
TITLE: You remained with the wreck.
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

= 2dayslater_mordecai
In the night, you stay awake to keep watch.
Things were not supposed to happen like this.
Mordecai wakes up, yawning, and sees you.
~ leftslot = "You"
~ rightslot = "Mordecai"
MORDECAI: Quiet out here, isn't it.
*[YES]
YOU: I suppose so, yes.
*[SAY NOTHING]
You say nothing.
-
MORDECAI: I'm sorry if I've come across badly so far.
MORDECAI: I'm just -- it's just been a stressful time.
MORDECAI: You can understand that, can't you?
*[IT'S OK]
YOU: I understand. It's fine. Everything will be fine.
*[SAY NOTHING]
You say nothing.
MORDECAI: I suppose you don't. You're a mean old rat, you know.
-
Mordecai feels inside his pockets and after a little while finds something.
He pulls out a wallet.
He opens it to show you a photo of a tall rat, and a small mouse.
MORDECAI: We adopted her when she was just a pup. 
MORDECAI: We couldn't have one of our own.
MORDECAI: I hope... I hope I get out of this.
MORDECAI: I hope I get to see them again.
*[YOU WILL]
*[SAY NOTHING]
-
You talk for a while longer, but Mordecai soon wants to go back to sleep.
As you sit up, you think about life.
You think about what you did to these people.
You wonder if they'd ever forgive you, if they knew.
It was you who destroyed the ship.
-> chapter5


 
= 2dayslater_arat
In the night, you stay awake to keep watch.
Things were not supposed to happen like this.
Arat wakes up, stretching and arching their back.
~ leftslot = "You"
~ rightslot = "Arat"
ARAT: Hello.
*[HELLO]
YOU: Erm, hi?
*[SAY NOTHING]
You are silent.
-
ARAT: I am hungry please can I have a treat I am scared also.
*[WE ALL ARE]
ARAT: Am I a good rat?
**[YES]
-> arat_happy
**[NO]
-> arat_unhappy
*["A TREAT"?]
ARAT: Yes my human gave me them but they went. 
ARAT: I do not know when they are back. I am sad.
**[SYMPATHY]
YOU: I'm sorry. You must miss them.
ARAT: Yes.
YOU: It's -- it's OK. It'll be OK.
-> arat_happy
**[SUSPICION]
YOU: You don't sound very much like a rat.
-> arat_unhappy

= arat_happy
Arat begins to purr for a little while, beginning to move their cheeks forward to rub you.
Arat stops suddenly, looking sad. 
-> arat_revelation

= arat_unhappy
Arat looks upset, shaking their head and looking down at the floor of the boat. 
-> arat_revelation

= arat_revelation
ARAT: Can I tell you a secret?
ARAT: Please don't tell anyone or make fun of me.
ARAT: I'm... I'm... -meow-
ARAT: I'm not actually a rat.
ARAT: I'm sorry for lying.
ARAT: My mum told me not to. Said I was just a kitten.
ARAT: I just wanted to be friends.
ARAT: Rats always look like they're having fun.
ARAT: Now I'm all on my own, now.
Arat begins to cry a little, wiping tears from their whiskers.
ARAT: I'm.. -meow- ... I'm so hungry.

{ mordecai_onboat == "yes":
-> arat_revelation_mordecai
- else:
-> arat_revelation_alone
}

= arat_revelation_alone
*[IT'LL BE OK]
YOU: It'll be OK, Arat, it'll all be fine...
ARAT: Do you promise?
**[YES]
YOU: Yes, of course...
**[NO]
YOU: I can't. But I'll do my best to make it OK.
*[ARE YOU DANGEROUS?]
ARAT: Meow!! I'd never hurt a friend!
-
Arat rubs their cheeks on you to demonstrate their affection.
Arat falls asleep near you, purring throughout the night.
As you sit up, you think about life.
You think about what you did to these people.
You wonder if they'd ever forgive you, if they knew.
It was you who destroyed the ship.
-> chapter5



= arat_revelation_mordecai
~ audiolevel = 3
There is a sudden cry from elsewhere on the boat.
~ leftslot = "Mordecai"
MORDECAI: Ah hah! You thought you'd eat us in our sleeps, did you?
ARAT: What? No! Rats are friends!
MORDECAI: Everyone, wake up! This beast is a good for nothing cat!
~ leftslot = "Emmental"
EMMENTAL: Mum, I'm scared, I --
~ leftslot = "Mordecai"
MORDECAI: It can't stay on this boat. It needs to go.
~ leftslot = "Cheddar"
CHEDDAR: Now just calm down for a second...
~ leftslot = "Mordecai"
MORDECAI: Calm? You want me to be calm? I'll do it myself.
Mordecai moves towards Arat, who backs away, meowing in fear.
Mordecai pulls out a knife from his pocket. 
*[SAVE ARAT]
You try grabbing the knife from Mordecai, but as he tries slashing around him...
Mordecai loses his footing.
~ mordecai_onboat = "no"
~ leftslot = "empty"
~ rightslot = "empty"
He falls from the boat, down into the waves. 
*[DO NOTHING]
You do nothing, and as Mordecai approaches Arat, the kitten stumbles back in fear.
Arat loses their footing.
~ arat_onboat = "no"
~ leftslot = "empty"
~ rightslot = "empty"
They fall from the boat, down into the waves.
-
~ leftslot = "Emmental"
EMMENTAL: We have to rescue them! Mum, we --
~ rightslot = "Cheddar"
CHEDDAR: No. We need to paddle away.
Cheddar would never forget how her daughter looked at her in that moment.
That mixture of surprise and shame.
EMMENTAL: Mum, we --
CHEDDAR: I said we need to paddle! They're dangerous!
~ leftslot = "empty"
~ rightslot = "empty"
-
~ difficulty = 0.3
~ distance = 0.7
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED] -> leftdrowner
*[FAIL] -> remaineddrowner

= leftdrowner
~ paddlingsection = "false"
~ location = "left"
~ audiolevel = 9
{ mordecai_onboat == "yes":
~ leftslot = "Cheddar"
CHEDDAR: I think -- hphh -- I think we can stop now.
~ rightslot = "Mordecai"
MORDECAI: Anywhere to get away from a blasted cat.
~ leftslot = "Emmental"
EMMENTAL: But Arat didn't hurt us at all! Arat was scared!
MORDECAI: Hmph. Maybe you should've jumped in the water with it.
~ leftslot = "Cheddar"
CHEDDAR: What did you just say to my daughter?
Cheddar looms over Mordecai. Mordecai gulps.
MORDECAI: Erm -- erm nothing, my lady. 
CHEDDAR: That's right. Don't talk to her again.
~ leftslot = "empty"
~ rightslot = "empty"
They argue back and forth throughout the night.
Eventually, sleep takes them all, the boat a little quieter.
Less warm for Arat's absence. 
- else:
~ leftslot = "Cheddar"
CHEDDAR: I think -- hphh -- I think we can stop now.
~ rightslot = "Arat"
ARAT: He -- is the bad rat gone? He was going to --
~ leftslot = "Emmental"
EMMENTAL: But he'll die if we leave him!
ARAT: I don't -- meow -- I didn't want any of this to...
Arat begins to cry again.
~ leftslot = "Cheddar"
CHEDDAR: It's OK, Arat. It's OK.
Arat shifts towards Cheddar, who begins to stroke Arat's fur.
CHEDDAR: You're a good kitten. 
Arat purrs.
~ leftslot = "empty"
~ rightslot = "empty"
They go like this throughout the night, until Araft falls asleep.
Eventually, sleep takes them all, the boat a little quieter.
}
As you sit up, you think about life.
You think about what you did to these people.
You wonder if they'd ever forgive you, if they knew.
It was you who destroyed the ship.
-> chapter5

= remaineddrowner
~ paddlingsection = "false"
~ audiolevel = 3
{ mordecai_onboat == "yes":
You do not go that far.
After a while, you hear splashing.
Arat pokes their head over the surface, crying out.
~ leftslot = "Arat"
ARAT: Help me! Meow!! I won't hurt anyone!
~ rightslot = "Cheddar"
CHEDDAR: Take my arm, Arat! Help me, all of you!
~ leftslot = "Mordecai"
MORDECAI: Are you mad? That thing will eat us!
CHEDDAR: The only dangerous one here is you. 
CHEDDAR: You should be ashamed of yourself!
CHEDDAR: Arat's just a child! Have you no child of your own?
MORDECAI: I -- I didn't do anything, I was just warning it...
CHEDDAR: Shut up and help me pull!
After a moment's hesitation, Mordecai throws his knife away.
Mordecai moves forward and helps lift Arat from the water. 
~ arat_onboat = "yes"
~ rightslot = "Arat"
~ audiolevel = 9
ARAT: Meoww!!! Thank you!
Arat starts to rub their cheeks over Mordecai, who tries to get away.
Eventually, Mordecai gives up, the faintest hint of tears in his eyes.
MORDECAI: I didn't -- I -- Please forgive me, won't you?
ARAT: Meooowwwww
~ leftslot = "empty"
~ rightslot = "empty"
For many hours, Mordecai talks to Arat, telling them about his daughter.
He says his daughter is a mouse. He adopted her after his mother was killed.
Arat is already asleep when Mordecai says this.
Eventually, sleep takes them all, the boat a little calmer.
- else:
You do not go that far.
After a while, you hear splashing.
Mordecai pokes his head over the surface, crying out.
~ leftslot = "Mordecai"
ARAT: Help me! Please, I can't -- I can't swim very well!
~ rightslot = "Cheddar"
CHEDDAR: Take my arm, Mordecai! Help me, all of you!
~ leftslot = "Arat"
ARAT: But he -- the bad rat wants to kill me!
CHEDDAR: He won't! I won't let him, OK?
ARAT: I'm scared, meow!!
CHEDDAR: So was he! If everyone stops being scared, we might get out of this!
CHEDDAR: So come on and help me pull!
After a moment's hesitation, Arat bumbles forward.
Arat helps lift Mordecai from the water.
~ audiolevel = 9
~ mordecai_onboat = "yes"
~ rightslot = "Mordecai"
MORDECAI: I -- I thank you, cat. You saved me.
Arat starts to lick the water from Mordecai, who flinches away.
Eventually, Mordecai gives up, the faintest hint of tears in his eyes.
MORDECAI: I didn't -- I -- Please forgive me, won't you?
ARAT: Meooowwwww
~ leftslot = "empty"
~ rightslot = "empty"
For many hours, Mordecai talks to Arat, telling them about his daughter.
He says his daughter is a mouse. He adopted her after his mother was killed.
Arat is already asleep when Mordecai says this.
Eventually, sleep takes them all, the boat a little calmer.
}
As you sit up, you think about life.
You think about what you did to these people.
You wonder if they'd ever forgive you, if they knew.
It was you who destroyed the ship.
-> chapter5




=== chapter5 ===
~ leftslot = "empty"
~ rightslot = "empty"
{ location == "wreck":
-> wreck
- else:
-> left
}



= left
~ audiolevel = 7
TITLE: The next morning.
TITLE: You have left the wreck.
TITLE: You have not found land yet.
~ leftslot = "Cheddar"
CHEDDAR: Come on! We need to keep going!
~ rightslot = "Emmental"
EMMENTAL: But I'm tired, I can't --
CHEDDAR: We have to, sweetie. We'll -- we have to.
~ leftslot = "empty"
~ rightslot = "empty"
-
~ difficulty = 0.3
~ distance = 1
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED]
~ rescuecounter = rescuecounter + 1
*[FAIL]
-
~ paddlingsection = "false"
~ audiolevel = 7
{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: I -- I'm not sure we're going to make it...
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: We shouldn't have left...
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
Arat says nothing, panting quietly in pain.
}
~ leftslot = "Cheddar"
~ rightslot = "empty"
CHEDDAR: Again! We have to keep trying!
~ leftslot = "empty"
~ rightslot = "empty"
-
~ difficulty = 0.5
~ distance = 0.5
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED]
~ rescuecounter = rescuecounter + 1
*[FAIL]
-
~ paddlingsection = "false"
~ audiolevel = 7
~ leftslot = "Cheddar"
CHEDDAR: Emmental, it's OK! We're going to make it! 
Emmental says nothing. Her eyes are shut. 
-
~ leftslot = "empty"
~ rightslot = "empty"
-
~ difficulty = 0.7
~ distance = 0.2
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED]
~ rescuecounter = rescuecounter + 1
*[FAIL]
-
~ paddlingsection = "false"
~ audiolevel = 7
~ leftslot = "Cheddar"
CHEDDAR: Emmental?
Her daughter is not moving.
~ leftslot = "empty"
~ rightslot = "empty"
-> left_ending




= wreck
~ audiolevel = 7
TITLE: The next morning.
TITLE: You have remained with the wreck.
TITLE: No help has come.
TITLE: Not until you see it, a shape, waving in the distance.
~ leftslot = "Cheddar"
CHEDDAR: Come on! We need to get to them!
~ rightslot = "Emmental"
EMMENTAL: But I'm tired, I can't --
CHEDDAR: We have to, sweetie. We'll -- it's rescue! 
~ leftslot = "empty"
~ rightslot = "empty"
-
~ difficulty = 0.3
~ distance = 1
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED]
~ rescuecounter = rescuecounter + 1
*[FAIL]
-
~ paddlingsection = "false"
~ audiolevel = 7
{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: I -- I'm not sure we're going to make it...
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: We should have left days ago...
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
Arat says nothing, panting quietly in pain.
}
~ leftslot = "Cheddar"
~ rightslot = "empty"
CHEDDAR: Again! We have to keep trying!
~ leftslot = "empty"
~ rightslot = "empty"
-
~ difficulty = 0.5
~ distance = 0.5
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED]
~ rescuecounter = rescuecounter + 1
*[FAIL]
-
~ paddlingsection = "false"
~ audiolevel = 7
~ leftslot = "Cheddar"
CHEDDAR: Emmental, it's OK! We're going to make it! 
Emmental says nothing. Her eyes are shut. 
-
~ leftslot = "empty"
~ rightslot = "empty"
-
~ difficulty = 0.7
~ distance = 0.2
~ rescuetarget = ""
~ paddlingsection = "true"
*[SUCCEED]
~ rescuecounter = rescuecounter + 1
*[FAIL]
-
~ audiolevel = 7
~ paddlingsection = "false"
~ leftslot = "Cheddar"
CHEDDAR: Emmental?
Her daughter is not moving.
~ leftslot = "empty"
~ rightslot = "empty"
-> wreck_ending









= left_ending
{ rescuecounter > 1:
    -> left_rescued
- else:
    -> left_notrescued
}


= wreck_ending
{ rescuecounter > 1:
    -> wreck_rescued
- else:
    -> wreck_notrescued
}



= left_rescued
~ audiolevel = 20
As Cheddar cries, trying to shake her daughter, you see it.
You see the side of the great ocean.
The waves lap against the edge of the wall, beyond which you can see nothing.
~ leftslot = "Cheddar"
CHEDDAR: Emmental, please...
~ leftslot = "empty"

{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: What -- what is that?
- else:
~ blank = "blank"
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: I think -- I think I'm seeing things, I -- 
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
ARAT: Meow.
}
~ leftslot = "empty"
~ rightslot = "empty"
A great voice speaks from the heavens. It is the voice of God.
Its cruel joke is unknown to the rats.
The kitten recognises just a little of it.
And so do you.
It says that the experiment was a complete success.
It says there were only minimal fatalities.
One of them is annoyed that Chester got in with the rats again.
And as great hands reach down to pluck you all from the boat...
Cheddar clings on to her daughter.
But they take her away.
Only you are left in the tank.
Only you are left, to take the next rats to meet their maker.
Only you are left, with the lapping of the waves.
TITLE: The End
-> credits


= wreck_rescued
~ audiolevel = 20
As Cheddar cries, trying to shake her daughter, you reach it.
It's not a rat.
It's a great circle, floating in the water. Glinting with steel.
~ leftslot = "Cheddar"
CHEDDAR: Emmental, please...
~ leftslot = "empty"

{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: What -- what is that?
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: I think -- I think I'm seeing things, I -- 
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
ARAT: Meow.
}

~ leftslot = "empty"
~ rightslot = "empty"
A great voice speaks from the heavens. It is the voice of God.
It swears, saying it's dropped its damned watch.
Its cruel joke is unknown to the rats.
The kitten recognises just a little of it.
And so do you.
It says that the experiment was a partial success.
The rats exhibited minimal wishes to escape.
It says there were only minimal fatalities.
One of them is annoyed that Chester got in with the rats again.
And as great hands reach down to pluck you all from the boat...
Cheddar clings on to her daughter.
But they take her away.
Only you are left in the tank.
Only you are left, to take the next rats to meet their maker.
Only you are left, with the lapping of the waves.
TITLE: The End
-> credits




= left_notrescued
~ audiolevel = 20
As Cheddar cries, trying to shake her daughter, nothing happens.
You have failed to find land.
You have failed to please your employers.
And for that, you don't know what will happen...
~ leftslot = "Cheddar"
CHEDDAR: Emmental, please...
~ leftslot = "empty"

{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: Cheddar, I...
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: Allow me to help! I know a lot of medicinal techniques!
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
Arat only cries.
}
~ leftslot = "empty"
~ rightslot = "empty"

You drift in the oceans, and one by one you all go to sleep, unable to do anything else. 
You hope that God will forgive you.
You hope that they will save you, as they always do.
As your eyes shut, you see their great hands descend from the sky. 
You hear their language.
The kitten recognises just a little of it.
And so do you.
It says that the experiment was a failure
It says most of them are dead.
One of them is annoyed that Chester got in with the rats again.
And as great hands reach down to pluck you all from the boat...
Cheddar clings on to her daughter, on to life.
But they take her away.
Only you are left in the tank, wondering if they will save you.
Only you are left, to take the next rats to meet their maker.
Only you are left, with the lapping of the waves.
TITLE: The End
-> credits


= wreck_notrescued
~ audiolevel = 20
As Cheddar cries, trying to shake her daughter, nothing happens.
You have failed to leave at all.
You have failed to please your employers.
And for that, you don't know what will happen...
~ leftslot = "Cheddar"
CHEDDAR: Emmental, please...
~ leftslot = "empty"

{ rowland_onboat == "yes":
~ rightslot = "Rowland"
ROWLAND: Cheddar, I...
}

{ mordecai_onboat == "yes":
~ rightslot = "Mordecai"
MORDECAI: Allow me to help! I know a lot of medicinal techniques!
}

{ arat_onboat == "yes":
~ rightslot = "Arat"
Arat only cries.
}
~ leftslot = "empty"
~ rightslot = "empty"

You drift in the oceans, and one by one you all go to sleep, unable to do anything else. 
You hope that God will forgive you.
You hope that they will save you, as they always do.
As your eyes shut, you see their great hands descend from the sky. 
You hear their language.
The kitten recognises just a little of it.
And so do you.
It says that the experiment was a total failure.
It says most of them are dead.
One of them is annoyed that Chester got in with the rats again.
And as great hands reach down to pluck you all from the boat...
Cheddar clings on to her daughter, on to life.
But they take her away.
Only you are left in the tank, wondering if they will save you.
Only you are left, to take the next rats to meet their maker.
Only you are left, with the lapping of the waves.
TITLE: The End
-> credits


= credits
TITLE: Written by Greg Buchanan
TITLE: Programming by Amy Phillips & Cherie Davidson
TITLE: Art by Aiden Kohler
TITLE: Music by Holley Gray
TITLE: Made at Guildford GGJ17
TITLE: Thanks for playing!
-> END