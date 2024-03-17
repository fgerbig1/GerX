"GerX 4 für Inform 7 V10" by "Frank Gerbig" (in German)

Include German by Team GerX.
Include Locksmith by Emily Short.

Use skip libcheck.
Use compound heads.
Use capitalised Du.

The story headline is "Ein interaktives Beispiel".


A region is usually privately-named.
A thing is usually privately-named.


Table of Compound Heads (continued)
head	n
"streich"	0



A room has a figure name called room figure.

The image-setting rule is listed before the room description body text rule in the carry out looking rules. 

This is the image-setting rule:
	if in darkness:
		display figure of darkness;
	else:
		if the room figure of the location is not figure of cover:
			display the room figure of the location.


Figure of kitchen is the file "kitchen.png".
Figure of living room is the file "living room.png".
Figure of darkness is the file "darkness.png".


A carrot is a kind of thing. It is edible. The printed name is "Karotte[f]". The printed plural name is "Karotten".
Understand "Karotte" and "Moehre" as a carrot.
Understand "Karotten" and "Moehren" as the plural of a carrot.

An apple is a kind of thing. It is edible. The printed name is "grün[^] Apfel[-s][m]". The printed plural name is "grün[^] Äpfel".
Understand "gruen" and "Apfel" as an apple.
Understand "Aepfel" as the plural of an apple.


Instead of climbing a supporter (called the supporter):
	try entering the supporter instead.

Instead of going down when the actor is on a supporter (called the supporter):
	try getting off the supporter instead.

After going a direction (called way-pushed) with something (called the thing-pushed): 
    say "Du schiebst [den thing-pushed] nach [way-pushed] in [den location]."; 
    continue the action.



The kitchen is a room. The printed name of the kitchen is "klein[^] Küche[f]". "Eine kleine Küche mit gefliestem Boden. Im Norden schließt sich das Wohnzimmer an.".
Understand "Kueche" as the kitchen.
The room figure of kitchen is figure of kitchen.

The floor is scenery in the kitchen. The printed name is "rau[^] Kacheln[p]". "Der Küchenboden ist mit rauen Kacheln bedeckt. Sehr hygienisch."
Understand "rau" and "Boden[m]" and "Fliessen[p]" and "Kacheln[p]" as the floor.


Maria is a woman in the kitchen.
Understand "Maria" or "Frau" as Maria.

Before printing the name of Maria:
	if current case is:
		-- nominative case: say "[if capitalised Du option is active]D[else]d[end if]eine";
		-- genitive case: say "[if capitalised Du option is active]D[else]d[end if]einer";
		-- dative case: say "[if capitalised Du option is active]D[else]d[end if]einer";
		-- accusative case: say "[if capitalised Du option is active]D[else]d[end if]eine";
	say " Frau ".

Persuasion rule for asking people to try doing something: persuasion succeeds.

Some money is in the kitchen.
The special indefinite article of the money is no article.
The printed name of the money is "Geld[-es][n]". The description of the money is "Ungefähr zweihunderttausend Euro.".
Understand "Geld/Euros[p]" and "Euro[p]" as the money. 

In the kitchen is a closed openable enterable locked container called the fridge. The printed name of the fridge is "Kühlschrank[-s][m]".
The description of the fridge is "Ein weißer Kühlschrank mit Metallgriff[if fridge is lit], im Innern leuchtet ein schwaches Lämpchen[end if].".
The fridge is fixed in place. The fridge is unlit.
Understand "weiss" and "Kuehlschrank" as the fridge.

The handle is part of the fridge. The printed name of the handle is "Griff[-s][m]".
Understand "Griff" and "Metallgriff" as the handle.

After opening the fridge:
	now the fridge is lit;
	continue the action.

After closing the fridge:
	now the fridge is unlit;
	continue the action.


The key is an object held by the player. The key unlocks the fridge. The printed name of the key is "klein[^] Schlüssel[-s][m]".
Understand "klein" and "Schluessel" as the key.
The key unlocks the fridge. 

In the fridge are six carrots.


The box is a container in the kitchen. The printed name of the box is "Kiste[f]".
Understand "Kiste" as the box.

In the box are 23 carrots.


In the kitchen is an portable enterable supporter called the stool. The printed name of the stool is "Hocker[-s][m]".
Understand "Hocker" as the stool.


	
The living room is a room. The printed name of the living room is "Wohnzimmer[-s][n]". "Ein gemütlich eingerichtetes Wohnzimmer. Im Süden liegt die Küche.".
Understand "gemuetlich" and "Wohnzimmer" as the living room.
The room figure of living room is figure of living room.

The living room is north of the kitchen.


In the living room is a portable enterable supporter called the table. The printed name of the table is "Tisch[-s][m]".
Understand "Tisch" as the table.
The table is pushable between rooms.


The pack of matches is an closed openable container. The printed name is "Packung[f] Streichhölzer".
Understand "streich-" and "Packung" and "Hoelzer[p]" and "Holzpackung" as the pack.

The match is a kind of thing. The printed name is "Streichholz[-es][n]". The printed plural name is "Streichhölzer".
Understand "streich-" and "Holz" as the match.
Understand "streich-" and "Hoelzer[p]" as the plural of matches.

A pack of matches is on the table. In the pack of matches are ten matches.


The bowl is a container on the table. The printed name is "groß[^] Schüssel[f]".
Understand "gross", "Schuessel" and "Schale" as the bowl.

In the bowl are three apples.


The anorak is a wearable thing in the living room. The printed name is "Anorak[-s][m]".
The description is "Eine richtig dicke Winterjacke. Ein Erbstück."
Understand "anorak", "parka[m]", "jacke[f]", "winterjacke[f]" and "erbstueck[n]" as the anorak.
