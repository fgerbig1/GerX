Version 4/230629 of German by Team GerX begins here.

"German Language: An extension to make German the language of play.
Adapted to I7 release 10.1.2 by Frank Gerbig.
Based on GerX release 3/161221 by Banbury, Christian Blümke, and Michael Baltes.
Based on deform release 6/11 by Martin Oehm."

Include (-
Constant GerXVersion = "4";
Constant GerXRelease = "230629";

Array HLAuxBuffer1 buffer 128;
Array HLAuxBuffer2 buffer  24;

-).

[ Die deutschen Originalkommentare von Martin Oehm wurden übernommen.
  *** Die Kommentare von Christian Blümke beginnen mit drei Sternchen.
  +++ Die Kommentare von Frank Gerbig beginnen mit drei Pluszeichen. ]

Part - I7 additions and replacements

Section - Memory settings

[Im aktuellen I6-Compiler wird der Standardwert von MAX_LINESPACE für
Mac OS X auf 10000 festgelegt, während unter Linux und Windows ein
Wert von 16000 der Standard ist.]

Use MAX_LINESPACE of 16000.


Section - Activities

[ +++ Die Activity tut nichts, wird aber nach "LanguageToInformese()" aufgerufen. ]
Translating a command into Informese is an activity.


Section - Use options

Include (- Default INVENTORY_INDENT = 2; -).
Use inventory indent translates as (- Constant INVENTORY_INDENT = 3; -).
Use inventory hyphen bullet translates as (- #IfNDef INVENTORY_BULLET; Constant INVENTORY_BULLET = "- "; #EndIf; -).
Use inventory asterisk bullet translates as (- #IfNDef INVENTORY_BULLET; Constant INVENTORY_BULLET = "* "; #EndIf; -).

Use compound heads translates as (- Constant COMPOUND_HEADS; -).
Use compound tails translates as (- Constant COMPOUND_TAILS; -).

Use non-nested lists translates as (- #IfNDef NO_NESTED_LISTS; Constant NO_NESTED_LISTS; #EndIf; -).

Use list buffer size of at least 20 translates as (- Constant LIST_BUFFER_SIZE = {N}; -).

Use capitalised Du translates as (- Constant CAPITAL_YOU_OPTION; -).

Use debug messages translates as (- Constant DEBUG_MESSAGES; -).

Use skip libcheck translates as (- Constant SKIP_LIBCHECK; -).

Use in-scope pronoun notice translates as (- Constant IN_SCOPE_PRONOUN_NOTICE; -).
Use room-related pronoun notice translates as (- Constant ROOMS_PRONOUN_NOTICE; -).

Use maximum printed name length of at least 160 translates as (- Constant MAX_GOBBLE_PRINTED_NAME_LENGTH = {N}; -).

Use omit is/are in contents lists translates as (- Constant NO_ISARE_CONTENTS; -).


Section - Values - The four German cases

A case is a kind of value.
The cases are nominative case [1], genitive case [2], dative case [3], accusative case [4].

The specification of case is "Represents the four German cases in English.
Can be used to print the object name in the correct case or for setting the
case for writing a list."

To set the/-- current case to (C - a case): (- short_name_case = {C}-1; -).

To decide which case is the current case: (- (short_name_case + 1) -).


Section - Traditional Gender Attributes

A thing can be female. A thing can be male. A thing can be neuter. A thing can be plural-named.
A thing is usually neuter.

A male thing is never neuter. A male thing is never female. A male thing is never plural-named.
A female thing is never neuter. A female thing is never male. A female thing is never plural-named.
A neuter thing is never male. A neuter thing is never female. A neuter thing is never plural-named.
A plural-named thing is never neuter. A plural-named thing is never male. A plural-named thing is never female.

A room can be female. A room can be male. A room can be neuter. A room can be plural-named.
A room is usually neuter.


A direction can be female. A direction can be male. A direction can be neuter. A direction can be plural-named.
A direction is usually male.

A man is never female. A man is never neuter. A man is never plural-named.
A woman is never male. A woman is never neuter. A woman is never plural-named.


Section - Grammatical Gender (replacing Section 1 - Grammatical definitions in English Language by Graham Nelson)

[The grammatical gender can be used as an alternative for setting the
gender of an object. The tradional way is to use attributes (male, female,
neuter, or plural-named).]

	[ +++ Die grammatical genders sind schon in "English Language.i7x" definiert, und zwar mit den Werten
			neuter = 1
			masculine = 2
			feminin = 3
		Daher mussten die folgendenArrays angepasst werden:
			LanguageArticles
			LanguageRelativePronouns
			LanguageSuffixes
			PersonalPronouns
	]

The grammatical genders are no-specified gender [4].

An object has a grammatical gender. The grammatical gender of an object is usually no-specified gender.

Definition: an object is masculine gendered if its grammatical gender is masculine gender.
Definition: an object is feminine gendered if its grammatical gender is feminine gender.
Definition: an object is neuter gendered if its grammatical gender is neuter gender.

The grammatical gender property translates into Inter as "grammatical_gender".

Include (-
Property grammatical_gender;
-).

Gender is a kind of value.
The genders are Mehrzahl, männlich, weiblich, and sächlich.

The specification of gender is "Gender represents genders of a thing as one
of the German language values männlich, weiblich, sächlich, and Mehrzahl. Mainly
for the use in output texts."


Section - In-line Gender Definitions

[von Martin Oehm, 02.12.2011]

[The grammatical gender of an object can be defined in the printed name, by
adding one of the text substitutions "m", "f", "n", or "p" directly after the name.]

To say m:
	now the previously named noun is singular-named;
	now the grammatical gender of the previously named noun is masculine gender.

To say f:
	now the previously named noun is singular-named;
	now the grammatical gender of the previously named noun is feminine gender.

To say n:
	now the previously named noun is singular-named;
	now the grammatical gender of the previously named noun is neuter gender.

To say p:
	now the previously named noun is plural-named;
	now the grammatical gender of the previously named noun is neuter gender.

Include (-
	[ Gobble s;
		VM_PrintToBuffer(StorageForShortName, MAX_GOBBLE_PRINTED_NAME_LENGTH, der, s);
		RunParagraphOn();
	];
-).

To gobble (o - an object): (- Gobble({o}); -).


Section - Genderisation

To purge the/-- gender attributes for (item - an object):
	now the item is not male;
	now the item is not female;
	now the item is not neuter.

To decide if (O - an object) is/are male-attributed: (- {O} has male -).
To decide if (O - an object) is/are female-attributed: (- {O} has female -).
To decide if (O - an object) is/are neuter-attributed: (- {O} has neuter -).

To convert the/-- remaining gender attributes for (item - an object):
	if the grammatical gender of the item is no-specified gender:
		if the item is plural-named:
			now the grammatical gender of the item is neuter gender; [GG darf später nicht no-specified-gender sein]
		otherwise if the item is male-attributed:
			now the item is singular-named;
			now the grammatical gender of the item is masculine gender;
		otherwise if the item is female-attributed:
			now the item is singular-named;
			now the grammatical gender of the item is feminine gender;
		otherwise if the item is neuter-attributed:
			now the item is singular-named;
			now the grammatical gender of the item is neuter gender;
	[ +++ Item ist immer noch "no-specified gender", daher Rückfall auf "neuter" ]
	if the grammatical gender of the item is no-specified gender:
		now the grammatical gender of the item is neuter gender;
	purge the gender attributes for the item.

To genderise (sexless - an object):
	convert remaining gender attributes for sexless;
	gobble sexless;

To re-genderise (item - an object) to (new printed name - a text),
acting plural or acting masculine or acting feminine or acting neuter and/or
with definite article or with no article or with yours and/or
as proper-named:
	now the printed name of the item is the new printed name;
	if acting plural:
		now the item is plural-named;
		now the grammatical gender of the item is neuter gender; [wahllos, weil irrelevant]
	if acting masculine:
		now the item is singular-named;
		now the grammatical gender of the item is masculine gender;
	if acting feminine:
		now the item is singular-named;
		now the grammatical gender of the item is feminine gender;
	if acting neuter:
		now the item is singular-named;
		now the grammatical gender of the item is neuter gender;
	if with definite article:
		now the special indefinite article of the item is definite article;
	otherwise if with no article:
		now the special indefinite article of the item is no article;
	otherwise if with yours:
		now the special indefinite article of the item is yours;
	otherwise:
		now the special indefinite article of the item is pending;
	if as proper-named:
		now the item is proper-named;
	otherwise:
		now the item is not proper-named;
	genderise the item.

When play begins (this is the initially genderise everything rule):
	Repeat with item running through things:
		genderise the item;
	Repeat with item running through rooms:
		genderise the item;
	Repeat with item running through directions:
		genderise the item.


Section - Values - Gender

[Die gender-Werte werden in I6 als die Werte 1, 2, 3 und 4 repräsentiert.
|Gender()| arbeitet mit der Basis 0, deshalb muss der von |Gender()| ermittelte
Wert um 1 erhöht werden. ]

To decide what gender is the gender of (something - an object):
	(- (Gender({something}) + 1) -).


Section - Changing Gender tokens

[Understand-Tokens für den CG, Idee und Code von Martin Oehm.
Die Routine |ParseTokenStopped()| musste ebenfalls geändert werden.]

The Understand token m translates into Inter as "CG_MALE_TOKEN".
The Understand token f translates into Inter as "CG_FEMALE_TOKEN".
The Understand token n translates into Inter as "CG_NEUTER_TOKEN".
The Understand token p translates into Inter as "CG_PLURAL_TOKEN".


Section - Values - The Changing Gender (CG)

To decide what gender is the changing gender of (something - an object):
	(- (Gender({something}, true) + 1) -).


Section - Values - Article mode

Article mode is a kind of value. The article modes are bare-mode, definite-mode and indefinite-mode.

To decide what article mode is the current article mode:
	(- indef_mode + 2 -).


Section - Lists - Writing sublists (for non-nested lists)

To write the/-- sublists: (- WriteSublists(1); -).

To write the/-- sublists with line break: (- WriteSublists(2); -).
To write the/-- sublists with paragraph break: (- WriteSublists(3); -).
To write the/-- sublists with space: (- WriteSublists(4); -).

To write the/-- inventory sublists: (- WriteSublists(4,1); -).



Section - Grammar - Setting suffixes and article mode

To set the/-- (AM - an article mode) suffixes from (O - an object) with (C - a case):
	(- indef_mode = {AM} - 2; SetLowStrings({C}-1, Gender({O})); -).

To set the/-- current article mode to (AM - an article mode):
	(- indef_mode = {AM} - 2; -).



Section - Grammar - Pronominal adverbs

A pronominal adverb is a kind of value.
The pronominal adverbs are erzwungen, hinein, heraus, hinweg, damit, darauf, darunter, dahinter, nach, hindurch, darüber, herunter, daran, dagegen, darum.

The current pronominal adverb is a pronominal adverb.
To decide what pronominal adverb is the current pronominal adverb: (- pronominal_adverb_flag -).

To decide whether the/a/-- noun has been supplied by a pronominal adverb: (- (pronominal_adverb_flag) -).
To reset the/-- pronominal adverb: (- pronominal_adverb_flag = false; -).



Section - Special articles

Special indefinite article is a kind of value.
The special indefinite articles are definite article, yours, no article, and pending.

An object has a special indefinite article.
The special indefinite article of an object is usually pending.
The special indefinite article property translates into Inter as "special_article".


Section - People (in place of Section 11 - People in Standard Rules by Graham Nelson)

The specification of person is "Despite the name, not necessarily a human
being, but anything animate enough to envisage having a conversation with, or
bartering with."

A person can be female or male. A person is usually male.
A person can be neuter. A person is usually not neuter.

A person has a number called carrying capacity.
The carrying capacity of a person is usually 100.

A person can be transparent. A person is always transparent.

The yourself is an undescribed person. The yourself is proper-named.

The yourself is privately-named.
Understand "dein frueheres selbst" or "mein frueheres selbst" or "frueheres selbst" or
	"frueheres" as yourself when the player is not yourself.

The description of yourself is usually "Gutaussehend wie immer."

The yourself is neuter. [ +++ Sonst kommt eine LibCheck-Warnung ]

The printed name of yourself is "[du]".
[Das ist nur Kosmetik für die Anzeige per showme.
Die eigentliche Ausgabe des Namens wird in print_yourself() erledigt.]

The yourself object translates into Inter as "selfobj".


Section - Directions (in place of Section 4 - Directions in Standard Rules by Graham Nelson)

The specification of direction is "Represents a direction of movement, such
as northeast or down. They always occur in opposite, matched pairs: northeast
and southwest, for instance; down and up."

A direction can be privately-named or publicly-named. A direction is usually
publicly-named.
A direction can be marked for listing or unmarked for listing. A direction is
usually unmarked for listing.
A direction can be scenery. A direction is always scenery.

A direction has a direction called an opposite.

Include (-
    with special_article definite, ! *** (09.11.2010): Um den indefinite article "the"
                                   !     zu überschreiben", den jede Richtung bekommt.
	has scenery, ! class CompassDirection,
-) when defining a direction.

[Die Richtungen sind privately-named; so werden die englischen Objektnamen
nicht mit ins Vokabular übernommen.]

A direction is usually privately-named.

The north is a direction.
The northeast is a direction.
The northwest is a direction.
The south is a direction.
The southeast is a direction.
The southwest is a direction.
The east is a direction.
The west is a direction.
The up is a direction.
The down is a direction.
The inside is a direction.
The outside is a direction.

[Die englischen Abkürzungen bleiben jedoch aus Traditionsgründen bestehen.]

The north has opposite south. Understand "n" as north.
The northeast has opposite southwest. Understand "ne" as northeast.
The northwest has opposite southeast. Understand "nw" as northwest.
The south has opposite north. Understand "s" as south.
The southeast has opposite northwest. Understand "se" as southeast.
The southwest has opposite northeast. Understand "sw" as southwest.
The east has opposite west. Understand "e" as east.
The west has opposite east. Understand "w" as west.
Up has opposite down. Understand "u" as up.
Down has opposite up. Understand "d" as down.
Inside has opposite outside. [Understand "in" as inside.]
Outside has opposite inside. [Understand "out" as outside.]

The inside object translates into Inter as "in_obj".
The outside object translates into Inter as "out_obj".

The verb to be above means the mapping up relation.
The verb to be mapped above means the mapping up relation.
The verb to be below means the mapping down relation.
The verb to be mapped below means the mapping down relation.


[Deutsche Synonyme und angezeigte Objektnamen für die Richtungen.]

Understand "Norden" as north.
The printed name of north is "Norden[-s][m]".

Understand "Nordosten" or "no" as northeast.
The printed name of northeast is "Nordosten[-s][m]".

Understand "Nordwesten" as northwest.
The printed name of northwest is "Nordwesten[-s][m]".

Understand "Sueden" as south.
The printed name of south is "Süden[-s][m]".

Understand "Suedosten" or "so" as southeast.
The printed name of southeast is "Südosten[-s][m]".

Understand "Suedwesten" as southwest.
The printed Name of southwest is "Südwesten[-s][m]".

Understand "Osten" or "o" as east.
The printed name of east is "Osten[-s][m]".

Understand "Westen" as west.
The printed name of west is "Westen[-s][m]".

Understand "hoch", "h", "rauf", "hinauf" and "oben" as up.
The printed name of up is "oben". Up is proper-named.

Understand "runter", "r", "hinunter" and "unten" as down.
The printed name of down is "unten". Down is proper-named.

Understand "rein", "innen" or "drinnen" as inside.
The printed name of inside is "drinnen". Inside is proper-named.

Understand "raus", "aussen" or "draussen" as outside.
The printed name of outside is "draußen". Outside is proper-named.


Section - Remove most of the English commands

Understand the command "take" as something new.
Understand the command "carry" as something new.
Understand the command "hold" as something new.
Understand the command "get" as something new.
Understand the command "pick" as something new.
Understand the command "stand" as something new.
Understand the command "remove" as something new.
Understand the command "shed" as something new.
Understand the command "doff" as something new.
Understand the command "disrobe" as something new.
Understand the command "don" as something new.
Understand the command "wear" as something new.
Understand the command "put" as something new.
Understand the command "drop" as something new.
Understand the command "throw" as something new.
Understand the command "discard" as something new.
Understand the command "give" as something new.
Understand the command "pay" as something new.
Understand the command "offer" as something new.
Understand the command "feed" as something new.
Understand the command "present" as something new.
Understand the command "display" as something new.
Understand the command "show" as something new.
Understand the command "go" as something new.
Understand the command "walk" as something new.
Understand the command "leave" as something new.
Understand the command "run" as something new.

Understand the command "inventory" as something new.
Understand the command "i" as something new.
Understand the command "inv" as something new.

Understand the command "look" as something new.
Understand the command "l" as something new.

Understand the command "consult" as something new.
Understand the command "open" as something new.
Understand the command "unwrap" as something new.
Understand the command "uncover" as something new.
Understand the command "shut" as something new.
Understand the command "cover" as something new.
Understand the command "close" as something new.
Understand the command "cross" as something new.
Understand the command "enter" as something new.
Understand the command "sit" as something new.
Understand the command "exit" as something new.
Understand the command "out" as something new.

Understand the command "x" as something new.

Understand the command "watch" as something new.
Understand the command "describe" as something new.
Understand the command "check" as something new.
Understand the command "examine" as something new.
Understand the command "read" as something new.
Understand the command "yes" as something new.
Understand the command "y" as something new.
Understand the command "yes" as something new.
Understand the command "no" as something new.

Understand the command "sorry" as something new.

Understand the command "damn" as something new.
Understand the command "bother" as something new.
Understand the command "curses" as something new.
Understand the command "drat" as something new.
Understand the command "darn" as something new.
Understand the command "search" as something new.
Understand the command "wave" as something new.
Understand the command "adjust" as something new.
Understand the command "set" as something new.
Understand the command "drag" as something new.
Understand the command "pull" as something new.
Understand the command "push" as something new.
Understand the command "move" as something new.
Understand the command "shift" as something new.
Understand the command "clear" as something new.
Understand the command "press" as something new.
Understand the command "rotate" as something new.
Understand the command "twist" as something new.
Understand the command "unscrew" as something new.
Understand the command "screw" as something new.
Understand the command "turn" as something new.
Understand the command "switch" as something new.
Understand the command "lock" as something new.
Understand the command "unlock" as something new.
Understand the command "attack" as something new.
Understand the command "break" as something new.
Understand the command "smash" as something new.
Understand the command "hit" as something new.
Understand the command "fight" as something new.
Understand the command "torture" as something new.
Understand the command "wreck" as something new.
Understand the command "crack" as something new.
Understand the command "destroy" as something new.
Understand the command "murder" as something new.
Understand the command "punch" as something new.
Understand the command "thump" as something new.
Understand the command "wait" as something new.
Understand the command "answer" as something new.
Understand the command "say" as something new.
Understand the command "shout" as something new.
Understand the command "speak" as something new.
Understand the command "tell" as something new.
Understand the command "ask" as something new.
Understand the command "eat" as something new.
Understand the command "sleep" as something new.
Understand the command "nap" as something new.
Understand the command "sing" as something new.
Understand the command "climb" as something new.
Understand the command "scale" as something new.
Understand the command "purchase" as something new.
Understand the command "buy" as something new.
Understand the command "squeeze" as something new.
Understand the command "swim" as something new.
Understand the command "dive" as something new.
Understand the command "swing" as something new.
Understand the command "blow" as something new.
Understand the command "pray" as something new.
Understand the command "wake" as something new.
Understand the command "awake" as something new.
Understand the command "awaken" as something new.
Understand the command "kiss" as something new.
Understand the command "embrace" as something new.
Understand the command "hug" as something new.
Understand the command "think" as something new.
Understand the command "sniff" as something new.
Understand the command "smell" as something new.
Understand the command "listen" as something new.
Understand the command "hear" as something new.
Understand the command "feel" as something new.
Understand the command "touch" as something new.
Understand the command "rub" as something new.
Understand the command "shine" as something new.
Understand the command "polish" as something new.
Understand the command "sweep" as something new.
Understand the command "clean" as something new.
Understand the command "dust" as something new.
Understand the command "wipe" as something new.
Understand the command "scrub" as something new.
Understand the command "attach" as something new.
Understand the command "fix" as something new.
Understand the command "tie" as something new.
Understand the command "light" as something new.
Understand the command "burn" as something new.
Understand the command "swallow" as something new.
Understand the command "sip" as something new.
Understand the command "drink" as something new.
Understand the command "fill" as something new.
Understand the command "slice" as something new.
Understand the command "prune" as something new.
Understand the command "chop" as something new.
Understand the command "cut" as something new.
Understand the command "jump" as something new.
Understand the command "skip" as something new.
Understand the command "hop" as something new.
Understand the command "dig" as something new.
Understand the command "score" as something new.

[Understand the command "quit" as something new.
Understand the command "q" as something new.
Understand the command "save" as something new.
Understand the command "restart" as something new.
Understand the command "restore" as something new.
Understand the command "verify" as something new.
Understand the command "version" as something new.]

Understand the command "script" as something new.
Understand the command "transcript" as something new.

[Understand the command "superbrief" as something new.
Understand the command "short" as something new.
Understand the command "verbose" as something new.
Understand the command "long" as something new.
Understand the command "brief" as something new.
Understand the command "normal" as something new.
Understand the command "nouns" as something new.
Understand the command "pronouns" as something new.
Understand the command "notify" as something new.]

Understand the command "insert" as something new.
Understand the command "purchase" as something new.
Understand the command "squash" as something new.
Understand the command "taste" as something new.
Understand the command "fasten" as something new.


Section - German Understand tokens

The Understand token dich translates into Inter as "DICH_TOKEN".
The Understand token dir translates into Inter as "DIR_TOKEN".

The Understand token dativ translates into Inter as "DATIVE_TOKEN".
The Understand token dative translates into Inter as "DATIVE_TOKEN".

The Understand token substantive translates into Inter as "SUBSTANTIVE_TOKEN".
The Understand token substantiv translates into Inter as "SUBSTANTIVE_TOKEN".

The Understand token hinein translates into Inter as "PREP_HINEIN_TOKEN".
The Understand token heraus translates into Inter as "PREP_HERAUS_TOKEN".
The Understand token weg translates into Inter as "PREP_WEG_TOKEN".
[The Understand token ab translates into Inter as "PREP_WEG_TOKEN".] [ +++ 30.05.2023 Doppelter Namen für gleiche Funktionalität]
The Understand token darauf translates into Inter as "PREP_DARAUF_TOKEN".
[The Understand token hinauf translates into Inter as "PREP_DARAUF_TOKEN".] [ +++ 30.05.2023 Doppelter Namen für gleiche Funktionalität]
The Understand token nach translates into Inter as "PREP_NACH_TOKEN".
The Understand token hindurch translates into Inter as "PREP_HINDURCH_TOKEN".
The Understand token darüber translates into Inter as "PREP_DARUEBER_TOKEN". [ +++ 30.05.2023 war "hinüber"]
The Understand token darueber translates into Inter as "PREP_DARUEBER_TOKEN". [ +++ 30.05.2023 war "hinueber"]
The Understand token herunter translates into Inter as "PREP_HERUNTER_TOKEN".
The Understand token darunter translates into Inter as "PREP_DARUNTER_TOKEN".
The Understand token daran translates into Inter as "PREP_DARAN_TOKEN".
The Understand token dagegen translates into Inter as "PREP_DAGEGEN_TOKEN".
The Understand token darum translates into Inter as "PREP_DARUM_TOKEN". [ +++ 31.05.2023 ergänzt]

The Understand token noun hinein translates into Inter as "NOUN_HINEIN_TOKEN".
The Understand token noun heraus translates into Inter as "NOUN_HERAUS_TOKEN".
The Understand token noun darauf translates into Inter as "NOUN_DARAUF_TOKEN".
The Understand token noun darunter translates into Inter as "NOUN_DARUNTER_TOKEN".
The Understand token noun dahinter translates into Inter as "NOUN_DAHINTER_TOKEN".
The Understand token noun hindurch translates into Inter as "NOUN_HINDURCH_TOKEN".
The Understand token noun darüber translates into Inter as "NOUN_DARUEBER_TOKEN".
The Understand token noun darueber translates into Inter as "NOUN_DARUEBER_TOKEN".
The Understand token noun herunter translates into Inter as "NOUN_HERUNTER_TOKEN".
The Understand token noun daran translates into Inter as "NOUN_DARAN_TOKEN".
The Understand token noun dagegen translates into Inter as "NOUN_DAGEGEN_TOKEN".
The Understand token noun darum translates into Inter as "NOUN_DARUM_TOKEN". [ +++ 31.05.2023 ergänzt]

The Understand token held hinein translates into Inter as "HELD_HINEIN_TOKEN".
The Understand token held darauf translates into Inter as "HELD_DARAUF_TOKEN".

The Understand token force nach translates into Inter as "FORCE_NACH_TOKEN".
The Understand token force in translates into Inter as "FORCE_IN_TOKEN".
The Understand token force nach in translates into Inter as "FORCE_NACH_IN_TOKEN".
The Understand token force pronoun translates into Inter as "FORCE_PRONOUN_TOKEN".

The Understand token implicit up translates into Inter as "IMPLICIT_UP_TOKEN".


Section - German commands

Understand "punkte" as requesting the score.
Understand the command "punktestand" and "score" as "punkte".
Understand "punkte on/an/ein/einschalten" as switching score notification on.
Understand "punkte off/aus/ausschalten" as switching score notification off.

Understand "notify on/an/ein/einschalten" as switching score notification on.
Understand "notify off/aus/ausschalten" as switching score notification off.
Understand the command "meldungen" as "notify".

Understand "ende" as quitting the game.
Understand the commands "stirb" and "beend" as "ende".

[Alle Formen von "laden" angelegt wegen RESTORE__WD == 'laden' und um
Kollisionen mit einem möglichen vom Autor definierten Objekt "Lade/Laden" zu
verhindern. Siehe dazu auch die geänderte Bedingung für das Prüfen des
Infinitivs in Parser Letter B.]

Understand "load", "lad", "lade" and "laden" as restoring the game.

Understand "neu" or "neustart" as restarting the game.
Understand "speicher" as saving the game.

Understand "skript" or "skript on/an/ein" as switching the story transcript on.
Understand "skript off/aus" as switching the story transcript off.
Understand the commands "script", "transkript", "transcript", "protokoll" and "mitschrift" as "skript".

Understand "superknapp", "superkurz", "super knapp/kurz" or "sehr knapp/kurz" or "immer knapp/kurz" as preferring abbreviated room descriptions.
Understand "ausfuehrlich" or "lang" as preferring unabbreviated room descriptions.
Understand "knapp" or "kurz" as preferring sometimes abbreviated room descriptions.
Understand "pronomen", "pronomina", "fuerwoerter" or "fuerwort" as requesting the pronoun meanings.

Understand "nimm [things]" as taking. [Damit NIMM ALLES sich richtig verhält.]
Understand "nimm [dir] [things]" as taking.
Understand "nimm [dir] [things] auf/mit" as taking.
Understand "nimm [a worn thing] ab" as taking off.
Understand "nimm [things] ab" as taking.
Understand "nimm [dir] [things inside] aus/in/von [dativ] [something] [heraus]" as removing it from. [*]
Understand "nimm [dir] [things inside] [noun heraus]" as removing it from.
Understand "nimm [dir] [things inside] [noun herunter]" as removing it from.
Understand "nimm [substantiv] platz auf/in [dativ] [something]" as entering. [*]
Understand "nimm auf/in [dativ] [something] [substantiv] platz" as entering. [*]
Understand the commands "nehm" and "hol" as "nimm".

Understand "greif [dir] [things]" as taking.
Understand "greif nach [dativ] [things]" as taking.
Understand "greif [things inside] auf/in [dativ] [something]" as removing it from. [*]
Understand "greif nach [dativ] [things inside] auf/in [dativ] [something]" as removing it from. [*]
Understand "greif [things inside] [noun heraus]" as removing it from.
Understand "greif an [something] [daran]" as touching.
Understand "greif [someone alive] an" as attacking.
Understand "greif [something] an" as touching.
Understand "greif [someone alive] mit [dativ] [something preferably held] an" as attacking it with.
Understand "greif mit [dativ] [something preferably held] [someone] an" as attacking it with (with nouns reversed).
Understand "greif [things inside] aus/von [dativ] [something] [heraus]" as removing it from. [*]
Understand the commands "fass" and "ergreif" as "greif".

Understand "pack [things]" or "pack [things] ein" as taking.
Understand "pack [someone]" as attacking.
Understand "pack [other things] auf [something] [darauf]" as putting it on.
Understand "pack [other things] [noun darauf]" as putting it on.
Understand "pack [other things] in [something] [hinein]" as inserting it into.
Understand "pack [other things] [noun hinein]" as inserting it into.

Understand "heb [things] auf" as taking.
Understand "heb [things inside] [noun heraus]" or "heb [things inside] [noun darunter]" as removing it from.
Understand "heb [something] an/hoch" as looking under. [*** Hier heißt es in deform "Lift", das gibt es in I7 aber nicht. ]

Understand "trag [something preferably held]" as wearing.

Understand "steh" or "steh auf" as exiting.
Understand "steh auf von/aus [dativ] [something]" as exiting from. [*]
Understand "steh auf [dativ] [something] [darauf]" as entering.
Understand "steh [noun darauf]" as entering.

Understand "entfern [a worn thing]" as taking off.
Understand "entfern [things]" as taking.
Understand "entfern [things inside] von/aus [dativ] [something]" as removing it from. [*]

Understand "tu [dich] auf [something]" as entering.
Understand "tu [dich] in [something]" as entering.

Understand "tu [things preferably held] weg" as dropping.
Understand "tu [other things] in [something] [hinein]" as inserting it into.
Understand "tu [other things] [noun hinein]" as inserting it into.
Understand "tu [other things] auf [something] [darauf]" as putting it on.
Understand "tu [other things] [noun darauf]" as putting it on.
Understand the commands "platzier" and "plazier" as "tu".

Understand "steck [other things] in [something] [hinein]" as inserting it into.
Understand "steck [dir] [things] ein" as taking.
Understand "steck [other things] [noun hinein]" as inserting it into.
Understand "steck [other things] auf [something] [darauf]" as putting it on.
Understand "steck [dir] [a wearable thing] an" as wearing.
Understand "steck [something] mit [dativ] [something preferably held] an" as burning it with.
Understand "steck mit [dativ] [something preferably held] [something] an" as burning it with (with nouns reversed).
Understand "steck [something] an" as burning.

Understand "lass [dich] auf/in [dativ] [something] nieder" as entering. [*]
Understand "lass [things preferably held]" as dropping.
Understand "lass [things preferably held] fallen/liegen/hier/ab/aus/los" as dropping.
Understand "lass [other things] in/unter [dativ] [something]" as inserting it into. [*]
Understand "lass [other things] auf/ueber [dativ] [something]" as putting it on. [*]

Understand "wirf [dich] auf [someone]" as attacking.
Understand "wirf [dich] gegen [something]" as attacking.
Understand "wirf [dich] auf [something]" as entering.
Understand "wirf [dich] in [something]" as entering.
Understand "wirf [things] [weg]" as dropping.
Understand "wirf [other things] in [something] [hinein]" as inserting it into.
Understand "wirf [other things] unter [something] [darunter]" as inserting it into.
Understand "wirf [other things] [noun hinein]" as inserting it into.
Understand "wirf [other things] auf [something]" as putting it on.
Understand "wirf [other things] ueber [something]" as putting it on.
Understand "wirf [something preferably held] nach/auf/gegen/zu [something]" as throwing it at.
Understand "wirf [something] [something preferably held] zu" as throwing it at (with nouns reversed).
Understand "wirf [something] nieder" as attacking.
Understand the commands "werf" and "schmeiss" and "schleuder" as "wirf".

Understand "gib [something preferably held] [dativ] [someone]" as giving it to.
Understand "gib [something preferably held] an [someone]" as giving it to.
Understand "gib [dativ] [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand "gib an [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand the commands "geb" and "offerier" and "reich" and "uebertrag" and "ueberreich" and "uebergib" as "gib".

Understand "fuetter [someone alive] mit [dativ] [something preferably held]" as giving it to (with nouns reversed).
Understand "fuetter mit [dativ] [something preferably held] [someone]" as giving it to.
Understand "fuetter [something preferably held] an [someone]" as giving it to.
Understand "fuetter an [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand "fuetter [something] mit [dativ] [other things]" as inserting it into (with nouns reversed).
Understand the commands "bezahl" and "zahl" as "fuetter".

Understand "biet [dativ] [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand "biet [something preferably held] [dativ] [someone] an" as giving it to.
Understand "biet fuer [something]" as buying.

Understand "zeig [dativ] [someone] [something preferably held]" as showing it to (with nouns reversed).
Understand "zeig [something preferably held] [dativ] [someone]" as showing it to.
Understand "zeig [dativ] [someone] [something preferably held] vor" as showing it to (with nouns reversed).
Understand "zeig [something preferably held] [dativ] [someone] vor" as showing it to.
Understand "zeig inventar/besitz/eigentum" as taking inventory.
Understand the commands "praesentier" and "fuehr" as "zeig".

Understand "geh" or "geh umher" as going.
Understand "geh weg/fort" as location-leaving.
Understand "geh weg/fort von hier/da/dort" as location-leaving.
Understand "geh weg/fort von [a room]" as location-leaving.

[(11.11.2011) Das folgende Satzmuster muss ebenfalls mit einem
Krücken-Adjektiv priorisiert werden, damit es bei einer Parser-Nachfrage nicht
heißt:

	>geh in
	Worichtung willst du ingehen?]

Definition: A thing is dummy-enterable: yes.
Understand "geh in [something dummy-enterable] [hinein]" as entering.

Understand "geh durch [something] [hindurch]" as entering.
Understand "geh ueber [something] [darueber]" as entering.
Understand "geh auf [something] [darauf]" as entering.
Understand "geh [direction]" as going.
Understand "geh nach [direction]" as going.
Understand "geh richtung [direction]" as going.
Understand "geh in richtung [direction]" as going.
Understand "geh nach draussen/aussen" as exiting.
Understand "geh raus/hinaus/heraus" as exiting.
Understand "geh rein/hinein/herein" as going into.
Understand "geh runter von [dativ] [supporter]" as getting off. [ +++ 27.05.2023 hinzugefügt]
Understand "geh von [dativ] [supporter]" as getting off.        [ +++ 27.05.2023 hinzugefügt]
Understand "geh von [dativ] [supporter] runter" as getting off. [ +++ 27.05.2023 hinzugefügt]

Understand the commands "lauf", "renn", "wander", "fluecht", "flieh", "schreit", and "spazier" as "geh".

Understand "verlass" as location-leaving.
Understand "verlass [someone alive]" as location-leaving.
Understand "verlass [something]" as exiting from.
Understand "verlass [a room]" as location-leaving.

Understand "mach [something] zu" as closing.
Understand "mach [something] auf" as opening.
Understand "mach [someone alive] an" as attacking.
Understand "mach [something] an" as switching on.
Understand "mach [something] aus" as switching off.
Understand "mach [something] kaputt" as attacking.

Understand "inventar" as taking inventory.
Understand "inventar hoch/liste/lang" as tall taking inventory.
Understand "inventar quer/satz/breit" as wide taking inventory.
Understand "inventar als liste" as tall taking inventory.
Understand "inventar als satz" as wide taking inventory.
Understand the commands "i", "inv", "besitz" and "eigentum" as "inventar".

Understand "schau" or "schau [dich] um" or "schau herum/umher" as looking.
Understand "schau [something]" or "schau [dir] [something] an" as examining.
Understand "schau nach [dativ] [direction]" as examining.
Understand "schau in [direction]" as examining.
Understand "schau durch [something] [hindurch]" as searching.
Understand "schau in [something] [hinein]" as searching.
Understand "schau aus [something] [heraus]" as searching.
Understand "schau in/auf [dativ] [something] [nach]" as searching. [*]
Understand "schau [noun hinein]" as searching.
Understand "schau [noun hindurch]" as searching.
Understand "schau [noun darunter] [nach]" as looking under.
Understand "schau [noun dahinter] [nach]" as looking under.
Understand "schau unter/hinter [dativ] [something] [nach]" as looking under. [*]
Understand "schau unter [dativ] [something] [darunter]" as looking under.
Understand "schau nach in/auf [dativ] [something]" as searching. [*]
Understand "schau [force nach in] nach [text] in [dativ] [something]" as consulting it about (with nouns reversed).
Understand "schau in [dativ] [something] unter [text] nach" as consulting it about.
Understand "schau in [dativ] [something] nach unter [text]" as consulting it about.
Understand "schau in [dativ] [something] ueber/ob/zu [text] nach" as consulting it about.
Understand "schau in [dativ] [something] [text] nach" as consulting it about.
Understand "schau [force nach in] [text] nach in [dativ] [something]" as consulting it about (with nouns reversed).
Understand "schau [force nach] [text] in [dativ] [something] nach" as consulting it about (with nouns reversed).
Understand "schau ueber/unter/bezueglich [force nach] [text] in [something] nach" as consulting it about (with nouns reversed). [**] [22.10.2011: Vorschlag von Bushin]
Understand "schau ueber/unter/bezueglich [force nach in] [text] nach in [something dummy-consultable]" as consulting it about (with nouns reversed). [**] [22.10.2011]

Understand the commands "seh" and "sieh" and "blick" and "lug" and "guck" and "kuck" as "schau".

Understand "lage" and "l" as looking.

Understand "lern nach/ob/ueber/von [text] aus/in [dativ] [something]" as consulting it about (with nouns reversed). [*]
Understand "lern [text] aus/in [dativ] [something]" as consulting it about (with nouns reversed). [*]
Understand "lern aus/in [dativ] [something] nach/ob/ueber/von [text]" as consulting it about. [*]
Understand the command "forsch" as "lern".

Understand "konsultier [something] ueber/bezueglich [text]" as consulting it about.

Understand "oeffne [something]" as opening.
Understand "oeffne mit [dativ] [something preferably held] [something]" as unlocking it with (with nouns reversed).
Understand "oeffne [something] mit [dativ] [something preferably held]" as unlocking it with.

Understand  "betritt [something]" as entering.
Understand the commands "durchquer" or "betret" as "betritt".

Understand "tritt [something]" as attacking.
Understand "tritt gegen [something]" as attacking.
Understand "tritt ein" as going into.
Understand "tritt aus/heraus/hinaus" as exiting.
Understand "tritt aus [dativ] [something] [heraus]" as exiting from.
Understand "tritt in [something] [hinein]" or "tritt ein in [something]" as entering.
Understand "tritt [noun hinein]" as entering.
Understand the command "tret" as "tritt".

[Solange die Reihenfolge der Grammar-Lines noch nicht beeinflusst werden kann,
werden die [dich]-Token in mehrdeutigen Satzmustern durch entsprechende
Check-Rules ersetzt.]

Understand "setz [dich] auf [something] [darauf]" or "setz [dich] in [something] [hinein]" as entering.
Understand "setz [dich] auf/in [something] nieder" as entering.
Understand "setz [dich] [noun hinein]" as entering.
Understand "setz [dich] [noun darauf]" as entering.

Understand "setz [things preferably held] ab/hin" as dropping.

Understand "setz [other things] in [something] [hinein]" as inserting it into.
Understand "setz [other things] in [dativ] [something] ab" as inserting it into.
Understand "setz [other things] [noun hinein]" as inserting it into.

Understand "setz [other things] auf [something] [darauf]" as putting it on.
Understand "setz [other things] auf [dativ] [something] ab" as putting it on.
Understand "setz [other things] [noun darauf]" as putting it on.

[Die vier folgenden Understand-Lines, die ein Dich-Token enthalten,
werden ebenfalls nicht korrekt geparst; zusätzliche Hilfs-Check-Rules sollen
Abhilfe schaffen.]

Understand "leg [dich] in [something] [hinein]" as entering.
Understand "leg [dich] auf [something] [darauf]" as entering.
Understand "leg [dich] auf [something] nieder" as entering.
Understand "leg [dich] in [something] nieder" as entering.

[Die folgenden drei Zeilen werden jedoch korrekt angeordnet.]

Understand "leg [dich] hin" as sleeping.
Understand "leg [dich] [noun hinein]" as entering.
Understand "leg [dich] [noun darauf]" as entering.

Understand "leg [a worn thing] ab" as taking off.
Understand "leg [things preferably held] hin" as dropping.
Understand "leg [things preferably held] [weg]" as dropping.
Understand "leg [other things] in [something] [hinein]" as inserting it into.
Understand "leg [other things] in [something] ab" as inserting it into.
Understand "leg [other things] [noun hinein]" as inserting it into.
Understand "leg [other things] auf [something] [darauf]" as putting it on.
Understand "leg [other things] auf [something] ab" as putting it on.
Understand "leg [other things] [noun darauf]" as putting it on.
Understand "leg [someone alive] um" as attacking.
Understand "leg [something preferably held] an/um" as wearing.

Understand "sitz auf/in [dativ] [something]" as entering. [*]
Understand "sitz [noun darauf]" as entering.
Understand "sitz [noun hinein]" as entering.
Understand the command "lieg" as "sitz".

Understand "raus" as exiting.
Understand "raus aus [dativ] [something]" as exiting from.
Understand the commands "heraus", "hinaus" as "raus".

Understand "rein" as going into.
Understand "rein in [something]" as entering.
Understand the commands "hinein" and "herein" as "rein".


Understand "u [something]" as examining.
Understand "u [implicit up]" as going. [So kann man U für RAUF sagen, ohne dass "u [something]" beeinträchtigt wird.]

Understand "untersuch [something]" as examining.
Understand the commands "b", "x", "betracht", "beschreib", "begutacht", and "inspizier" as "untersuch".

Understand "durchsuch [something]" as searching.
Understand the commands "durchwuehl" and "durchstoeber" as "durchsuch".

Understand "lies [something]" as examining.
Understand "lies [things] auf" as taking.
Understand "lies in [dativ] [something]" as examining.
Understand "lies in [dativ] [something] nach" as examining.
Understand "lies nach in [dativ] [something]" as examining.
Understand "lies nach in [dativ] [something] ueber/von [text]" as consulting it about.
Understand "lies nach ueber/von [text] in [dativ] [something]" as consulting it about (with nouns reversed).
Understand "lies [force nach] in [dativ] [something] ueber/von [text] nach" as consulting it about.
Understand "lies [force in] in [dativ] [something] nach ueber/von [text]" as consulting it about.
Understand "lies [force in] in [dativ] [something] ueber/von [text]" as consulting it about.
Understand "lies [force in] ueber/von [text] in [dativ] [something] [nach]" as consulting it about (with nouns reversed).

[16.10.2011: Um das folgende Satzmuster zu priorisieren, benutzen wir ein überflüssiges, weil für alle
Objekte zutreffendes, Adjektiv (dummy-consultable), um dem System einen Spezialfall vorzugaukeln.]
Definition: An object is dummy-consultable: yes.
Understand "lies [force nach in] ueber/von [text] nach in [dativ] [something dummy-consultable]" as consulting it about (with nouns reversed).[**]

Understand "lies [force nach in] [text] nach in [dativ] [something]" as consulting it about (with nouns reversed).
Understand "lies [force nach] [text] in [dativ] [something] [nach]" as consulting it about (with nouns reversed).
Understand "lies [force in] [text] in [dativ] [something]" as consulting it about (with nouns reversed).
Understand the command "les" as "lies".

Understand "ja" or "j" or "jawohl" as saying yes.

Understand "nein" or "nee" or "noe" as saying no.

Understand "verzeih", "verzeih mir", "verzeih mir bitt" or "verzeih bitt" as saying sorry.
Understand the commands "entschuldigung", "entschuldig" and "pardon" as "verzeih".

[Understand the commands "scheiss", "kack", "arschloch", "wichser", "piss", "verpiss" and "fick" as "fuck".]

[Understand "verdammt", "mist", "schiet", "scheibenkleister" or "depp" as swearing mildly.]

Understand "such in/auf [dativ] [something]" as searching. [*]
Understand "such hinter/neben [dativ] [something]" as searching. [*]
Understand "such unter [dativ] [something]" as looking under.
Understand "such [something] ab" as searching.
Understand "such [noun darunter]" as looking under.
Understand "such [noun dahinter]" as looking under.
Understand "such in [dativ] [something] nach [text]" as consulting it about.
Understand "such nach [text] in [dativ] [something]" as consulting it about (with nouns reversed).
Understand the commands "stoeber" and "wuehl" as "such".

Understand "wink" as waving hands.
Understand "wink mit [dativ] [something]" as waving.
Understand "wink mit hand" or "wink mit der hand" as waving hands.
Understand "wink mit haende" or "wink mit den haende" as waving hands.

Understand "stell [dich] hin" as exiting.
Understand "stell [dich] auf [something] [darauf]" as entering.
Understand "stell [dich] in [something] [hinein]" as entering.
Understand "stell [dich] [noun hinein]" as entering.
Understand "stell [dich] [noun darauf]" as entering.
Understand "stell [something]" as setting it.
Understand "stell [other things] in [something] [hinein]" as inserting it into.
Understand "stell [other things] auf [something] [darauf]" as putting it on.
Understand "stell [other things] [noun hinein]" as inserting it into.
Understand "stell [something] auf [text] ein" as setting it to.
Understand "stell [something] auf [text]" as setting it to.
Understand "stell [something switchable] an/ein" as switching on.
Understand "stell [something switchable] ab/aus" as switching off.
Understand "stell [things preferably held] ab/weg/hin" as dropping.
Understand "stell [things preferably held] [weg]" as dropping.

Understand "zieh [something]" as pulling. [ +++ 24.06.2023 Zeile hinzugefügt, vorher wurde "zieh xxx" als taking verstanden. ]
Understand "zieh [something] [weg]" as pulling.
Understand "zieh an [dativ] [something]" as pulling.
Understand "zieh [a worn thing] ab/aus" as taking off.
Understand "zieh [something] aus [something] [heraus]" as removing it from.
Understand "zieh [something] [noun heraus]" as removing it from.
Understand "zieh [someone alive] aus" as undressing.
Understand "zieh [someone alive] an" as dressing.
Understand "zieh [something preferably held] an/ueber/auf" as wearing.
Understand "zieh [something] aus" as taking off.

Understand "reiss [something] weg" as pulling.
Understand "reiss [something] ab" as taking.
Understand "reiss an [dativ] [something]" as pulling.
Understand "reiss [other things] aus [something] [heraus]" as removing it from.
Understand "reiss [other things] [noun heraus]" as removing it from.
Understand the commands "zerr", "zupf", and "rupf" as "reiss".

Understand "kleid [someone alive]" as dressing.
Understand "kleid [something]" as dressing.
Understand "kleid [someone alive] an"  as dressing.
Understand "kleid [something] an" as dressing.
Understand "kleid [dich] an mit [dativ] [something preferably held]" as wearing.
Understand "kleid [dich] mit [dativ] [something preferably held] an" as wearing.
Understand "kleid [dich] in [something preferably held]" as wearing.
Understand the commands "bekleid" and "schmueck" as "kleid".

Understand "entkleid [someone alive]" as undressing.

Understand "drueck [something]" as pushing.
Understand "drueck [something] [weg]" as pushing.
Understand "drueck [noun hinein]" and "drueck [noun dagegen]" as pushing.
Understand "drueck gegen [something]" as pushing.
Understand "drueck [something] [direction]" as pushing it to.
Understand "drueck [something] nach/richtung [direction]" as pushing it to.
Understand "drueck [something] aus/zusammen" as squeezing.
Understand "drueck [other things] in [something] [hinein]" as inserting it into.
Understand "drueck [something] auf" as opening.
Understand "drueck [something] zu" as closing.
Understand "drueck [something] hoch/hinauf/rauf" as looking under.
Understand "drueck [something] nach oben" as looking under.
Understand the commands "press", "beweg", "schieb" and "verschieb" as "drueck".

Understand "dreh [something]" as turning.
Understand "dreh an [dativ] [something]" as turning.
Understand "dreh [something switchable] an/ein" as switching on.
Understand "dreh [something switchable] ab/aus" as switching off.
Understand "dreh [something] an/ein" as switching on.
Understand "dreh [something] ab/aus" as switching off.
Understand "dreh [something] auf [text]" as setting it to.
Understand "dreh [something] auf" as opening.
Understand "dreh [something] zu" as closing.
Understand the commands "schraub" and "rotier" as "dreh".

Understand "schalt [something switchable]" as switching on.
Understand "schalt [something switchable] an/ein" as switching on.
Understand "schalt [something switchable] ab/aus" as switching off.
Understand "schalt [something]" as switching on.
Understand "schalt [something] an/ein" as switching on.
Understand "schalt [something] ab/aus" as switching off.

Understand "schliess [something]" as closing.
Understand "schliess [a lockable thing] mit [dativ] [something preferably held]" as locking it with.
Understand "schliess [something] mit [dativ] [something preferably held]" as closing it with.
Understand "schliess [something] mit [dativ] [something preferably held] ab/zu" as locking it with.
Understand "schliess [something] ab mit [dativ] [something preferably held]" as locking it with.
Understand "schliess [something] ab" as locking.

Locking is an action applying to one touchable thing and requiring light.
Carry out locking:
	if the noun is lockable:
		say "Womit willst [du] [den noun] abschließen?";
	else:
		say "[text of can't lock without a lock rule response (A)][line break]".

Understand "schliess [something] mit [dativ] [something preferably held] auf" as unlocking it with.
Understand "schliess [something] auf mit [dativ] [something preferably held]" as unlocking it with.
Understand the command "sperr" as "schliess".

Understand "verschliess [a lockable thing] mit [dativ] [something preferably held]" as locking it with.
Understand "verschliess [something]" as closing.
Understand "verschliess [something] mit [dativ] [something preferably held]" as closing it with.
Understand the commands "verriegel", "verriegle" and "versperr" as "verschliess".

Understand "schlag [someone alive]" as attacking.
Understand "schlag [noun hinein]" as attacking.
Understand "schlag [something]" as attacking.
Understand "schlag auf [something] ein" as attacking.
Understand "schlag auf [something] [darauf]" as attacking.
Understand "schlag [something] um/ab/entzwei/kaputt" as attacking.
Understand "schlag in [something] [hinein]" as attacking.
Understand "schlag [someone alive] mit [dativ] [something preferably held]" as attacking it with.
Understand "schlag [something] mit [dativ] [something preferably held]" as attacking it with.
Understand "schlag mit [dativ] [something preferably held] gegen [something]" as attacking it with (with nouns reversed).
Understand "schlag [something preferably held] gegen [something]" as attacking it with (with nouns reversed).
Understand "schlag [something] auf" as opening.
Understand "schlag [something] zu" as closing.
Understand "schlag nach in [dativ] [something]" as examining.
Understand "schlag in [dativ] [something] [text] nach" as consulting it about.
Understand "schlag in [dativ] [something] ueber/unter/zu [text] nach" as consulting it about.
Understand "schlag [force nach in] ueber/unter/zu [text] nach in [dativ] [something]" as consulting it about (with nouns reversed).
Understand "schlag [force nach in] [text] nach in [dativ] [something]" as consulting it about (with nouns reversed).
Understand "schlag [force nach] [text] in [dativ] [something] nach" as consulting it about (with nouns reversed).

Understand "hau [someone alive]" as attacking.
Understand "hau [noun hinein]" as attacking.
Understand "hau [something]" as attacking.
Understand "hau auf [something] ein" as attacking.
Understand "hau auf [something] [darauf]" as attacking.
Understand "hau [something] um/ab/entzwei/kaputt" as attacking.
Understand "hau in [something] [hinein]" as attacking.
Understand "hau mit [dativ] [something preferably held] gegen [something]" as attacking it with (with nouns reversed).
Understand "hau [something preferably held] gegen [something]" as attacking it with (with nouns reversed).

Understand "brich [something]" as attacking.
Understand "brich [something] ab/auseinander" as attacking.
Understand "brich [something] ab/auseinander mit [dativ] [something preferably held]" as attacking it with.
Understand the command "brech" as "brich".

Understand "zerbrich [something]" as attacking.
Understand "zerbrich [something] mit [dativ] [something preferably held]" as attacking it with.
Understand the commands "vernicht", "zerstoer", "zerschlag", and "zertruemmer" as "zerbrich".

Understand "toet [someone alive]" as attacking.
Understand "toet [someone alive] mit [dativ] [something preferably held]" as attacking it with.
Understand "toet [something]" as attacking.
Understand "toet [something] mit [dativ] [something preferably held]" as attacking it with.
Understand the commands "attackier", "ermord", "mord", "bekaempf", "folter", "quael", "pruegle" and "pruegel" as "toet".

Understand "kaempf mit [dativ] [someone alive]" as attacking.
Understand "kaempf mit [dativ] [something]" as attacking.
Understand "kaempf gegen [someone alive]" as attacking.
Understand "kaempf gegen [something]" as attacking.
Understand "kaempf mit [dativ] [something preferably held] gegen [someone alive]" as attacking it with (with nouns reversed).
Understand "kaempf mit [dativ] [something preferably held] gegen [something]" as attacking it with (with nouns reversed).
Understand "kaempf gegen [someone alive] mit [dativ] [something preferably held]" as attacking it with.
Understand "kaempf gegen [something] mit [dativ] [something preferably held]" as attacking it with.

Understand "wart" or "wart ab" as waiting.
Understand "verharr" or "verweil" as waiting.
Understand "harr aus" as waiting.

Understand "antwort" as vaguely communicating.
Understand "antwort [dativ] [someone alive] [text]" as answering it that.
Understand "antwort zu [dativ] [someone alive] [text]" as answering it that. [04.12.2011]
Understand "antwort [text] zu [dativ] [someone alive]" as answering it that (with nouns reversed).
Understand "antwort [dativ] [something] [text]" as answering it that.
Understand "antwort zu [dativ] [something] [text]" as answering it that. [04.12.2011]
Understand "antwort [text] zu [dativ] [something]" as answering it that (with nouns reversed).
Understand the commands "sag" and "schrei" and "beantwort" as "antwort".

Understand "red" as vaguely communicating.
Understand "red mit/zu [dativ] [someone alive] ueber [text]" as telling it about. [*]
Understand "red mit/zu [dativ] [something] ueber [text]" as telling it about. [*]
Understand "red mit/zu [dativ] [someone alive]" as telling it about. [*]
Understand "red mit/zu [dativ] [something]" as telling it about. [*]
Understand "red [someone alive] ueber [text] an" as telling it about.
Understand "red [something] ueber [text] an" as telling it about.
Understand "red ueber [text] mit/zu [dativ] [someone alive]" as telling it about (with nouns reversed). [*]
Understand "red ueber [text] mit/zu [dativ] [something]" as telling it about (with nouns reversed). [*]
Understand the commands "sprech" and "sprich" and "schwatz" and "schwaetz" as "red".

Understand "erzaehl" as vaguely communicating.
Understand "erzaehl [dativ] [someone alive] ueber/von [text]" as telling it about.
Understand "erzaehl [dativ] [something] ueber/von [text]" as telling it about.
Understand the commands "unterricht" and "bericht" and "erklaer" as "erzaehl".

Understand "frag" as vaguely communicating.
Understand "frag [someone alive] ueber/zu/nach/ob [text]" as asking it about.
Understand "frag [someone alive] ueber/zu/nach/ob [text] aus" as asking it about.
Understand "frag [something] ueber/zu/nach/ob [text]" as asking it about.
Understand "frag [something] ueber/zu/nach/ob [text] aus" as asking it about.
Understand the command "befrag" as "frag".

Understand "bitt [someone] um [something]" as asking it for.

Understand "iss [something preferably held]" as eating.
Understand the commands "ess" and "friss" and "verspeis" and "verzehr" as "iss".

Understand "schlaf" or "schlaf ein" as sleeping.
Understand the commands "nick" and "schlummer" and "does" as "schlaf".

Understand "streif [something]" as touching.
Understand "streif [a worn thing] ab" as taking off.
Understand "streif [something] ab" as taking off.

[ +++ Singen wurde aus neueren Inform 7 Versionen entfernt ]
Singing is an action applying to nothing.
The Singing action translates into Inter as "Sing".

Check an actor singing (this is the block singing rule):
	say "Du singst. Nicht sehr schön." (A).

Understand "pfeif", "traeller", "jodel", "jodle" or "sing" as singing.

Understand "kletter [something] hoch" as climbing. [ +++ 04.06.2023 damit "kletter Leiter hoch" erkannt wird ]
Understand "kletter auf [something] [darauf]" as climbing.
Understand "kletter ueber [something] [darueber]" as climbing.
Understand "kletter [something] [darauf]" as climbing. [ +++ 04.06.2023 damit "kletter Leiter rauf" erkannt wird ]
Understand "kletter [noun darauf]" as climbing.
Understand "kletter in [something] [hinein]" as entering.
Understand "kletter [noun hinein]" as entering.
Understand "kletter heraus/raus/aus/ab" as exiting.
Understand "kletter [noun heraus]" as exiting from.
Understand "kletter aus [dativ] [something] [heraus]" as exiting from.
Understand "kletter [herunter]" as exiting. [ +++ 23.04.2023 "runter/herunter" durch Token ersetzt ]
Understand "kletter [something] [herunter]" as getting off. [ +++ 04.06.2023 damit "kletter Leiter runter" erkannt wird ]
Understand "kletter [noun herunter]" as getting off.
Understand "kletter von [dativ] [something] [herunter]" as getting off.
Understand the commands "klettre" as "kletter".

Understand "steig [something] hoch" as entering.
Understand "steig auf [something] [darauf]" as entering.
Understand "steig ueber [something] [darueber]" as entering.
Understand "steig [something] [darauf]" as climbing. [ +++ 04.06.2023 damit "steig Leiter rauf" erkannt wird ]
Understand "steig [noun darauf]" as entering.
Understand "steig in [something] [hinein]" as entering.
Understand "steig [noun hinein]" as entering.
Understand "steig aus/ab" as exiting. [ +++ 04.06.2023 "hinunter/herab/hinab" ergänzt]
Understand "steig [herunter]" as exiting. [ +++ 04.06.2023 damit "steig runter" erkannt wird ]
Understand "steig [noun heraus]" as exiting from.
Understand "steig aus [dativ] [something] [heraus]" as exiting from.
Understand "steig [something] [herunter]" as getting off. [ +++ 04.06.2023 damit "steig Leiter runter" erkannt wird ]
Understand "steig [noun herunter]" as getting off.
Understand "steig von [dativ] [something] [herunter]" as getting off.

Understand "erklimm [something]" as climbing.
Understand the command "erkletter" as "erklimm".

Understand "kauf [something]" as buying.
Understand the commands "erwerb" and "erwirb" as "kauf".

Understand "quetsch [something]" as squeezing.
Understand the commands "zerdrueck" and "zerquetsch" as "quetsch".

Understand "schwing [dich] auf [something] [darauf]" as swinging.
Understand "schwing [dich] in [something] [hinein]" as swinging.
Understand "schwing auf/an [something]" as swinging.
Understand "schwing [dich] [noun darauf]" as swinging.
Understand "schwing [something]" as waving.
Understand "schwing mit [dativ] [something]" as waving.
Understand "schwing mit hand" or "schwing mit der hand" as waving hands.
Understand "schwing mit haende" or "schwing mit den haende" as waving hands.
Understand the commands "schwenk", "wedel", "wedle", "baumle", and "baumel" as "schwing".

Understand "wach" or "wach auf" or "erwach" as waking up.

Understand "weck [someone]" or "weck [someone] auf" as waking.
Understand the command "erweck" as "weck".

Understand "kuess [someone]" as kissing.
Understand the commands "umarm" and "lieb" and "streichel" and "streichle" and "knutsch" and "liebkos" as "kuess".

Understand "denk" or "denk nach" as thinking.
Understand "denk ueber [text] nach" as thinking about.
Understand "denk nach ueber [text]" as thinking about.
Understand "denk an [text]" as thinking about.

Understand "erinner [dich] an [text]" as thinking about.
Understand "erinner [text]" as thinking about.

Understand "riech" as smelling.
Understand "riech [something]" as smelling.
Understand "riech an [dativ] [something]" as smelling.
Understand "riech [noun daran]" as smelling.
Understand the commands "schnueffle", "schnueffel", "schnupper", "beschnupper", "beschnueffel" and "beschnueffle" as "riech".

Understand "hoer" as listening to.
Understand "hoer [something]" as listening to.
Understand "hoer an [dativ] [something]" as listening to.
Understand "hoer [dativ] [something] zu" as listening to.
Understand "hoer [noun daran]" as listening to.
Understand the commands "horch" and "lausch" and "belausch" as "hoer".

Understand "schmeck [something]" as tasting.
Understand "schmeck an [dativ] [something]" as tasting.
Understand "schmeck [noun daran]" as tasting.
Understand the commands "leck" and "kost" and "probier" as "schmeck".

Understand "beruehr [something]" as touching.
Understand the commands "ertast" and "befuehl" and "betast" as "beruehr".

Understand "fuehl [something]" as touching.
Understand "fuehl an/ueber/nach [dativ] [something]" as touching.
Understand "fuehl [something] an" as touching.
Understand the command "tast" as "fuehl".

Understand "wisch [something]" as rubbing.
Understand "wisch an [dativ] [something]" as rubbing.
Understand "wisch [something] mit [dativ] [something preferably held] [weg]" as rubbing it with. [ +++ 30.05.2023 "[ab]" => "[weg]"]
Understand "wisch mit [dativ] [something preferably held] [something] [weg]" as rubbing it with.
Understand the commands "reinig", "putz", "reib", "schrubb", "saeuber", "polier", "glaett", "schmirgel", "schmirgle" and "buerst" as "wisch".

Understand "bind [something]" as tying it to.
Understand "bind [something] an [something]" as tying it to.
Understand "bind [something] mit [dativ] [something]" as tying it to.

Understand "zuend [something] an" as burning.
Understand "zuend [something] mit [dativ] [something preferably held] an" as burning it with.
Understand "zuend mit [dativ] [something preferably held] [something] an" as burning it with (with nouns reversed).

Understand "entzuend [something] mit [dativ] [something preferably held]" as burning it with.
Understand "entzuend mit [dativ] [something preferably held] [something]" as burning it with.
Understand "entzuend [something]" as burning.
Understand the command "entflamm" and "verbrenn" as "entzuend".

Understand "brenn [something] an/ab/nieder" as burning.
Understand "brenn [something] mit [dativ] [something preferably held] an/ab/nieder" as burning it with.
Understand "brenn mit [dativ] [something preferably held] [something] an/ab/nieder" as burning it with (with nouns reversed).
Understand "brenn [something] mit [dativ] [something preferably held]" as burning it with.
Understand "brenn mit [dativ] [something preferably held] [something]" as burning it with (with nouns reversed).

Understand "trink [something]" as drinking.
Understand "trink [something] aus/leer" as drinking.
Understand the command "sauf" and "schluerf" and "schluck" as "trink".

Understand "schneid [someone alive]" as attacking.
Understand "schneid [something]" as cutting.
Understand the commands "trenn" and "spalt" and "teil" and "zertrenn" and "durchschneid" and "zerteil" and "zerschneid" as "schneid".

Understand "spring" or "spring hoch/herum/umher" as jumping.
Understand the command "huepf" as "spring".


Section - Saying - Names with definite articles

To say Der (obj - object): (- print (GDer) {obj}; -).
To say Des (obj - object): (- print (GDes) {obj}; -).
To say Dem (obj - object): (- print (GDem) {obj}; -).
To say Den (obj - object): (- print (GDen) {obj}; -).

To say der (obj - object): (- print (der) {obj}; -).
To say des (obj - object): (- print (des) {obj}; -).
To say dem (obj - object): (- print (dem) {obj}; -).
To say den (obj - object): (- print (den) {obj}; -).


Section - Saying - Names with indefinite articles

To say Ein (obj - object): (- print (GEin) {obj}; -).
To say Eines (obj - object): (- print (GEines) {obj}; -).
To say Einem (obj - object): (- print (GEinem) {obj}; -).
To say Einen (obj - object): (- print (GEinen) {obj}; -).

To say ein (obj - object): (- print (ein) {obj}; -).
To say eines (obj - object): (- print (eines) {obj}; -).
To say einem (obj - object): (- print (einem) {obj}; -).
To say einen (obj - object): (- print (einen) {obj}; -).

To say Kein (obj - object): (- print (GKein) {obj}; -).
To say Keines (obj - object): (- print (GKeines) {obj}; -).
To say Keinem (obj - object): (- print (GKeinem) {obj}; -).
To say Keinen (obj - object): (- print (GKeinen) {obj}; -).

To say kein (obj - object): (- print (kein) {obj}; -).
To say keines (obj - object): (- print (keines) {obj}; -).
To say keinem (obj - object): (- print (keinem) {obj}; -).
To say keinen (obj - object): (- print (keinen) {obj}; -).


Section - Saying - Names without articles

To say (obj - an object): (- WithoutArt({obj}); -).

To say (obj - an object) with (C - a case): (- WithoutArt({obj}, {C}-1); -).

To say (obj - an object) definite with (C - a case): (- WithoutArt({obj}, {C}-1, 1); -).
To say (obj - an object) indefinite with (C - a case): (- WithoutArt({obj}, {C}-1, 2); -).

Section - Saying - Personal pronouns

The previously named noun is an object that varies.
The previously named noun variable translates into Inter as "pnn".

[Die I6-Variable pnn (previously named noun in I7) wird in |STANDARD_NAME_PRINTING_R|,
den Print-Routinen oder direkt vor der Ausgabe auf das angesprochene Objekt gesetzt.
Die Textersetzungen, die sich auf das letzte Objekt beziehen, benutzen pnn
für die Ausgabe.]

[ mit angegebenem Objekt: ]

To say Er (obj - object): (- print (GEr) {obj}; -).
To say Seiner (obj - object): (- print (GSeiner) {obj}; -).
To say Ihm (obj - object): (- print (GIhm) {obj}; -).
To say Ihn (obj - object): (- print (GIhn) {obj}; -).

[ aufs zuletzt genannte Hauptwort bezogen: ]

To say Er: (- print (GEr) pnn; -).
To say Seiner: (- print (GSeiner) pnn; -).
To say Ihm: (- print (GIhm) pnn; -).
To say Ihn: (- print (GIhn) pnn; -).

[ mit angegebenem Objekt: ]

To say er (obj - object): (- print (er) {obj}; -).
To say seiner (obj - object): (- print (seiner) {obj}; -).
To say ihm (obj - object): (- print (ihm) {obj}; -).
To say ihn (obj - object): (- print (ihn) {obj}; -).

[ aufs zuletzt genannte Hauptwort bezogen: ]

To say er: (- print (er) pnn; -).
To say seiner: (- print (seiner) pnn; -).
To say ihm: (- print (ihm) pnn; -).
To say ihn: (- print (ihn) pnn; -).

Section - Saying - Auxiliary verbs

[ mit angegebenem Objekt: ]

To say ist (obj - object): (- print (ist) {obj}; -).
To say hat (obj - object): (- print (hat) {obj}; -).
To say wird (obj - object): (- print (wird) {obj}; -).

[ aufs zuletzt genannte Hauptwort bezogen: ]

To say ist: (- print (ist) pnn; -).
To say hat: (- print (hat) pnn; -).
To say wird: (- print (wird) pnn; -).

Section - Saying - Verbs

To say betritt: (- print (betritt) pnn; -).
To say gibt: (- print (gibt) pnn; -).
To say isst: (- print (isst) pnn; -).
To say kann: (- print (kann) pnn; -).
To say mag: (- print (mag) pnn; -).
To say nimmt: (- print (nimmt) pnn; -).
To say sieht: (- print (sieht) pnn -).
To say trägt: (- print (traegt) pnn; -).
To say verlässt: (- print (verlaesst) pnn; -).


Section - Saying - Prepositions

To say Auf (obj - object): (- print (GAuf) {obj}; -).
To say Von (obj - object): (- print (GVon) {obj}; -).

To say auf (obj - object): (- print (auf) {obj}; -).
To say von (obj - object): (- print (von) {obj}; -).

To say Auf: (- print (GAuf) pnn; -).
To say Von: (- print (GVon) pnn; -).

To say auf: (- print (auf) pnn; -).
To say von: (- print (von) pnn; -).


Section - Saying - The universal suffix for all inflected adjectives

To say ^: (- print (string) AdjectiveEndings-->AdjectiveEndingsIndex; -). [ war @00 ]


Section - Saying - Suffixes (Verbs)

[ mit angegebenem Objekt: ]

To say t (obj - object): (- print (_t) {obj}; -).
To say et (obj - object): (- print (_et) {obj}; -).
To say e (obj - object): (- print (_e) {obj}; -).

[ aufs zuletzt genannte Hauptwort bezogen: ]

To say t: (- print (_t) pnn; -).
To say et: (- print (_et) pnn; -).
To say e: (- print (_e) pnn; -).


Section - Saying - Suffixes (Nouns)

To say -n:  (- print (string) SubstantiveEndings_n-->SubstantiveEndingsIndex;  -). [ war @01 ]
To say -en: (- print (string) SubstantiveEndings_en-->SubstantiveEndingsIndex; -). [ war @02 ]
To say -s:  (- print (string) SubstantiveEndings_s-->SubstantiveEndingsIndex;  -). [ war @03 ]
To say -es: (- print (string) SubstantiveEndings_es-->SubstantiveEndingsIndex; -). [ war @04 ]


Section - Saying - Definite articles in proper names

To say das: (- print (string) LanguageArticles-->(1 + short_name_case * 4); -).
To say der: (- print (string) LanguageArticles-->(2 + short_name_case * 4); -).
To say die: (- print (string) LanguageArticles-->(3 + short_name_case * 4); -).
To say die plural: (- print (string) LanguageArticles-->(0 + short_name_case * 4); -).
To say -der-/-die-/-das- (obj - object):
	(- SetPreviouslyNamedNoun({obj}); print (string) LanguageArticles-->(Gender({obj}) + short_name_case * 4); -).


Section - Saying - Relative pronouns

[ mit angegebenem Objekt: ]

To say *der* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Nom * 4); -).
To say *dessen-deren* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Gen * 4); -).
To say *dessen-derer* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Gen * 4 + 12); -).
To say *dem* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Dat * 4); -).
To say *den* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Akk * 4); -).

To say *welcher* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Nom * 4 + 20); -).
To say *welchem* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Dat * 4 + 20); -).
To say *welchen* (obj - object): (- SetPreviouslyNamedNoun({obj}); print (string) LanguageRelativePronouns-->(Gender({obj}) + Akk * 4 + 20); -).

[ aufs zuletzt genannte Hauptwort bezogen: ]

To say *der*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Nom * 4); -).
To say *dessen-deren*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Gen * 4); -).
To say *dessen-derer*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Gen * 4 + 12); -).
To say *dem*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Dat * 4); -).
To say *den*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Akk * 4); -).

To say *welcher*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Nom * 4 + 20); -).
To say *welchem*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Dat * 4 + 20); -).
To say *welchen*: (- print (string) LanguageRelativePronouns-->(Gender(pnn) + Akk * 4 + 20); -).


Section - Saying - Capitalised "Du"

[ +++ Die use option "CAPITAL_YOU_OPTION" in eine globale Variable "CAPITAL_YOU" umwandeln. ]
Include (-
#IfDef CAPITAL_YOU_OPTION;
Global CAPITAL_YOU = true;
#Ifnot;
Global CAPITAL_YOU = false;
#EndIf;
-).

To say du: (- if (CAPITAL_YOU) print "Du"; else print "du"; -). [ war @20 ]
To say dir: (- if (CAPITAL_YOU) print "Dir"; else print "dir"; -). [ war @21 ]
To say dich: (- print (dich) -). [ war @22 ]
Include (- [ dich; if (CAPITAL_YOU) print "Dich"; else print "dich"; ]; -).

To say dein: (- if (CAPITAL_YOU) print "Dein"; else print "dein"; -). [ war @23 ]
To say deine: (- if (CAPITAL_YOU) print "Deine"; else print "deine"; -). [ war @24 ]

To say deines: (- if (CAPITAL_YOU) print "Deines"; else print "deines"; -). [ war @25 ]
To say deiner: (- if (CAPITAL_YOU) print "Deiner"; else print "deiner"; -). [ war @26 ]

To say deinem: (- if (CAPITAL_YOU) print "Deinem"; else print "deinem"; -). [ war @27 ]
To say deinen: (- if (CAPITAL_YOU) print "Deinen"; else print "deinen"; -). [ war @28 ]


Section - Saying - Debug messages

[ Debug-Meldungen kennzeichnen: Idee von Erik Temple ]

To say debug: (- #ifdef DEBUG; #ifdef DEBUG_MESSAGES; -).
To say end debug: (-  #endif; #endif; RunParagraphOn(); -).


Section - Saying - Saying lists of things with case

To list the contents of (O - object) with (C - a case),
	with newlines,
	indented,
	giving inventory information,
	as a sentence,
	including contents,
	including all contents,
	tersely,
	giving brief inventory information,
	using the definite article,
	listing marked items only,
	prefacing with is/are,
	not listing concealed items,
	suppressing all articles
	and/or with extra indentation:
	(- WriteListFromCase(child({O}), {phrase options}, {C}-1); -).


To say a list of (OS - description of objects) with (C - a case): (-
	 	objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		WriteListOfMarkedObjects(ENGLISH_BIT, {C}-1);
	-).

To say A list of (OS - description of objects) with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		TEXT_TY_Say_Capitalised((+ "[list-writer list of marked objects with C]" +));
	-).

To say list-writer list of marked objects with (C - a case): (-
	 	WriteListOfMarkedObjects(ENGLISH_BIT, {C}-1);
	-).

To say list of (OS - description of objects) with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		WriteListOfMarkedObjects(ENGLISH_BIT+NOARTICLE_BIT, {C}-1);
	-).

To say the list of (OS - description of objects) with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		WriteListOfMarkedObjects(ENGLISH_BIT+DEFART_BIT, {C}-1);
	-).

To say The list of (OS - description of objects) with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		TEXT_TY_Say_Capitalised((+ "[list-writer articled list of marked objects with C]" +));
	-).

To say list-writer articled list of marked objects with (C - a case): (-
	 	WriteListOfMarkedObjects(ENGLISH_BIT+DEFART_BIT+CFIRSTART_BIT {C}-1);
	-).

To say is-are a list of (OS - description of objects) with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		WriteListOfMarkedObjects(ENGLISH_BIT+ISARE_BIT, {C}-1);
	-).

To say is-are list of (OS - description of objects) with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		WriteListOfMarkedObjects(ENGLISH_BIT+ISARE_BIT+NOARTICLE_BIT, {C}-1);
	-).

To say is-are the list of (OS - description of objects) with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		WriteListOfMarkedObjects(ENGLISH_BIT+DEFART_BIT+ISARE_BIT, {C}-1);
	-).

To say a list of (OS - description of objects) including contents with (C - a case): (-
		objectloop({-my:1} ofclass Object)
			if ({-matches-description:1:OS})
				give {-my:1} workflag2;
			else
				give {-my:1} ~workflag2;
		WriteListOfMarkedObjects(ENGLISH_BIT+RECURSE_BIT+PARTINV_BIT+
			TERSE_BIT+CONCEAL_BIT, {C}-1);
	-).




Section - Replaced standard rules

The German print standard inventory rule is listed instead of
the print standard inventory rule in the carry out taking inventory rules.

Carry out taking inventory (this is the German print standard inventory rule):
	if inventory style is wide inventory: [ Inventory als Satz ]
		say "Du hast ";
		list the contents of the player with accusative case, as a sentence, including contents,
			tersely, giving inventory information;
		say " bei [dir].";
		if the non-nested lists option is active :
			write the inventory sublists;
	otherwise: [ Inventory als Liste ]
		say "Du hast Folgendes bei [dir]:[line break]" (A);
		list the contents of the player with accusative case, with newlines, indented, including contents,
			giving inventory information, with extra indentation.

The German announce items from multiple object lists rule is listed instead of
the announce items from multiple object lists rule in the action-processing rules.

[Für Multi-Aktionen (z.B. NIMM ALLES): Damit es in der Liste der Gegenstände nicht
heißt "grüne Ball: In Ordnung.", sondern "grüner Ball: In Ordnung."]

This is the German announce items from multiple object lists rule:
	if the current item from the multiple object list is not nothing,
		say "[current item from the multiple object list with nominative case]: [run paragraph on]".


[ Raumbeschreibungen anpassen ]

[20.07.2013: room description heading rule ersetzt;
Bei UNDO konnte es vorkommen, dass der Raumname in einem
falschen Kasus angegeben wurde.]

The German room description heading rule is listed instead of
the room description heading rule in the carry out looking rulebook.

To issue the/-- capitalised room description for the/-- (O - an object):
	(- RunCapitalised(WithoutArt, {O}, Nom); -).

Carry out looking (this is the German room description heading rule):
	say bold type;
	if the visibility level count is 0:
		begin the printing the name of a dark room activity;
		if handling the printing the name of a dark room activity:
			say "Dunkelheit" (A);
		end the printing the name of a dark room activity;
	otherwise if the visibility ceiling is the location:
		issue capitalised room description for visibility ceiling;  [ +++ Raumbeschreibungen immer groß ]
		[say "[visibility ceiling with nominative case]";]
	otherwise:
		say "[Der visibility ceiling]";
	say roman type;
	let intermediate level be the visibility-holder of the actor;
	repeat with intermediate level count running from 2 to the visibility level count:
		if the intermediate level is a supporter or the intermediate level is an animal:
			say " (auf [dem intermediate level])" (B);
		otherwise:
			say " (in [dem intermediate level])" (C);
		let the intermediate level be the visibility-holder of the intermediate level;
	say line break;
	say run paragraph on with special look spacing.


The German set pronouns from items in room descriptions rule is listed instead of
the set pronouns from items in room descriptions rule in the for printing a locale paragraph about rulebook.

[Hier die Option "Use manual pronouns." berücksichtigen. Die Pronomen werden bei der Ausgabe von Objekten in der Raumbeschreibung nicht automatisch gesetzt, wenn diese Option gewählt wurde.]

For printing a locale paragraph about a thing (called the item)
	(this is the German set pronouns from items in room descriptions rule):
	if the item is not mentioned and the manual pronouns option is not active, set pronouns from the item;
	continue the activity.

The German-you-can-also-see rule is listed instead of
the you-can-also-see rule in the for printing the locale description rulebook.

For printing the locale description (this is the German-you-can-also-see rule):
	let the domain be the parameter-object;
	let the mentionable count be 0;
	repeat with item running through things:
		now the item is not marked for listing;
	repeat through the Table of Locale Priorities:
		if the locale description priority entry is greater than 0,
			now the notable-object entry is marked for listing;
		increase the mentionable count by 1;
	if the mentionable count is greater than 0:
		repeat with item running through things:
			if the item is mentioned:
				now the item is not marked for listing;
		begin the listing nondescript items activity with the domain;
		if the number of marked for listing things is 0:
			abandon the listing nondescript items activity with the domain;
		otherwise:
			if handling the listing nondescript items activity with the domain:
				if the domain is the location:
					say "Du siehst hier " (A);
				otherwise if the domain is a supporter or the domain is an animal:
					say "Auf [dem domain] siehst [du] " (B);
				otherwise:
					say "In [dem domain] siehst [du] " (C);
				if the locale paragraph count is greater than 0:
					say "außerdem " (D);
				otherwise:
					say "" (E);
				let the common holder be nothing;
				let contents form of list be true;
				repeat with list item running through marked for listing things:
					if the holder of the list item is not the common holder:
						if the common holder is nothing,
							now the common holder is the holder of the list item;
						otherwise now contents form of list is false;
					if the list item is mentioned, now the list item is not marked for listing;
				filter list recursion to unmentioned things;
				if contents form of list is true and the common holder is not nothing,
					list the contents of the common holder with accusative case, as a sentence, including contents,
						giving brief inventory information, tersely, not listing
						concealed items, listing marked items only;
				otherwise say "[a list of marked for listing things including contents with accusative case]";
				if the domain is the location, say "" (F);
				say ".[paragraph break]";
				write the sublists; [ Non-nested lists ]
				unfilter list recursion;
			end the listing nondescript items activity with the domain;
	continue the activity.

The German use initial appearance in room descriptions rule is listed instead of
the use initial appearance in room descriptions rule in the for printing a locale paragraph about rulebook.

For printing a locale paragraph about a thing (called the item)
	(this is the German use initial appearance in room descriptions rule):
	if the item is not mentioned:
		if the item provides the property initial appearance and the
			item is not handled and the initial appearance of the item is
			not "":
			increase the locale paragraph count by 1;
			say "[initial appearance of the item]";
			say "[paragraph break]";
			if a locale-supportable thing is on the item:
				repeat with possibility running through things on the item:
					now the possibility is marked for listing;
					if the possibility is mentioned:
						now the possibility is not marked for listing;
				say "Auf [dem item] ";
				list the contents of the item with nominative case, as a sentence, including contents,
					giving brief inventory information, tersely, not listing
					concealed items, prefacing with is/are, listing marked items only;
				say ".[paragraph break]";
				write the sublists; [ Non-nested lists ]
			now the item is mentioned;
	continue the activity.

The German describe what's on scenery supporters in room descriptions rule is listed instead of
the describe what's on scenery supporters in room descriptions rule in the for printing a locale paragraph about rules.

For printing a locale paragraph about a thing (called the item)
	(this is the German describe what's on scenery supporters in room descriptions rule):
	if the item is scenery and the item does not enclose the player:
		if a locale-supportable thing is on the item:
			set pronouns from the item;
			repeat with possibility running through things on the item:
				now the possibility is marked for listing;
				if the possibility is mentioned:
					now the possibility is not marked for listing;
			increase the locale paragraph count by 1;
			say "Auf [dem item] ";
			list the contents of the item with nominative case, as a sentence, including contents, [ +++ im Vergleich zur Original-Regel "with nominative case" hinzugefügt ]
				giving brief inventory information, tersely, not listing
				concealed items, prefacing with is/are, listing marked items only;
			say ".[paragraph break]";
			write the sublists; [ Non-nested lists ]
	continue the activity.


Section - New actions and rules

[Inventar als Liste oder als Satz]

Invstyle is a kind of value. The invstyles are wide inventory and tall inventory.

The inventory style is an invstyle variable. The inventory style is tall inventory.

Wide taking inventory is an action applying to nothing.

Carry out wide taking inventory (this is the print wide inventory rule):
	now the inventory style is wide inventory;
	try taking inventory.

Tall taking inventory is an action applying to nothing.

Carry out tall taking inventory (this is the print tall inventory rule):
	now the inventory style is tall inventory;
	try taking inventory.

[-----------------------------------------------------------------------------]

["zieh [someone] an" geht nicht, weil das held-Token bevorzugt wird.]

[Lösungsvorschlag von Emily Short und JDC: Mit einer gefakten Definition können wir die Reihenfolge der
Grammar-Lines in I6 definieren. Das ist ein Workararound; irgendwann soll es in I7 vielleicht mal
eine Möglichkeit geben, die Reihenfolge der I6-Understand-Zeilen eleganter anzugeben.]

Definition: a person is alive: yes.

Definition: a thing is switchable if it is a device.

[ Dress: ZIEH DICH AN vs. ZIEH SCHUHE AN ]

Dressing is an action applying to one thing.
The Dressing action translates into Inter as "Dress".

[ Undress: ZIEH DICH AUS vs. ZIEH SCHUHE AUS ]

Undressing is an action applying to one thing.
The undressing action translates into Inter as "Undress".

Exiting from is an action applying to one thing.
Check an actor exiting from
	(this is the convert exiting from to exiting rule):
	convert to the exiting action on nothing.

The specification of the exiting from action is "This action converts to the exiting action when an actor tries to exit a supporter or container, e.g. STEIG VOM TISCH HERUNTER."

Closing it with is an action applying to two things.
Check closing it with
	(this is the convert closing it with to closing rule):
	convert to the closing action on the noun.

The specification of the closing it with action is "This action converts to the closing action when an actor tries to close a thing with something, e.g. SCHLIESS DIE KISTE MIT DEM STEMMEISEN."

Rubbing it with is an action applying to two things.
Check rubbing it with
	(this is the convert rubbing it with to rubbing rule):
	convert to the rubbing action on the noun.

The specification of the rubbing it with action is "This action converts to the rubbing action when an actor tries to rub a thing with something, e.g. REIBE DIE LAMPE MIT DEM TUCH."

Attacking it with is an action applying to two things.
Check attacking it with
	(this is the convert attacking it with to attacking rule):
	convert to the attacking action on the noun.

The specification of the attacking it with action is "This action converts to the attacking action when an actor tries to attack somebody with something, e.g. ERSCHLAGE DEN ORK MIT DEM SCHWERT."

Burning it with is an action applying to two things.
Check burning it with
	(this is the convert burning it with to burning rule):
	convert to the burning action on the noun.

The specification of the burning it with action is "This action converts to the burning action when an actor tries to burn a thing with something, e.g. ZÜNDE DEN OFEN MIT DER KERZE AN."

Going into is an action applying to nothing.
Check going into
	(this is the convert going into to going inside rule):
	convert to the going action on inside.

The specification of the going into action is "This action converts to the going action on the inside when commands like GEH REIN or TRITT EIN are used."

Vaguely communicating is an action applying to nothing.
Check vaguely communicating (this is the block vaguely communicating rule):
	say "Bitte gib auch an, was [du] sagen oder fragen möchtest."

The specification of the vaguely communicating action is "This action fires when the player enters communication-related commands missing the interlocutor and/or the topic, e.g. FRAG, REDE, ANTWORTE."

Thinking about is an action applying to one topic.
Check thinking about (this is the block thinking about rule):
	say "Dir fällt jetzt nichts dazu ein.".

The specification of the thinking about action is "This action fires when an actor tries to think of or remember a topic, e.g. DENKE AN DEN LETZTEN URLAUB."

[------------------------------------------------------------------------------]

[Den aktuellen Standort VERLASSEN und BETRACHTEN vgl. Verbendefinition
für "verlass" und "untersuch".]

Location-leaving is an action applying to one object.

Rule for supplying a missing noun when location-leaving (this is the supply current location when location-leaving rule):
	[say "([den location])[command clarification break]";]
	now the noun is the location.

Carry out location-leaving (this is the leave current location rule):
	let N be 0;
	let target be nothing;
	repeat with D running through directions:
		if room-or-door D from the location is not nothing:
			increase N by 1;
			now target is D;
	if N is 0, say "Es gibt hier keine offensichtlichen Ausgänge." (A);
	if N is 1:
		now the noun is the target;
		say "(nach [noun])[line break]" (B);
		convert to the going action on the noun;
	if N is greater than 1, say "Es gibt mehrere Ausgänge. Bitte sage genau, wohin [du] gehen möchtest." (C);

The specification of the location-leaving action is "This action enables the player to leave the current location by using the verb 'verlass'  if there is only one exit."

Instead of examining a room (this is the convert examining a room into looking rule):
	try looking.


[Die korrekte Priorisierung der [dich]-Token funktioniert nicht immer, da die
Reihenfolge der I6-Grammar-Lines noch nicht explizit angegeben werden kann.
Deshalb gibt es erstmal Krücken-Check-Rules, die das umgehen.]

[>LEG DICH AUF DAS SOFA]

Check an actor putting the player on
	(this is the convert putting the player on something into entering rule):
	convert to the entering action on the second noun.

[>LEG DICH IN DIE WANNE]

Check an actor inserting the player into
	(this is the convert inserting the player into something into entering rule):
	convert to the entering action on the second noun.

[------------------------------------------------------------------------------]

[Die Pronominaladverbien [noun heraus], usw. ergänzen das unvollständige
Satzmuster immer um das zuletzt angesprochene Objekt, das keine Person
ist. Beispiel:

>durchsuche schrank
In dem Schrank findest du eine Socke.

>nimm socke heraus [wird als "nimm socke aus dem schrank" verarbeitet]
Du nimmst die Socke aus dem Schrank.

Für den Parser ist das eine klare Sache, jedoch nicht unbedingt für den Spieler.
Der hat vielleicht gerade in einer Raumbeschreibung gelesen: "In dem Holster steckt
eine Pistole." und versucht nun

>nimm pistole heraus
Die Pistole ist aber gar nicht in der Socke.

obwohl das zuletzt angesprochene Objekt nicht der Holster war.

Die folgende Check-Rule versucht, ein mögliches Missverständnis aufzulösen
und gibt zur Verdeutlichung in Klammern aus, um welches Objekt die
Anweisung ergänzt wurde, wenn das Antezedens des Adverbialpronomens geändert
wurde.]


Check an actor removing something from
when a noun has been supplied by a pronominal adverb
(this is the adjust the pronominal adverb reference when removing rule):
	if the noun is not in anything and the noun is not on anything:
		say "[Der noun] [ist] aber gar nicht auf oder in irgend etwas.";
		stop the action;
	otherwise:
		let P be the holder of the noun;
		if P is not the second noun:
			if P is a supporter, say "(von [dem holder of the noun])[command clarification break]";
			if P is a container, say "(aus [dem holder of the noun])[command clarification break]";
			reset the pronominal adverb;
			try removing the noun from P;
			rule fails;


Section - Special room features

Understand "Ort [m]", "Platz [m]", "Raum [m]", "Standort [m]" and "Umgebung [f]" as "[basic-room-synonyms]".
Understand "[basic-room-synonyms]" as a room.

Examining is allowing wide scope.
Location-leaving is allowing wide scope.
Smelling is allowing wide scope.

After deciding the scope of the player while allowing wide scope (this is the location visibility rule):
	place the location in scope.


Section - Compound Heads and Compound Tails

Table of Compound Heads
head	n
""	0		[ +++ Platzhalter]



Table of Compound Tails
tail	n
""	0		[ +++ Platzhalter]


Section - German Final question options (in place of Section 6 - Final question options in Standard Rules by Graham Nelson)

Table of Final Question Options
final question wording								only if victorious	topic		final response rule					final response activity
"einen NEUSTART"									false				"neustart"	immediately restart the VM rule		--
"einen Spielstand LADEN"							false				"laden"		immediately restore saved game rule	--
"im NACHWORT über lustige Dinge im Spiel erfahren"	true				"nachwort"	--									amusing a victorious player
"das Spiel BeENDEn"									false				"ende"		immediately quit rule				--
--													false				"undo"		immediately undo rule				--



Section - Check noun declinations (Not for release)

Declining is an action out of world applying to one object.

Understand "deklinier [any thing]" as declining.
Understand "deklinier [any room]" as declining.

Report declining (this is the standard report declining rule):
	say "[Der noun], [des noun], [dem noun], [den noun].[line break][Ein noun], [eines noun], [einem noun], [einen noun]."


Section - Library Checking (Not for release)


To check the/-- library definitions: (- PerformLibcheckAll(0, 1); -).
To silently check the/-- library definitions: (- PerformLibcheckAll(1, 1); -).


Library checking is an action out of world.
Carry out library checking: check library definitions.
Understand "libcheck" as library checking.

When play begins (this is the perform initial libcheck rule):
	if the skip libcheck option is inactive, silently check the library definitions.


[Ignore list to be continued by the author ...]

Table of blessed verb forms
Verb
"ausgaenge"

When play begins (this is the initialise debug synonyms table rule):
	initialise the auxiliary synonyms.

To initialise the/-- auxiliary synonyms: (- InitialiseLanguageSynonyms2(); -).

The initialise debug synonyms table rule is listed first in the when play begins rulebook.


Section - Tables of special vocabulary

[Diese Tabelle kann der Autor mit Infinitiven von Verben, aus denen sich nicht
ohne Weiteres der Infinitiv rekonstruieren lässt, fortführen.]

Table of infinitives
Verb		Infinitive
""			""

[Diese Tabelle kann mit Verbformen, die auch als Objektsynonyme verwendet
werden können, fortgeführt werden. Kommandos, die mit diesen
Verben beginnen, werden auf jeden Fall in die Infinitiv-Prüfung geschickt.]

Table of verb-noun collisions
Verb
""


Section - German assembly components workaround

A thing can be s-terminated.

Rule for printing the name of a thing (called the item)
when the item is part of a person [and the item is proper-named]
(this is the German printing the name of a body part rule):
	let C be the current case;
	if the holder of the item is the player:
		if C is:
			-- nominative case:
				if the gender of the item is:
					-- Mehrzahl: say "[deine]";
					-- männlich: say "[dein]";
					-- weiblich: say "[deine]";
					-- sächlich: say "[dein]";
			-- genitive case:
				if the gender of the item is:
					-- Mehrzahl: say "[deiner]";
					-- männlich: say "[deines]";
					-- weiblich: say "[deiner]";
					-- sächlich: say "[deines]";
			-- dative case:
				if the gender of the item is:
					-- Mehrzahl: say "[deinen]";
					-- männlich: say "[deinem]";
					-- weiblich: say "[deiner]";
					-- sächlich: say "[deinem]";
			-- accusative case:
				if the gender of the item is:
					-- Mehrzahl: say "[deine]";
					-- männlich: say "[deinen]";
					-- weiblich: say "[deine]";
					-- sächlich: say "[dein]";
		set definite-mode suffixes from the item with C;
		say " [printed name of item]";
	otherwise:
		if the holder of the item is proper-named:
			set bare-mode suffixes from the item with C;
			say "[holder of item][if holder of item is not s-terminated]s[otherwise]['][end if] ";
			now the previously named noun is the item;
			say "[printed name of item]";
		otherwise:
			set definite-mode suffixes from the item with C;
			say "[printed name of item] [des holder of item]";
	now the previously named noun is the item;



Part - Translations of built-in extensions


Section - German Rideable Vehicles (for use with Rideable Vehicles by Graham Nelson)

[
Rideable Vehicles by Graham Nelson:
    can't mount when mounted on an animal rule response (A): "[We] [are] already riding [the steed]."
    can't mount when mounted on a vehicle rule response (A): "[We] [are] already riding [the conveyance]."
    can't mount something unrideable rule response (A): "[The noun] [cannot] be ridden."
    standard report mounting rule response (A): "[We] [mount] [the noun]."
    standard report mounting rule response (B): "[The actor] [mount] [the noun]."
    mounting excuses rule response (A): "[The person asked] [are] already riding [the steed]."
    mounting excuses rule response (B): "[The person asked] [are] already riding [the conveyance]."
    mounting excuses rule response (C): "[The noun] [cannot] be ridden."
    can't dismount when not mounted rule response (A): "[We] [are] not riding anything."
    standard report dismounting rule response (A): "[We] [dismount] [the noun].[line break][run paragraph on]"
    standard report dismounting rule response (B): "[The actor] [dismount] [the noun]."
    dismounting excuses rule response (A): "[The person asked] [are] not riding anything."
]


Chapter - German Locksmith (for use with Locksmith by Emily Short)

Section Texts

The opening doors before entering rule response (A) is "(Du öffnest zuerst [den blocking door].)[command clarification break]".
	[war "(first opening [the blocking door])[command clarification break]"]
The closing doors before locking rule response (A) is "(Du schließt zuerst [den door ajar].)[command clarification break]".
	[war "(first closing [the door ajar])[command clarification break]"]
The closing doors before locking keylessly rule response (A) is "(Du schließt zuerst [den door ajar].)[command clarification break]".
	[war "(first closing [the door ajar])[command clarification break]"]
The unlocking before opening rule response (A) is "(Du schließt [den sealed chest] zuerst auf.)[command clarification break]".
	[war "(first unlocking [the sealed chest])[command clarification break]"]
The standard printing key lack rule response (A) is "Du hast keinen Schlüssel, der zu [dem locked-thing] passt.".
	[war "[We] [lack] a key that fits [the locked-thing]."]
The right second rule response (A) is "[Der second noun] [if second noun is plural-named]passen[otherwise]passt[end if] nicht für [den noun].".
	[war "[The second noun] [do not fit] [the noun]."]
The standard keylessly unlocking rule response (A) is "(mit [dem key unlocked with])[command clarification break]".
	[war "(with [the key unlocked with])[command clarification break]"]
The standard keylessly locking rule response (A) is "(mit [dem key locked with])[command clarification break]".
	[war "(with [the key locked with])[command clarification break]"]
The identify passkeys in inventory rule response (A) is " (für [the list of things unbolted by the item with accusative case])".
	[war " (which [open] [the list of things unbolted by the item])"]
The passkey description rule response (A) is "[Der noun] öffne[t] [the list of things unbolted by the noun with accusative case].".
	[war "[The noun] [unlock] [the list of things unbolted by the noun]."]
The limiting keychains rule response (A) is "[Der noun] [ist] kein Schlüssel.".
	[war "[The noun] [are] not a key."]
The noun must be accessible rule response (A) is "Ohne [den noun] kannst [du] nichts machen.".
	[war "Without holding [the noun], [we] [can] do nothing."]
The second noun must be accessible rule response (A) is "Ohne [den noun] kannst [du] nichts machen.".
	[war "Without holding [the second noun], [we] [can] do nothing."]

Section Debugging Texts (Not for release)

The lock debugging rule response (A) is "Du schließt [den item] auf.".
	[war "Unlocking [the item]."]
The report universal unlocking rule response (A) is "Ein lautes Klicken bestätigt [dir], dass alles im Spiel entsperrt wurde.".
	[war "A loud stereophonic click assures you that everything in the game has been unlocked."]

Section Understand Definitions

[Volume 1 - Automatic locking and unlocking ...]

[Part 2 - Unlocking]

[Section 1 - Regular unlocking]

Understand the command "unlock" as something new.
Understand the commands "open" and "uncover" and "unwrap" as something new.

Understand the commands "schliess" and "sperr" as something new.
Understand the command "oeffne" as something new.

Understand the commands "verriegel", "verriegle" and "versperr" as something new.


Understand "schliess [something] mit [dativ] [something] auf" as unlocking it with.
Understand "schliess [something] auf mit [dativ] [something]" as unlocking it with.
Understand "schliess [a locked lockable thing] mit [dativ] [something] auf" as unlocking it with.
Understand "schliess [a locked lockable thing] auf mit [dativ] [something]" as unlocking it with.
Understand "schliess [a lockable thing] mit [dativ] [something] auf" as unlocking it with.
Understand "schliess [a lockable thing] auf mit [dativ] [something]" as unlocking it with.
Understand the command "sperr" as "schliess".

Understand "oeffne [something]" as opening.
Understand "oeffne [something] mit [dativ] [something]" as unlocking it with.
Understand "oeffne mit [dativ] [something] [something]" as unlocking it with (with nouns reversed).
Understand "oeffne [a locked lockable thing] mit [dativ] [something]" as unlocking it with.
Understand "oeffne mit [dativ] [something] [a locked lockable thing]" as unlocking it with (with nouns reversed).
Understand "oeffne [a lockable thing] mit [dativ] [something]" as unlocking it with.
Understand "oeffne mit [dativ] [something] [a lockable thing]" as unlocking it with (with nouns reversed).

[Section 2 - Keylessly]

Understand "schliess [something] auf" as unlocking keylessly.
Understand "schliess [a locked lockable thing] auf" as unlocking keylessly.
Understand "schliess [lockable thing] auf" as unlocking keylessly.

Understand "entsperr [something]" as unlocking keylessly.
Understand "entsperr [a locked lockable thing]" as unlocking keylessly.
Understand "entsperr [lockable thing]" as unlocking keylessly.
Understand the commands "entriegel" and "entriegle" as "entsperr".

[Part 3 - Locking]

[Section 1 - Regular locking]

Understand "schliess [something] mit [dativ] [something] ab/zu" as locking it with.
Understand "schliess [something] ab/zu mit [dativ] [something]" as locking it with.

Understand "schliess [a locked lockable thing] mit [dativ] [something] ab/zu" as locking it with.
Understand "schliess [a locked lockable thing] ab/zu mit [dativ] [something]" as locking it with.

Understand "schliess [a lockable thing] mit [dativ] [something] ab/zu" as locking it with.
Understand "schliess [a lockable thing] ab/zu mit [dativ] [something]" as locking it with.

[Und auch noch das restliche, ebenfalls gelöschte, Vokabular für "schliess" wieder definieren]

Understand "schliess [something]" as closing.
Understand "schliess [something] mit [dativ] [something]" as closing it with.
Understand "schliess [something] mit [dativ] [something preferably held]" as closing it with.


[Section 2 - Keylessly]

Understand "schliess [something] ab/zu" as locking keylessly.
Understand "schliess [a locked lockable thing] ab/zu" as locking keylessly.
Understand "schliess [lockable thing] ab/zu" as locking keylessly.

Understand "verschliess [something]" as locking keylessly.
Understand "verschliess [a locked lockable thing]" as locking keylessly.
Understand "verschliess [lockable thing]" as locking keylessly.
Understand the commands "verriegel", "verriegle" and "versperr" as "verschliess".

[Volume 4 - The Keychain kind, needed only if you want a keychain]

Understand "steck [passkey] auf/an [keychain]" as putting it on.
Understand "haeng [passkey] auf/an [keychain]" as putting it on.
Understand "tu [passkey] auf/an [keychain]" as putting it on.


Section - German Basic Screen Effects (for use with Basic Screen Effects by Emily Short)

[
Basic Screen Effects by Emily Short:
""[paragraph break]Bitte drücke die LEERTASTE, um fortzufahren.""
    standard pausing the game rule response (A): "[paragraph break]Please press SPACE to continue."
]


Section - German Menus  (for use with Menus by Emily Short)



Section - German Basic Help Menu (for use with Basic Help Menu by Emily Short)






Part - I6 additions and replacements - unindexed


Section - Definitions


Include (-
Global verb_prep = -1; ! *** (17.03.2012) Zum Merken einer Präposition im Infinitiv

Constant APPEND_BIT	 32768;	! Hängt die Inhalte der gelisteten Objekte
							! an, anstatt sie in einem Nebensatz zu
							! erwähnen
							! *** Der Originalwert 8192 ist in I7 schon
							!	 von EXTRAINDENT_BIT belegt

Global ignore_append_bit = false;	! *** um das APPEND_BIT in |WillRecurs()|
									! bei der Ausgabe von Listen mit
									! Objektinhalt zu ignorieren.


Property special_article;			! *** I7 special indefinte article

Global max_wn;	! Höchster erreichter Wortmarker für
				! das beste Satzmuster, in der Fehlerausgabe
				! verwendet.

Global pronominal_adverb_flag = false;	! *** Gibt es ein Pronominaladverb im Satz?
										! Und wenn ja, welches?

Global printing_command = false;	! Krücke, um den Changing Gender auch bei
									! Pluralen zu berücksichtigen.


Global pnn = selfobj;	! *** previously named noun, für [ist] [hat] usw.
						! ist das zuletzt in einer Textersetzung
						! genannte Objekt


#Stub PreInformese		0;	! *** Diese Einhänger in |LanguageToInformese()|
#Stub PostInformese		0;	!     können für die Erstellung von Extensions
#Stub HandlePunctuation	0;	!     nützlich sein (vgl. z.B. German Mistype).

-) replacing "Definitions.i6t".


Section - Language

Include (-
Constant AMUSING_PROVIDED 1;
Constant TASKS_PROVIDED   1;

!Default LIST_BUFFER_SIZE = 20; ! *** Wird über die Use-Option List buffer size gesetzt
Array list_buffer --> (LIST_BUFFER_SIZE + 1);
Array list_depth  --> (LIST_BUFFER_SIZE + 1);

Constant definite	= 1;  ! *** Dies sind zusätzliche I6-Entsprechungen der
Constant yours		= 2;  ! special articles DEFINITE, YOURS,
Constant no_article	= 3;  ! NO ARTICLE und PENDING.
Constant pending	= 4;

Property additive init;	! Zur einfachen Initialisierung

#ifdef TARGET_ZCODE;
Constant CHAR_AE = 155; ! 'ä' +++ Warum geht das nicht mehr?
Constant CHAR_OE = 156; ! 'ö'
Constant CHAR_UE = 157; ! 'ü'
Constant CHAR_SS = 161; ! 'ß'
#ifnot;
Constant CHAR_AE = 228;
Constant CHAR_OE = 246;
Constant CHAR_UE = 252;
Constant CHAR_SS = 223;
#endif;

#ifdef TARGET_ZCODE;
Array orig_buffer --> 123;	! Kopie der ursprünglichen Eingabe
Array orig_parse --> 65;	! Kopie der ursprünglichen Wortpositionen
Array orig_position --> 17;	! Wortreferenz, eventuell durch Synonyme
							! verschoben

[ OriginalAddress wordnum;
	if (wordnum > orig_position-->0)
		return orig_buffer + orig_buffer->1 + 1;
	wordnum = orig_position-->wordnum;
	return orig_buffer + orig_parse->(wordnum*4+1);
];

[ OriginalLength wordnum;
	if (wordnum > orig_position-->0) rfalse;
	wordnum = orig_position-->wordnum;
	return orig_parse->(wordnum*4);
];
#ifnot;

Array orig_buffer buffer INPUT_BUFFER_LEN;
Array orig_parse --> PARSE_BUFFER_LEN;
Array orig_position --> (MAX_BUFFER_WORDS + WORDSIZE);

[ OriginalAddress wordnum;
	if (wordnum > orig_position-->0)
		return orig_buffer + orig_buffer-->0 + 1;
	wordnum = orig_position-->wordnum;
	return orig_buffer + orig_parse-->(wordnum*3);
];

[ OriginalLength wordnum;
	if (wordnum > orig_position-->0) rfalse;
	wordnum = orig_position-->wordnum;
	return orig_parse-->(wordnum*3-1);
];
#endif;

[ PrintOriginal wordnum   buffer length i;
	buffer = OriginalAddress(wordnum);
	length = OriginalLength(wordnum);

	for (i = 0 : i < length : i++) print (char) buffer->i;
];

Global genitive_list = 0;	! Flagge, ob ein Plural im Genitiv steht
							! Das sollte eine lokale Flagge sein, aber
							! in WriteListR waren keine mehr frei,
							! und Plurale verschachteln sich nicht.
Global article_word;		! Gibt an, ob und welches Wort als
							! Artikel verstanden wurde.
Global parse_noun_from;		! Gibt an, ab welchem Wort eine Noun
							! Phrase untersucht wird.
-).


Include (-
#Ifdef DEBUG;
! *** In dem LanguageSynonyms-Array stehen im DEBUG-Modus statt Vokabeln Strings,
!	 weil Vokabeln in einem Array von Haus aus als Objektsynonyme
!	 gekennzeichnet werden, und das wollen wir eben nicht. Dies
!	 soll erst durch den (fehlerhaften) Gebrauch durch den Autor
!	 geschehen, sodass der Libcheck hierzu eine entsprechende Warnung
!	 herausgeben kann. (Die Vokabeln werden im DEBUG-Modus als
!	 Verben definiert, siehe Section - Libcheck.)
!
!	 Zur schnellen Prüfung der Vokabeln im DEBUG-Modus wird bei Spielbeginn eine
!	 Kopie von LanguageSynonyms (LanguageSynonyms2) angelegt, die
!	 statt der Strings die Vokabeln enthält, also genau so aussieht, wie
!	 LanguageSynonyms beim Release.

Array LanguageSynonyms table
	"am"		"an dem"
	"ans"		"an das"
	"aufs"		"auf das"
	"beim"		"bei dem"
	"durchs"	"durch das"
	"fuers"		"fuer das"
	"hinterm"	"hinter dem"
	"hinters"	"hinter das"
	"im"		"in dem"
	"ins"		"in das"
	"nebens"	"neben das"
	"uebers"	"ueber das"
	"ueberm"	"ueber dem"
	"unters"	"unter das"
	"unterm"	"unter dem"
	"vom"		"von dem"
	"vors"		"vor das"
	"vorm"		"vor dem"
	"zum"		"zu dem"
	"zur"		"zu der"
	"darin"		"in ihm/r"
	"damit"		"mit ihm/r"
	"beid"		"zwei"
	;

Array LanguageSynonyms2 --> 48;

#Ifnot; ! DEBUG
Array LanguageSynonyms table
	'am'		"an dem"
	'ans'		"an das"
	'aufs'		"auf das"
	'beim'		"bei dem"
	'durchs'	"durch das"
	'fuers'		"fuer das"
	'hinterm'	"hinter dem"
	'hinters'	"hinter das"
	'im'		"in dem"
	'ins'		"in das"
	'nebens'	"neben das"
	'uebers'	"ueber das"
	'ueberm'	"ueber dem"
	'unters'	"unter das"
	'unterm'	"unter dem"
	'vom'		"von dem"
	'vors'		"vor das"
	'vorm'		"vor dem"
	'zum'		"zu dem"
	'zur'		"zu der"
	'darin'		"in ihm/r"
	'damit'		"mit ihm/r"
	'beid'		"zwei"
	;
#Endif; ! DEBUG

Array LanguageTwins table
	'bis'		'auf'		"ausser"
	'nur'		'nicht'		"ausser"
	THEN1__WD	THEN1__WD	"."
	;

!   Die Einträge in LanguageVerbPreps sind mögliche Kandidaten für den
!   ersten Teil zusammengesetzter Verben: an-machen, zusammen-kleben,
!   fort-fahren, usw.

Array LanguageVerbPreps table
	"ab"		  "an"		  "auf"		 "aus"
	"auseinander" "bei"		 "darauf"	  "daraus"
	"darein"	  "drauf"	   "durch"	   "ein"
	"entzwei"	 "fort"		"herauf"	  "heraus"
	"herum"	   "herunter"	"hin"		 "hinauf"
	"hinaus"	  "hinein"	  "hinueber"	"hinweg"
	"hoch"		"kaputt"	  "mit"		 "nach"
	"nieder"	  "rauf"		"raus"		"rein"
	"runter"	  "ueber"	   "um"		  "umher"
	"unter"	   "weg"		 "zu"		  "zusammen"
	;
-).

Include (-
Array LanguageNumbers table
	'eins' 1  'zwei' 2  'drei' 3  'vier' 4  'fuenf' 5
	'sechs' 6  'sieben' 7  'acht' 8  'neun' 9  'zehn'  10
	'elf' 11  'zwoelf' 12 'dreizehn' 13  'vierzehn' 14  'fuenfzehn' 15
	'sechzehn' 16  'siebzehn' 17  'achtzehn' 18  'neunzehn' 19  'zwanzig' 20
	'einundzwanzig' 21  'zweiundzwanzig' 22  'dreiundzwanzig' 23
	'vierundzwanzig' 24 'fuenfundzwanzig' 25  'sechsundzwanzig' 26
	'siebenundzwanzig' 27  'achtundzwanzig' 28 'neunundzwanzig' 29 'dreissig' 30
	'einundreissig' 31  'zweiunddreissig' 32  'dreiunddreissig' 33
	'vierunddreissig' 34  'fuenfunddreissig' 35  'sechsunddreissig' 36
	'siebenunddreissig' 37  'achtunddreissig' 38 'neununddreissig' 39
	'vierzig' 40  'einundvierzig' 41  'zweiundvierzig' 42  'dreiundvierzig' 43
	'vierundvierzig' 44  'fuenfundvierzig' 45  'sechsundvierzig' 46
	'siebenundvierzig' 47  'achtundvierzig' 48  'neunundvierzig' 49
	'fuenfzig' 50  'einundfuenfzig' 51  'zweiundfuenfzig' 52
	'dreiundfuenfzig' 53  'vierundfuenfzig' 54  'fuenfundfuenfzig' 55
	'sechsundfuenfzig' 56  'siebenundfuenfzig' 57  'achtundfuenfzig' 58
	'neunundfuenfzig' 59  'sechzig' 60
	;
-) replacing "LanguageNumbers".

Include (-
[ LanguageNumber n one_style	   f;

!*** (03.12.2010): Die Ausgabe der großen Zahlen korrigiert. Dazu wurde
!	der Parameter one_style eingeführt, mit dem die Ausgabe von
!	"ein", "eins" und "eine" gesteuert wird.

	if (n==0) {
		print "null"; rfalse;
	}
	if (n<0) {
		print "minus "; n = -n;
	}

	#Iftrue (WORDSIZE == 4);
	if (n >= 1000000000) {
		if (f == 1) print " ";
		LanguageNumber(n/1000000000, 2);
		print " Milliarde"; if (n/1000000000 > 1) print "n";
		n = n%1000000000;
		if (n>0) print " ";
		f = 1;
	}
	if (n >= 1000000) {
		if (f == 1) print " ";
		LanguageNumber(n/1000000, 2);
		print " Million"; if (n/1000000 > 1) print "en";
		n = n%1000000;
		if (n>0) print " ";
		f = 1;
	}
	#Endif; ! (WORDSIZE == 4)

	if (n>=1000) {
		LanguageNumber(n/1000, 1);
		print "tausend"; n=n%1000; f=1;
	}
	if (n>=100) {
		LanguageNumber(n/100, 1);
		print "hundert"; n=n%100;
	}

	if (n==0) rfalse;

	switch(n) {
		1:	print "ein";
			switch (one_style) {
				1: print "";		! "einhundert, eintausend"
				2: print "e";		! "eine Million, eine Milliarde"
				default: print "s"; ! "eins"
			}
		2:	print "zwei";
		3:	print "drei";
		4:	print "vier";
		5:	print "fünf";
		6:	print "sechs";
		7:	print "sieben";
		8:	print "acht";
		9:	print "neun";
		10: print "zehn";
		11: print "elf";
		12: print "zwölf";
		13: print "dreizehn";
		14: print "vierzehn";
		15: print "fünfzehn";
		16: print "sechzehn";
		17: print "siebzehn";
		18: print "achtzehn";
		19: print "neunzehn";
	}

if (n >= 20 && n <=99) { ! 20 to 99:	! +++ 2023_05_08 "to" is no longer recognized by I7
	if (n%10 ~= 0) {
		LanguageNumber(n%10, 1);
		print "und";
	}
	switch(n/10) {
		2: print "zwanzig";
		3: print "dreißig";
		4: print "vierzig";
		5: print "fünfzig";
		6: print "sechzig";
		7: print "siebzig";
		8: print "achtzig";
		9: print "neunzig";
	}
}
];
-) replacing "LanguageNumber".

Include (-
#Ifdef TARGET_ZCODE;
[ DictionaryLookup b l i;
	for (i=0 : i<l : i++) buffer2->(2+i) = b->i;
	buffer2->1 = l;
	VM_Tokenise(buffer2,parse2);
	return parse2-->1;
];
#Ifnot; ! TARGET_GLULX
[ DictionaryLookup b l i;
	for (i=0 : i<l : i++) buffer2->(WORDSIZE+i) = b->i;
	buffer2-->0 = l;
	VM_Tokenise(buffer2,parse2);
	return parse2-->1;
];
#Endif; ! TARGET_ZCODE

#Ifdef TARGET_GLULX;
Array UmlautAux -> DICT_WORD_SIZE;
#Ifnot;
Array UmlautAux -> 12;
#Endif; ! TARGET_GLULX

[ UmlautAddress i cap  letter next last skip start length;

	! Vokabel auf Hilfsfeld schreiben
	#ifdef TARGET_GLULX;
	length = Glulx_PrintAnyToArray(UmlautAux, 24, i);
	start = 0;
	#ifnot;
	@output_stream 3 UmlautAux;
	print (address) i;
	@output_stream -3;
	length = UmlautAux-->0;
	start = 2;
	#endif;

	! Vokabel mit ersetzten Umlauten ausgeben
	! *** und wenn (cap==true) mit Großbuchstaben am Anfang
	for (i=0 : i < length : i++) {
		letter = UmlautAux->(i+start);
		if(i + 1 >= length) next = 0;
		else next = UmlautAux ->(i+start+1);

		if (letter == 'a' && next == 'e') {
			if (i==0 && cap) print "Ä"; else print "ä"; skip = true;
		} else if (letter == 'o' && next == 'e') {
			if (i==0 && cap) print "Ö"; else print "ö"; skip = true;
		} else if (letter == 'u' && next == 'e' && last ~= 'a' or 'e' or 'q') {
		   if (i==0 && cap) print "Ü"; else print "ü"; skip = true;
		} else if (skip) skip = false;
		else if (i==0 && cap) print (char) VM_LowerToUpperCase(letter); else print (char) letter;
		last = letter;
	}
];

! *** |CUmlautAddress()|: Wie UmlautAddress, nur mit Großbuchstaben am Anfang.
!	 (|CPrintOrRun(UmlautAddress(i))| funktioniert leider nicht so einfach.)
!
!	 Das Großschreiben des Anfangsbuchstabens wird nun in |UmlautAddress()|
!	 erledigt, wenn man als zweiten Parameter true übergibt.

[ CUmlautAddress i; UmlautAddress(i, true); ];

[ IsDirectionWord w	obj i index;
	objectloop (obj in Compass) {
		if (WordInProperty(w, obj, name)) return obj;
	}

	! *** (07.03.2012) Direkter Abgleich ohne Array LanguageDirectionWords

	switch (w) {
		'norden', 'n//': return (+ north +);
		'nordosten', 'no', 'ne': return (+ northeast +);
		'nordwesten', 'nw': return (+ northwest +);
		'sueden', 's//': return (+ south +);
		'suedosten', 'so', 'se': return (+ southeast +);
		'suedwesten', 'sw': return (+ southwest +);
		'osten', 'o//', 'e//': return (+ east +);
		'westen', 'w//': return (+ west +);
		'hoch', 'rauf', 'hinauf', 'oben', 'h//', 'u//': return (+ up +);
		'runter', 'hinunter', 'unten', 'r//', 'd//': return (+ down +);
		'rein', 'drinnen', 'innen': return (+ inside +);
		'raus', 'draussen', 'aussen': return (+ outside +);
		default: rfalse;
	}
];

[ LastCharacterAddress i j		length start ch pos;

	! Vokabel auf Hilfsfeld schreiben
	#ifdef TARGET_GLULX;
	length = Glulx_PrintAnyToArray(UmlautAux, 24, i);
	start = 0;
	#ifnot;
	@output_stream 3 UmlautAux;
	print (address) i;
	@output_stream -3;
	length = UmlautAux-->0;
	start = 2;
	#endif;

	pos = length-1+start-j;
	if (pos < start) return 0;
	ch = UmlautAux->(pos); ! *** letzes Zeichen - j
	return ch;
];

[ AddressMatchesText a s	 i length1 length2 start     vokabel; ! TODO
	! *** (05.03.2014) Wenn a oder s mit dem Wert -1
	!	 übergeben werden, kommt es in Glulx zu einem
	!	 Absturz des Programms. Deshalb werden negative
	!	 Werte abgefangen.
	#ifdef TARGET_GLULX; ! +++ Abfrage nur für Glulx
	if (a <= 0) rfalse; ! *** (19.03.2014) Neu
	if (s <= 0) rfalse;
	#endif;

	! *** (04.05.2011) Eine Vokabel a mit einem String s vergleichen.
	!	 Als Hilfsarrays werden UmlautAux und HLAuxBuffer2
	!	 wiederverwendet.
	!
	!	 UmlautAux enthält die Zeichenkette der Vokabel a, in
	!	 HLAuxBuffer2 wird der String s geschrieben.
	#ifdef TARGET_GLULX;
	length1 = Glulx_PrintAnyToArray(UmlautAux, 24, a);
	start = 0;
	#ifnot;
	@output_stream 3 UmlautAux;
    if (UnsignedCompare(a, HDR_DICTIONARY-->0) >= 0 &&
        UnsignedCompare(a, HDR_HIGHMEMORY-->0) < 0)
         print (address) a;
    else print a;
	@output_stream -3;
	length1 = UmlautAux-->0;
	start = 2;
	#endif;

	! +++ Ist s ein regulärer String, oder ein gepackter Text?
	switch (s-->0) {
		CONSTANT_PACKED_TEXT_STORAGE, CONSTANT_PERISHABLE_TEXT_STORAGE, PACKED_TEXT_STORAGE:	length2 = VM_PrintToBuffer(HLAuxBuffer2, 24, s-->1);
		default:																				length2 = VM_PrintToBuffer(HLAuxBuffer2, 24, s);
	}

	if (length1 == length2) {
		for (i = 0 : i < length1 : i++) {
			if (UmlautAux->(i + start) ~= HLAuxBuffer2->(i + WORDSIZE))
				break;
		}
		if (i == length1) rtrue;
	}
	rfalse;
];

[ AddressInTable i tab start_row col	   n index;

	! *** Hier wird eine Vokabel i mit Text-Einträgen in einer I7-Tabelle
	!	 tab verglichen. Wenn ein passendes Wort gefunden wurde, wird
	!	 die Zeilennummer des gefundenen Wortes zurückgegeben. Wird keine
	!	 Übereinstimmung festgestellt, ist das Ergebnis 0.

	if (start_row == 0) start_row = 1;
	if (col == 0) col = 1;

	n = TableRows(tab);

	for (index = start_row : index <= n : index++) {
		if (AddressMatchesText(i, TableLookUpEntry(tab, col, index)) )
			return index;
	}
	return 0;
];

[ CheckTableOfInfinitives i	 tab index;
! *** Die Verben, die der Autor in die Tabelle "Table of Infinitives (continued)"
!	 eingetragen hat, werden mit der Vokabel i abgeglichen.

	tab = (+ Table of infinitives +);
	index = AddressInTable(i, tab, 2); ! *** beginnt die Suche in Zeile 2
	if (index) {
		print (PrintI6Text) TableLookUpEntry(tab, 2, index)-->1; ! +++
		rtrue;
	}
	rfalse;
];
-).

Include (-
[ LanguageVerb i	obj last;

	! *** Table of Infinitives nach unregelmäßigen
	!	 Imperativ-Infinitv-Paarungen durchsuchen. Die Tabelle wird
	!	 vom Autor selbst fortgesetzt. Zudem können in dieser
	!	 Tabelle Änderungen an den Standard-Infinitven vorgenommen
	!	 werden.

	if (CheckTableOfInfinitives(i)) return true;

	switch (i) {
		'l//', 'lage': print "schauen";
		'z//': print "warten";
		'j//': print "ja";
		'x//','u//','b//': print "betrachten";
		'v//': print "verlassen";
		'i//', 'inv', 'inventar': print "Inventar anzeigen";
		'raus', 'hinaus', 'heraus': print "raus gehen";

		! Wörter, die zu lang sind oder in denen ein ß ist

		'giess':		 print "gießen";

		'ueberreich':	print "überreichen";
		'praesentier':	print "präsentieren";
		'konsultier':	print "konsultieren";
		'durchwuehl':	print "durchwühlen";
		'durchstoeber':	print "durchstöbern";
		'schliess':		print "schließen";
		'verschliess':	print "verschließen";
		'verriegel':	print "verriegeln";
		'zertruemmer':	print "zertrümmern";
		'unterricht':	print "unterrichten";
		'zerdrueck':	print "zerdrücken";
		'zerquetsch':	print "zerquetschen";
		'durchschneid':	print "durchschneiden";
		'zerschneid':	print "zerschneiden";

		! Starke Verben (*** erweiterte Liste)

		'befiehl':		print "befehlen";
		'brich':		print "brechen";
		'betritt':		print "betreten";
		'birg  ':		print "bergen";
		'empfiehl':		print "empfehlen";
		'erschrick':	print "erschrecken";
		'erwirb':		print "erwerben";
		'ficht':		print "fechten";
		'friss':		print "fressen";
		'gib':			print "geben";
		'hilf':			print "helfen";
		'iss':			print "essen";
		'lies':			print "lesen";
		'miss':			print "messen";
		'nimm':			print "nehmen";
		'sei':			print "sein";
		'sieh':			print "sehen";
		'sprich':		print "sprechen";
		'stich':		print "stechen";
		'stiehl':		print "stehlen";
		'triff':		print "treffen";
		'tritt':		print "treten";
		'verdirb':		print "verderben";
		'vergiss':		print "vergessen";
		'wirb':			print "werben";
		'wirf':			print "werfen";
		'zerbrich':		print "zerbrechen";

		! *** Imperative mit -le und -re

		'baumle':		print "baumeln";
		'beschnueffle':	print "beschnueffeln";
		'entriegle':	print "entriegeln";
		'jodle':		print "jodeln";
		'klettre':		print "erklimmen";
		'schmirgle':	print "schmirgeln";
		'schnueffle':	print "schüffeln";
		'streichle':	print "streicheln";
		'verriegle':	print "verriegeln";
		'wedle': 		print "wedeln";

		default:


		! Himmelsrichtung

		obj = IsDirectionWord(i); if (obj) {
			print "nach ", (WithoutArt) obj, " gehen";
			rtrue;
		}

		! Schwache Verben: Infinitiv ist Form ohne 'e' und '-en'
		! *** oder auch mit 'e' und ohne 'n'.

		!*** Falls doch noch ein 'e' am Verb dranhängt wird nur ein "n"
		!	ausgegeben.
		!
		!	LastChracterAddress(wort, n); ermittelt das n-letzte Zeichen,
		!	um den Infinitiv etwas genauer rekonstruieren zu können.

		if(PrintVerb(i) == 0) {
			UmlautAddress(i);
			last = LastCharacterAddress(i); ! letztes Zeichen

			! -e
			if (last == 'e') { print "n"; rtrue; }

			! -el, -er
			if (last == 'l' or 'r'
				&& LastCharacterAddress(i,1) == 'e') {

				! -auel, -euel, -auer, -euer: +n
				if (LastCharacterAddress(i,2) == 'u'
					&& LastCharacterAddress(i,3) == 'a' or 'e')
						{ print "n"; rtrue; }

				! -iel, -ier, -ael, -aer, -oel, -oer, -uel, -uer: +en
				! Alle anderen Buchstaben vor -el oder -er: +n
				if (LastCharacterAddress(i,2) ~= 'i' or 'a' or 'o' or 'u')
						{ print "n"; rtrue; }
			}
			print "en";
		}
	}
];
-) replacing "LanguageVerb".

Include (-
[ PruneWord w	start length;
	wn = w; if (NextWord()) return;

	start = WordAddress(w);
	length = WordLength(w);

	if (start->(length - 1) == 'e' or 'n' or 's'
		&& DictionaryLookup(start, length - 1)) {
		start->(length - 1) = ' ';
		VM_Tokenise(buffer, parse);
		return;
	}

	if (start->(length - 2) == 'e'
		&& start->(length - 1) == 'm' or 'n' or 'r' or 's'
		&& DictionaryLookup(start, length - 2)) {
		start->(length - 1) = ' ';
		start->(length - 2) = ' ';
		VM_Tokenise(buffer, parse);
		return;
	}
];

Array SynonymBuffer --> 24;

[ printSynonymBuffer s;
	#Ifdef TARGET_ZCODE;
	@output_stream 3 SynonymBuffer;
	print (string) s;
	@output_stream -3;
	return SynonymBuffer-->0;
	#Ifnot; ! TARGET_GLULX
	return Glulx_PrintAnyToArray(SynonymBuffer, 24, s);
	#Endif; ! TARGET_ZCODE
];

! Die beiden Routinen CheckSynonym/Twin geben jetzt einen Erfolgswert zurück,
! der aber nicht benutzt wird.

[ CheckSynonym w s	 i n wd start length newlength offset;
	wn = w; wd = NextWord(); if (~~wd) return false;

	! *** (28.03.2015) Einwortsätze nicht checken
	if (WordCount() == 1) return false;

	#Ifdef TARGET_ZCODE;
	offset = WORDSIZE;
	#Ifnot; ! TARGET_GLULX
	offset = 0;
	#Endif; ! TARGET_ZCODE

	! Die Tabelle durchlaufen
	n = (s-->0);
	for (i = 1 : i<=n : i = i + 2) {
		if (wd ~= s-->i) continue;

		start = WordAddress(w);
		length = WordLength(w);
		newlength = printSynonymBuffer(s-->(i+1));
		while (newlength > length) {
			LTI_Insert(start + length - buffer,
				SynonymBuffer->(offset + (--newlength)));
		}
		while (newlength < length) {
			start->(--length) = ' ';
		}
		for (i = 0 : i<length : i++) {
			start->i = SynonymBuffer->(offset + i);
		}
		! Satz neu in Tokens ausfplitten
		length = WordCount();
		VM_Tokenise(buffer, parse);

		! Referenzpositionen merken
		n = WordCount();
		length = length - n;
		for (w++ : w<=n : w++)
			orig_position-->w = orig_position-->w + length;
		orig_position-->0 = orig_position-->0 - length;
		return true;
	}
	return false;
];

[ CheckTwin w s   i n wd1 wd2 start length newlength offset;
	wn = w; wd1 = NextWord(); wd2 = NextWord();
	#Ifdef TARGET_ZCODE;
	offset = WORDSIZE;
	#Ifnot; ! TARGET_GLULX
	offset = 0;
	#Endif; ! TARGET_ZCODE
	if (~~wd1) return; if (~~wd2) return false;

	!   Die Tabelle durchlaufen
	n = (s-->0);
	for (i = 1 : i<=n : i = i + 3) {
		if (wd1 ~= s-->i) continue;
		if (wd2 ~= s-->(i+1)) continue;
		start = WordAddress(w);
		length = WordAddress(w+1) + WordLength(w+1) - start;
		newlength = printSynonymBuffer(s-->(i+2));
		start->(newlength - 1) = ' ';
		while (newlength > length) {
			LTI_Insert(start + length - buffer,
				SynonymBuffer->(offset + (--newlength)));
		}
		while (newlength < length) {
			start->(--length) = ' ';
		}
		for (i = 0 : i<length : i++) {
			start->i = SynonymBuffer->(offset + i);
		}
		! Satz neu in Tokens ausfplitten
		length = WordCount();
		VM_Tokenise(buffer, parse);

		! Referenzpositionen merken
		n = WordCount();
		length = length - n;
		for (w++ : w<=n : w++)
			orig_position-->w = orig_position-->w + length;
		orig_position-->0 = orig_position-->0 - length;
		return true;
	}
	return false;
];

#Ifdef COMPOUND_HEADS;
[ CheckCompoundHeads w   n i start length olength cheads;
	wn = w;

	cheads = (+ Table of Compound Heads +);

	!   Die Tabelle durchlaufen
	n = TableRows(cheads);
	 for (i = 2 : i<=n : i++) { ! +++ kann i=2 bleiben wegen Platzhalter
		olength = WordLength(wn);
		length = WordMatch(TableLookUpEntry(cheads, 1, i));
		if (length==0) continue;
		if (length==olength) continue;
		start = WordAddress(w);
		if (start->length == '-') {
			LTI_Insert(start + length - buffer + 1, ' ');
		} else {
			LTI_Insert(start + length - buffer, ' ');
			if (TableLookUpEntry(cheads, 2, i) == 0)
				LTI_Insert(start + length - buffer, '-');
		}

		! Satz neu in Tokens aufsplitten
		VM_Tokenise(buffer, parse);

		! Referenzpositionen merken
		length = -1;
		for (w++ : w<=16 : w++)
			orig_position-->w = orig_position-->w + length;
		orig_position-->0 = orig_position-->0 - length;

		! Eventuell den Rest beschneiden
		PruneWord(wn);
		return;
	}
];
#Endif; ! COMPOUND_HEADS

#Ifdef COMPOUND_TAILS;
[ CheckCompoundTails w   n i start length olength ctails;
	wn = w;

	ctails = (+ Table of Compound Tails +);

	!   Die Tabelle durchackern
	n = TableRows(ctails);

	for (i = 2 : i<=n : i = i + 1) {
		olength = WordLength(wn);
		length = WordMatch(TableLookUpEntry(ctails, 1, i), 0, olength);

		start = WordAddress(w);
		if (length == 0 && start->(olength - 1) == 'e' or 's' or 'n') {
			length = WordMatch(TableLookUpEntry(ctails, 1, i), 0, olength-1);
			if (length) olength--;
		}
		if (length == 0 && start->(olength - 2) == 'e'
			&& start->(olength - 1) == 'm' or 'n' or 'r' or 's') {
			length = WordMatch(TableLookUpEntry(ctails, 1, i), 0, olength-2);
			if (length) olength = olength - 2;
		}

		if (length==0) continue;
		if (length==olength) continue;

		start = WordAddress(w) + olength - length;
		if ((start - 1)->0 == '-') {
			LTI_Insert(start - buffer, ' ');
		} else {
			LTI_Insert(start - buffer, ' ');
			if (TableLookUpEntry(ctails, 2, i)==0)
				LTI_Insert(start - buffer, '-');
		}

		! Satz neu in Tokens ausfplitten
		VM_Tokenise(buffer, parse);

		! Referenzpositionen merken
		length = -1;
		for (w++ : w<=16 : w++)
			orig_position-->w = orig_position-->w + length;
		orig_position-->0 = orig_position-->0 - length;

		! Eventuell den Rest beschneiden
		PruneWord(wn);
		return;
	}
];
#Endif; ! COMPOUND_TAILS

[ VM_GetEndOfBuffer buf	ze;
	if (buf == 0) buf = buffer;
	#Ifdef TARGET_ZCODE;
	ze = 2 + buf->1;
	#Ifnot; ! TARGET_GLULX
	ze = WORDSIZE + buf-->0;
	#Endif; ! TARGET_ZCODE
	return ze;
];

[ PrintBuffer zs ze i; ! +++ Gibt den Puffer aus.
	zs = WORDSIZE;
	ze = VM_GetEndOfBuffer();
	for (i = zs : i < ze : i++) {
		print (char) buffer->i;
	}
	print "^^";
];

[ LanguageToInformese	zs ze i;

	verb_prep = -1; ! +++ Merker für Präposition im Infinitiv zurücksetzen

!	(i)
!	Der Autor bekommt Kontrolle über die Informisierung

	if (PreInformese()) rtrue;


!	(ii)
!	Alle Umlaute und Eszetts in 'ae', 'oe', 'ue', 'ss' umwandeln

	zs = WORDSIZE;
	ze = VM_GetEndOfBuffer();

	for (i = zs : i < ze : i++) {

		! *** (01.09.2010) Im Glulx-Format müssen möglicherweise vorhandene
		!	 Großbuchstaben in der Spielereingabe vor Umwandlung der Umlaute
		!	 und Abschneiden der Endungen in Kleinbuchstaben umgewandelt
		!	 werden, damit groß geschriebene Umlaute und Endungen korrekt
		!	 verarbeitet werden können. Wir erledigen das an dieser Stelle
		!	 gleich mit. (Eigentlich sollte das schon mit VM_Tokenise()
		!	 erledigt sein, aber aus irgendeinem Grund funktioniert das
		!	 Umwandeln der großen Umlaute dort nicht.)

		#Ifdef TARGET_GLULX;
		buffer->i = VM_UpperToLowerCase(buffer->i);
		#Endif; ! TARGET_GLULX

		if (buffer->i > 128) {
			switch(buffer->i) {
				CHAR_AE: buffer->i = 'a'; LTI_Insert(i+1, 'e'); ze++;
				CHAR_OE: buffer->i = 'o'; LTI_Insert(i+1, 'e'); ze++;
				CHAR_UE: buffer->i = 'u'; LTI_Insert(i+1, 'e'); ze++;
				CHAR_SS: buffer->i = 's'; LTI_Insert(i+1, 's'); ze++;
			}
		}

		! *** (26.06.2012) Overflow in den Puffern verhindern
		if (ze > INPUT_BUFFER_LEN) { ze = VM_GetEndOfBuffer(); break; }
	}
	VM_Tokenise(buffer, parse);

!	(iii)
!	Kopie der Originaleingabe (allerdings ohne Umlaute) anlegen

	for (i = 0 : i < ze : i++) orig_buffer->i = buffer->i;

	ze = WordCount();

	#Ifdef TARGET_ZCODE;
	for (i=1 : i<=ze*2 : i++) orig_parse-->i = parse-->i;
	#Ifnot; ! TARGET_GLULX
	for (i=1 : i<=ze*3 : i++) orig_parse-->i = parse-->i;
	#Endif; ! TARGET_ZCODE
	orig_parse-->0 = parse-->0;

	#Ifdef TARGET_GLULX;
	for (i=1 : i<=MAX_BUFFER_WORDS : i++) orig_position-->i = i;
	#Ifnot; ! TARGET_GLULX
	for (i=1 : i<=16 : i++) orig_position-->i = i;
	#Endif; ! TARGET_ZCODE
	orig_position-->0 = ze;

!	(iv)
!	Endungen (-e, -em, -en, -er, -es, -n, -s) abschneiden. Hierbei wird so lange
!	abgeschnitten, bis ein gültiges Wort gefunden wird. Wenn es also eine
!	'laute' gibt, so wird "Laute" belassen, ansonsten wird das '-e' abgestrennt.
!
!	Das kann bei einigen Paarungen von Substantiven mit Adjektiven (jung/Junge)
!	oder Verben (pump/Pumpe) Konflikte geben. Dann muss das Vokabular angepasst
!	werden. (Nicht schön, aber praktikabel.)

	for (i=0 : i<ze : i++) PruneWord(i + 1);

!	(v)
!	Umwandeln der Synonyme, hauptsächlich Kontraktionen aus Präpositionen und
!	bestimmten Artikeln. Hierzu wird das Feld Synonyms herangezogen.

	for (i=0 : i<ze : i++) {
		#Ifdef Synonyms;
		CheckSynonym(i + 1, Synonyms);
		#Endif; ! Synonyms

		#Ifdef DEBUG;
		CheckSynonym(i + 1, LanguageSynonyms2);
		#Ifnot; ! DEBUG
		CheckSynonym(i + 1, LanguageSynonyms);
		#Endif; ! DEBUG

		#Ifdef TARGET_ZCODE;
		ze = parse->1;
		#Ifnot; ! TARGET_GLULX
		ze = parse-->0;
		#Endif; ! TARGET_ZCODE
	}

	i = ze - 1;
	while (i-- ) {	! Leerzeichen nach i--, weil es sonst als Ende des I6-Einschubs interpretiert wird
	!for (i=0 : i<ze-1 : i++) {
		#Ifdef Twins;
		CheckTwin(i + 1, Twins);
		#Endif; ! Twins
		CheckTwin(i + 1, LanguageTwins);
		#Ifdef TARGET_ZCODE;
		ze = parse->1;
		#Ifnot; ! TARGET_GLULX
		ze = parse-->0;
		#Endif; ! TARGET_ZCODE
	}

	#Ifdef COMPOUND_HEADS;
	for (i=0 : i<ze : i++) {
		CheckCompoundHeads(i + 1);
		#Ifdef TARGET_ZCODE;
		ze = parse->1;
		#Ifnot; ! TARGET_GLULX
		ze = parse-->0;
		#Endif; ! TARGET_ZCODE
	}
	#Endif; ! COMPOUND_HEADS

	#Ifdef COMPOUND_TAILS;
	for (i=0 : i<ze : i++) {
		CheckCompoundTails(i + 1);
		#Ifdef TARGET_ZCODE;
		ze = parse->1;
		#Ifnot; ! TARGET_GLULX
		ze = parse-->0;
		#Endif; ! TARGET_ZCODE
	}
	#Endif; ! COMPOUND_TAILS

!	(vi)
!	Ausrufe- und Fragezeichen behandeln, falls gewünscht.

	HandlePunctuation();

	#Ifdef UMLAUT_DICT_WORDS;
	Glulx_CheckUmlautDictWords(buffer, parse);
	#Endif;

! +++ Die Activity "Translating a command into Informese" tut nichts, aber man
!     kann mit "After translating a command into Informese" in I7 Anpassungen
!     vornehmen.
    BeginActivity( (+ Translating a command into Informese +) );
    EndActivity( (+ Translating a command into Informese +) );

! +++ Einkommentieren zur Ausgabe des Puffers
!PrintBuffer();

!	(vii)
!	Der Autor bekommt noch einmal Kontrolle über die Informisierung.

	if (PostInformese()) rtrue;

];
-) replacing "LanguageToInformese".


Include (-
Constant Nom = 0;
Constant Gen = 1;
Constant Dat = 2;
Constant Akk = 3;

Constant def_article_base 0;
Constant indef_article_base 16;
Constant neg_article_base 32;

Array LanguageSuffixes -->
	"en"	"e"		"e"		"e"		! mit bestimmtem Artikel
	"en"	"en"	"en"	"en"
	"en"	"en"	"en"	"en"
	"en"	"e"		"en"	"e"
	"e"		"es"	"er"	"e"		! mit unbestimmtem Artikel
	"er"	"en"	"en"	"en"
	"en"	"en"	"en"	"en"
	"e"		"es"	"en"	"e"
	"e"		"es"	"er"	"e"		! ohne Artikel
	"er"	"en"	"en"	"er"
	"en"	"em"	"em"	"er"
	"e"		"es"	"en"	"e"
	"e"		"es"	"er"	"e"		! Demonstrativpronomen.
	"er"	"es"	"es"	"er"
	"en"	"em"	"em"	"er"
	"e"		"es"	"en"	"e"
	"e"		""		""		"e"		! Possessivpronomen
	"er"	"es"	"es"	"er"
	"en"	"em"	"em"	"er"
	"e"		""		"en"	"e"
	;


Constant possessive_suffix_base 64;

Array PersonalPronouns -->
	"sie"		"es"		"er"		"sie"
	"ihrer"		"seiner"	"seiner"	"ihrer"
	"ihnen"		"ihm"		"ihm"		"ihr"
	"sie"		"es"		"ihn"		"sie"
	;

Array LanguageRelativePronouns -->
	"die"		"das"		"der"		"die"
	"deren"		"dessen"	"dessen"	"deren"
	"denen"		"dem"		"dem"		"der"
	"die"		"das"		"den"		"die"
	"derer"		"dessen"	"dessen"	"derer"
	"welche"	"welches"	"welcher"	"welche"
	0			0			0			0			! *** keine Genitiv-Formen
	"welchen"	"welchem"	"welchem"	"welcher"
	"welche"	"welches"	"welchen"	"welche"
	;

Constant MAX_CG_STACK = 8;

Array CG_buffer --> (2 * MAX_CG_STACK);
Global CG_pointer;

[ GenderChanged obj   i;
	for (i = 0 : i < MAX_CG_STACK : i++) {
		if (CG_buffer-->(2*i) == obj) return CG_buffer-->(2*i + 1);
	}
	return -1; ! +++ 19.04.2023 Rückgabewert "-1", wenn das Objekt im Changing Gender Buffer "CG_buffer" nicht gefunden wurde
];

[ GenderNotice obj g   i;
	! Objekt und Genus löschen
	for (i=0 : i < MAX_CG_STACK : i++) {
		if (CG_buffer-->(2*i) == obj) {
			CG_buffer-->(2*i) = 0;
		}
	}

	if (g) {
		! Objekt und Genus setzen
		CG_buffer-->(CG_pointer*2) = obj;
		CG_buffer-->(CG_pointer*2 + 1) = g;
		CG_pointer++;
		CG_pointer = CG_pointer % MAX_CG_STACK;
	}
];

[ Gender obj flag   g;
	if (obj == nothing) return;

	! +++ TODO 19.04.2023 Der Gender wird manchmal geändert, ohne dass dies gewünscht ist
	! +++ Ich halte das mittlerweile für einen Fehler in I7, da ich keine Stelle gefunden habe, wo der grammatical gender gesetzt wird und es eine Auswirkung auf den Fehler hat.
	! +++ Eine "Lösung" ist den Objektnamen neu "auszugeben":
	!#ifdef TARGET_ZCODE;
	!if (standard_interpreter ~= 0) {
	!	StorageForShortName-->0 = 40;
	!	@output_stream 3 StorageForShortName;
	!	print (TEXT_TY_Say) obj.short_name; ! +++ convert to string in StorageForShortName
	!	@output_stream -3;
	!}
	!#ifnot;
	!Glulx_PrintAnyToArray(StorageForShortName, 40, obj.short_name-->1); ! write to StorageForShortName
	!#endif;


	! Wenn flag gesetzt ist, nach Gender-Änderungen schauen
 	if (flag) {
		g = GenderChanged(obj);
		if (g >= 0) { ! +++ 19.04.2023 Rückgabewert "-1", wenn das Objekt im Changing Gender Buffer "CG_buffer" nicht gefunden wurde
			switch (g) {
				pluralname:	return 0;
				male:		return 1;
				female:		return 2;
				neuter:		return 3;
			}
		}
	}

	! Genus zurücksetzen
	if (~~printing_command) GenderNotice(obj, 0);

	! Übliches Verfahren nach Plural-Attribut/grammatical_gender:

	if (obj has pluralname) return 0;

	! *** (22.05.2012) evtl. im Spiel hinzugefügte Gender-Attribute
	!	 werden gegenüber dem GG bevorzugt behandelt, denn der Autor muss
	!	 sie absichtlich vergeben haben. Sie werden hier gleich in
	!	 den grammatical gender übersetzt, jedoch nicht gelöscht.

	! +++ 17.03.2023 auskommentiert: die I6 Attribute "neuter", "male", "female"
	!     sollen den grammatical gender nicht übersteuern.

	!if (obj has neuter) {
	!	obj.grammatical_gender = 1;
	!}
	!else if (obj has male) {
	!	obj.grammatical_gender = 2;
	!}
	!else if (obj has female) {
	!	obj.grammatical_gender = 3;
	!}

	return obj.grammatical_gender;
];

! *** Die Printed Inflections aus dem Original wurden komplett gestrichen
!	 und durch neue Routinen ersetzt.

[ SetPreviouslyNamedNoun obj;
	! *** nur I7/GerX: Für Textersetzungen, die sich auf das zuletzt genannte
	!	 Objekt beziehen (z.B. [ist], [hat], [wird] usw.).
	pnn = obj;
];


[ GDer obj; CDefArt(obj, 0); ];
[ GDes obj; CDefArt(obj, 1); ];
[ GDem obj; CDefArt(obj, 2); ];
[ GDen obj; CDefArt(obj, 3); ];

[ der obj; DefArt(obj, 0); ];
[ des obj; DefArt(obj, 1); ];
[ dem obj; DefArt(obj, 2); ];
[ den obj; DefArt(obj, 3); ];

[ GEin obj;   CIndefArt(obj, 0); ];
[ GEines obj; CIndefArt(obj, 1); ];
[ GEinem obj; CIndefArt(obj, 2); ];
[ GEinen obj; CIndefArt(obj, 3); ];

[ ein obj;   IndefArt(obj, 0); ];
[ eines obj; IndefArt(obj, 1); ];
[ einem obj; IndefArt(obj, 2); ];
[ einen obj; IndefArt(obj, 3); ];

[ GKein obj;   RunCapitalised(NegativeArt, obj, 0); ];
[ GKeines obj; RunCapitalised(NegativeArt, obj, 1); ];
[ GKeinem obj; RunCapitalised(NegativeArt, obj, 2); ];
[ GKeinen obj; RunCapitalised(NegativeArt, obj, 3); ];

[ kein obj;   NegativeArt(obj, 0); ];
[ keines obj; NegativeArt(obj, 1); ];
[ keinem obj; NegativeArt(obj, 2); ];
[ keinen obj; NegativeArt(obj, 3); ];

[ er obj;     PersonalPron(obj, 0); ];
[ seiner obj; PersonalPron(obj, 1); ];
[ ihm obj;    PersonalPron(obj, 2); ];
[ ihn obj;    PersonalPron(obj, 3); ];

[ GEr obj;     RunCapitalised(PersonalPron, obj, 0); ];
[ GSeiner obj; RunCapitalised(PersonalPron, obj, 1); ];
[ GIhm obj;    RunCapitalised(PersonalPron, obj, 2); ];
[ GIhn obj;    RunCapitalised(PersonalPron, obj, 3); ];

[ ist obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "ist"; return; }
	if (obj == player) { print "bist"; return; }
	if (obj has pluralname) print "sind"; else print "ist";
];

[ hat obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "hat"; return; }
	if (obj == player) { print "hast"; return; }
	if (obj has pluralname) print "haben"; else print "hat";
];

[ wird obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "wird"; return; }
	if (obj == player) { print "wirst"; return; }
	if (obj has pluralname) print "werden"; else print "wird";
];


[ betritt obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "betritt"; return; }
	if (obj == player) { print "betrittst"; return; }
	if (obj has pluralname) print "betreten"; else print "betritt";
];

[ gibt obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "gibt"; return; }
	if (obj == player) { print "gibst"; return; }
	if (obj has pluralname) print "geben"; else print "gibt";
];

[ isst obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "isst"; return; }
	if (obj == player) { print "isst"; return; }
	if (obj has pluralname) print "essen"; else print "isst";
];

[ kann obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "kann"; return; }
	if (obj == player) { print "kannst"; return; }
	if (obj has pluralname) print "können"; else print "kann";
];

[ mag obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "mag"; return; }
	if (obj == player) { print "magst"; return; }
	if (obj has pluralname) print "mögen"; else print "mag";
];

[ nimmt obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "nimmt"; return; }
	if (obj == player) { print "nimmst"; return; }
	if (obj has pluralname) print "nehmen"; else print "nimmt";
];

[ sieht obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "sieht"; return; }
	if (obj == player) { print "siehst"; return; }
	if (obj has pluralname) print "sehen"; else print "sieht";
];

[ traegt obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "trägt"; return; }
	if (obj == player) { print "trägst"; return; }
	if (obj has pluralname) print "tragen"; else print "trägt";
];

[ verlaesst obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "verlässt"; return; }
	if (obj == player) { print "verlässt"; return; }
	if (obj has pluralname) print "verlassen"; else print "verlässt";
];


[ _t obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "t"; return; }
	if (obj == player) { print "st"; return; }
	if (obj has pluralname) print "en"; else print "t";
];

[ _et obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "et"; return; }
	if (obj == player) { print "est"; return; }
	if (obj has pluralname) print "en"; else print "et";
];

[ _e obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print "e"; return; }
	if (obj == player) { print "est"; return; }
	if (obj has pluralname) print "en"; else print "e";
];

[ plur pl sg obj;
	SetPreviouslyNamedNoun(obj);
	if (obj == 0) { print (string) sg; return; }
	if (obj has pluralname) print (string) pl; else print (string) sg;
];

[ GAuf obj; if (obj has supporter) print "Auf"; else print "In"; ];

[ GVon obj; if (obj has supporter) print "Von"; else print "Aus"; ];

[ auf obj; if (obj has supporter) print "auf"; else print "in"; ];

[ von obj; if (obj has supporter) print "von"; else print "aus"; ];


[ ParsedAuf  obj	i w num_words entry_size;

	! *** (03.02.2011) Hier wird geprüft, ob in der geparsten Spielereingabe eine
	! der Präpositionen "auf" oder "in" enthalten ist. Wenn ja, wird diese
	! ausgegeben; wenn nicht, richtet sich die Präposition nach der
	! Beschaffenheit des Objekts (supporter/container).

#Ifdef TARGET_ZCODE;
	entry_size = 2;
#Ifnot;
	entry_size = 3;
#Endif; ! TARGET_ZCODE
	num_words = WordCount();
	for (i=0 : i < num_words: i++) {
		w = parse-->(i*entry_size + 1);
		if ( w == 'auf' or 'in' && (w->#dict_par1 & 8) ) {
			! $1000 (8) ist das Bit für Präpositionen
			print (address) w; return;
		}
	}
	print (auf) obj;
];
-).


Section - Messages

The adjust light rule response (A) is "Es ist nun stockfinster hier!".
	[was "[It] [are] [if story tense is present tense]now [end if]pitch dark in [if story tense is present tense]here[else]there[end if]!"]

The generate action rule response (A) is "(Es werden nur die ersten sechzehn Objekte berücksichtigt.)[command clarification break]".
	[was "(considering the first sixteen objects only)[command clarification break]"]
The generate action rule response (B) is "Hier gibt es nichts zu tun!".
	[was "Nothing to do!"]

The basic accessibility rule response (A) is "Versuch es mit etwas, das mehr Substanz hat.".
	[was "You must name something more substantial."]

The basic visibility rule response (A) is "Es ist stockfinster, [du] siehst nichts.".
	[was "[It] [are] pitch dark, and [we] [can't see] a thing."]

The requested actions require persuasion rule response (A) is "[Der noun] [hat] Besseres zu tun.".
	[was "[The noun] [have] better things to do."]

The carry out requested actions rule response (A) is "[Der noun] [kann] das nicht tun.".
	[was "[The noun] [are] unable to do that."]

The access through barriers rule response (A) is "[Den noun] gibt es hier nicht.".
	[was "[regarding the noun][Those] [aren't] available."]

The can't reach inside closed containers rule response (A) is "[Der noun] [ist] nicht offen.".
	[was "[The noun] [aren't] open."]

The can't reach inside rooms rule response (A) is "Du kannst nicht in [den noun] hineingreifen.".
	[was "[We] [can't] reach into [the noun]."]

The can't reach outside closed containers rule response (A) is "[Der noun] [ist] nicht offen.".
	[was "[The noun] [aren't] open."]

The list writer internal rule response (A) is " (".
	[was " ("]
The list writer internal rule response (B) is ")".
	[was ")"]
The list writer internal rule response (C) is " und ".
	[was " and "]
The list writer internal rule response (D) is "[*der*] Licht spend[et]".
	[was "providing light"]
The list writer internal rule response (E) is "[*der*] geschlossen [ist]".
	[was "closed"]
The list writer internal rule response (F) is "[*der*] leer [ist]".
	[was "empty"]
The list writer internal rule response (G) is "[*der*] geschlossen und leer [ist]".
	[was "closed and empty"]
The list writer internal rule response (H) is "[*der*] geschlossen [ist] und Licht spend[et]".
	[was "closed and providing light"]
The list writer internal rule response (I) is "[*der*] leer [ist] und Licht spend[et]".
	[was "empty and providing light"]
The list writer internal rule response (J) is "[*der*] geschlossen und leer [ist] und Licht spend[et]".
	[was "closed, empty[if serial comma option is active],[end if] and providing light"]
The list writer internal rule response (K) is "[*der*] angezogen [ist] und Licht spend[et]".
	[was "providing light and being worn"]
The list writer internal rule response (L) is "[*der*] angezogen [ist]".
	[was "being worn"]
The list writer internal rule response (M) is "[*der*] offen [ist]".
	[was "open"]
The list writer internal rule response (N) is "[*der*] offen und leer [ist]".
	[was "open but empty"]
The list writer internal rule response (O) is "[*der*] geschlossen [ist]".
	[was "closed"]
The list writer internal rule response (P) is "[*der*] abgeschlossen [ist]".
	[was "closed and locked"]
The list writer internal rule response (Q) is "darin ".
	[was "containing"]
The list writer internal rule response (R) is "darauf ".
	[was "on [if the noun is a person]whom[otherwise]which[end if] "]
The list writer internal rule response (S) is ", darauf ".
	[was ", on top of [if the noun is a person]whom[otherwise]which[end if] "]
The list writer internal rule response (T) is "darin ".
	[was "in [if the noun is a person]whom[otherwise]which[end if] "]
The list writer internal rule response (U) is ", darin ".
	[was ", inside [if the noun is a person]whom[otherwise]which[end if] "]
The list writer internal rule response (V) is "[regarding list writer internals][ist-sind bezogen auf Liste]".
	[was "[regarding list writer internals][are]"]
To say ist-sind bezogen auf Liste: (- if (prior_named_list > 1 ) print "sind";  else print "ist"; -).

The list writer internal rule response (W) is "[regarding list writer internals][ist] nichts".
	[was "[regarding list writer internals][are] nothing"]
The list writer internal rule response (X) is "Nichts".
	[was "Nothing"]
The list writer internal rule response (Y) is "nichts".
	[was "nothing"]

The action processing internal rule response (A) is "[bracket][Der noun] kann keine ans Spiel gerichteten Anweisungen ausführen.[close bracket]".
	[was "[bracket]That command asks to do something outside of play, so it can only make sense from you to me. [The noun] cannot be asked to do this.[close bracket]"]
The action processing internal rule response (B) is "Du musst den Namen eines Objekts angeben.".
	[was "You must name an object."]
The action processing internal rule response (C) is "Hier kannst [du] keinen Namen eines Objekts angeben.".
	[was "You may not name an object."]
The action processing internal rule response (D) is "Du musst ein Hauptwort angeben.".
	[was "You must supply a noun."]
The action processing internal rule response (E) is "Du kannst kein Hauptwort angeben.".
	[was "You may not supply a noun."]
The action processing internal rule response (F) is "Du musst noch ein zweites Objekt angeben.".
	[was "You must name a second object."]
The action processing internal rule response (G) is "Hier kannst [du] kein zweites Objekt angeben.".
	[was "You may not name a second object."]
The action processing internal rule response (H) is "Du musst ein zweites Hauptwort angeben.".
	[was "You must supply a second noun."]
The action processing internal rule response (I) is "Du kannst hier kein zweites Hauptwort angeben.".
	[was "You may not supply a second noun."]
The action processing internal rule response (J) is "(Da etwas Dramatisches passiert ist, wurde die Liste [deiner] Anweisungen nicht komplett ausgeführt.)".
	[was "(Since something dramatic has happened, your list of commands has been cut short.)"]
The action processing internal rule response (K) is "Diesen Befehl habe ich nicht verstanden.".
	[was "I didn't understand that instruction."]

The parser error internal rule response (A) is "Diesen Satz habe ich nicht verstanden.".
	[was "I didn't understand that sentence."]
The parser error internal rule response (B) is "Ich habe nur Folgendes verstanden: ".
	[was "I only understood you as far as wanting to "]
The parser error internal rule response (C) is "Ich habe nur verstanden, dass [du] irgendwohin gehen möchtest ".
	[was "I only understood you as far as wanting to (go) "]
The parser error internal rule response (D) is "Diese Zahl habe ich nicht verstanden.".
	[was "I didn't understand that number."]
The parser error internal rule response (E) is "So etwas kannst [du] hier nicht sehen.".
	[was "[We] [can't] see any such thing."]
The parser error internal rule response (F) is "Du scheinst nicht alles gesagt zu haben!".
	[was "You seem to have said too little!"]
The parser error internal rule response (G) is "Aber das hast [du] nicht bei [dir]!".
	[was "[We] [aren't] holding that!"]
The parser error internal rule response (H) is "Hier kannst [du] nur ein Objekt angeben.".
	[was "You can't use multiple objects with that verb."]
The parser error internal rule response (I) is "Du kannst in jedem Satz nur einmal Listen von Objekten angeben.".
	[was "You can only use multiple objects once on a line."]
The parser error internal rule response (J) is "Mir ist nicht klar, worauf sich ['][pronoun i6 dictionary word]['] bezieht.".
	[was "I'm not sure what ['][pronoun i6 dictionary word]['] refers to."]
The parser error internal rule response (K) is "Du siehst ['][pronoun i6 dictionary word]['] ([den noun]) hier im Moment nicht.".
	[was "[We] [can't] see ['][pronoun i6 dictionary word]['] ([the noun]) at the moment."]
The parser error internal rule response (L) is "Du hast etwas ausgeschlossen, das gar nicht zur Ausgangsmenge gehört!".
	[was "You excepted something not included anyway!"]
The parser error internal rule response (M) is "Das kannst [du] nur mit Lebewesen sinnvoll machen.".
	[was "You can only do that to something animate."]
The parser error internal rule response (N) is "Ich habe dieses Verb nicht verstanden.".
	[was "That's not a verb I [if American dialect option is active]recognize[otherwise]recognise[end if]."]
The parser error internal rule response (O) is "Damit brauchst [du] [dich] in diesem Spiel nicht zu beschäftigen.".
	[was "That's not something you need to refer to in the course of this game."]
The parser error internal rule response (P) is "Das Satzende habe ich leider nicht verstanden.".
	[was "I didn't understand the way that finished."]
The parser error internal rule response (Q) is "[if number understood is 0]Nichts [otherwise]Nur [number understood in words][end if][if number understood is 1]es[end if] davon [if number understood is 1]ist[else]sind[end if] verfügbar.".
	[was "[if number understood is 0]None[otherwise]Only [number understood in words][end if] of those [regarding the number understood][are] available."]
The parser error internal rule response (R) is "Dieses Hauptwort macht in diesem Zusammenhang keinen Sinn.".
	[was "That noun did not make sense in this context."]
The parser error internal rule response (S) is "Wenn [du] einen Befehl wie 'Häschen, hüpf' wiederholen willst, sag 'nochmal', nicht 'Häschen, nochmal'.".
	[was "To repeat a command like 'frog, jump', just say 'again', not 'frog, again'."]
The parser error internal rule response (T) is "Du kannst den Satz nicht mit einem Komma beginnen.".
	[was "You can't begin with a comma."]
The parser error internal rule response (U) is "Du möchtest wahrscheinlich jemandem eine Anweisung erteilen, aber mir ist nicht klar wem.".
	[was "You seem to want to talk to someone, but I can't see whom."]
The parser error internal rule response (V) is "Mit [dem noun] kann man nicht reden.".
	[was "You can't talk to [the noun]."]
The parser error internal rule response (W) is "Um mit jemandem zu reden, benutze bitte 'Jemand, hallo'.".
	[was "To talk to someone, try 'someone, hello' or some such."]
The parser error internal rule response (X) is "Wie bitte?".
	[was "I beg your pardon?"]

The parser nothing error internal rule response (A) is "Es gibt hier nichts zu tun!".
	[was "Nothing to do!"]
The parser nothing error internal rule response (B) is "Hier ist aber nichts, womit [du] das tun kannst.".
	[was "[There] [adapt the verb are from the third person plural] none at all available!"]
The parser nothing error internal rule response (C) is "Das scheint zu [dem noun] zu gehören.".
	[was "[regarding the noun][Those] [seem] to belong to [the noun]."]
The parser nothing error internal rule response (D) is "[Der noun] [ist] weder ein Behälter noch eine Ablage.".
	[was "[regarding the noun][Those] [can't] contain things."]
The parser nothing error internal rule response (E) is "[Der noun] [ist] nicht offen.".
	[was "[The noun] [aren't] open."]
The parser nothing error internal rule response (F) is "[Der noun] [ist] leer.".
	[was "[The noun] [are] empty."]

The darkness name internal rule response (A) is "Dunkelheit".
	[was "Darkness"]

The parser command internal rule response (A) is "Da gibt es leider nichts zu korrigieren.".
	[was "Sorry, that can't be corrected."]
The parser command internal rule response (B) is "Denk [dir] nichts weiter.".
	[was "Think nothing of it."]
The parser command internal rule response (C) is "Mit 'undo' kann immer nur ein Wort korrigiert werden.".
	[was "'Oops' can only correct a single word."]
The parser command internal rule response (D) is "Das kann man nicht wiederholen.".
	[was "You can hardly repeat that."]

The parser clarification internal rule response (A) is "Wen meinst [du]: ".
	[was "Who do you mean, "]
The parser clarification internal rule response (B) is "Was meinst [du]: ".
	[was "Which do you mean, "]
The parser clarification internal rule response (C) is "Hier kannst [du] nur ein Objekt angeben. Welches?".
	[was "Sorry, you can only have one item here. Which exactly?"]
The parser clarification internal rule response (D) is "[Wen noun] [if the noun is the player]willst [du][else]soll [der noun][end if] [parser command so far]?".
	[was "Whom do you want [if the noun is not the player][the noun] [end if]to [parser command so far]?"]

To say Wen (O - object) :
	(- PrintWemCommand({o}); -).

The parser clarification internal rule response (E) is "[Womit noun] [if the noun is the player]willst [du][else]soll [der noun][end if] [parser command so far]?".
	[was "What do you want [if the noun is not the player][the noun] [end if]to [parser command so far]?"]

To say Womit (O - object) :
	(- PrintWomitCommand({o}); -).

The parser clarification internal rule response (F) is "diese Sachen".
	[was "those things"]
The parser clarification internal rule response (G) is "das".
	[was "that"]
The parser clarification internal rule response (H) is " oder ".
	[was " or "]

The yes or no question internal rule response (A) is "Bitte antworte mit Ja oder Nein.".
	[was "Please answer yes or no."]

The print protagonist internal rule response (A) is "Du".
	[was "[We]"]
The print protagonist internal rule response (B) is "und".
	[was "[ourselves]"]
The print protagonist internal rule response (C) is "[dein] früheres Selbst".
	[was "[our] former self"]

The standard implicit taking rule response (A) is "(Dazu hebst [du] [den noun] erst auf.)[command clarification break]".
	[was "(first taking [the noun])[command clarification break]"]
The standard implicit taking rule response (B) is "([Der second noun] [nimmt] zuerst [den noun])[command clarification break]".
	[was "([the second noun] first taking [the noun])[command clarification break]"]

The print obituary headline rule response (A) is " Du bist gestorben ".
	[was " You have died "]
The print obituary headline rule response (B) is " Du hast gewonnen ".
	[was " You have won "]
The print obituary headline rule response (C) is " Ende ".
	[was " The End "]

The immediately undo rule response (A) is "Die Verwendung von 'UNDO' ist in diesem Spiel nicht erlaubt.".
	[was "The use of 'undo' is forbidden in this story."]
The immediately undo rule response (B) is "Erst machen, dann rückgängig machen.".
	[was "You can't 'undo' what hasn't been done!"]
The immediately undo rule response (C) is "Dein Interpreter kann leider keine Spielzüge rückgängig machen.".
	[was "Your interpreter does not provide 'undo'. Sorry!"]
The immediately undo rule response (D) is "Der Spielzug konnte nicht rückgängig gemacht werden.".
	[was "'Undo' failed. Sorry!"]
The immediately undo rule response (E) is "[bracket]Der letzte Zug wurde rückgängig gemacht.[close bracket]".
	[was "[bracket]Previous turn undone.[close bracket]"]
The immediately undo rule response (F) is "Du kannst keine weiteren Spielzüge rückgängig machen.".
	[was "'Undo' capacity exhausted. Sorry!"]

The quit the game rule response (A) is "Möchtest [du] das Spiel wirklich beenden? ".
	[was "Are you sure you want to quit? "]

The save the game rule response (A) is "Der Spielstand konnte nicht abgespeichert werden.".
	[was "Save failed."]
The save the game rule response (B) is "In Ordnung.".
	[was "Ok."]

The restore the game rule response (A) is "Laden des Spielstands fehlgeschlagen.".
	[was "Restore failed."]
The restore the game rule response (B) is "In Ordnung.".
	[was "Ok."]

The restart the game rule response (A) is "Möchtest [du] wirklich neu starten? ".
	[was "Are you sure you want to restart? "]
The restart the game rule response (B) is "Fehlgeschlagen.".
	[was "Failed."]

The verify the story file rule response (A) is "Die Spieldatei ist intakt.".
	[was "The game file has verified as intact."]
The verify the story file rule response (B) is "Die Spieldatei ist korrupt.".
	[was "The game file did not verify as intact, and may be corrupt."]

The switch the story transcript on rule response (A) is "Es wird bereits ein Protokoll mitgeschrieben.".
	[was "Transcripting is already on."]
The switch the story transcript on rule response (B) is "Es wird nun ein Protokoll angelegt von".
	[was "Start of a transcript of:"]
The switch the story transcript on rule response (C) is "Der Versuch, ein Protokoll anzulegen, scheiterte.".
	[was "Attempt to begin transcript failed."]

The switch the story transcript off rule response (A) is "Es wird gar kein Protokoll mitgeschrieben.".
	[was "Transcripting is already off."]
The switch the story transcript off rule response (B) is "[line break]Ende des Protokolls.".
	[was "[line break]End of transcript."]
The switch the story transcript off rule response (C) is "Der Versuch, das Protokoll zu schließen, scheiterte.".
	[was "Attempt to end transcript failed."]

The announce the score rule response (A) is "[if the story has ended]In diesem Spiel [otherwise]Bislang [end if]hast [du] [score] von [maximum score] möglichen Punkten in [turn count] [if turn count is 1]Zug[else]Zügen[end if] erreicht".
	[was "[if the story has ended]In that game you scored[otherwise]You have so far scored[end if] [score] out of a possible [maximum score], in [turn count] turn[s]"]
The announce the score rule response (B) is ", mit dem Rang ".
	[was ", earning you the rank of "]
The announce the score rule response (C) is "In diesem Spiel gibt es keine Punkte.".
	[was "[There] [are] no score in this story."]
The announce the score rule response (D) is "[bracket]Du hast gerade [number understood] Punkt[if number understood > 1]e[end if] bekommen.[close bracket]".
	[was "[bracket]Your score has just gone up by [number understood in words] point[s].[close bracket]"]
The announce the score rule response (E) is "[bracket]Du hast gerade [number understood] Punkt[if number understood > 1]e[end if] verloren.[close bracket]".
	[was "[bracket]Your score has just gone down by [number understood in words] point[s].[close bracket]"]

The standard report preferring abbreviated room descriptions rule response (A) is " ist nun im superknappen Modus, der immer nur die kurze Raumbeschreibung anzeigt, auch wenn dieser zum ersten Mal betreten wird.".
	[was " is now in its 'superbrief' mode, which always gives short descriptions of locations (even if you haven't been there before)."]

The standard report preferring unabbreviated room descriptions rule response (A) is " ist nun im ausführlichen Modus, der immer die langen Raumbeschreibungen zeigt, auch wenn dieser schon einmal besucht wurde.".
	[was " is now in its 'verbose' mode, which always gives long descriptions of locations (even if you've been there before)."]

The standard report preferring sometimes abbreviated room descriptions rule response (A) is " ist nun im knappen Modus, in dem Raumbeschreibungen nur beim ersten Betreten eines Raums angezeigt werden.".
	[was " is now in its 'brief' printing mode, which gives long descriptions of places never before visited and short descriptions otherwise."]

The standard report switching score notification on rule response (A) is "Meldungen bei Änderung des Punktestands ein.".
	[was "Score notification on."]

The standard report switching score notification off rule response (A) is "Meldungen bei Änderung des Punktestands aus.".
	[was "Score notification off."]

The announce the pronoun meanings rule response (A) is "Die Pronomen beziehen sich im Moment auf Folgendes:[line break]".
	[was "At the moment, "]

The announce the pronoun meanings rule response (B) is "= ".
	[was "means "]
The announce the pronoun meanings rule response (C) is "ist nicht gesetzt".
	[was "is unset"]
The announce the pronoun meanings rule response (D) is "Dieses Spiel kennt keine Pronomen.".
	[was "no pronouns are known to the game."]

The announce items from multiple object lists rule response (A) is "[current item from the multiple object list]: [run paragraph on]".
	[was "[current item from the multiple object list]: [run paragraph on]"]

The block vaguely going rule response (A) is "Du musst sagen, in welche Richtung [du] gehen möchtest.".
	[was "You'll have to say which compass direction to go in."]

The print the final prompt rule response (A) is "> [run paragraph on]".
	[was "> [run paragraph on]"]


The print the final question rule response (A) is "Möchtest [du] ".
	[was "Would you like to "]
The print the final question rule response (B) is " oder ".
	[was " or "]
The standard respond to final question rule response (A) is "Bitte antworte mit einer der oben genannten Möglichkeiten.".
	[was "Please give one of the answers above."]


The use initial appearance in room descriptions rule response (A) is "Auf [dem item] ".
	[was "On [the item] "]

The describe what's on scenery supporters in room descriptions rule response (A) is "Auf [dem item] ".
	[was "On [the item] "]

The describe what's on mentioned supporters in room descriptions rule response (A) is "Auf [dem item] ".
	[was "On [the item] "]

The print empty inventory rule response (A) is "Du hast nichts bei [dir].".
	[was "[We] [are] carrying nothing."]

The report other people taking inventory rule response (A) is "[Der actor] durchsuch[t] seine Habe.".
	[was "[The actor] [look] through [their] possessions."]

The can't take yourself rule response (A) is "Immer diese Selbstversessenheit.".
	[was "[We] [are] always self-possessed."]

The can't take other people rule response (A) is "Das würde [dem noun] bestimmt nicht gefallen.".
	[was "I don't suppose [the noun] [would care] for that."]

The can't take component parts rule response (A) is "[Der noun] schein[t] ein Teil von [dem whole] zu sein.".
	[was "[regarding the noun][Those] [seem] to be a part of [the whole]."]

The can't take people's possessions rule response (A) is "[Der noun] schein[t] [dem owner] zu gehören.".
	[was "[regarding the noun][Those] [seem] to belong to [the owner]."]

The can't take items out of play rule response (A) is "[Den noun] gibt es hier nicht.".
	[was "[regarding the noun][Those] [aren't] available."]

The can't take what you're inside rule response (A) is "Dazu müsstest [du] zunächst [if noun is a supporter]von [dem noun] herunter[otherwise]aus [dem noun] heraus[end if].".
	[was "[We] [would have] to get [if noun is a supporter]off[otherwise]out of[end if] [the noun] first."]

The can't take what's already taken rule response (A) is "Du hast [den noun] bereits.".
	[was "[We] already [have] [regarding the noun][those]."]

The can't take scenery rule response (A) is "Du kannst [den noun] nicht mitnehmen.".
	[was "[regarding the noun][They're] hardly portable."]

The can only take things rule response (A) is "Du kannst [den noun] nicht tragen.".
	[was "[We] [cannot] carry [the noun]."]

The can't take what's fixed in place rule response (A) is "Du kannst [den noun] nicht mitnehmen.".
	[was "[regarding the noun][They're] fixed in place."]

The use player's holdall to avoid exceeding carrying capacity rule response (A) is "(Du verstaust [den transferred item] in [dem current working sack] um Platz zu schaffen.)[command clarification break]".
	[was "(putting [the transferred item] into [the current working sack] to make room)[command clarification break]"]

The can't exceed carrying capacity rule response (A) is "Du trägst bereits zu viele Dinge.".
	[was "[We]['re] carrying too many things already."]

The standard report taking rule response (A) is "In Ordnung.".
	[was "Taken."]
The standard report taking rule response (B) is "[Der actor] [nimmt] [den noun].".
	[was "[The actor] [pick] up [the noun]."]

The can't remove what's not inside rule response (A) is "Aber [der noun] [ist] da gar nicht.".
	[was "But [regarding the noun][they] [aren't] there now."]

The can't remove from people rule response (A) is "[Der noun] gehör[t] offenbar [dem owner].".
	[was "[regarding the noun][Those] [seem] to belong to [the owner]."]

The can't drop yourself rule response (A) is "Dir fehlt die nötige Geschicklichkeit.".
	[was "[We] [lack] the dexterity."]

The can't drop body parts rule response (A) is "Du kannst keinen Teil von [dir] ablegen.".
	[was "[We] [can't drop] part of [ourselves]."]

The can't drop what's already dropped rule response (A) is "[Der noun] [ist] bereits hier.".
	[was "[The noun] [are] already here."]

The can't drop what's not held rule response (A) is "Du hast [den noun] gar nicht.".
	[was "[We] [haven't] got [regarding the noun][those]."]

The can't drop clothes being worn rule response (A) is "(Dazu ziehst [du] [den noun] erst aus.)[command clarification break]".
	[was "(first taking [the noun] off)[command clarification break]"]

The can't drop if this exceeds carrying capacity rule response (A) is "Es ist kein Platz mehr auf [dem noun].".
	[was "[There] [are] no more room on [the receptacle]."]
The can't drop if this exceeds carrying capacity rule response (B) is "Es ist kein Platz mehr in [dem noun].".
	[was "[There] [are] no more room in [the receptacle]."]

The standard report dropping rule response (A) is "In Ordnung.".
	[was "Dropped."]
The standard report dropping rule response (B) is "[Der actor] leg[t] [den noun] hin.".
	[was "[The actor] [put] down [the noun]."]

The can't put something on itself rule response (A) is "Du kannst nichts auf sich selbst ablegen.".
	[was "[We] [can't put] something on top of itself."]

The can't put onto what's not a supporter rule response (A) is "Dinge auf [den second noun] zu tun bringt nichts.".
	[was "Putting things on [the second noun] [would achieve] nothing."]

The can't put clothes being worn rule response (A) is "(Du ziehst [den noun] erst aus.)[command clarification break]".
	[was "(first taking [regarding the noun][them] off)[command clarification break]"]

The can't put if this exceeds carrying capacity rule response (A) is "Es ist kein Platz mehr auf [dem second noun].".
	[was "[There] [are] no more room on [the second noun]."]

The concise report putting rule response (A) is "In Ordnung.".
	[was "Done."]

The standard report putting rule response (A) is "Du legst [den noun] auf [den second noun].".
	[was "[The actor] [put] [the noun] on [the second noun]."]

The can't insert what's already inserted rule response (A) is "[Der noun] [ist] bereits drin.".
	[was "[The noun] [are] already there."]

The can't insert something into itself rule response (A) is "Du kannst nichts in sich selbst legen.".
	[was "[We] [can't put] something inside itself."]

The can't insert into closed containers rule response (A) is "[Der second noun] [ist] geschlossen.".
	[was "[The second noun] [are] closed."]

The can't insert into what's not a container rule response (A) is "[Der second noun] [ist] kein Behälter.". [ +++ 29.06.2023 korrigiert [noun] => [second noun] ]
	[was "[regarding the second noun][Those] [can't contain] things."]

The can't insert clothes being worn rule response (A) is "(Du ziehst [den noun] erst aus.)[command clarification break]".
	[was "(first taking [regarding the noun][them] off)[command clarification break]"]

The can't insert if this exceeds carrying capacity rule response (A) is "Es ist kein Platz mehr auf [dem second noun].".
	[was "[There] [are] no more room in [the second noun]."]

The concise report inserting rule response (A) is "In Ordnung.".
	[was "Done."]

The standard report inserting rule response (A) is "Du legst [den noun] in [den second noun].".
	[was "[The actor] [put] [the noun] into [the second noun]."]

The can't eat unless edible rule response (A) is "[Der noun] [ist] nicht essbar.".
	[was "[regarding the noun][They're] plainly inedible."]

The can't eat clothing without removing it first rule response (A) is "(Du ziehst [den noun] erst aus.)[command clarification break]".
	[was "(first taking [the noun] off)[command clarification break]"]

The can't eat other people's food rule response (A) is "Es könnte sein, dass das [der owner] nicht so gerne [hat].".
	[was "[The owner] [might not appreciate] that."]

The standard report eating rule response (A) is "Du isst [den noun]. Nicht schlecht.".
	[was "[We] [eat] [the noun]. Not bad."]
The standard report eating rule response (B) is "[Der actor] [isst] [den noun].".
	[was "[The actor] [eat] [the noun]."]

The stand up before going rule response (A) is "(Dazu steigst [du] erst von [dem chaise])[command clarification break]".
	[was "(first getting off [the chaise])[command clarification break]"]

The can't travel in what's not a vehicle rule response (A) is "Du musst zuerst von [dem nonvehicle] runter.".
	[was "[We] [would have] to get off [the nonvehicle] first."]
The can't travel in what's not a vehicle rule response (B) is "Du musst zuerst aus [dem nonvehicle] raus.".
	[was "[We] [would have] to get out of [the nonvehicle] first."]

The can't go through undescribed doors rule response (A) is "Du kannst nicht in diese Richtung gehen.".
	[was "[We] [can't go] that way."]

The can't go through closed doors rule response (A) is "(Du öffnest zuerst [den door gone through].)[command clarification break]".
	[was "(first opening [the door gone through])[command clarification break]"]

The can't go that way rule response (A) is "Du kannst nicht in diese Richtung gehen.".
	[was "[We] [can't go] that way."]
The can't go that way rule response (B) is "Das geht nicht, [der door gone through] führ[t] nirgendwohin.".
	[was "[We] [can't], since [the door gone through] [lead] nowhere."]

The describe room gone into rule response (A) is "[Der actor] geh[t] hinauf".
	[was "[The actor] [go] up"]
The describe room gone into rule response (B) is "[Der actor] geh[t] hinunter".
	[was "[The actor] [go] down"]
The describe room gone into rule response (C) is "[Der actor] geh[t] nach [noun]".
	[was "[The actor] [go] [noun]"]
The describe room gone into rule response (D) is "[Der actor] komm[t] von oben herunter".
	[was "[The actor] [arrive] from above"]
The describe room gone into rule response (E) is "[Der actor] komm[t] von unten herauf".
	[was "[The actor] [arrive] from below"]
The describe room gone into rule response (F) is "[Der actor] komm[t] von [back way]".
	[was "[The actor] [arrive] from [the back way]"]
The describe room gone into rule response (G) is "[Der actor] komm[t]".
	[was "[The actor] [arrive]"]
The describe room gone into rule response (H) is "[Der actor] erreich[t] [den room gone to] von oben".
	[was "[The actor] [arrive] at [the room gone to] from above"]
The describe room gone into rule response (I) is "[Der actor] erreich[t] [den room gone to] von unten".
	[was "[The actor] [arrive] at [the room gone to] from below"]
The describe room gone into rule response (J) is "[Der actor] erreich[t] [den room gone to] von [back way]".
	[was "[The actor] [arrive] at [the room gone to] from [the back way]"]
The describe room gone into rule response (K) is "[Der actor] geh[t] durch [den noun]".
	[was "[The actor] [go] through [the noun]"]
The describe room gone into rule response (L) is "[Der actor] komm[t] von [dem noun]".
	[was "[The actor] [arrive] from [the noun]"]
The describe room gone into rule response (M) is "auf [dem vehicle gone by]".
	[was "on [the vehicle gone by]"]
The describe room gone into rule response (N) is "in [dem vehicle gone by]".
	[was "in [the vehicle gone by]"]
The describe room gone into rule response (O) is ", [den thing gone with] vor sich her schiebend, und [dich] dazu".
	[was ", pushing [the thing gone with] in front, and [us] along too"]
The describe room gone into rule response (P) is ", [den thing gone with] vor sich her schiebend".
	[was ", pushing [the thing gone with] in front"]
The describe room gone into rule response (Q) is ", [den thing gone with] aus dem Weg schiebend".
	[was ", pushing [the thing gone with] away"]
The describe room gone into rule response (R) is ", [den thing gone with] hineinschiebend".
	[was ", pushing [the thing gone with] in"]
The describe room gone into rule response (S) is ", [dich] mitziehend".
	[was ", taking [us] along"]

The can't enter what's already entered rule response (A) is "Aber [du] bist schon auf [dem noun].".
	[was "But [we]['re] already on [the noun]."]
The can't enter what's already entered rule response (B) is "Aber [du] bist schon in [dem noun].".
	[was "But [we]['re] already in [the noun]."]

The can't enter what's not enterable rule response (A) is "Du kannst auf [dem noun] nicht stehen.".
	[was "[regarding the noun][They're] not something [we] [can] stand on."]
The can't enter what's not enterable rule response (B) is "Du kannst auf [dem noun] nicht sitzen".
	[was "[regarding the noun][They're] not something [we] [can] sit down on."]
The can't enter what's not enterable rule response (C) is "Du kannst auf [dem noun] nicht liegen".
	[was "[regarding the noun][They're] not something [we] [can] lie down on."]
The can't enter what's not enterable rule response (D) is "Du kannst [den noun] nicht betreten.".
	[was "[regarding the noun][They're] not something [we] [can] enter."]

The can't enter closed containers rule response (A) is "Du kannst nicht in [den noun] wenn [er] geschlossen [ist].".
	[was "[We] [can't get] into the closed [noun]."]

The can't enter if this exceeds carrying capacity rule response (A) is "Es ist kein Platz mehr auf [dem noun].".
	[was "[There] [are] no more room on [the noun]."]
The can't enter if this exceeds carrying capacity rule response (B) is "Es ist kein Platz mehr in [dem noun].".
	[was "[There] [are] no more room in [the noun]."]

The can't enter something carried rule response (A) is "Du kannst nur frei stehende Dinge betreten.".
	[was "[We] [can] only get into something free-standing."]

The implicitly pass through other barriers rule response (A) is "(Dazu steigst [du] erst von [dem noun].)[command clarification break]".
	[was "(getting off [the current home])[command clarification break]"]
The implicitly pass through other barriers rule response (B) is "(Dazu steigst [du] erst aus [dem noun].)[command clarification break]".
	[was "(getting out of [the current home])[command clarification break]"]
The implicitly pass through other barriers rule response (C) is "(Du steigst zuerst auf [den target].)[command clarification break]".
	[was "(getting onto [the target])[command clarification break]"]
The implicitly pass through other barriers rule response (D) is "(Du betrittst zuerst [den target].)[command clarification break]".
	[was "(getting into [the target])[command clarification break]"]
The implicitly pass through other barriers rule response (E) is "(Du betrittst zuerst [den target])[command clarification break]".
	[was "(entering [the target])[command clarification break]"]

The standard report entering rule response (A) is "Du [report-entering-a] [den noun].".
	[was "[We] [get] onto [the noun]."]
To say report-entering-a: (-
	switch (verb_word) {
		'tritt', 'tret': 		print "trittst auf";
		'geh':					print "gehst auf";
		'kletter':				print "kletterst auf";
		'lieg', 'leg':			print "legst ", (dich), " auf";
		'sitz', 'setz':			print "setzt dich auf";
		'stell', 'steh':		print "stellst dich auf";
		default:				print "steigst auf";
	}
-).

The standard report entering rule response (B) is "Du [report-entering-b] [den noun].".
	[was "[We] [get] into [the noun]."]
To say report-entering-b: (-
	switch (verb_word) {
		'betritt', 'betret': 	print "betrittst";
		'geh':					print "gehst in";
		'kletter':				print "kletterst in";
		'lieg', 'leg':			print "legst dich in";
		'sitz', 'setz':			print "setzt dich in";
		'stell', 'steh':		print "stellst dich in";
		default:				print "steigst in";
	}
-).

The standard report entering rule response (C) is "[Der actor] [betritt] [den noun].".
	[was "[The actor] [get] into [the noun]."]
The standard report entering rule response (D) is "[Der actor] steig[t] auf [den noun].".
	[was "[The actor] [get] onto [the noun]."]

The can't exit when not inside anything rule response (A) is "Aber [du] bist im Moment nirgendwo drin.".
	[was "But [we] [aren't] in anything at the [if story tense is present tense]moment[otherwise]time[end if]."]

The can't exit closed containers rule response (A) is "Du kannst [den cage] nicht verlassen, wenn [er] geschlossen [ist].".
	[was "You can't get out of the closed [cage]."]

The standard report exiting rule response (A) is "Du steigst von [dem container exited from] herunter.".
	[was "[We] [get] off [the container exited from]."]
The standard report exiting rule response (B) is "Du [report-exiting-a] [dem container exited from].".
	[was "[We] [get] out of [the container exited from]."]
To say report-exiting-a: (-
	switch (verb_word) {
		'geh':					print "gehst aus";
		'kletter':				print "kletterst aus";
		'tritt', 'tret':		print "trittst aus";
		default:				print "steigst aus";
	}
-).

The standard report exiting rule response (C) is "[Der actor] [verlässt] [den container exited from].".
	[was "[The actor] [get] out of [the container exited from]."]

The can't get off things rule response (A) is "Aber [du] bist gar nicht auf [dem noun].".
	[was "But [we] [aren't] on [the noun] at the [if story tense is present tense]moment[otherwise]time[end if]."]

The standard report getting off rule response (A) is "Du steigst von [dem noun] herunter.".
	[was "[The actor] [get] off [the noun]."]

The room description body text rule response (A) is "Es ist stockfinster, [du] siehst nichts.".
	[was "[It] [are] pitch dark, and [we] [can't see] a thing."]

The other people looking rule response (A) is "[Der actor] [sieht] sich um.".
	[was "[The actor] [look] around."]

The examine directions rule response (A) is "Du siehst nichts Unerwartetes in dieser Richtung.".
	[was "[We] [see] nothing unexpected in that direction."]

Carry out examining (this is the german examine containers rule):
	if the noun is a container:
		if the noun is open or the noun is transparent:
			if something described which is not scenery is in the noun and something which
				is not the player is in the noun:
				say "In [dem noun] siehst [du] " (A);
				list the contents of the noun with accusative case, as a sentence, tersely, not listing
					concealed items;
				say ".";
				now examine text printed is true;
			otherwise if examine text printed is false:
				if the player is in the noun:
					make no decision;
				say "[Der noun] [ist] leer." (B);
				now examine text printed is true;

The german examine containers rule is listed instead of the examine containers rule in the Carry out examining rulebook.


The examine devices rule response (A) is "[Der noun] [ist] [if the noun is switched on]ein[otherwise]aus[end if]geschaltet.".
	[was "[The noun] [are] [if story tense is present tense]currently [end if]switched [if the noun is switched on]on[otherwise]off[end if]."]

Carry out examining (this is the german examine supporters rule):
	if the noun is a supporter:
		if something described which is not scenery is on the noun and something which is
			not the player is on the noun:
			say "Auf [dem noun] siehst [du] " (A);
			list the contents of the noun with accusative case, as a sentence, tersely, not listing
				concealed items, including contents, giving brief inventory information;
			say ".";
			now examine text printed is true.

The german examine supporters rule is listed instead of the examine supporters rule in the Carry out examining rulebook.


The examine undescribed things rule response (A) is "Du siehst nichts Besonderes an [dem noun].".
	[was "[We] [see] nothing special about [the noun]."]

The report other people examining rule response (A) is "[Der actor] betracht[et] [den noun] genau.".
	[was "[The actor] [look] closely at [the noun]."]

The standard looking under rule response (A) is "Du findest nichts Interessantes.".
	[was "[We] [find] nothing of interest."]

The report other people looking under rule response (A) is "[Der actor] [sieht] unter [den noun].".
	[was "[The actor] [look] under [the noun]."]

The can't search unless container or supporter rule response (A) is "Du findest nichts Interessantes.".
	[was "[We] [find] nothing of interest."]

The can't search closed opaque containers rule response (A) is "Du kannst nicht hineinschauen, [der noun] [ist] geschlossen.".
	[was "[We] [can't see] inside, since [the noun] [are] closed."]

The standard search containers rule response (A) is "In [dem noun] ".
	[was "In [the noun] "]
The standard search containers rule response (B) is "[Der noun] [ist] leer.".
	[was "[The noun] [are] empty."]

The standard search supporters rule response (A) is "Auf [dem noun] siehst [du] ".
	[was "On [the noun] "]
The standard search supporters rule response (B) is "Auf [dem noun] ist nichts.".
	[was "[There] [are] nothing on [the noun]."]

The report other people searching rule response (A) is "[Der actor] durchsuch[t] [den noun].".
	[was "[The actor] [search] [the noun]."]

The block consulting rule response (A) is "Du findest nichts Interessantes in [dem noun].".
	[was "[We] [discover] nothing of interest in [the noun]."]
The block consulting rule response (B) is "[Der actor] [sieht] sich [den noun] an.".
	[was "[The actor] [look] at [the noun]."]

The can't lock without a lock rule response (A) is "[Den noun] kann man nicht abschließen.".
	[was "[regarding the noun][Those] [don't] seem to be something [we] [can] lock."]

The can't lock what's already locked rule response (A) is "[Der noun] [ist] schon abgeschlossen.".
	[was "[regarding the noun][They're] locked at the [if story tense is present tense]moment[otherwise]time[end if]."]

The can't lock what's open rule response (A) is "Du musst [den noun] dazu erst zumachen.".
	[was "First [we] [would have] to close [the noun]."]

The can't lock without the correct key rule response (A) is "[Der second noun] pass[t] nicht.".
	[was "[regarding the second noun][Those] [don't] seem to fit the lock."]

The standard report locking rule response (A) is "Du schließt [den noun] ab.".
	[was "[We] [lock] [the noun]."]
The standard report locking rule response (B) is "[Der actor] schließ[t] [den noun] ab.".
	[was "[The actor] [lock] [the noun]."]

The can't unlock without a lock rule response (A) is "[Den noun] kann man nicht aufschließen.".
	[was "[regarding the noun][Those] [don't] seem to be something [we] [can] unlock."]

The can't unlock what's already unlocked rule response (A) is "[Der noun] [ist] bereits aufgeschlossen.".
	[was "[regarding the noun][They're] unlocked at the [if story tense is present tense]moment[otherwise]time[end if]."]

The can't unlock without the correct key rule response (A) is "[Der second noun] pass[t] nicht.".
	[was "[regarding the second noun][Those] [don't] seem to fit the lock."]

The standard report unlocking rule response (A) is "Du schließt [den noun] auf.".
	[was "[We] [unlock] [the noun]."]
The standard report unlocking rule response (B) is "[Der actor] schließ[t] [den noun] auf.".
	[was "[The actor] [unlock] [the noun]."]

The can't switch on unless switchable rule response (A) is "Du kannst [den noun] nicht einschalten.".
	[was "[regarding the noun][They] [aren't] something [we] [can] switch."]

The can't switch on what's already on rule response (A) is "[Der noun] [ist] bereits an.".
	[was "[regarding the noun][They're] already on."]

The standard report switching on rule response (A) is "[Der actor] schalt[et] [den noun] ein.".
	[was "[The actor] [switch] [the noun] on."]

The can't switch off unless switchable rule response (A) is "Du kannst [den noun] nicht ausschalten.".
	[was "[regarding the noun][They] [aren't] something [we] [can] switch."]

The can't switch off what's already off rule response (A) is "[Der noun] [ist] bereits aus.".
	[was "[regarding the noun][They're] already off."]

The standard report switching off rule response (A) is "[Der actor] schalt[et] [den noun] aus.".
	[was "[The actor] [switch] [the noun] off."]

The can't open unless openable rule response (A) is "Du kannst [den noun] nicht öffnen.".
	[was "[regarding the noun][They] [aren't] something [we] [can] open."]

The can't open what's locked rule response (A) is "[Der noun] [ist] offenbar abgeschlossen.".
	[was "[regarding the noun][They] [seem] to be locked."]

The can't open what's already open rule response (A) is "[Der noun] [ist] bereits offen.".
	[was "[regarding the noun][They're] already open."]

The reveal any newly visible interior rule response (A) is "Du öffnest [den noun] und findest ".
	[was "[We] [open] [the noun], revealing "]

The standard report opening rule response (A) is "Du öffnest [den noun].".
	[was "[We] [open] [the noun]."]
The standard report opening rule response (B) is "[Der actor] öffn[et] [den noun].".
	[was "[The actor] [open] [the noun]."]
The standard report opening rule response (C) is "[Der noun] öffn[et] sich.".
	[was "[The noun] [open]."]

The can't close unless openable rule response (A) is "Du kannst [den noun] nicht schließen.".
	[was "[regarding the noun][They] [aren't] something [we] [can] close."]

The can't close what's already closed rule response (A) is "[Der noun] [ist] bereits geschlossen.".
	[was "[regarding the noun][They're] already closed."]

The standard report closing rule response (A) is "Du schließ[t] [den noun].".
	[was "[We] [close] [the noun]."]
The standard report closing rule response (B) is "[Der actor] schließ[t] [den noun].".
	[was "[The actor] [close] [the noun]."]
The standard report closing rule response (C) is "[Der noun] schließ[t] sich.".
	[was "[The noun] [close]."]

The can't wear what's not clothing rule response (A) is "Du kannst [den noun] nicht anziehen!".
	[was "[We] [can't wear] [regarding the noun][those]!"]

The can't wear what's not held rule response (A) is "Du hast [den noun] gar nicht!".
	[was "[We] [aren't] holding [regarding the noun][those]!"]

The can't wear what's already worn rule response (A) is "Du trägst [den noun] bereits!".
	[was "[We]['re] already wearing [regarding the noun][those]!"]

The standard report wearing rule response (A) is "Du ziehst [den noun] an.".
	[was "[We] [put] on [the noun]."]
The standard report wearing rule response (B) is "[Der actor] zieh[t] [den noun] an.".
	[was "[The actor] [put] on [the noun]."]

The can't take off what's not worn rule response (A) is "Du trägst [den noun] gar nicht.".
	[was "[We] [aren't] wearing [the noun]."]

The can't exceed carrying capacity when taking off rule response (A) is "Du trägst bereits zu viele Dinge.".
	[was "[We]['re] carrying too many things already."]

The standard report taking off rule response (A) is "Du ziehst [den noun] aus.".
	[was "[We] [take] off [the noun]."]
The standard report taking off rule response (B) is "[Der actor] zieh[t] [den noun] aus.".
	[was "[The actor] [take] off [the noun]."]

The can't give what you haven't got rule response (A) is "Du hast [den noun] gar nicht.".
	[was "[We] [aren't] holding [the noun]."]

The can't give to yourself rule response (A) is "Jetzt willst [du] es [dir] aber mal richtig geben, was?".
	[was "[We] [can't give] [the noun] to [ourselves]."]

The can't give to a non-person rule response (A) is "[Der second noun] [ist] nicht in der Lage etwas anzunehmen.".
	[was "[The second noun] [aren't] able to receive things."]

The can't give clothes being worn rule response (A) is "(Du ziehst [den noun] erst aus.)[command clarification break]".
	[was "(first taking [the noun] off)[command clarification break]"]

The block giving rule response (A) is "[Der second noun] schein[t] nicht besonders interessiert zu sein.".
	[was "[The second noun] [don't] seem interested."]

The can't exceed carrying capacity when giving rule response (A) is "[Der second noun] [trägt] bereits zu viele Dinge.".
	[was "[The second noun] [are] carrying too many things already."]

The standard report giving rule response (A) is "Du gibst [dem second noun] [den noun].".
	[was "[We] [give] [the noun] to [the second noun]."]
The standard report giving rule response (B) is "[Der actor] [gibt] [dir] [den noun].".
	[was "[The actor] [give] [the noun] to [us]."]
The standard report giving rule response (C) is "[Der actor] [gibt] [dem second noun] [den noun].".
	[was "[The actor] [give] [the noun] to [the second noun]."]

The can't show what you haven't got rule response (A) is "Aber [du] hast [den noun] gar nicht.".
	[was "[We] [aren't] holding [the noun]."]

The block showing rule response (A) is "[Der second noun] [ist] nicht beeindruckt.".
	[was "[The second noun] [are] unimpressed."]

The block waking rule response (A) is "Das ist unnötig.".
	[was "That [seem] unnecessary."]

The implicitly remove thrown clothing rule response (A) is "(Dazu ziehst [du] [den noun] erst aus.)[command clarification break]".
	[was "(first taking [the noun] off)[command clarification break]"]

The futile to throw things at inanimate objects rule response (A) is "Witzlos.".
	[was "Futile."]

The block throwing at rule response (A) is "Im kritischen Augenblick fehlen [dir] die Nerven dazu.".
	[was "[We] [lack] the nerve when it [if story tense is the past tense]came[otherwise]comes[end if] to the crucial moment."]

The block attacking rule response (A) is "Gewalt ist keine Lösung.".
	[was "Violence [aren't] the answer to this one."]

The kissing yourself rule response (A) is "Davon hast [du] nicht viel.".
	[was "[We] [don't] get much from that."]

The block kissing rule response (A) is "[Der noun] [mag] das vielleicht nicht.".
	[was "[The noun] [might not] like that."]

The block answering rule response (A) is "Keine Antwort.".
	[was "[There] [are] no reply."]

The telling yourself rule response (A) is "Du unterhältst [dich] ein wenig und erzählst [dir] alte Geschichten.".
	[was "[We] [talk] to [ourselves] a while."]

The block telling rule response (A) is "Keine Antwort.".
	[was "This [provoke] no reaction."]

The block asking rule response (A) is "Keine Antwort.".
	[was "[There] [are] no reply."]

The standard report waiting rule response (A) is "Die Zeit verstreicht.".
	[was "Time [pass]."]
The standard report waiting rule response (B) is "[Der actor] wart[et].".
	[was "[The actor] [wait]."]

The report touching yourself rule response (A) is "Wenn [du] meinst.".
	[was "[We] [achieve] nothing by this."]
The report touching yourself rule response (B) is "[Der actor] berühr[t] sich.".
	[was "[The actor] [touch] [themselves]."]

The report touching other people rule response (A) is "[Der noun] [mag] das vielleicht nicht.".
	[was "[The noun] [might not like] that."]
The report touching other people rule response (B) is "[Der actor] berühr[t] [dich].".
	[was "[The actor] [touch] [us]."]
The report touching other people rule response (C) is "[Der actor] berühr[t] [den noun].".
	[was "[The actor] [touch] [the noun]."]

The report touching things rule response (A) is "Du fühlst nichts Unerwartetes.".
	[was "[We] [feel] nothing unexpected."]
The report touching things rule response (B) is "[Der actor] berühr[t] [den noun].".
	[was "[The actor] [touch] [the noun]."]

The can't wave what's not held rule response (A) is "Du hast [den noun] gar nicht.".
	[was "But [we] [aren't] holding [regarding the noun][those]."]

The report waving things rule response (A) is "Du schwenkst [den noun].".
	[was "[We] [wave] [the noun]."]
The report waving things rule response (B) is "[Der actor] schwenk[t] [den noun].".
	[was "[The actor] [wave] [the noun]."]

The can't pull what's fixed in place rule response (A) is "[Der noun] [ist] nicht beweglich.".
	[was "[regarding the noun][They] [are] fixed in place."]

The can't pull scenery rule response (A) is "Du bist nicht in der Lage dazu.".
	[was "[We] [are] unable to."]

The can't pull people rule response (A) is "[Der noun] [mag] das vielleicht nicht.".
	[was "[The noun] [might not like] that."]

The report pulling rule response (A) is "Nichts passiert.".
	[was "Nothing obvious [happen]."]
The report pulling rule response (B) is "[Der actor] zieh[t] [den noun]".
	[was "[The actor] [pull] [the noun]."]

The can't push what's fixed in place rule response (A) is "[Der noun] [ist] nicht beweglich.".
	[was "[regarding the noun][They] [are] fixed in place."]

The can't push scenery rule response (A) is "Du bist nicht in der Lage dazu.".
	[was "[We] [are] unable to."]

The can't push people rule response (A) is "[Der noun] [mag] das vielleicht nicht.".
	[was "[The noun] [might not like] that."]

The report pushing rule response (A) is "Nichts passiert.".
	[was "Nothing obvious [happen]."]
The report pushing rule response (B) is "[Der actor] schieb[t] [den noun].".
	[was "[The actor] [push] [the noun]."]

The can't turn what's fixed in place rule response (A) is "[Der noun] [ist] nicht beweglich.".
	[was "[regarding the noun][They] [are] fixed in place."]

The can't turn scenery rule response (A) is "Du bist nicht in der Lage dazu.".
	[was "[We] [are] unable to."]

The can't turn people rule response (A) is "[Der noun] [mag] das vielleicht nicht.".
	[was "[The noun] [might not like] that."]

The report turning rule response (A) is "Nichts passiert.".
	[was "Nothing obvious [happen]."]
The report turning rule response (B) is "[Der actor] dreh[t] [den noun].".
	[was "[The actor] [turn] [the noun]."]

The can't push unpushable things rule response (A) is "[Den noun] kannst [du] nicht von einem Ort zum anderen schieben.".
	[was "[The noun] [cannot] be pushed from place to place."]

The can't push to non-directions rule response (A) is "Das ist keine Richtung.".
	[was "[regarding the noun][They] [aren't] a direction."]

The can't push vertically rule response (A) is "Du kannst [den noun] nicht nach oben oder unten schieben.".
	[was "[The noun] [cannot] be pushed up or down."]

The can't push from within rule response (A) is "Von hier aus kannst [du] [den noun] nicht schieben.".
	[was "[The noun] [cannot] be pushed from here."]

The block pushing in directions rule response (A) is "[Den noun] kannst [du] nicht von einem Ort zum anderen schieben.".
	[was "[The noun] [cannot] be pushed from place to place."]

The innuendo about squeezing people rule response (A) is "[Der noun] [mag] das vielleicht nicht.".
	[was "[The noun] [might not like] that."]

The report squeezing rule response (A) is "Das bringt nichts.".
	[was "[We] [achieve] nothing by this."]
The report squeezing rule response (B) is "[Der actor] quetsch[t] [den noun].".
	[was "[The actor] [squeeze] [the noun]."]

The block saying yes rule response (A) is "Das war eine rhetorische Frage.".
	[was "That was a rhetorical question."]

The block saying no rule response (A) is "Das war eine rhetorische Frage.".
	[was "That was a rhetorical question."]

The block burning rule response (A) is "Das ist gefährlich und wenig sinnvoll.".
	[was "This dangerous act [would achieve] little."]

The block waking up rule response (A) is "Die bittere Wahrheit ist: Dies ist kein Traum.".
	[was "The dreadful truth [are], this [are not] a dream."]

The block thinking rule response (A) is "Gute Idee!".
	[was "What a good idea."]

The report smelling rule response (A) is "Du riechst nichts Unerwartetes.".
	[was "[We] [smell] nothing unexpected."]
The report smelling rule response (B) is "[Der actor] riech[t].".
	[was "[The actor] [sniff]."]

The report listening rule response (A) is "Du hörst nichts Unerwartetes.".
	[was "[We] [hear] nothing unexpected."]
The report listening rule response (B) is "[Der actor] lausch[t].".
	[was "[The actor] [listen]."]

The report tasting rule response (A) is "Du schmeckst nichts Unerwartetes.".
	[was "[We] [taste] nothing unexpected."]
The report tasting rule response (B) is "[Der actor] probier[t] [den noun].".
	[was "[The actor] [taste] [the noun]."]

The block cutting rule response (A) is "Es bringt nichts, [den noun] zu zerschneiden.".
	[was "Cutting [regarding the noun][them] up [would achieve] little."]

The report jumping rule response (A) is "Du springst auf der Stelle.".
	[was "[We] [jump] on the spot."]
The report jumping rule response (B) is "[Der actor] spring[t] auf der Stelle.".
	[was "[The actor] [jump] on the spot."]

The block tying rule response (A) is "Dadurch würdest [du] nichts erreichen.".
	[was "[We] [would achieve] nothing by this."]

The block drinking rule response (A) is "Hier gibt es nichts geeignetes zum Trinken.".
	[was "[There's] nothing suitable to drink here."]

The block saying sorry rule response (A) is "Schwamm drüber.".
	[was "Oh, don't [if American dialect option is active]apologize[otherwise]apologise[end if]."]

The block swinging rule response (A) is "Hier gibt es nichts zu schaukeln.".
	[was "[There's] nothing sensible to swing here."]

The can't rub another person rule response (A) is "[Der noun] [mag] das vielleicht nicht.".
	[was "[The noun] [might not like] that."]

The report rubbing rule response (A) is "Du reibst [den noun].".
	[was "[We] [rub] [the noun]."]
The report rubbing rule response (B) is "[Der actor] reib[t] [den noun].".
	[was "[The actor] [rub] [the noun]."]

The block setting it to rule response (A) is "Du kannst [den noun] nicht auf irgendetwas einstellen.".
	[was "No, [we] [can't set] [regarding the noun][those] to anything."]

The report waving hands rule response (A) is "Du winkst.".
	[was "[We] [wave]."]
The report waving hands rule response (B) is "[Der actor] wink[t].".
	[was "[The actor] [wave]."]

The block buying rule response (A) is "Hier gibt es nichts zu kaufen.".
	[was "Nothing [are] on sale."]

The block climbing rule response (A) is "Damit wirst [du] nichts erreichen.".
	[was "Little [are] to be achieved by that."]

The block sleeping rule response (A) is "Du fühlst [dich] nicht müde.".
	[was "[We] [aren't] feeling especially drowsy."]



Section - Parser

Include (-
[ GetGNAOfObject obj case gender;
	if (obj hasnt animate) case = 6;

	! *** (07.12.2011) Den grammatical gender berücksichtigen.
	!     Das muss hier gemacht werden, damit bei Verwendung der Objekteigenschaft
	!     grammatical gender die Pronomen richtig gesetzt werden.

	switch (obj.grammatical_gender) {
		2: gender = male;
		3: gender = female;
		default: gender = neuter;
	}

	! *** Ansonsten greift das herkömmliche Verfahren über Attribute.
	if (obj has male) gender = male;
	if (obj has female) gender = female;
	if (obj has neuter) gender = neuter;
	if (gender == 0) {
		if (case == 0) gender = LanguageAnimateGender;
		else gender = LanguageInanimateGender;
	}
	if (gender == female)   case = case + 1;
	if (gender == neuter)   case = case + 2;
	if (obj has pluralname) case = case + 3;
	return case;
];
-) replacing "GetGNAOfObject".

Include (-
[ PronounValue dword   x obj mask;
	for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
		if (LanguagePronouns-->x == dword) {
			mask = LanguagePronouns-->(x+1);
			obj = LanguagePronouns-->(x+2);
			if (obj && obj ~= NULL) {
				if (mask & $$100000) GenderNotice(obj, male);
				if (mask & $$010000) GenderNotice(obj, female);
				if (mask & $$001000) GenderNotice(obj, neuter);
				if (mask & $$000111) GenderNotice(obj, pluralname);
			}
			return obj;
		}
	return 0;
];
-) replacing "PronounValue".

Include (-
[ GetGNAOfAttribute attr;
	if (attr == male)	return 0;
	if (attr == female)	return 1;
	if (attr == neuter)	return 2;
	return 3;
];
-).

Include (-
[ PronounNotice obj x bm g;
	#ifdef IN_SCOPE_PRONOUN_NOTICE;
	! *** (27.03.2011) Per Use-Option "in-scope pronoun notice"
	!	 kann bewirkt werden, dass die Pronomen nur für
	!	 Objekte gesetzt werden, die in Sicht sind.
	if (TestScope(obj, actor)==false) return;
	#endif;

	#ifndef ROOMS_PRONOUN_NOTICE;
	if (obj has mark_as_room) return;
	#endif;

	if (obj == player) return;

	g = (GetGNAOfObject(obj));

	! Hier den changing_gender in einem Aufwasch miterledigen.
	bm = GenderChanged(obj);

	if (bm >= 0) { ! +++ 19.04.2023 Rückgabewert "-1", wenn das Objekt im Changing Gender Buffer "CG_buffer" nicht gefunden wurde
		bm = PowersOfTwo_TB-->(GetGNAOfAttribute(bm));
		for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
			if (bm & (LanguagePronouns-->(x+1)) ~= 0)
				LanguagePronouns-->(x+2) = obj;
	}

	bm = PowersOfTwo_TB-->g;
	for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
		if (bm & (LanguagePronouns-->(x+1)) ~= 0)
			LanguagePronouns-->(x+2) = obj;

	if (((g % 6) < 3) && (obj has ambigpluralname)) {
		g = g + 3;
		bm = PowersOfTwo_TB-->g;
		for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
			if (bm & (LanguagePronouns-->(x+1)) ~= 0)
				LanguagePronouns-->(x+2) = obj;
	}
];
-) replacing "PronounNotice".

Include (-
[ I7_ExtendedTryNumber wordnum i j;
	i = wn; wn = wordnum; j = NextWordStopped(); wn = i;
	switch (j) {
		'einundzwanzig': return 21;
		'zweiundzwanzig': return 22;
		'dreiundzwanzig': return 23;
		'vierundzwanzig': return 24;
		'fuenfundzwanzig': return 25;
		'sechsundzwanzig': return 26;
		'siebenundzwanzig': return 27;
		'achtundzwanzig': return 28;
		'neunundzwanzig': return 29;
		'dreissig': return 30;
		default: return TryNumber(wordnum);
	}
];
-) replacing "I7_ExtendedTryNumber".

Include (-
[ WordMatch s_ty exact reverse	sl wl sa wa	s; ! +++ nicht in Parser enthalten
	! Prüft, ob das Wort wn mit dem String s übereinstimmt wenn es
	! ein Treffer ist, wird wn weiterbewegt, ansonsten bleibt wn stehen.
	! So kann man diese Routine mehrmals hintereinander, durch ||
	! verknüpft, aufrufen. (Wenn die linke Seite von || wahr ist, wird
	! die rechte nicht mehr ausgeführt. Mit exact==true kann man die
	! genaue Wortlänge erzwingen, ansonsten wird nur so auf s geprüft.
	! Wordmatch("die") erkennt also "Dieselkraftstoff"

	! +++ Der String s_ty wird gepackt übergeben und muss erst in einen
	!     "normalen" String s konvertiert werden (bzw. in StringAdresse sa
	!     und StringLänge sl).

	if (wn > num_words) rfalse;

	#ifdef TARGET_ZCODE;
	if (standard_interpreter ~= 0) {
		StorageForShortName-->0 = 40;
		@output_stream 3 StorageForShortName;
		print (TEXT_TY_Say) s_ty; ! +++ convert s_ty to string in StorageForShortName
		@output_stream -3;
		sa = StorageForShortName + WORDSIZE;
		sl = StorageForShortName-->0;
	}
	#ifnot;
	s = s_ty-->1; ! +++ convert s_ty to string
	sl = Glulx_PrintAnyToArray(StorageForShortName, 40, s); ! write s to StorageForShortName
	sa = StorageForShortName;
	#endif;

	wl = WordLength(wn);
	wa = WordAddress(wn);

	if (reverse) wa = wa + reverse - sl;
	if (wl < sl) rfalse;
	if (exact && wl ~= sl) rfalse;
	wl = sl;
	while (sl-- ) if ((sa++)->0 ~= (wa++)->0) rfalse;
	wn++; return wl;
];
-).

Include (-
[ ParseTokenStopped x y;
	! *** Damit das Gender-Token für den Changing Gender auch nach dem letzten
	!	 Wort noch gelesen werden kann, muss hier zunächst geprüft werden,
	!	 ob y ein solches Token ist (Änderung vorgeschlagen von Martin Oehm).
	if (y == CG_NEUTER_TOKEN or CG_FEMALE_TOKEN or CG_MALE_TOKEN or CG_PLURAL_TOKEN) {
		return ParseToken(x,y);
	}
	if (wn>WordCount()) return GPR_FAIL;
	return ParseToken(x,y);
];
-) replacing "ParseTokenStopped".

Include (-
[ BestGuess  earliest its_score best i j;
	earliest = 0; best = -1;
	for (i=0 : i<number_matched : i++ ) {
		if (match_list-->i >= 0) {
			its_score = match_scores-->i;
			if (its_score > best) { best = its_score; earliest = i; }
		}
	}
	#Ifdef DEBUG;
	if (parser_trace >= 4)
		if (best < 0) print "   Best guess ran out of choices^";
		else print "   Best guess ", (the) match_list-->earliest, "^";
	#Endif; ! DEBUG
	if (best < 0) return -1;
	i = match_list-->earliest;

	! *** Bei identischen Objekten den CG des ersten Objekts
	!	 neu setzen, da die Information in CG_buffer möglicherweise
	!	 überschrieben wurde (dies geschieht, wenn es mehr als
	!	 MAX_CG_STACK/2 identische Objekte gibt).

	for (j = 0 : j < MAX_CG_STACK : j++ ) {
		if ( Identical(i, CG_buffer-->(2*j)) ) {
				 GenderNotice(i, CG_buffer-->(2*j + 1));
				 break;
		}
	}

	match_list-->earliest = -1;
	return i;
];
-) replacing "BestGuess".


Include (-
[ IsToken p t tt; ! *** hinzugefügt von CB

	! *** IsToken() prüft, ob ein GPR-Token an Position p im
	!	 Satzmuster vom Token-Typ t ist (GPR = General Parsing Routine)
	!	 (19.04.2012) tt kann übergeben werden, wenn ein anderer
	!	 Token-Typ geprüft werden soll.

	if (p < 0) rfalse;
	if (tt == 0) tt = GPR_TT;
	if (line_ttype-->(p) == tt && line_tdata-->(p) == t) rtrue;
	rfalse;
];

[ GWomit w dative_flag first;
	! Das schreibt ein Fragewort, das nach einem indirekten Objekt fragt,
	! wie das namengebende Womit, oder Woraus, Wonach, Worein. Das wird
	! zusammen mit PrintCommand benutzt: "Woran möchtest du ziehen?"

	! *** (05.04.2011) Dadurch, dass jetzt auch AND- und BUT-Words in
	!	 Satzmustern erlaubt sind (siehe Parse Token Letter E), kommt
	!	 es hier möglicherweise zu Problemen, da auch unsinnige Wörter wie
	!	 "Worund" erzeugt werden könnten. Also müssen wir uns hier etwas
	!	 einfallen lassen. Das "Womit" für die AND-Worte ist ein fauler
	!	 Kompromiss, der den Spieler zu einer falschen Eingabe verleitet,
	!	 wenn der Autor 'mit' nicht im Satzmuster vorgesehen hat.

	if (w == BUT1__WD or BUT2__WD or BUT3__WD) { print "Ohne was"; return; }
	if (w == AND1__WD or AND2__WD or AND3__WD) { print "Womit"; return; }

	print "Wo";

	if (w=='in') {
		if (dative_flag) print "rin";
		else			 print "rein";
		rtrue;
	}

	#ifdef TARGET_ZCODE;
	if (standard_interpreter ~= 0) {
		StorageForShortName-->0 = 16;
		@output_stream 3 StorageForShortName;
		print (address) w;
		@output_stream -3;
		first = StorageForShortName->2;
	}
	#ifnot;
	Glulx_PrintAnyToArray(StorageForShortName, 16, w);
	first = StorageForShortName->0;
	#endif;
	if (first == 'a' or 'e' or 'i' or 'o' or 'u') print "r";
	!print (address) w;
	print (UmlautAddress) w; ! *** (10.11.2011) Damit es "worüber" und nicht "worueber" lautet.
];

[ PrintWomitCommand	  x1 prep offset;
	x1 = pcount;

	!if (pattern-->(pcount - 1) == PATTERN_NULL) pcount--;

	!*** (15.05.2011) mit gruppierten Präpositionen gab's Probleme vor
	!	dem Dativ-Token, deshalb muss an den Anfang der Präpositionen-Kette
	!	zurückgegangen werden (while statt if).
	!	offset dient dazu, ein evtl. vorhandenes Dativ-Token zu lokalisieren.

	while (pattern-->(pcount - 1) == PATTERN_NULL) { pcount--; offset++; }
	if (offset) offset--;
	if (pattern-->(pcount - 1) > REPARSE_CODE) {
		! Wenn das letzte Element eines unvollständigen Satzes eine
		! Präposition, also eine Vokabel anstatt eines Objekts ist,
		! dann soll sie als Fragewort ("Womit" usw. ) benutzt werden.
		! pcount muss nachher wieder zurückgesetzt werden, damit die
		! Antwort richtig analysiert werden kann.

		! *** In Z-Code werden die Wörter im Satzmuster pattern durch ihre
		!	 Record-Nummer repräsentiert und müssen erst einmal in eine
		!	 Adresse umgewandelt werden, die an GWomit() übergeben werden
		!	 kann.

		prep = VM_NumberToDictionaryAddress(pattern-->(pcount-1)-REPARSE_CODE);

		! *** In GWomit() das Dativ-Token berücksichtigen, damit "worin"
		!	 und "worein" unterschieden werden können.

		GWomit(prep, IsToken(pcount-1 + offset, DATIVE_TOKEN));

		pcount--;
	} else print "Was";
	pcount = x1;
];

[ PrintWemCommand x1  offset;
	x1 = pcount;
	!if (pattern-->(pcount - 1) == PATTERN_NULL) pcount--;
	! *** (15.05.2011) siehe PrintWomitCommand()
	while (pattern-->(pcount - 1) == PATTERN_NULL) { pcount--; offset++; }
	if (offset) offset--;
	if (pattern-->(pcount - 1) > REPARSE_CODE) {
		! Siehe Erklärung unter PrintWomitCommand.
		! *** Großbuchstabe am Anfang
		CUmlautAddress(VM_NumberToDictionaryAddress(pattern-->(pcount-1)-REPARSE_CODE));
		print " wem ";
		pcount--;
	} else {
		if (IsToken(pcount-1 + offset, DATIVE_TOKEN)) print "Wem";
		else print "Wen";
	}
	pcount = x1;
];
-).

Include (-
! *** 27.03.2010: In |PrintInferredCommand| wird jetzt das Dativ-Token
!	 berücksichtigt und an |PrintCommand| als Flag im zweiten Parameter
!	 übergeben.


[ PrintInferredCommand from singleton_noun; ! +++ Dative angegeben
	singleton_noun = false; ! +++
	if ((from ~= 0) && (from == pcount-1) &&
		(pattern-->from > 1) && (pattern-->from < REPARSE_CODE))
			singleton_noun = true; ! +++

	if (singleton_noun) {
		BeginActivity(CLARIFYING_PARSERS_CHOICE_ACT, pattern-->from);
		if (ForActivity(CLARIFYING_PARSERS_CHOICE_ACT, pattern-->from) == 0) {
			! *** zusätzlich noch das Dativ-Flag an |PrintCommand| übergeben
			print "("; PrintCommand(from, IsToken(from-2, DATIVE_TOKEN)); print ")^"; ! +++
		}
		EndActivity(CLARIFYING_PARSERS_CHOICE_ACT, pattern-->from);
	} else {
		! *** zusätzlich noch das Dativ-Flag an |PrintCommand| übergeben
		print "("; PrintCommand(from, IsToken(from-2, DATIVE_TOKEN)); print ")^"; ! +++
	}
];
-) replacing "PrintInferredCommand".

Include (-
! *** (19.03.2012) Ist das letzte Wort der Eingabe eine nachgestellte Verb-Präposition?

[ CheckLastWordPreposition pp	 num_words last_word i index;
	if (pp ~= -1) return pp; ! +++ verb_prep ~= -1, d.h. es wurde bereits eine Präpostion gefunden

	num_words = WordCount();

	! letztes Wort ist WordCount - 1
	#ifdef TARGET_ZCODE;
	index = (num_words-1)*2+1; ! +++ Berechnung klarer gemacht, dass es sich um das letzte (num_words-1) Wort handelt
	#ifnot;
	index = (num_words-1)*3+1;
	#endif;

	last_word = parse-->index;

	for ( i = 1 : i <= LanguageVerbPreps-->0 : i++ ) {
		if (AddressMatchesText(last_word, LanguageVerbPreps-->i)) {
			return LanguageVerbPreps-->i;
		}
	}
	return pp;
];

! *** (17.03.2014) Beim Ausgeben von Topics in PrintCommand()
!	 gab's Probleme. Das sollen jetzt PrintWord und PrintTopic
!	 richten.

[ PrintWord w caps wa wl ch;
	wa = WordAddress(w);
	wl = WordLength(w);
	for (w=0 : w<wl : w++) {
		ch = wa->w;
		if (((ch >= 97 && ch <= 122) && w==0) && caps) ch = ch - 32; ! *** (06.05.2015, CB) Das erste && war ein ||
		print (char) ch;
	}
];

[ PrintTopic caps	w;
	for (w = 0 : w < consult_words : w++) {
		if (w) print (char) ' ';
		PrintWord(consult_from + w, caps);
	}
];


[ PrintCommand ! +++ ziemlich stark umgebaut
	from			! erstes Token, ab dem ausgegeben wird,
					! kann negativ sein, um den Satz im Imperativ
					! ("Hebe Stein auf") anstatt als Infinitiv-Phrase
					! ("Stein aufheben") auszugeben. Wird für den
					! Yoda-Modus gebraucht
	dative_flag ! erzwingt den Dativ im nächsten Token

	i k spacing_flag prep_before prep;

	printing_command = true;
	k = from;					! Das Verb wird als Infinitiv hintenangestellt
	if (k==0) k = 1;			! und muss hier korrigiert werden.

	if (k < 0) {
		k = 1;
		PrintImperativeVerb(verb_word, true);
		spacing_flag = true;
	}

	verb_prep = CheckLastWordPreposition(verb_prep);

	for ( : k<pcount : k++) {
		i = pattern-->k;
		if (i == PATTERN_NULL) {
			! Token ohne eingelesenes Wort
			dative_flag = IsToken(k-1, DATIVE_TOKEN);
			continue;
		}
		!if (from > 0) {
		!	if (spacing_flag && verb_prep == -1) print (char) ' ';
		!}
		if (from > 0) { ! *** (16.03.2015) Leerzeichenfehler SCHLIESS SCHLOSS AUF (mitdem Schlüssel) korrigiert?
			if (spacing_flag) {
				if (prep_before || verb_prep == -1) {
					print (char) ' ';
				}
			}
		} else {
			if (spacing_flag) print (char) ' ';
		}
		if (verb_word == 'no.verb') {
			if (i == 0 or 1) jump TokenPrinted;
		} else {
			if (i == 0) { print (string) "all das"; jump TokenPrinted; }
			if (i == 1) { ! *** (19.04.2012)
				if (IsToken(k-1, TOPIC_TOKEN, ELEMENTARY_TT)) {
					! *** (17.03.2014) Neu: PrintSnippet gegen PrintTopic getauscht
					print "~", (PrintTopic) 1, "~";
				}
				else print (string) "das";
				jump TokenPrinted;
			}
		}
		if (i >= REPARSE_CODE) {
			! *** hier wird unterschieden zwischen "Platz nehmen" und "aufheben"
			if (IsToken(k-2, SUBSTANTIVE_TOKEN)) {
				print (CUmlautAddress) VM_NumberToDictionaryAddress(i-REPARSE_CODE);
				spacing_flag = true;
				prep_before = false;
			}
			else {
				! *** (17.03.2012) Wenn eine Infinitiv-Form mit einer vorangehenden
				!	 Präposition eingegeben wurde, wird die wiederholte Ausgabe der Präposition
				!	 am Ende des Satzes einer Kommando-Vervollständigung unterdrückt.

				prep = VM_NumberToDictionaryAddress(i-REPARSE_CODE);
				if  (AddressMatchesText(prep, verb_prep) == true && from == 0) { ! Yoda: from <= 0
				! +++ Abfrage auf == true, da sonst bei "schliess x auf" ein 'mit' zuviel ist: "Womit willst Du auf mit schliessen?"
					print (UmlautAddress) prep;
					prep_before = true;
				}
				spacing_flag = false; ! +++ "Platz  nehmen" => "Platz nehmen"
			}
			continue;
		} else {
			if (i ofclass (+ Direction +) && LanguageVerbLikesAdverb(verb_word)) {
				!print "nach ", (LanguageDirection) i;
				! *** (17.03.2012) geändert, um die doppelte Ausgabe von "nach" zu verhindern:
				!	 (Das "nach" wird schon im ersten Durchlauf aus dem Satzmuster gezogen.)
				print (WithoutArt) i;
			}
			else {
				! *** "mit dem Ding etwas tun":
				!	 verb_word ist 'no.verb', wenn für Aktionen gar kein
				!	 Verb angegeben wurde, z.B. in
				!	 Understand "[something]" as examining.

				! *** (15.03.2012) Der Ausdruck "mit dem <Objekt> etwas tun"
				!	 wird nur ausgegeben, wenn from==0 ist (z.B. bei recap of command).
				!	 Ansonsten wird die Teilphrase "den/dem <Objekt> ..." geschrieben.

				dative_flag = IsToken(k-2, DATIVE_TOKEN); ! *** (17.04.2015) Dativ-Flag setzen
				if (verb_word == 'no.verb' && from == 0) { dative_flag = 1; print "mit "; }

				if (i == selfobj) { ! +++ I7 "yourself" = I6 "selfobj" - verhindert "Worauf willst Du Du setzen?"
					print "dich";
				} else {
					if (dative_flag) print (dem) i;
					else print (den) i;
					dative_flag = false;
				}
			}
		}
		.TokenPrinted;
		spacing_flag = true;
		prep_before = false;
	}

	! *** Hier wird das Dich-Token berücksichtigt, um Infintive für
	!	 reflexive Verbformen zu schreiben: "Worauf willst du dich setzen?"
	if (IsToken(k-2, DICH_TOKEN)) {
		print "dich";
		spacing_flag = true; prep_before = false;
	}

	if (from == 0) {
		if (verb_word == 'no.verb' && i == 0 or 1) spacing_flag = false;
		if (spacing_flag && ~~prep_before) print (char) ' ';
		i = verb_word;
		if (LanguageVerb(i) == 0)
			!if (PrintVerb(i) == 0) print (address) i; ! *** (10.11.2011) Umlaute im Verb ausgeben
			if (PrintVerb(i) == 0) print (UmlautAddress) i;
		from++;
	}
	printing_command = false;
];

-) replacing "PrintCommand".



Include (-
[ PrefaceByArticle o acode pluralise capitalise  g s;
	SetPreviouslyNamedNoun(o);
	! acode ist die von Inform vorgesehene Art des Artikels
	! 0 "The ", 1 "the ", 2, "a(n) ". Das dieses System in GerX
	! abgeschafft ist, müssen wir uns was anderes überlegen.
	!
	! capitalise gibt an, ob das Gedruckte groß geschrieben werden
	! soll. Das wird in GerX direkt in GDer() usw. festgelegt,
	! diese Flagge wird also hier ignoriert.
	if (pluralise) {
		SetLowStrings(short_name_case, 0);
		if (acode < 2) {
			! Modus ist 0 (best. artikel) und Genus ist auch 0 (Plural)

			s = LanguageArticles-->(short_name_case*4);

			if (capitalise) print (Cap) s;
			else			print (string) s;
			print " ";
		}
		! *** Die Anzahl wird in PRINTING_A_NUMBER_OF_ACT/
		!	 "Rule for printing a number of something"
		!	 in |WriteSingleClassGroup| ausgegeben. Dort wird nun
		!	 auch über die Großschreibung entschieden.
	} else {
		if (indef_mode >= 0) {
			g = Gender(o);
			s = LanguageArticles-->(indef_mode*16 + short_name_case*4 + g);
			if (s) {
				if (capitalise) print (Cap) s;
				else			print (string) s;
				print " ";
			}
		}
		print (PSN__) o;
	}
	capitalise = 0;
];
-) replacing "PrefaceByArticle".


Include (-
[ IndefArt obj k	i g	 art;
	if (obj == 0) return PrintNothing(k);
	SetPreviouslyNamedNoun(obj);
	i = indef_mode; indef_mode = true;
	g = Gender(obj);
	short_name_case = k;
	SetLowStrings(k, g);
	if (obj has proper) { indef_mode = NULL; print (PSN__) obj; indef_mode = i; return; }

	! *** Um zu verhindern, dass die Property "article"
	!	 doppelt vergeben wird, was zu einem Compiler-Fehler führt,
	!	 werden die speziellen unbestimmten Artikel "definite", "yours" und
	!	 "no article" in der Property special_article definiert und
	!	 nicht wie zuvor ebenfalls in article (in I7 kann eine Eigenschaft
	!	 nur von einem einzigen Typ sein).
	!	 Der "special indefinite article" dominiert einen möglicherweise
	!	 vorhandenen "indefinite article".

	! +++ article wird jetzt immer gesetzt, daher überschreibt er die Ausgabe des deutschen Artikels
	!if ((obj provides article) && (obj.article ~= EMPTY_TEXT_VALUE)) art = obj.article;
	if ((obj provides special_article) && (obj.special_article ~= pending))
		art = obj.special_article;

	if (art) {
!print art; ! +++ TODO
		if (art == definite) {
			return DefArt(obj, k);
		} else if (art == yours) {

			!*** Die Low-Strings für die Ausgabe des Plurals mit "dein" anpassen.
			!	Flektiert wird wie beim bestimmten Artikel:
			!	"nervige Nachbarn" vs. "deine nervigen Nachbarn"

			if (obj has pluralname) {
				indef_mode = false;
				SetLowStrings(k, g);
			}

			if (CAPITAL_YOU) print "Dein"; else print "dein"; ! +++ 2023_05_08
			print (string) LanguageSuffixes-->(possessive_suffix_base + 4*k + g),
			" ", (PSN__) obj; indef_mode = i; return;
		} else if (art ~= no_article) {
			PrintOrRun(obj, article, 1); print " ";
		} else {
			indef_mode = -1;
			SetLowStrings(k, g);
		}
		print (PSN__) obj; indef_mode = i; return;
	}
	PrefaceByArticle(obj, 2); indef_mode = i;
];
-) replacing "IndefArt".


Include (-
[ CIndefArt obj k;
	if (obj == 0) return PrintNothing(k, CFIRSTART_BIT);
	RunCapitalised(IndefArt, obj, k);
];
-) replacing "CIndefArt".

Include (-
[ DefArt obj k	i g;
	if (obj == 0) return PrintNothing(k);
	SetPreviouslyNamedNoun(obj);
	i = indef_mode; indef_mode = false;

	!*** (30.11.2011) Adjektive in Proper-Objekten werden im "bare mode" dekliniert,
	!	wie z.B. in "Bernds kleines Auto"

	if (obj has proper) indef_mode = -1;

	g = Gender(obj);
	short_name_case = k;
	SetLowStrings(k, g);
	if ((~~obj ofclass Object) || obj has proper) {
		indef_mode = NULL; print (PSN__) obj; indef_mode = i;
		return;
	}
	PrefaceByArticle(obj, 1); indef_mode = i;
];
-) replacing "DefArt".


Include (-
[ CDefArt obj k;
	if (obj == 0) return PrintNothing(k, CFIRSTART_BIT);
	RunCapitalised(DefArt, obj, k);
];
-) replacing "CDefArt".


Include (-
[ PrintShortName obj i;
	i = indef_mode; indef_mode = NULL;
	PSN__(obj); indef_mode = i;
];
-) replacing "PrintShortName".

Include (-
[ WithoutArt obj k mode   i g;
	SetPreviouslyNamedNoun(obj);

	i = indef_mode;

	! *** AUFGEBOHRT:
	!	 Default ist indef_mode = -1; mode kann dazu verwendet werden,
	!	 den bestimmten oder unbestimmten Modus zu setzen
	!	 (1: bestimmt, 2: unbestimmt). Damit erhält man
	!	 die Form wie mit bestimmtem/unbestimmten Artikel, nur eben ohne
	!	 den dazugehörigen Artikel.
	!	 Das wird z.B. bei den Say-Phrasen "[<Objekt> bestimmt im <Kasus>]",
	!	 "[<Objekt> unbestimmt im <Kasus>]" usw. benutzt.

	indef_mode = mode - 1;

	g = Gender(obj);
	short_name_case = k;
	SetLowStrings(k, g);
	if ((~~obj ofclass Object) || obj has proper) {
		indef_mode = NULL; print (PSN__) obj; indef_mode = i;
		return;
	}
	if (indef_mode >= 0) { print (PSN__) obj; indef_mode = i; return; }
	PrefaceByArticle(obj, 1); indef_mode = i;
];

[ NegativeArt obj k;
	print (string) LanguageArticles-->(neg_article_base + 4*k + Gender(obj)), " ";

	! *** Hier wird jetzt der Objektname in der
	!	 unbestimmten Form (mode 2) mit ausgegeben
	WithoutArt(obj, k, 2);
];

[ PersonalPron obj k;
	SetPreviouslyNamedNoun(obj);
	print (string) PersonalPronouns-->(4*k + Gender(obj, true));
];

[ RunCapitalised a b c    i length;
!   Wie PrintCapitalised, nur für Routinen, so dass die Ausgabe von
!   a(b, c) am Anfang groß geschrieben wird.

	if (~~(a ofclass Routine)) return;
	VM_PrintToBuffer(StorageForShortName, 160, a, b, c);
	StorageForShortName->WORDSIZE = VM_LowerToUpperCase(StorageForShortName->WORDSIZE);
	length = StorageForShortName-->0;
	for (i=WORDSIZE: i<length+WORDSIZE: i++) print (char) StorageForShortName->i;
	return length;
];

[ pr__verb v;   ! Hilfsroutine für PrintImperativeVerb
	if (LanguageVerb(v) == 0)
		if (PrintVerb(v) == 0) print (address) v;
];

!   Gibt den Imperativ (abgeleitet aus dem Infinitiv) von v groß aus.
[ PrintImperativeVerb ! +++ komplett neu
	v	   ! Verb (dict word), 0 -> v )== verb_word
	cap	 ! Soll der Anfangsbuchstabe groß geschrieben werden?

	i length s;

!	if (v == 0) v = verb_word; ! +++ TODO
!	s = StorageForShortName;
!	VM_PrintToBuffer(s, 160, pr__verb, v);
!	if (cap) s->WORDSIZE = VM_LowerToUpperCase(s->WORDSIZE);
!	length = s-->0;
!	s = s + WORDSIZE;
!	if (s->(length - 1) == 'n') {
!		length--;
!		if (s->(length - 1) == 'r' or 'l' && s->(length - 2) == 'e') {
!			s->(length - 2) = s->(length - 1);
!			s->(length -1) = 'e';
!		}
!	}
!	for (i = 0: i < length: i++) print (char) s->i;
];
-).

Include (-
[ LanguagePrintShortName obj;
	SetPreviouslyNamedNoun(obj); ! *** obj als "zuvor genanntes Objekt" merken
	rfalse;
];

! +++ Die Routine STANDARD_NAME_PRINTING_R besitzt den Einhängepunkt "LanguagePrintShortName".
!     Das SetPreviouslyNamedNoun wurde dort eingefügt und die Routine STANDARD_NAME_PRINTING_R
!     unverändert übernommen; aber ohne diese funktioniert es nicht.
[ STANDARD_NAME_PRINTING_R obj;
	obj = parameter_value;
	if (obj == 0) {
		LIST_WRITER_INTERNAL_RM('Y'); return;
	}
	switch (metaclass(obj)) {
		Routine:  print "<routine ", obj, ">"; return;
		String:   print "<string ~", (string) obj, "~>"; return;
		nothing:  print "<illegal object number ", obj, ">"; return;
	}
	#Ifdef LanguagePrintShortName;
	if (LanguagePrintShortName(obj)) return;
	#Endif; ! LanguagePrintShortName
	if (indef_mode && obj provides short_name_indef &&
		PrintOrRun(obj, short_name_indef, true) ~= 0) return;
	if (caps_mode &&
		obj provides cap_short_name && PrintOrRun(obj, cap_short_name, true) ~= 0) {
		caps_mode = false;
		return;
	}
	if (obj provides short_name && PrintOrRun(obj, short_name, true) ~= 0) return;
	print (object) obj;
];
-) replacing "STANDARD_NAME_PRINTING_R".

[
Include (-
[ SL_Score_Moves;
	if (not_yet_in_play) return;
	#ifdef NO_SCORING; print sline2; #ifnot; print sline1, "/", sline2; #endif;
];
-) replacing "SL_Score_Moves".
]

[20.07.2013: Bei UNDO gab es teilweise Probleme mit dem Kasus des
Raumnamens. In SL_Location() wurde das Kasus nicht auf Nominativ gesetzt,
was jetzt geändert ist.]
Include (-
[ SL_Location even_before;
	if ((not_yet_in_play) && (even_before == false)) return;
	if (location == thedark) {
		BeginActivity(PRINTING_NAME_OF_DARK_ROOM_ACT);
		if (ForActivity(PRINTING_NAME_OF_DARK_ROOM_ACT) == false)
 			DARKNESS_NAME_INTERNAL_RM('A');
		EndActivity(PRINTING_NAME_OF_DARK_ROOM_ACT);
	} else {
		FindVisibilityLevels();
		if (visibility_ceiling == location) {
			RunCapitalised(WithoutArt, visibility_ceiling, Nom); ! +++ war "print (name) location"
		}
		else print (GDer) visibility_ceiling; ! +++ (GDer) statt (The)
	}
];
-) replacing "SL_Location".

[ +++ Die "story headline" lässt sich nicht so ändern, dass der Autor sie später wieder ändern kann, daher Definition der "german story headline" ]
The german story headline is some indexed text that varies.

When play begins:
	if the story headline is "An Interactive Fiction": [ +++ Abfrage auf Default-Wert ]
		now the german story headline is "Ein Textadventure";
	else:
		now the german story headline is the story headline.

Include (-
[ Banner;
   BeginActivity(PRINTING_BANNER_TEXT_ACT);
   if (ForActivity(PRINTING_BANNER_TEXT_ACT) == false) {
	   	VM_Style(HEADER_VMSTY);
		TEXT_TY_Say(Story);
		VM_Style(NORMAL_VMSTY);
		new_line;
		TEXT_TY_Say( (+ the german story headline +) ); ! +++ print the german story headline
		if (KIT_CONFIGURATION_BITMAP & STORY_AUTHOR_TCBIT) {
			print " von "; TEXT_TY_Say(Story_Author);
		}
		new_line;
		VM_Describe_Release();
		print " / Inform 7 v", (PrintI6Text) I7_VERSION_NUMBER, " / GerX ", (PrintI6Text) GerXVersion, " v", (PrintI6Text) GerXRelease; ! +++
		#Ifdef DEBUG;
		print " / D";
		#Endif; ! DEBUG
		new_line;
    }
    EndActivity(PRINTING_BANNER_TEXT_ACT);
];
-) replacing "Banner".


Section - Output



Section - Time

Include (-
[ PrintTimeOfDay t h aop;
	if (t<0) { print "<keine Uhrzeit>"; return; }
	h = t/ONE_HOUR; !if (h==0) h=12;
	print h, ":";
	if (t%ONE_HOUR < 10) print "0"; print t%ONE_HOUR; !, (string) aop;
];
-) replacing "PrintTimeOfDay".


Include (-
! *** PrintTimeOfDayGerman von CB

[ PrintDir dir;
	switch (dir) {
	 1: print "nach";
	-1: print "vor";
	}
];

[ PrintTimeOfDayGerman t h m dir   x;
	h = (t/ONE_HOUR) % 12; m = t%ONE_HOUR; if (h==0) h=12;
	if (m==0) {
		if (h==1) print "ein"; else print (number) h;
		print " Uhr"; return;
	}
	dir = 1;
	if (m > HALF_HOUR) { m = ONE_HOUR-m; h = (h+1)%12; if (h==0) h=12; dir = -1; }
	switch(m) {
		QUARTER_HOUR: print "Viertel"; HALF_HOUR: print "halb";
		25: print "fünf"; ! "fünf vor halb" oder "fünf nach halb"
		default:
			if (m == 1) print "eine";
			else print (number) m;
			if (m%5 ~= 0) {
				if (m == 1) print " Minute"; else print " Minuten";
			}
	}
	print " ";
	if (m == HALF_HOUR) { h++;
		if (h > 12) h = h - 12;
	}
	else {
		if (m == 25) {
			dir = -dir; ! vertausche "vor" und "nach"
			PrintDir(dir); print " ";
			print "halb "; if (dir == -1) h++;
		}
		else { PrintDir(dir); print " "; }
	}
	if (h == 1) print "eins";
	else print (number) h;
];

[ PrintTimeOfDayEnglish t;
	PrintTimeOfDayGerman(t);
];
-) replacing "PrintTimeOfDayEnglish".



Include (-
[ IstimeOfDayWord word;
	if (word == 'morgens') rtrue;
	if (word == 'mittags') rtrue;
	if (word == 'nachmittags') rtrue;
	if (word == 'abends') rtrue;
	if (word == 'nachts') rtrue;
	rfalse;
];

[ ConsiderTimeOfDay hour timeofday_word  halb add;
! *** um z.B. "3 uhr nachmittags" sagen zu können
	if (timeofday_word == -1) return hour;
	if (hour > 12) return hour;

	switch (timeofday_word) {
		'abends': ! *** Der Abend beginnt um 17:00 Uhr und endet um 0:00 Uhr
			if (hour >= 5 && hour <= 12) return hour+12; else return hour;
		'nachts': ! *** Die Nacht beginnt um 21:00 Uhr und endet um 0:00 Uhr
			if (hour >= 9 && hour <= 12) return hour+12; else return hour;
		'nachmittags', 'mittags': ! *** Der Nachmittag dauert von 13 bis 17 Uhr
			if (hour >= 1 && hour <=5) return hour+12; else return hour;
		default: return hour;
	}
];

! *** (Februar 2011) Endlich auch ein deutsches Time-Token ...

[ TIME_TOKEN first_word second_word at length flag
	illegal_char offhour hr mn i original_wn
	viertelflag minuteflag timeofday_word;

	original_wn = wn;

	wn = original_wn;
	first_word = NextWordStopped();
	switch (first_word) {
		'mitternacht':
			parsed_number = 0; return GPR_NUMBER;
		'mittag', 'mittags':
			parsed_number = TWELVE_HOURS; return GPR_NUMBER;
	}

	! Next try the format 12:02
	at = WordAddress(wn-1); length = WordLength(wn-1);
	for (i=0: i<length: i++) {
		switch (at->i) {
			':': if (flag == false && i>0 && i<length-1) flag = true;
			else illegal_char = true;
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9': ;
			default: illegal_char = true;
		}
	}
	if (length < 3 || length > 5 || illegal_char) flag = false;
	if (flag) {
		for (i=0: at->i~=':': i++, hr=hr*10) hr = hr + at->i - '0';
		hr = hr/10;
		for (i++: i<length: i++, mn=mn*10) mn = mn + at->i - '0';
		mn = mn/10;
		second_word = NextWordStopped();

		! 5:16 (Uhr) abends
		if (second_word == 'uhr')
			second_word = NextWordStopped();
		if (IstimeOfDayWord(second_word)) {
			hr = ConsiderTimeOfDay(hr, second_word);
			second_word = NextWordStopped();
		}

		parsed_number = HoursMinsWordToTime(hr, mn);
		if (parsed_number == -1) return GPR_FAIL;
		if (second_word ~= 'uhr') wn--;
		return GPR_NUMBER;
	}

	! Lastly the wordy format
	offhour = -1; viertelflag = 0; minuteflag = false;
	timeofday_word = -1;

	if (first_word == 'null') offhour = 0; ! "Null Uhr"
	if (first_word == 'halb') { wn++; viertelflag = 2; }
	if (first_word == 'dreiviertel') { wn++; viertelflag = 3; }
	if (first_word == 'viertel') {
		second_word = NextWordStopped();
		! "Viertel nach acht", "Viertel vor zehn"
		if (second_word == 'vor' or 'nach') {
			offhour = QUARTER_HOUR;
			wn--;
		}
		! "Viertel neun (8:15)"
		else {
			viertelflag = 1;
		}
	}
	if (offhour < 0) offhour = TryNumber(wn-1);

	! Vor einem möglichen Abbruch Wortmarker für explizite Fehlermeldungen setzen.
	if (wn - 1 > max_wn) max_wn = wn - 1;

	if (offhour < 0 || offhour >= ONE_HOUR) return GPR_FAIL;

	second_word = NextWordStopped();
	if (second_word == 'uhr') second_word = NextWordStopped();

	! "Viertel 8 und 3 Minuten" unterbinden ...
	if (viertelflag == 0) {
		! "sieben Uhr", "sieben Uhr dreißig"
		if (second_word == 'und') second_word = NextWordStopped();
		if (second_word == 'minute' or 'minuten') {
			minuteflag = true;
			second_word = NextWordStopped();
		}
	}

	! "zehn Uhr abends und drei Minuten"
	if (IstimeOfDayWord(second_word)) {
		timeofday_word = second_word;
		second_word = NextWordStopped();
		if (second_word == 'und') second_word = NextWordStopped();
	}

	! +++ "switch" in "if" umgebaut, da switch mit verschiedenen Datentypen nicht mehr kompiliert
	if (second_word == -1) {
		if (minuteflag) { ! "sieben", "halb sieben"
			hr = 0; mn = offhour;
		}
		else {
			if (timeofday_word ~= -1)
				hr = ConsiderTimeOfDay(offhour, timeofday_word);
			else hr = offhour;
			if (viertelflag > 0) {
				! viertelflag ist entweder 1 (Viertel), 2 (Halb) oder 3 (Dreiviertel)
				hr--;
				mn = viertelflag*QUARTER_HOUR;
			}
			if (wn - 1 > max_wn) max_wn = wn - 1;
			if (hr > 24) return GPR_FAIL;
		}

	} else if (second_word == 'vor' or second_word == 'nach') { ! "Viertel vor sieben", "zwanzig nach Mitternacht"
		mn = offhour; hr = TryNumber(wn);
		if (hr <= 0) {
			switch (NextWordStopped()) {
				'mittag': hr = 12;
				'mitternacht': hr = 0;
				default:
					if (wn - 1 > max_wn) max_wn = wn - 1;
					return GPR_FAIL;
			}
		}
		if (wn - 1 > max_wn) max_wn = wn - 1;
		if (hr >= 25) return GPR_FAIL;
		if (second_word == 'vor') {
			mn = ONE_HOUR-mn; hr--; if (hr<0) hr=23;
			if (offhour == QUARTER_HOUR) viertelflag = true;
		}
		wn++; second_word = NextWordStopped();

		if (second_word == 'uhr')
			second_word = NextWordStopped();

		! "Viertel vor neun (Uhr) Abends"
		if (IstimeOfDayWord(second_word)) {
			if (viertelflag) hr++;
			hr = ConsiderTimeOfDay(hr, second_word);
			if (viertelflag) hr--;
			second_word = NextWordStopped();
		}

	} else { ! "six thirty" (diese Form bleibt erhalten)
		if (timeofday_word ~= -1)
			hr = ConsiderTimeOfDay(offhour, timeofday_word);
		else hr = offhour;
		mn = TryNumber(--wn); if (wn > max_wn) max_wn = wn;
		if (mn < 0 || mn >= ONE_HOUR) return GPR_FAIL;
		wn++; second_word = NextWordStopped();

	}

	if (second_word == 'uhr' or 'minute' or 'minuten')
		second_word = NextWordStopped();

	! "zwei Uhr drei Minuten Nachmittags"
	if (IstimeOfDayWord(second_word)) {
		hr = ConsiderTimeOfDay(hr, second_word);
		second_word = NextWordStopped();
	}
	parsed_number = HoursMinsWordToTime(hr, mn);
	if (wn - 1 > max_wn) max_wn = wn - 1;
	if (parsed_number < 0) return GPR_FAIL;
	if (second_word ~= 'uhr' or 'minute' or 'minuten') wn--;
	return GPR_NUMBER;
];
-) replacing "TIME_TOKEN".


Include (-
[ HoursMinsWordToTime hour minute word x;
	if (hour > 24) return -1;
	if (minute >= ONE_HOUR) return -1;

	if (hour == 24) hour = 0;
	x = hour*ONE_HOUR + minute; if (hour > 12) return x;
	x = x % TWELVE_HOURS; !if (word == 'pm') x = x + TWELVE_HOURS;
	!if (word ~= 'am' or 'pm' && hour == 12) x = x + TWELVE_HOURS;
	if (hour == 12) x = x + TWELVE_HOURS;
	return x;
];
-) replacing "HoursMinsWordToTime".




Section - Printing


Include (-

! +++ Aktuell (10.1.2) kann Inform keine Dynamischen Strings wie "@00" definieren (s. I7-2286).
!     Als Lösung wurden die Endungen in Arrays konvertiert.

Global AdjectiveEndingsIndex = 0;
Global SubstantiveEndingsIndex = 0;

! war @00
Array AdjectiveEndings -->
	"en"	"e"		"e"		"e"		! indef_mode == 0
	"en"	"en"	"en"	"en"
	"en"	"en"	"en"	"en"
	"en"	"e"		"en"	"e"

	"e"		"es"	"er"	"e"			! indef_mode == 1
	"er"	"en"	"en"	"en"
	"en"	"en"	"en"	"en"
	"e"		"es"	"en"	"e"

	"e"		"es"	"er"	"e"			! anderer indef_mode
	"er"	"en"	"en"	"er"
	"en"	"em"	"em"	"er"
	"e"		"es"	"en"	"e"
	;

! war @01
Array SubstantiveEndings_n -->
	""		""		""		""
	""		""		"n"		""
	"n"		"n"		"n"		"n"
	""		""		"n"		""
	;

! war @02
Array SubstantiveEndings_en -->
	""		""		""		""
	"en"	"en"	"en"	"en"
	"en"	"en"	"en"	"en"
	"en"	"en"	"en"	"en"
	;

! war @03
Array SubstantiveEndings_s -->
	""		""		""		""
	"s"		"s"		"s"		"s"
	""		""		""		""
	""		""		""		""
	;

! war @04
Array SubstantiveEndings_es -->
	""		""		""		""
	"es"	"es"	"es"	"es"
	""		""		""		""
	""		""		""		""
	;


[ SetLowStrings k g   idm;

	! Berechne welcher Teil der Tabelle mit Adjektivendungen genommen wird:
	! indef_mode = 0: ersten  Block mit 16 Einträgen
	! indef_mode = 1: zweiten Block mit 16 Einträgen
	! sonst:          dritten Block mit 16 Einträgen
	idm = 2;
	if (indef_mode == 0 || indef_mode == 1) {
		idm = indef_mode;
	}

	! Setze Zeiger in das Array mit Adjektivendungen
	AdjectiveEndingsIndex = (idm*16 + k*4 + g);

	! Setze Zeiger in die Arrays mit Substantivendungen
	SubstantiveEndingsIndex = (k*4 + g);
];

[ WriteListFromCase o in_style case depth no_action iter	old_case old_indef;
	! Das ISARE_BIT ist nur sinnvoll, wenn man die Liste im Nominativ
	! ausgibt, daher wird die Liste im Nominativ ausgegeben.
	if (case ~= Nom && (in_style & ISARE_BIT)) case = Nom;

	old_case = short_name_case; ! Alten Fall merken. (In ListWriteR gab es keine
	short_name_case = case;	    ! freien lokalen Var. mehr, um case zu übergeben.)
	old_indef = indef_mode;

	if (in_style & DEFART_BIT) indef_mode = 0;
	else if (in_style & NOARTICLE_BIT) indef_mode = -1;
	else indef_mode = 1;

	#Ifdef NO_NESTED_LISTS;
	if (~~ignore_append_bit) {
		if ((in_style & RECURSE_BIT) && (in_style & ENGLISH_BIT)) in_style = in_style | APPEND_BIT;
	}
	#Endif; ! NO_NESTED_LISTS

	WriteListFrom(o, in_style, depth, no_action, iter);

	short_name_case = old_case;
	indef_mode = old_indef;
];

#Ifdef NO_NESTED_LISTS;
[ WriteSublists first force_line_break   o n ld;
	! In der Liste gespeicherte Objekte noch abarbeiten.
	while (list_buffer-->0) {
		o = list_buffer-->(list_buffer-->0);
		ld = list_depth-->(list_buffer-->0);

		! *** 1: write the sublists;
		!     2: write the sublists with line break;
		!     3: write the sublists with paragraph break;
		!     4: write the sublists with space;
		!
		!  Innerhalb einer Listenebene wird zwischen den Unterlisten
		!  ein Leerzeichen oder ein Absatz geschrieben, je nachdem, ob
		!  "Use non-nested lists" oder "Use non-nested lists with separate
		!  paragraphs" gewählt wurde.

		switch (first) {
			1: print "";
			2: print "^";
			3: print "^^";
			4: print " ";
			default:
				if (ld && NO_NESTED_LISTS == 0) print " ";
				else print "^^";
		}

		(list_buffer-->0)--;
		print (GAuf) o, " ", (dem) o, " "; ! *** In I7 wird ISARE_BIT ohne " " interpretiert.
		WriteListFromCase(child(o),
		  ENGLISH_BIT + RECURSE_BIT + PARTINV_BIT + TERSE_BIT + CONCEAL_BIT
		  + ISARE_BIT, Nom, 1);
		  ! Tiefe eins, um die Zeilenumbrüche zu steuern
		print "."; if (WriteSublists()==0) "";

		n++;
	}
	if (force_line_break && n==0) print "^";
	return n;
];
#Ifnot; ! NO_NESTED_LISTS
[ WriteSublists; rfalse; ];
#Endif; ! NO_NESTED_LISTS
-).


Section - List Writer

Include (-
[ WriteListOfMarkedObjects in_style case
	obj common_parent first mixed_parentage length;

	objectloop (obj ofclass Object && obj has workflag2) {
		length++;
		if (first == nothing) { first = obj; common_parent = parent(obj); }
		else { if (parent(obj) ~= common_parent) mixed_parentage = true; }
	}
	if (mixed_parentage) common_parent = nothing;

	! *** Ausgabe von "nichts" durch PrintNothing() flexibler gemacht.

	if (length == 0) PrintNothing(case, in_style);
	else {

		@push MarkedObjectArray; @push MarkedObjectLength;
		MarkedObjectArray = RequisitionStack(length);
		MarkedObjectLength = length;
		if (MarkedObjectArray == 0) return RunTimeProblem(RTP_LISTWRITERMEMORY);

		if (common_parent) {
			ObjectTreeCoalesce(child(common_parent));
			length = 0;
			objectloop (obj in common_parent) ! object tree order
				if (obj has workflag2) MarkedObjectArray-->length++ = obj;
		} else {
			length = 0;
			objectloop (obj ofclass Object) ! object number order
				if (obj has workflag2) MarkedObjectArray-->length++ = obj;
		}

		!WriteListFrom(first, in_style, 0, false, MarkedListIterator);

		! *** Hier wird das Listenschreiben erst einmal nach |WriteListFromCase()|
		!	 umgelenkt. Damit die dann alles korrekt an die neue I7-|WriteListFrom()|
		!	 übergeben kann, mussten wir zwei lokale Variablen hinzufügen.
		!	 (siehe |WriteListFromCase()|).

		WriteListFromCase(first, in_style, case, 0, false, MarkedListIterator);
		FreeStack(MarkedObjectArray);
		@pull MarkedObjectLength; @pull MarkedObjectArray;
	}
	return;
];
-) replacing "WriteListOfMarkedObjects".


Include (-
[ PrintNothing case in_style;
	! *** Die Ausgabe von "nichts" flexibler gemacht:
	!     Großschreibung am Satzanfang ("Nichts"), vorangestelltes "ist" und
	!     der Genitiv ("Von/von nichts") werden entsprechend ausgegeben.
	!     Diese Routine wird in |WriteListFrom| und |WriteListOfMarkedObjects|
	!     verwendet.
	if ((in_style & CFIRSTART_BIT) && case ~= Gen) { print (string) "Nichts"; rtrue; }
	if (in_style & ISARE_BIT) print (string) "ist ";
	else if (case == Gen) {
		if (in_style & CFIRSTART_BIT) print "Von ";
		else print "von ";
	}
	print (string) "nichts"; rtrue;
];

[ WriteListFrom first in_style depth noactivity iter a ol;
	@push c_iterator; @push c_style; @push c_depth; @push c_margin;
	if (iter) c_iterator = iter; else c_iterator = ObjectTreeIterator;
	c_style = in_style; c_depth = depth;
	c_margin = 0; if (in_style & EXTRAINDENT_BIT) c_margin = 1;

	objectloop (a ofclass Object) {
		give a list_filter_permits;
		if ((list_filter_routine) && (list_filter_routine(a) == false))
			give a ~list_filter_permits;
	}

	first = c_iterator(first, depth, 0, START_ITF);
	if (first == nothing) {
		PrintNothing(short_name_case, in_style);
		if (in_style & NEWLINE_BIT ~= 0) new_line;
	} else {
		if ((noactivity) || (iter)) {
			WriteListR(first, c_depth, true);
			say__p = 1;
		} else {
			objectloop (ol provides list_together) ol.list_together = 0;
			CarryOutActivity(LISTING_CONTENTS_ACT, parent(first));
		}
	}

	@pull c_margin; @pull c_depth; @pull c_style; @pull c_iterator;
];

[ LanguageNotifySuffixes cap definite_mode;
	! In dieser Routine wird das Drucken von list_together und plural
	! vorbereitet, damit diese Properties auch die Kurzstrings benutzen
	! können. Außerdem wird der Fall Zahl + Genitiv vorübergehend in
	! "von" + Zahl + Dativ umgewandelt. (Zugegeben, ganz schön akademisch,
	! das mit den Listen im Genitiv, und es funktioniert nicht immer.)

	! *** Für das Schreiben von Genitiv-Listen in I7 werden jetzt mit
	!	 den Flags cap und definite_mode Großschreibung und
	!	 bestimmter/unbestimmter Artikel sinnvoll berücksichtigt:
	!	 Nur mit unbestimmtem Artikel wird "von" + Anzahl + Dativ
	!	 ("von fünf roten Bällen") geschrieben;
	!	 mit bestimmtem Artikel heißt es jetzt "der fünf roten Bälle".

	if ((~~definite_mode) && (short_name_case == Gen)) {
		short_name_case = Dat; genitive_list = true;
		if (cap) print "Von ";
		else	 print "von ";
	}
	! Wichtig ist diese Zeile!
	SetLowStrings(short_name_case, 0);
];

[ LanguageUnnotifySuffixes;
	! Hier wird der Fall wieder zurückgesetzt.
	if (~~genitive_list) rtrue;
	genitive_list = false; short_name_case = Gen;
];
-) replacing "WriteListFrom".


Include (-
[ STANDARD_CONTENTS_LISTING_R;
	WriteListFromCase(child(parameter_value), c_style, short_name_case, c_depth, true);
];
-) replacing "STANDARD_CONTENTS_LISTING_R".


Include (-
[ ListEqual o1 o2;
	if ((o1.plural == 0) || (o2.plural == 0)) rfalse;
	if (child(o1) ~= 0 && WillRecurs(o1) ~= 0) rfalse;
	if (child(o2) ~= 0 && WillRecurs(o2) ~= 0) rfalse;
	if (c_style & (FULLINV_BIT + PARTINV_BIT) ~= 0) {
		if ((o1 hasnt worn && o2 has worn) || (o2 hasnt worn && o1 has worn)) rfalse;
		if ((o1 hasnt light && o2 has light) || (o2 hasnt light && o1 has light)) rfalse;
		if (o1 has container) {
			if (o2 hasnt container) rfalse;
			if ((o1 has open && o2 hasnt open) || (o2 has open && o1 hasnt open))
				rfalse;
		}
		else if (o2 has container)
			rfalse;
	}
	return Identical(o1, o2);
];
-) replacing "ListEqual".


Include (-
[ WillRecurs obj;
	if (c_style & ALWAYS_BIT ~= 0) rtrue;
	!if (c_style & RECURSE_BIT == 0) rfalse;
	if (c_style & (RECURSE_BIT | APPEND_BIT) == 0) rfalse;
	if ((obj has supporter) || ((obj has container) && (obj has open or transparent))) rtrue;
	rfalse;
];
-) replacing "WillRecurs".


Include (-
[ WriteMultiClassGroup cl memb depth partition_class_sizes q k2 l;
	! Save the style, because the activity below is allowed to change it
	q = c_style;

	!if (c_style & INDENT_BIT ~= 0) PrintSpaces(2*(depth+c_margin));

	! Inventory Indent und Inventory Bullet berücksichtigt
	! *** Die zusätzliche Einrückung wird nur bei Aufzählungsebene
	!	 größer 1 wirksam.
	if (c_style & INDENT_BIT) {
		if (depth == 1) PrintSpaces(2*(depth+c_margin));
		else PrintSpaces(INVENTORY_INDENT*(depth+c_margin));
		#ifdef INVENTORY_BULLET;
		print (string) INVENTORY_BULLET;
		#endif;
	}

	BeginActivity(GROUPING_TOGETHER_ACT, memb);

	if (ForActivity(GROUPING_TOGETHER_ACT, memb)) {
		c_style = c_style &~ NEWLINE_BIT;
	} else {

		if (memb.list_together ofclass String) {
			! Set k2 to the number of objects covered by the group
			k2 = 0;
			for (l=0 : l<listing_size : l++) k2 = k2 + partition_class_sizes->(l+cl);
			! Vor der Ausgabe die Endung @00 für den Plural setzen
			LanguageNotifySuffixes();

			EnglishNumber(k2); print " ";
			print (string) memb.list_together;
			if (c_style & ENGLISH_BIT ~= 0) print " (";
			if (c_style & INDENT_BIT ~= 0)  print ":^";
			LanguageUnnotifySuffixes();
		} else {
			inventory_stage = 1;
			parser_one = memb; parser_two = depth + c_margin;
			if (RunRoutines(memb, list_together) == 1) jump Omit__Sublist2;
		}

		c_margin++;
		@push lt_value; @push listing_together; @push listing_size;

		lt_value = memb.list_together; listing_together = memb;
		#Ifdef DBLW; print "^^DOWN lt_value = ", lt_value, " listing_together = ", memb, "^^";
		@push DBLW_no_classes; @push DBLW_no_objs; #Endif;
		WriteListR(memb, depth, false);
		#Ifdef DBLW; print "^^UP^^"; @pull DBLW_no_objs; @pull DBLW_no_classes; #Endif;

		@pull listing_size; @pull listing_together; @pull lt_value;
		c_margin--;

		if (memb.list_together ofclass String) {
			if (q & ENGLISH_BIT ~= 0) print ")";
		} else {
			inventory_stage = 2;
			parser_one = memb; parser_two = depth+c_margin;
			RunRoutines(memb, list_together);
		}
		.Omit__Sublist2;
	}

	EndActivity(GROUPING_TOGETHER_ACT, memb);

	! If the NEWLINE_BIT has been forced by the activity, act now
	! before it vanishes...
	if (q & NEWLINE_BIT ~= 0 && c_style & NEWLINE_BIT == 0) new_line;

	! ...when the original style is restored again:
	c_style = q;
];
-) replacing "WriteMultiClassGroup".


Include (-
[ WriteSingleClassGroup cl memb depth size q		  capitalised_number_flag;
	q = c_style;
	! Inventory Indent und Inventory Bullet berücksichtigt
	! *** Die zusätzliche Einrückung wird nur bei Aufzählungsebene
	!	 größer 1 wirksam.
	if (c_style & INDENT_BIT) {
		if (depth == 1) PrintSpaces(2*(depth+c_margin));
		else PrintSpaces(INVENTORY_INDENT*(depth+c_margin));
		#ifdef INVENTORY_BULLET;
		print (string) INVENTORY_BULLET;
		#endif;
	}

	if (size == 1) {
		if (c_style & NOARTICLE_BIT ~= 0) WithoutArt(memb, short_name_case);
		else {
			if (c_style & DEFART_BIT) {
				if ((cl == 1) && (c_style & CFIRSTART_BIT)) CDefArt(memb, short_name_case);
				else DefArt(memb, short_name_case);
			} else {
				if ((cl == 1) && (c_style & CFIRSTART_BIT)) CIndefArt(memb, short_name_case);
				else IndefArt(memb, short_name_case);
			}
		}
	} else {
		if (c_style & DEFART_BIT) {
			if ((cl == 1) && (c_style & CFIRSTART_BIT)) PrefaceByArticle(memb, 0, size, 1);
			else PrefaceByArticle(memb, 1, size);
		}
		if ((cl == 1) && (c_style & CFIRSTART_BIT)) {
			if (c_style & DEFART_BIT) LanguageNotifySuffixes(1,1); ! *** Großschreibung, bestimmt
			else { !*** Die Anzahl für die Ausgabe
				   !	mit Großbuchstaben vormerken ("Vier Bälle")
				   capitalised_number_flag = true;
				   LanguageNotifySuffixes(1); ! *** Großschreibung, unbestimmt
			}
		}
		else {
			if (c_style & DEFART_BIT) LanguageNotifySuffixes(0,1); ! *** Kleinschreibung, bestimmt
			else LanguageNotifySuffixes(0);   ! *** Kleinschreibung, unbestimmt
		}

		! *** Wenn capitalised_number_flag gesetzt ist, wird die Anzahl mit
		!	 Großbuchstaben ausgegeben ("Vier Bälle"). Nur im Genitiv bleibt die Anzahl
		!	 klein, weil in diesem Fall "Von drei Bällen/der drei Bälle"
		!	 geschrieben wird. Das "Von" wird in |LanguageNotifySuffixes()|
		!	 ausgegeben.

		@push listing_size; listing_size = size;
		if (capitalised_number_flag && ~~genitive_list)
			RunCapitalised(CarryOutActivity, PRINTING_A_NUMBER_OF_ACT, memb);
		else CarryOutActivity(PRINTING_A_NUMBER_OF_ACT, memb);
		@pull listing_size;
		LanguageUnnotifySuffixes();
	}
	if ((size > 1) && (memb hasnt pluralname)) {
		give memb pluralname;
		WriteAfterEntry(memb, depth);
		give memb ~pluralname;
	} else WriteAfterEntry(memb, depth);
	c_style = q;
];
-) replacing "WriteSingleClassGroup".


Include (-
[ PushListBuffer obj depth;
	if (list_buffer-->0 == LIST_BUFFER_SIZE) rfalse;
	(list_buffer-->0)++;
	list_buffer-->(list_buffer-->0) = obj;
	list_depth-->(list_buffer-->0) = depth;
	rtrue;
];

[ WriteAfterEntry o depth
    p recurse_flag parenth_flag eldest_child child_count combo   old_case; ! +++ old_case hinzugefügt

    inventory_stage = 2;
    if (c_style & PARTINV_BIT) {
        BeginActivity(PRINTING_ROOM_DESC_DETAILS_ACT, o);
        if (ForActivity(PRINTING_ROOM_DESC_DETAILS_ACT, o) == false) {
			combo = 0;
			if (o has light && location hasnt light) combo=combo+1;
			if (o has container && o hasnt open)     combo=combo+2;
			if ((o has container && (o has open || o has transparent))
				&& (child(o)==0))                    combo=combo+4;
			if (combo) LIST_WRITER_INTERNAL_RM('A'); ! space and open bracket
			switch (combo) {
				1: LIST_WRITER_INTERNAL_RM('D', o);
				2: LIST_WRITER_INTERNAL_RM('E', o);
				3: LIST_WRITER_INTERNAL_RM('H', o);
				4: LIST_WRITER_INTERNAL_RM('F', o);
				5: LIST_WRITER_INTERNAL_RM('I', o);
				6: LIST_WRITER_INTERNAL_RM('G', o);
				7: LIST_WRITER_INTERNAL_RM('J', o);
			}
			if (combo) LIST_WRITER_INTERNAL_RM('B'); ! close bracket
		}
        EndActivity(PRINTING_ROOM_DESC_DETAILS_ACT, o);
    }   ! end of PARTINV_BIT processing

    if (c_style & FULLINV_BIT) {
        BeginActivity(PRINTING_INVENTORY_DETAILS_ACT, o);
        if (ForActivity(PRINTING_INVENTORY_DETAILS_ACT, o) == false) {
			if (o has light && o has worn) { LIST_WRITER_INTERNAL_RM('A'); LIST_WRITER_INTERNAL_RM('K', o);  parenth_flag = true; }
			else {
				if (o has light)           { LIST_WRITER_INTERNAL_RM('A'); LIST_WRITER_INTERNAL_RM('D', o);  parenth_flag = true; }
				if (o has worn)            { LIST_WRITER_INTERNAL_RM('A'); LIST_WRITER_INTERNAL_RM('L', o); parenth_flag = true; }
			}

			if (o has container) {
				if (o has openable) {
					if (parenth_flag) {
						if (KIT_CONFIGURATION_BITMAP & SERIAL_COMMA_TCBIT)
							print ",";
						LIST_WRITER_INTERNAL_RM('C');
					} else            LIST_WRITER_INTERNAL_RM('A', o);
					if (o has open) {
						if (child(o)) LIST_WRITER_INTERNAL_RM('M', o);
						else          LIST_WRITER_INTERNAL_RM('N', o);
					} else {
						if (o has lockable && o has locked) LIST_WRITER_INTERNAL_RM('P', o);
						else                                LIST_WRITER_INTERNAL_RM('O', o);
					}
					parenth_flag = true;
				}
				else {
					if (child(o)==0 && o has transparent) {
						if (parenth_flag) { LIST_WRITER_INTERNAL_RM('C'); LIST_WRITER_INTERNAL_RM('F'); }
						else              { LIST_WRITER_INTERNAL_RM('A'); LIST_WRITER_INTERNAL_RM('F'); LIST_WRITER_INTERNAL_RM('B'); }
					}
				}
			}
			if (parenth_flag) LIST_WRITER_INTERNAL_RM('B');
		}
        EndActivity(PRINTING_INVENTORY_DETAILS_ACT, o);
    }   ! end of FULLINV_BIT processing

	child_count = 0;
	eldest_child = nothing;
	objectloop (p in o)
		if ((c_style & CONCEAL_BIT == 0) || (ConcealedFromLists(p) == false))
			if (p has list_filter_permits) {
				child_count++;
				if (eldest_child == nothing) eldest_child = p;
			}

    if (child_count && (c_style & ALWAYS_BIT)) {
        if (c_style & ENGLISH_BIT) { print " "; LIST_WRITER_INTERNAL_RM('Q', o); print " "; }
        recurse_flag = true;
    }

    if (child_count && (c_style & RECURSE_BIT)) {
        if (o has supporter) {
            if ((c_style & ENGLISH_BIT) && (c_style & APPEND_BIT)==0) { ! +++ && (c_style & APPEND_BIT)==0
                if (c_style & TERSE_BIT) {
                	LIST_WRITER_INTERNAL_RM('A', o);
                	LIST_WRITER_INTERNAL_RM('R', o);
                } else LIST_WRITER_INTERNAL_RM('S', o);
            }
            recurse_flag = true;
        }
        if (o has container && (o has open || o has transparent)) {
            if ((c_style & ENGLISH_BIT) && (c_style & APPEND_BIT)==0) { ! +++ && (c_style & APPEND_BIT)==0
                if (c_style & TERSE_BIT) {
                	LIST_WRITER_INTERNAL_RM('A', o);
                	LIST_WRITER_INTERNAL_RM('T', o);
                } else LIST_WRITER_INTERNAL_RM('U', o);
            }
            recurse_flag = true;
        }
    }

	#ifndef NO_ISARE_CONTENTS; ! +++
	! *** 11.05.2014: Test "ist/sind" in Inhaltslisten ausgeben, allerdings nur,
	!	 wenn die Non-nested-lists-Option (APPEND_BIT) inaktiv ist.
    if (recurse_flag && (c_style & ENGLISH_BIT) && ~~(c_style & APPEND_BIT) ) { ! +++  && ~~(c_style & APPEND_BIT)
    	SetLWI(child_count, -1, eldest_child);
    	LIST_WRITER_INTERNAL_RM('V', o); print " ";
	}
	#endif; ! +++

    if (c_style & NEWLINE_BIT) new_line;

    if (recurse_flag) {
		if ((c_style & APPEND_BIT) && PushListBuffer(o, depth)) rfalse; ! +++
        o = child(o);

		! *** Die Inhaltslisten in Klammern stehen im Nominativ,
		!	 unabhängig von dem Fall der Hauptliste.

		old_case = short_name_case; ! +++
		#ifdef NO_ISARE_CONTENTS; ! +++
			if (old_case ~= Akk) short_name_case = Nom; ! +++
		#ifnot; ! +++
			short_name_case = Nom; ! +++
		#endif; ! +++

        @push lt_value; @push listing_together; @push listing_size;
        @push c_iterator;
        c_iterator = ObjectTreeIterator;
        lt_value = EMPTY_TEXT_VALUE; listing_together = 0; listing_size = 0;
        WriteListR(o, depth+1, true);
        @pull c_iterator;
        @pull listing_size; @pull listing_together; @pull lt_value;

		short_name_case = old_case; ! +++

        if (c_style & TERSE_BIT) LIST_WRITER_INTERNAL_RM('B');
    }
];
-) replacing "WriteAfterEntry".


Section - Z-Machine (for Z-machine only)



Section - Glulx (for Glulx only)

Include (-
Global dict_start;
Global dict_entry_size;
Global dict_end;
-).


Section - Out of World



Section - Tests



Section - Relations



Section - Unterstand Tokens

Include (-
[ PrintMyWord wn	i;
	print "'";
	for (i=0 : i<WordLength(wn) : i++) {
		print (char) WordAddress(wn)->i;
	}
	print "'^";
];

[ StringOrArray str i;
	if (str ofclass String) {
		print (string) str;
	} else {
		i = 1;
		print "'";
		while (str->i > 0) {
			print (char) str->i;
			i++;
		}
		print "'^";
	}
];

! ----------------------------------------------------------------------------
! Spezielle Token:
!
! [dagegen]              Die prep-Tokens überlesen die Adverbialpronomen als
! [daran]                Präposition ohne Ergebnis. Ist ähnlich der Notation
! [darauf]               'weg'/'fort' und nützlich, wenn diese Wörter gesagt
! ...                    werden können, aber keine Information tragen wie bei
!                        "Schau in Kiste hinein/rein".
!
! [noun dagegen]         Die noun-Tokens überlesen ebenfalls eine Reihe von
! [noun daran]           Wörtern jedoch als Adverbialpronomen. Das heißt es
! [noun darauf]          wird als Ergebnis das letzte Objekt, das nicht
! ...                    'animate' ist zurückgegeben, oder ein Fehler, wenn
!                        es kein solches Objekt gibt. Hier haben die Wörter
!                        sehr wohl eine Information: "schau hinein" schaut
!                        in das zuletzt angegebene Objekt.
!
! [held darauf]          Die held-Tokens sind wie die noun-Tokens oben, nur
! [held hinein]          dass sie zusätzlich verlangen, dass das Objekt beim
!                        Spieler ist und auch ein implizites ##Take versuchen.
!                        Dunmmerweise wird die Gültigkeit in Inform nur beim
!                        Token geprüft.
!
! [force nach]           Prüft den gesamten Satz und lässt das Satzmuster
!                        nur zu, wenn es das Wort 'nach' enthält. Dies wird
!                        in Sätzen mit <topic>-Token verwendet, um fehler-
!                        hafte Eingaben wie >>schau xxx<< nicht fälschlich
!                        als Consult zu interpretieren.
!
! [force in]             Dito, erzwingt 'in' im Satz.
!
! [force nach in]        Erzwingt 'nach', lässt den Satz aber nicht zu, wenn
!                        vor 'nach' ein 'in' gefunden wird. Das wird auch bei
!                        <topic> benötigt, um >>schau italien im atlas nach<<
!                        nicht "* topic 'nach' 'in' noun" zu überlassen - >>im
!                        atlas<< würde hier als Teil des <topic> überlesen,
!                        das Nachschalgewerk impliziert.
!
! [force pronoun]        Kann in Kombination mit Präpositionen verwendet
!                        werden, zum Beispiel ist 'damit' [force_pronoun]
!                        dasselbe wie [noun_damit]. Die erste Variante kann
!                        aber nach einem [topic] verwendet werden, da einem
!                        Topic-Token nur Präpositionen oder das Satzende
!                        folgen können. Deshalb wird es hier auch nur als
!                        Krücke für ##Consult verwendet.
!
! [dativ]                Kennzeichnet ein nachfolgendes Token als Dativ.
!                        (Wird von der Lib nur zur Ausgabe von PrintCommand
!                        benutzt. Die Routine parse_name kann aber überprüfen,
!                        ob der dative_mode gesetzt ist.)
! ----------------------------------------------------------------------------


[ parse_pronomial_adverb a mode	w found;
	! Diese Routine überliest entweder Adverbialpronomen (mode==0) oder
	! bildet sie auf das "Pronomen" 'spez.' ab, das passende Pronomen
	! für Objekte, die nicht 'animate' sind. Aus der offiziellen Lib
	! übernommen. Originalcode Toni Arnold?

	! In GerX erweitert, um [held] und [noun] zu unterscheiden.
	! Der mode ist 0 für überspringen, 1 für [noun] und 2 für [held].

	!print "^parse_pronomial_adverb(a=", a, ", mode=", mode, ")^"; ! +++ Print debug info

	w = NextWordStopped();
	if (w == -1 or THEN1__WD && mode == 0) {
		wn--; return GPR_PREPOSITION;
	}
	if (w == 'da' or 'dort' or 'hier') w = NextWordStopped();

	!print "w=", w, "; wn=", wn, ": "; PrintMyWord(wn); ! +++ Print debug info
	!StringOrArray(w); ! +++ Print debug info

	found = false; ! +++ 24.06.2023 Definierter Anfangszustand

	switch (a) {
		1: if (w == 'hinein' or 'rein' or 'darein' or 'herein') found = true;
		2: if (w == 'heraus' or 'hinaus' or 'raus' or 'daraus') found = true;
		3: if (w == 'hinweg' or 'weg' or 'fort' or 'ab') found = true;
		! *** (16.05.2011) 'damit' wird vom Synonym-Mechanismus ersetzt, deshalb auskommentiert
		!4: if (w == 'damit') found = true;
		5: if (w == 'darauf' or 'drauf' or 'herauf' or 'rauf' or 'hinauf') found = true;
		6: if (w == 'darunter' or 'drunter') found = true;
		7: if (w == 'dahinter') found = true;
		8: if (w == 'nach') found = true;
		9: if (w == 'durch' or 'hindurch') found = true;
		10: if (w == 'darueber' or 'hinueber' or 'drueber' or 'herueber') found = true;
		11: if (w == 'herunter' or 'hinunter' or 'runter' or 'herab' or 'hinab') found = true; ! +++ 04.06.2023 um "herab", "hinab" ergänzt
		12: if (w == 'daran' or 'dran' or 'ran' or 'an') found = true;
		13: if (w == 'dagegen' or 'gegen') found = true;
		14: if (w == 'darum' or 'drum' or 'herum' or 'rum') found = true;
	}
	if (found) {
		if (mode == 0) return GPR_PREPOSITION;
		w = PronounValue('spez.');
		if (w == 0) return GPR_FAIL;
		if (TestScope(w, actor)) {
			if (mode == 1) {
				pronominal_adverb_flag = a+1;
				!print "referred obj='", (name) w, "'^";
				return w;
			}
			! *** Hier wird a im pronominal_adverb_flag hinterlegt, um
			!	 eventuell später feststellen zu können, welches
			!	 Pronominaladverb verwendet wurde.

			if (mode == 2 && parent(w) ~= actor) {
				if (ForActivity(IMPLICITLY_TAKING_ACT, w)==true) {
					etype = NOTHELD_PE;
					return GPR_FAIL;
				}
				!not_holding = w;
			}
			return w;
		}
	}
	return GPR_FAIL;
];

[ PREP_HINEIN_TOKEN;	return parse_pronomial_adverb(1, 0);  ];
[ PREP_HERAUS_TOKEN;	return parse_pronomial_adverb(2, 0);  ];
[ PREP_WEG_TOKEN;		return parse_pronomial_adverb(3, 0);  ];
[ PREP_DARAUF_TOKEN;	return parse_pronomial_adverb(5, 0);  ];
[ PREP_DARUNTER_TOKEN;	return parse_pronomial_adverb(6, 0);  ];
[ PREP_NACH_TOKEN;		return parse_pronomial_adverb(8, 0);  ];
[ PREP_HINDURCH_TOKEN;	return parse_pronomial_adverb(9, 0);  ];
[ PREP_DARUEBER_TOKEN;	return parse_pronomial_adverb(10, 0); ];
[ PREP_HERUNTER_TOKEN;	return parse_pronomial_adverb(11, 0); ];
[ PREP_DARAN_TOKEN;		return parse_pronomial_adverb(12, 0); ];
[ PREP_DAGEGEN_TOKEN;	return parse_pronomial_adverb(13, 0); ];
[ PREP_DARUM_TOKEN;		return parse_pronomial_adverb(14, 0); ];

[ NOUN_HINEIN_TOKEN;	return parse_pronomial_adverb(1, 1);  ];
[ NOUN_HERAUS_TOKEN;	return parse_pronomial_adverb(2, 1);  ];
[ NOUN_DARAUF_TOKEN;	return parse_pronomial_adverb(5, 1);  ];
[ NOUN_DARUNTER_TOKEN;	return parse_pronomial_adverb(6, 1);  ];
[ NOUN_DAHINTER_TOKEN;	return parse_pronomial_adverb(7, 1);  ];
[ NOUN_HINDURCH_TOKEN;	return parse_pronomial_adverb(9, 1);  ];
[ NOUN_DARUEBER_TOKEN;	return parse_pronomial_adverb(10, 1); ];
[ NOUN_HERUNTER_TOKEN;	return parse_pronomial_adverb(11, 1); ];
[ NOUN_DARAN_TOKEN;		return parse_pronomial_adverb(12, 1); ];
[ NOUN_DAGEGEN_TOKEN;	return parse_pronomial_adverb(13, 1); ];
[ NOUN_DARUM_TOKEN;		return parse_pronomial_adverb(14, 1); ];

[ HELD_HINEIN_TOKEN;	return parse_pronomial_adverb(1, 2);  ];
[ HELD_DARAUF_TOKEN;	return parse_pronomial_adverb(5, 2);  ];


[ force_prep required stop   w n;
	w = wn;
	if (stop == 0) stop = -1;
	wn = verb_wordnum + 1;
	n = NextWordStopped();
	while (n ~= -1) {
		if (n == stop) return GPR_FAIL;
		if (n == required) {
			wn = w;
			return GPR_PREPOSITION;
		}
		n = NextWordStopped();
	}
	return GPR_FAIL;
];

[ FORCE_NACH_TOKEN; return force_prep('nach'); ];
[ FORCE_NACH_IN_TOKEN; return force_prep('nach', 'in'); ];
[ FORCE_IN_TOKEN; return force_prep('in'); ];

[ FORCE_PRONOUN_TOKEN wd;
	wd = PronounValue('spez.');
	if (wd == 0) return GPR_FAIL;
	if (TestScope(wd, actor)) {
		pronominal_adverb_flag = 1; ! *** 1: erzwungen, 2-15: vordefinierte
		return wd;
	}
	return GPR_FAIL;
];


! Token, das das nachfolgende Token als Dativ kennzeichnet. So kann der
! Fall berücksichtigt werden (wird er aber noch nicht) und trotzdem bleibt
! der Scope des Tokens erhalten: dative noun, dative held, dative edible usw.

! *** Der Dativ wird bei der Ausgabe von Parser-Meldungen bei ergänzten
!     Satzmustern berücksichtigt.

[ DATIVE_TOKEN; return GPR_PREPOSITION; ];

[ SUBSTANTIVE_TOKEN; return GPR_PREPOSITION; ];


! Krücke für 'u' -> 'h', ohne 'u busch' zu beeinträchtigen

[ IMPLICIT_UP_TOKEN;
	#Ifdef u_obj;
	return u_obj;
	#Ifnot;
	return GPR_FAIL;
	#Endif;
];


[ DICH_TOKEN;
	if (NextWord() == 'dich' or 'sich' or 'euch' or 'mich')
		return GPR_PREPOSITION;
	wn--; return GPR_FAIL;
];

[ DIR_TOKEN;
	if (NextWord() ~= 'dir' or 'sich' or 'mir' or 'uns') wn--;
	return GPR_PREPOSITION;
];
-).
[replacing "Language.i6t". Das ist zu früh, weil u_obj an dieser Stelle noch nicht definiert ist,
und deshalb das IMPLICIT_UP_TOKEN nicht korrekt funktioniert. Deshalb wird hier kein spezieller
Ort für die Ersetzung angegeben.]


[-------------- Changing Gender -----------------]

Include (-
[ CG__Token gender;
	GenderNotice(self, gender);
	return GPR_PREPOSITION;
];

[ CG_MALE_TOKEN; return CG__Token(male); ];

[ CG_FEMALE_TOKEN; return CG__Token(female); ];

[ CG_NEUTER_TOKEN; return CG__Token(neuter); ];

[ CG_PLURAL_TOKEN; return CG__Token(pluralname); ];
-).


Section - Libcheck (Not for release)

Include (-
#ifdef DEBUG;

Global LC_notice_printed = false;

Array LibcheckIgnoreVerbs table

! *** Dies sind alle von GerX vordefinierten Verben, die möglicherweise
!	 auf 'e' oder 'en' enden. Diese werden beim Verben-Libcheck ignoriert,
!	 damit nur die vom Autor neu hinzugefügten Verben geprüft werden.

	'durchstoeber' 'ende'	'examine'
	'fuerwoerter'
	'konsultier' 'lage'		 'meldungen'	'nee'	 'noe'
	'pronomen'   'pruegle'	  'punkte'	   'restore' 'save'  'scheibenkleister'
	'schnueffel'
	'scope'		'score'		'showme'
	'superbrief' 'trace'		'tree'		 'verbose' 'verschliess'
	'durchschneid'				'praesentier'  'zertruemmer'
	'lade'	   'laden'

! *** Die Vokabeln der Standard-Lib, die Umlaute
!	 enthalten, werden ebenfalls übergangen.

	'rueckgängig' 'rückgaengig' 'rückgängig' 'zurück'  'äh'
;

[ PerformLibcheckAll s i;

	dict_start = #dictionary_table + WORDSIZE;
	dict_entry_size = DICT_WORD_SIZE + 7;
	dict_end = dict_start + #dictionary_table-->0 * dict_entry_size;

	if (~~s) ShowDictStat();
	XLibcheck1(s, i);
	XLibcheck2(s, i);
	!XLibcheck3(); ! +++ TODO: Stillgelegt, da immer Problem in den Understand Definitionen "am", geneldet werden
	LibcheckAnnounce(2);
];

#ifdef UMLAUT_DICT_WORDS;
[ UmlautCheck; rfalse; ];
#ifnot;
[ UmlautCheck i letter length start invalid;

	#ifdef TARGET_GLULX;
	length = Glulx_PrintAnyToArray(StorageForShortName, 24, i);
	start = 0;
	#ifnot;
	@output_stream 3 StorageForShortName;
	print (address) i;
	@output_stream -3;
	length = StorageForShortName-->0;
	start = 2;
	#endif;

	! *** Vokabel nach Umlauten durchsuchen
	for (i=0 : i < length : i++) {
		letter = StorageForShortName->(i+start);
		if (letter == CHAR_AE or CHAR_OE or CHAR_UE or CHAR_SS) invalid = true;
	}
	return invalid;
];
#endif;

[ DictWordCorrection i max	letter length start umlaute;
	#ifdef TARGET_GLULX;
	length = Glulx_PrintAnyToArray(StorageForShortName, 24, i);
	start = 0;
	#ifnot;
	@output_stream 3 StorageForShortName;
	print (address) i;
	@output_stream -3;
	length = StorageForShortName-->0;
	start = 2;
	#endif;
	umlaute = 0;

	if (max) length = max;

	! *** Vokabel i nach Umlauten durchsuchen und mit Umschreibungen ausgeben
	for (i=0 : i < length : i++) {

		letter = StorageForShortName->(i+start);
		#ifdef TARGET_ZCODE;
		if (letter == CHAR_AE or CHAR_OE or CHAR_UE or CHAR_SS) umlaute++;
		#endif;
		switch (letter) {
			CHAR_AE: print "ae";
			CHAR_OE: print "oe";
			CHAR_UE: print "ue";
			CHAR_SS: print "ss";
			default: print (char) letter;
		}
	}
	#ifdef TARGET_ZCODE;
	if (length == 9-(umlaute*3)) print "(...)";
	#ifnot;
	if (length == DICT_WORD_SIZE) print "(...)";
	#endif;
];

[ LibcheckAnnounce n newlines   i;
	say__p = 0;
	newlines = 2-newlines;
	switch (n) {
		1:  if (~~LC_notice_printed) {
				LC_notice_printed = true;
				print "LIBCHECK hat Probleme gefunden:";
				for (i=0 : i < newlines : i++) print "^";
			}
		2:  if (LC_notice_printed) {
				LC_notice_printed=false;
				print "^Hinweis: Mit dem Kommando LIBCHECK kann dieser Test
					jederzeit während des Spiels ausgeführt werden. Mit der
					Option ~Use skip libcheck.~ wird der automatische Libcheck
					bei Spielbeginn übersprungen.
					^^
					LIBCHECK ENDE.^^";
			}
	}
];

[ SuffixAddress dw mode	 i letter start length;
	! Vokabel auf Hilfsfeld schreiben
	#ifdef TARGET_GLULX;
	length = Glulx_PrintAnyToArray(UmlautAux, 24, dw);
	start = 0;
	#ifnot;
	@output_stream 3 UmlautAux;
	print (address) dw;
	@output_stream -3;
	length = UmlautAux-->0;
	start = 2;
	#endif;

	! *** Vokabel mit abgesetzten Endungen ausgeb|en
	for (i=0 : i < length : i++) {
		letter = UmlautAux->(i+start);
		if (i == length-mode) print "|";
		print (char) letter;
	}
	print " [Korrekturvorschlag: ";
	DictWordCorrection(dw, length-mode);
	print "]";
];

[ ShowDictStat	  dict_entries a i j
					verb_count meta_count noun_count prep_count;
	say__p = 0;

	dict_entries = (dict_start - dict_end)/dict_entry_size;
	if (dict_entries < 0) dict_entries = -dict_entries;

	for (a = 0 : a < dict_entries : a++ ) {
		! *** Adresse berechnen
		i = dict_start + a*dict_entry_size;
		j = i->#dict_par1;
		if (j & 1) verb_count++;
		if (j & $$00000010) meta_count++;
		if (j & $$10000000) noun_count++;
		if (j & $$00001000) prep_count++;
	}

	print "Info: Maximale Länge der Wörterbucheinträge: ";
	#ifdef TARGET_ZCODE;
	print "9 Zeichen. Das Limit kann in Z-Code nicht erhöht
		werden. Umlaute und ß belegen jeweils 4 Zeichen
		einer Vokabel.";
	#ifnot;
	print DICT_WORD_SIZE, " Zeichen. Das Limit kann in Glulx
		erhöht werden: Use DICT_WORD_SIZE of <N>.";
	#endif;

	print "^^Das ";
	#ifdef TARGET_GLULX;
	print "Glulx";
	#ifnot;
	print "Z-Machine";
	#endif;
	print "-Wörterbuch enthält ", dict_entries, " Einträge. Davon sind ",
		verb_count, " als Verben, ", meta_count, " als Meta-Befehle, ",
		 noun_count, " als Objektsynonyme und ", prep_count, " als
		 Präpositionen gekennzeichnet.^^";
];

[ CheckIgnoreLists word ignore_lib_verbs		n j;
	if (ignore_lib_verbs == false) rfalse;
	for (n = 1 : n <= LibcheckIgnoreVerbs-->0 : n++ )
		  if (LibcheckIgnoreVerbs-->n == word) { j = -1; break; }
	if (j==-1) rtrue;
	if (AddressInTable(word, (+ Table of blessed verb forms +) )) rtrue;
	rfalse;
];

[ XLibcheck1 silent ignore_lib_verbs	 o n errors i j synonyms_listed dict_entries
										a gender_error;

	say__p = 1;
	! *** Gesamtliste aller Vokabeln mit Umlauten ohne Objektbezug erstellen,
	!	 um auch die Vokabeln zu erwischen, die nicht in der name-Property
	!	 eines Objekts stehen.

	! *** Anzahl der Wörterbucheinträge ermitteln. Eine Schleife direkt über die
	!	 Adressen kann wegen eines "signed integer overflows" fehlschlagen.
	dict_entries = (dict_start - dict_end)/dict_entry_size;
	if (dict_entries < 0) dict_entries = -dict_entries;

	for (a = 0 : a < dict_entries : a++ ) {

		! *** Adresse berechnen
		i = dict_start + a*dict_entry_size;

		if (CheckIgnoreLists(i, ignore_lib_verbs)) continue;

		if (UmlautCheck(i)) {
			errors++;
			if (errors == 1) {
				LibcheckAnnounce(1);
				print "Gesamtliste aller Vokabeln, die Umlaute
					   oder 'ß' enthalten:^^";
			}
			j = i->#dict_par1;
			print errors, ": ", (address) i;
			if (j & 1) print " [Verb] [Korrekturvorschlag: siehe Verben-Check
							   weiter unten]^";
			else {
				if (j & $$10000000) {
					print " [Objekt-Synonym]";
					synonyms_listed++;
				}
				if (j & $$00001000) print " [Präposition]";
				if (j & $$00000010) print " [Meta-Verb]";
				print " [Korrekturvorschlag: ", (DictWordCorrection) i, "]^";
			}
		}
	}
	if (errors) {
		print "^Hintergrund: Vokabeln (Verben und Präpositionen in Satzmustern
				sowie Synonyme für Objekte), die Umlaute (ä, ö, ü) oder
				Eszett (ß) enthalten, können vom GerX-Parser nicht korrekt mit der
				Eingabe des Spielers abgeglichen werden, da sämtliche Umlaute und ß
				in der Spielereingabe vor der Analyse durch Umschreibungen ersetzt werden.
				Umlaute und ß in Vokabeln müssen deshalb immer mit
				ae, oe, ue und ss umschrieben werden (siehe Korrekturvorschlag).
				Nur so werden alle Umlaute und ß sowie deren Umschreibungen
				in der Spielereingabe korrekt vom Spiel verstanden.^^";
	}

	errors = 0;

	objectloop (o has mark_as_room || o has mark_as_thing || o in Compass) {

		! *** (25.05.2012)
		n = 0;

		if (o.grammatical_gender == 4) { ! == no-specified-gender (I7)

			! *** Die kompletten Attribute nur für nicht-genderisierte Objekte
			!	 prüfen, da Attribute nur noch vorhanden sein können, wenn
			!	 die initially genderise everything rule aus den Rulebooks
			!	 entfernt wurde.

			if (o has male) n++;
			if (o has female) n++;
			if (o has neuter) n++;
			if (o has pluralname) n++;
		}
		else n = 1;

		if (n ~= 1) {
			LibcheckAnnounce(1);
			print "Objekt ", o, " (", (der) o, ") hat ";
			if (n) print "keine eindeutige Genus/Numerus-Definition.^";
			else print "keine Angabe zum Genus/Numerus.^";
			errors++;
			gender_error = true;
		}


		! *** Vokabeln mit Umlauten und 'ß' in der name-Property eines
		!	 Objekts identifizieren

		#ifndef UMLAUT_DICT_WORDS;
			for (n = 0 : n<o.#name/WORDSIZE : n++) {
				if (UmlautCheck(o.&name-->n)) {
					LibcheckAnnounce(1);
					errors++;
					if (errors == 1) print "Objektdefinitionen:^^";
					print "Die Vokabel '", (address) o.&name-->n,
						"' von Objekt ", o, " (", (der) o, ") enthält
						Umlaute oder 'ß'.^";
				}
			}
		#endif;
	}
	if (errors == 0) {
		if (LC_notice_printed || ~~silent) {
			print "Keine";
			if (synonyms_listed) print " offensichtlichen";
		}
	}
	else if (errors) print "^", errors;
	if (LC_notice_printed || errors || (errors==0 && ~~silent) ) {
		print " Fehler bei den Objektdefinitionen.";
		if (gender_error) { print "^^Achtung: Mehrdeutige oder fehlende
			Genus-Definitionen sollten nicht vorkommen.
			^^
			Möglicherweise werden Attribute zur Laufzeit oder
			in eingebundenem I6-Code vergeben.^";
		}
		else {
			if (errors) print " Siehe Korrekturvorschlag in der Gesamtliste
								weiter oben.";
			print "^";
		}
		if (synonyms_listed && (synonyms_listed ~= errors) ) {
			print "^Achtung: ";
			if (synonyms_listed==1) print "Es wurde ein Objektsynonym gefunden,
				das Umlaute/ß enthält";
			else print "Es wurden ", synonyms_listed, " Objektsynonyme gefunden, die
				Umlaute/ß enthalten";
			print " (siehe
				Gesamtliste weiter oben). Objekte mit dem Attribut ~privately-named~
				oder gruppierten Vokabeln (~vokabel1/vokabel2/vokabel3~),
				die nicht automatisch geprüft werden können, sollten
				deshalb manuell auf ";
			if (synonyms_listed>1) print "die gelisteten Synonyme";
			else print "das gelistete Synonym";
			print " hin überprüft werden.^";
		}
	}
];

[ XLibcheck2 silent ignore_lib_verbs  i j last last2 last3
									  mode warnings dict_entries
									  a suffix_warning;
	say__p = 1;

	dict_entries = (dict_start - dict_end)/dict_entry_size;
	if (dict_entries < 0) dict_entries = -dict_entries;

	! *** Verben auf Endung 'e', 'n' (nach 'l') oder 'en' + Umlaute/ß prüfen:

	warnings = 0;
	suffix_warning = false;

	for (a = 0 : a < dict_entries : a++ ) {
		i = dict_start + a*dict_entry_size;
		j = i->#dict_par1;
		if (j & 1) {

			if (CheckIgnoreLists(i, ignore_lib_verbs)) continue;

			last  = LastCharacterAddress(i, 0);
			last2 = LastCharacterAddress(i, 1);
			last3 = LastCharacterAddress(i, 2);

			! *** (22.02.2011) Verben, die  auf 'ae', 'ee', 'ie', 'oe' oder 'ue'
			!	 enden, werden nicht angemeckert.

			if (last == 'e' && last2 == 'a' or 'e' or 'i' or 'o' or 'u') continue;

			! *** (28.03.2014) -chle ist immer richtig ('laechle', 'pichle' :).

			if (LastCharacterAddress(i, 3) == 'c'
				&& last3 == 'h' && last2 == 'l' && last == 'e') continue;

			! *** (28.03.2014) was auf -<aeiou>l und -<lrwy>l endet, wird angemeckert,
			!	 der Rest ist korrekt (baumle, wedle, entriegle usw.)

			if ( last == 'e' && last2 == 'l' or 'n' or 'r' ) { ! -le, -ne, -re
				if (last3 ~= 'a' or 'e' or 'i' or 'o' or 'u'
				 && last3 ~= 'h' or 'l' or 'r' or 'w' or 'y')
						continue;
			}

			if (last2 == 'l' && last == 'n') mode = 2; ! mode == 2: Infinitiv-Form (wird momentan nicht benutzt)
			else if (last2 == 'e' && last == 'n') mode = 2;
			else if (last == 'e') mode = 1;

			if (mode || UmlautCheck(i)) {
				if (mode) suffix_warning = true;
				warnings++;
				if (warnings == 1) {
					LibcheckAnnounce(1,1);
					#ifdef UMLAUT_DICT_WORDS;
					print "^Folgende Verben haben Endungen:^^";
					#ifnot;
					print "^Folgende Verben haben überflüssige Endungen und/oder enthalten Umlaute/ß:^^";
					#endif;
				}
				print warnings, ": ";
				SuffixAddress(i, mode);
				print "^";
				mode = 0;
			}
		}
	 }
	 if (suffix_warning) {
		print "^Hintergrund: Verben sollten immer im Imperativ (der Befehlsform)
			für die 2. Person Singular angegeben werden, wobei der Spieler
			das Spiel konventionsgemäß duzt. Es empfiehlt sich, immer die
			knappste Form eines Verbs (~geh~) ohne Endungen zu definieren, damit
			möglichst viele Wortformen (~geh~, ~gehe~, ~gehen~, ~geht~)
			verstanden werden (siehe Korrekturvorschlag).
			Der Parser erkennt Endungen in der Spielereingabe, deshalb braucht
			man sie nicht extra anzugeben.";

		print "^^Tipp: Wenn das Verb auch ohne die Endung einen gültigen
			Imperativ darstellt, sollte die bestehende Definition geändert
			und ausschließlich die Form ohne Endung verwendet werden.
			^^
			Sind Verben mit der Endung 'e', 'en' oder 'n'
			notwendig, weil sie gar keine (deutschen) Verben sind (z.B. 'karte', 'analyze'),
			kann man diese in einem Not-for-release-Abschnitt in die fortgesetzte
			Tabelle ~Table of blessed verb forms (continued)~ eintragen und
			somit abgsegnen; die Verben in dieser Tabelle werden beim nächsten
			Library-Check ignoriert und nicht mehr als Fehler gemeldet.
			^^
			Es folgt ein Beispiel für eine Tabelle mit dem Kommando-Wort 'hinweise' und
			dem englischen Verb 'analyze', deren Formen ohne 'e' keine gültigen
			Imperative sind und deshalb mit 'e' am Ende definiert werden sollten:
			^^
			Section - Abgesegnete Verbformen (Not for release)
			^^Table of blessed verb forms (continued)^
			Verb^
			~karte~^
			~analyze~^";
	  }
	  if (warnings==0 && silent==false) {
		  print "^Keine Fehler bei den Verben-Definitionen.^";
		  if (~~LC_notice_printed) print "^";
	  }
];

[ _PrintPrepSnip s   i;
	VM_PrintToBuffer(HLAuxBuffer1, 128, s);
	while (HLAuxBuffer1->(i + WORDSIZE) ~= 32) {
		print (char) HLAuxBuffer1->(i + WORDSIZE);
		i++;
	}
];

[ XLibcheck3		n index par errors word orig orig2 syn;
	say__p = 1;
	n = LanguageSynonyms2-->0;

	for (index = 1 : index < n : index = index + 2) {
		word = LanguageSynonyms2-->index;
		par = word->#dict_par1;
		if (~~(par & $$10001000)) continue;

		errors++;
		orig = LanguageSynonyms2-->index;
		orig2 = LanguageSynonyms-->index;
		syn = LanguageSynonyms2-->(index+1);
		if (errors == 1) {
			LibcheckAnnounce(1,1);
			print "^Folgende Wörter in Understand-Definitionen können niemals verstanden werden:^^";
		}
		print errors, ": ", (address) word;
		if (par & $$00001000) print " (Bestandteil eines oder mehrerer Satzmuster)";
		if (par & $$10000000) print " (Bestandteil eines oder mehrerer Objekt-Synonyme)";
		print " [Korrekturvorschlag: ~", (_PrintPrepSnip) syn, "~ vor [Satzbaustein], ansonsten ~",
			(PrintI6Text) syn, "~]^";
	}
	if (errors) {
		print "^Hintergrund: Einige Wörter in der Spielereingabe werden
			vor der Analyse durch anderen Text ersetzt. Dies
			sind vor allem Verschmelzungen von Präpositionen und Artikeln,
			wie z.B. ~im~, ~zum~ usw. Vor der Satzanalyse werden sie in ihre Bestandteile
			zerlegt und durch ~in dem~, ~zu dem~ usw. ersetzt. Deshalb können Objektsynonyme
			und Satzmuster, in denen diese Wörter als Vokabeln vorkommen,
			unter keinen Umständen verstanden werden.^^";

		print "Tipp: Die Understand-Definitionen sollten gemäß
			der Korrekturvorschläge angepasst werden.
			Vor einem Understand-Token (Satzbaustein), wie z.B.
			[something], sollte nur die
			Präposition angegeben werden, da der bestimmte Artikel
			überlesen wird. Folgt im Satzmuster kein Satzbaustein,
			muss die vollständige Auflösung der Verschmelzung
			angegeben werden. Nur so werden die
			ursprünglichen und die ersetzten Formen (z.B. ~",
			(address) orig, "~ und ~", (PrintI6Text) syn, "~)
			gleichermaßen verstanden.^";
	}
];

#endif; ! DEBUG
-).

Include (-
#ifdef DEBUG;
-).

[ *** (06.05.2011) Für den Synonym-Libcheck (XLibcheck3) müssen die Worte,
	 die vor dem Parsen durch Synonym-Strings ersetzt werden, als
	 Vokabeln im Wörterbuch vorhanden sein. Aber: Damit überprüft werden
	 kann, ob der Autor sie als Objekt-Synonym verwendet hat, tarnen
	 wir die früheren Vokabeln aus dem Array LanguageSynonyms zunächst
	 als Verben.

	 Dass die Vokabeln ursprünglich Verben sind, ist kein Problem:
	 Versucht der Spieler z.B. >DURCHS, kann das Wort niemals als
	 Verb verstanden werden, weil der Befehl für den Parser >DURCH DAS
	 lautet. ]

[ +++ TODO Die Verben waren in I6 als "meta" gekennzeichnet. ]
Synonym checking is an action out of world applying to nothing.
Report Synonym checking: say "Ich habe dieses Verb nicht verstanden.[line break]".
Understand "am" and "ans" and "aufs" and "beim" and "durchs" and "fuers" and "hinterm" and "hinters" and "im" and "ins" and "nebens" and "uebers" and "ueberm" and "unters" and "unterm" and "vom" and "vors" and "vorm" and "zum" and "zur" and "darin" and "damit" and "beid" as synonym checking.

Include (-
#endif; ! DEBUG
-).

Include (-
#ifdef DEBUG;
[ InitialiseLanguageSynonyms2 n index word;
	! *** (18.05.2011) Spielbeginn: Kopie von LanguageSynonyms erstellen, allerdings
	!	 mit Vokabeln statt Strings.

	n = LanguageSynonyms2-->0 = LanguageSynonyms-->0;
	for (index = 1 : index < n : index = index + 2) {
		word = LanguageSynonyms-->index; ! Ein String ...
		VM_PrintToBuffer(HLAuxBuffer2, 24, word);
		VM_Tokenise(HLAuxBuffer2, parse);
		word = parse-->1; ! ... und jetzt ein Wörterbuch-Eintrag (eine Vokabel)!
		LanguageSynonyms2-->index = word;
		LanguageSynonyms2-->(index+1) = LanguageSynonyms-->(index+1);
	}
];
#endif; ! DEBUG
-).


[Section - Temporary bug fixes]


German ends here.

---- DOCUMENTATION ----

By including this German extension (GerX) you can make German the language of play.
The I6 code for German language processing is exclusively based on the deform library 6/11 by Martin Oehm.
GerX is, like I7 itself, a work in progress.

Please send bug reports, suggestions, and comments to

	"fgerbig@users.sourceforge.net" and "GerX@pageturner.de"

or post them in the German IF forum at

	"http://forum.ifzentrale.de"

Chapter: Willkommen

Section: Allgemeines

Mit dieser German-Extension (GerX) kann man deutschsprachige Textadventures mit Inform 7 (I7) schreiben. Das heißt, dass Ein- und Ausgabe des fertigen Spiels auf Deutsch stattfinden; der Inform-7-Quelltext wird weiterhin auf Englisch geschrieben.

Die Anpassung von GerX an Inform 7 10.2.1 wurde von Frank Gerbig durchgeführt.

GerX wurde von Banbury, Christian Blümke und Michael Baltes erstellt. Der Inform-6-Code, der für die spezielle Behandlung der deutschen Eingabe- und Ausgabetexte verantwortlich ist, wurde ausschließlich der deform-Bibliothek Release 6/11 von Martin Oehm entnommen und so behutsam wie möglich für die Benutzung mit Inform 7 angepasst. Danke an Martin Oehm für diese Steilvorlage!

GerX ist so ausgelegt, dass der Autor, wie beim englischen Original auch, alle Standard-Antworten ändern kann. Sehr bequem geht das z.B. mit der Extension Default Messages von Ron Newcomb in Kombination mit German Default Messages von Team GerX. Alle neuen Rules haben Namen, die man im Inform-Index nachschlagen kann. Über diese lassen sich die Rules ersetzen oder in ihrer Reihenfolge beeinflussen. Für die in Inform 7 enthaltenen Erweiterungen Rideable Vehicles von Graham Nelson sowie Locksmith, Menus und Basic Screen Effects von Emily Short bringt GerX schon Übersetzungen mit. Die Original-Erweiterungen müssen im Quelltext vor der deutschen Erweiterung eingebunden werden.

Um mit GerX arbeiten zu können, muss sich der Autor jedoch mit ein paar Besonderheiten vertraut machen. So gibt es zum Beispiel neue Methoden, Texte mit flexiblen Adjektiv- und/oder Substantiv-Endungen auszugeben. Es gibt auch einige Regeln für das Benennen von Dingen und Vokabeln, an die sich der Autor halten muss, damit das Spiel am Ende richtig funktioniert und der Spieler die größtmögliche Flexibilität bei der Eingabe seiner Anweisungen hat. All das wird im Folgenden erläutert werden.


Section: Dankeschön

Die Autoren dieser Erweiterung danken Martin Oehm, Emily Short, Marius Müller, Christoph Winkler, Martin Barth, Ingo Scharmann, Andrew Plotkin und allen Nutzern auf "forum.ifzentrale.de" und "rec.arts.int-fiction", die geholfen haben, diese Extension zu erstellen und zu verbessern.

Einer fehlt noch:

	Before thanking the above, try thanking Graham Nelson (this is the specially acknowledging the creator of Inform rule).

Chapter: Die ersten Schritte

Section: Einbinden des German-Language-Kit und der German-Extension

Zunächst muss das "Inter"-Verzeichnis, welches das GermanLanguageKit enthält, aus dem "materials"-Verzeichnis des Demo-Spiels in das "materials"-Verzeichnis des eigenen Projekts kopiert werden.

Dann muss der Autor das GermanLanguageKit einbinden. Dies geschieht durch das Angeben von "(in German)" nach dem Titel.
Abschließend wird die German-Extension eingebunden.

	*: "Story" by "Author" (in German)
	Include German by Team GerX.


Section: Bibliographische Daten

Titel und Autor können wie im englischen Original angegeben werden:

	"Sauwetter" by Lasse Regner

Wichtig ist, dass weiterhin "by" geschrieben wird. GerX macht bei der Ausgabe ein "von" daraus.

Der Autor sollte eine eigene story headline für sein Spiel angeben, weil ansonsten in den bibliographischen Metadaten (Datei "Metadata.iFiction" im Projektordner) die englische Standard-Headline "An Interactive Fiction" verzeichnet wird.

	The story headline is "Ein interaktives Beispiel".

Nun wird am Anfang des Spiels folgender Text ausgegeben:

	Sauwetter
	Ein interaktives Beispiel von Lasse Regner

Wenn keine story headline angegeben wird, heißt es im Titel-Banner des Spiels (aber eben nicht in den Metadaten):

	Sauwetter
	Ein Textadventure von Lasse Regner

Chapter: Vokabeln

Section: Was sind Vokabeln?

Vokabeln sind die Wörter im Lexikon eines Spiels, die mit der Spieler-Eingabe abgeglichen werden, um die Anweisung zu verstehen. Dies sind zum einen die vordefinierten Verben, aber auch die vom Autor neu definierten Kommandos und Synonyme für Objekte. Damit auf Deutsch möglichst viele verschiedene Formen (Imperativ oder Infinitv für Verben, Adjektive und Substantive mit Endungen) verstanden werden können, wird die Eingabe des Spielers vor der Auswertung informisiert, d.h. sie wird von Deutsch nach "Informesisch", der Muttersprache des Parsers, übersetzt. (Siehe hierzu auch Kap. 8.1: Die Informisierung der Spielereingabe.)

Zunächst werden die Umlaute (ä, ö, ü) in "ae", "oe" und "ue" umgewandelt; das Eszett (ß) wird zu "ss". Deshalb müssen sämtliche Vokabeln (Verben, Substantive, Adjektive, Präpositionen usw.) vom Autor ohne ä, ö, ü oder ß angegeben werden, wobei für Umlaute die Umschreibungen "ae", "oe" und "ue", für das Eszett "ss" zu verwenden sind. Vokabeln, die Umlaute enthalten, werden vom Spiel nicht verstanden.

Nach der Umschreibung der Umlaute werden sämtliche Flexionsendungen in der Eingabe so weit wie möglich abgeschnitten. Das heißt, der Parser beschneidet die einzelnen Wörter so lange, bis eine Wortform vorliegt, die im Lexikon des Spiels existiert. Deshalb empfiehlt es sich, Vokabeln per Understand-Definitonen immer auf Informesisch (ohne Umlaute und Endungen) zu definieren, damit möglichst viele Varianten verstanden werden können.

Die Einschränkungen für das Definieren von Vokabeln wie "Baeume" sind leider nicht besonders intuitiv, sie haben aber den Vorteil, dass der Spieler sowohl "Bäume" als auch "Baeume" mitsamt aller möglicher Endungen ("Bäumen", "Baeumen") in seiner Anweisung schreiben kann. Es ist also möglich, das Spiel auch auf einer Tastatur ohne deutsche Umlaute zu spielen. Außerdem wird das Definieren von Vokabeln auf diese Weise viel übersichtlicher, da nur die Grundform eines Wortes angegeben werden muss.

Mit der Testfunktion LIBCHECK kann man prüfen, ob versehentlich Vokabeln mit Umlauten oder Endungen definiert wurden (s. Kap. 5.13: "Überprüfen der Vokabel- und Genusdefinitionen").

Intern werden nur die ersten 9 Zeichen einer Vokabel verarbeitet. Dies ist ein Relikt aus speicherarmen Zeiten und kann bei langen Wörtern zu Problemen führen. Zwei Möglichkeiten, wie man lange Vokabeln behandeln kann, sind beschrieben in Section 9.1: Wortköpfe und -schwänze (Compound Heads und Compound Tails) von langen Wörtern abtrennen.


Section: Hauptwörter und Adjektive (Synonyme für Objekte)

Nomen und Adjektive sollten immer ohne Endungen angegeben werden. Umlaute und "ß" werden umschrieben. Groß- und Kleinschreibung können bei der Definition von Vokabeln beliebig verwendet werden; sie werden bei der Erzeugung des Wörterbuches sämtlich in Kleinbuchstaben übersetzt.

	Understand "Reisepass" and "Fuehrerschein" as the documents.
	Understand "gruen" as the Green Goblin.

Section: Verben (Kommandos) und Satzmuster

Bevor man ein neues Verb definiert, sollte man prüfen, ob das Verb mit dem dazugehörigen Satzmuster schon besteht und, falls ja, welche Aktion es auslöst. Sämtliche aktuell für ein Projekt existierenden Kommandos und Satzmuster werden im Actions-Index von Inform 7 aufgelistet.

Verben sollten immer in der Imperativ-Form für die 2. Person Singular angegeben werden, wobei der Spieler das Spiel (und auch andere Personen im Spiel) konventionsgemäß duzt. Im Deutschen haben die regelmäßigen Verben meist zwei Imperativ-Formen, die sich nur durch ein angehängtes "e" unterscheiden ("denk" / "denke"). Das Kommando-Verb sollte nur in der Form ohne "e" angegeben werden, damit diese beiden Formen sowie der Imperativ für die 2. Person Plural ("denkt") und der Infinitiv ("denken") verstanden werden.

	Understand "blas" and "pust" as blowing. Understand "kneif" as pinching.

Kommandos müssen aber nicht unbedingt ohne "e" definiert werden, besonders wenn es keine echten Verben sind, sondern Substantive oder englische Verben ("punkte", "save"). Aber auch wenn die Form ohne "e" keinen gültigen Imperativ ergibt, wie z.B. bei "buddl", sollte ebenfalls ein "e" angehängt werden.

	Understand "buddle in [dativ] [something]" as digging.

In so einem Fall wird der Parser bei Rückfragen einen falschen Infinitiv konstruieren:

	>BUDDLE
	Worin willst du buddlen?

Um dem Programm bei Bedarf den korrekten Infinitv für unregelmäßige Imperativ-Infinitiv-Paare mitteilen zu können, gibt es die Tabelle "Table of infinitives", in die Imperative und die dazugehörigen Infinitive eingetragen werden können. Die Tabelle muss vom Autor mit dem Zusatz "(continued)" fortgesetzt werden, da sie von Haus aus schon eine Zeile enthält.

	Table of infinitives (continued)
	Verb		Infinitive
	"buddle"	"buddeln"

	>BUDDLE
	Worin willst du buddeln?

Natürlich ist es auch möglich, den Infinitiv eines anderes Verbs anzugeben:

	Table of infinitives (continued)
	Verb		Infinitive
	"buddle"	"graben"

	>BUDDLE
	Worin willst du graben?

In der Tabelle können auch bereits vordefinierte Verb-Infinitiv-Paare verändert werden.

	Table of infinitives (continued)
	Verb		Infinitive
	"nimm"		"dir aneignen"

	>NIMM
	Was willst du dir aneignen?


Section: Konflikte zwischen Vokabeln

In seltenen Fällen kann es vorkommen, dass sich Verben und Hauptwörter überschneiden.

	The pump is a thing. The printed name of the pump is "Pumpe[f]". Understand "pumpe[f]" as the pump.

	Pumping is an action applying to nothing. Understand "pump" as pumping.

Das Vorhandensein der Vokabel 'pumpe' verhindert, dass Spielereingaben auf "pump" heruntergekürzt werden, da bei "pumpe" Schluss ist. Gibt der Spieler etwa ">PUMPE" ein, so wird das nicht als "pump" verstanden, sondern als "pumpe".

Die einfachste Lösung dafür ist, die Vokabel für die Pumpe ohne -e zu definieren:

	Understand "pump[f]" as the pump.

Will man jedoch die Vokabel mit -e definieren, z.B., wenn man deutsche Bezeichner benutzt, die ins Vokabular übernommen werden (publically-named), wird es etwas komplizierter:

	The Pumpe is a publically-named thing.

Nun muss man das Vokabular fürs Pumpen (die Aktion pumping) erweitern:

	Understand "pumpe" as pumping.

Oder auch:

	Understand the command "pumpe" as "pump".

	>PUMPE BETRACHTEN
	Ich habe nur Folgendes verstanden: pumpen.

In so einem Fall kann man das betreffende Wort in die fortgeführte Tabelle "Table of verb-noun collisions (continued)" eintragen, damit die Infinitiv-Konstruktion wieder korrekt funktioniert.

	Table of verb-noun collisions (continued)
	Verb
	"pumpe"

	>PUMPE BETRACHTEN
	Du siehst nichts Besonderes an der Pumpe.

Auch bei der Verwendung von Gesprächsthemen (Topics) kann es zu Überschneidungen mit bestehendem Vokabular geben:

	Instead of asking the teacher about "Frage/Fragen" ...
	Understand "Fragebogen/Frage/Fragen" as "[Fragebogen-Topic]".

In diesen Fällen werden die Vokabeln 'frage' und 'fragen' im Wörterbuch angelegt, was verhindert, dass die Imperative "frage" und der Infinitiv "fragen" vom Parser verstanden werden können, da die Verben in der Spieleringabe nicht mehr auf "frag" heruntergekürzt werden.

Die einfachste Lösung ist hier wohl, in den Gesprächsthemen die kürzeste Form zu verwenden:

	Instead of asking the teacher about "Frag" ...
	Understand "Fragebogen/Frag" as "[Fragebogen-Topic]".

Der Spieler kann nun aber auch die verkürzte Form, die nicht korrekt ist, benutzen

	*>FRAGE DEN LEHRER NACH DER FRAG

Wer das nicht möchte, muss wie oben beschrieben vorgehen:

	Understand the commands "frage" and "fragen" as "frag".

	Table of verb-noun collisions (continued)
	Verb
	"frage"
	"fragen"

Nun muss aber auch noch die Infinitv-Form für das Kommando "fragen" geändert werden, weil bei der Verwendung des Infinitivs in der Eingabe die Wiedergabe des Kommandos ("[recap of command]") einen falschen Infinitiv schreibt: "fragenen". Also:

	Table of Infinitives (continued)
	Verb		Infinitive
	"fragen"	"fragen"


Chapter: Das Definieren von Dingen

Section: Zwei unterschiedliche Methoden

Das Definieren von Dingen ist im englischen Inform 7 eine elegante Sache. Der Autor benennt ein Objekt und I7 macht aus diesem internen Namen gleich noch eine Vokabel, oder auch mehrere. Zudem wird der interne Name für die Anzeige im Spiel genutzt. Ein Beispiel:

	The book is a thing in the library.

Book ist nun der interne Bezeichner, mit dem der Autor in seinem Code auf das Objekt verweist. 'book' wird gleichzeitig als Vokabel definiert und der angezeigte Name, der printed name, wird als "book" angelegt.

Mit GerX stoßen wir mit dieser schönen Verzahnung von Programmier- und Spielsprache leider an Grenzen, da nur die Spielsprache ins Deutsche übertragen wird. Solange es keinen I7-Compiler gibt, der deutschen Quelltext versteht und nach Inform 6 übersetzt, muss man Kompromisse machen.

Es gibt zwei unterschiedliche Methoden zum Definieren von Objekten. Der Standard ist ein uneleganter Sprachen-Mix. Es gibt aber ein alternatives Verfahren, bei der Objektbezeichner und Vokabular nicht direkt zusammenhängen. Jede dieser Vorgehensweisen stellt einen Kompromiss mit unterschiedlichen Schwerpunkten dar; welche man bevorzugt, ist reine Geschmackssache, denn der Spieler wird den Unterschied später nicht merken.

Section: Methode I: Die einsprachige Variante (Standard)

Um den uneleganten Sprachen-Mix zu vermeiden, kann man die Arten (kinds) "thing" und "room" als "privately-named" deklarieren (im Gegensatz zu "publically-named"). Das bedeutet, dass der interne Bezeichner nicht ans Vokabular weitergegeben wird. Das betrifft dann auch sämtliche Unter-Arten von "room" und "thing" ("supporter", "container" usw.). Man kann die Objekte in seinem Quelltext also nennen, wie man möchte, vor allem aber englische Bezeichner und Arten verwenden. Das hat den Vorteil, dass der Quelltext natürlicher wirkt; der Nachteil allerdings ist, dass der angezeigte Objektname (printed name) und die Synonyme explizit für jedes Objekt angegeben werden müssen. Bei mehreren Objekten derselben Art müssen zudem noch der angezeigte Plural-Objektname (printed plural name) und das Plural-Vokabular nachgeliefert werden.

	A thing is usually privately-named. A room is usually privately-named.

Beispiele:

	The basement is a room. The printed name is "Keller[m]". Understand "Keller" as the basement.

	The box is a container in the basement, fixed in place. The printed name is "Kasten[m]". Understand "Kasten" as the box.

	The green apple is an edible thing in the box. The printed name is "grün[^] Apfel[-s][m]". Understand "gruen" and "Apfel" as the apple.

	A carrot is a kind of thing. It is edible. The printed name is "Karotte[f]". The printed plural name is "Karotten". Understand "Karotte" and "Moehre" as a carrot. Understand "Karotten" and "Moehren" as the plural of a carrot.

	In the box are six carrots.

Bei Eigennamen muss nur das Vokabular nachgeliefert werden. Der angezeigte Objektname wird vom Bezeichner übernommen.

	Tina McKenzie is a woman in the saloon. Understand "Tina" and "McKenzie" as Tina.

Das Beispiel A "Der Mantel der Finsternis" im Anhang dieser Dokumentation benutzt die einsprachige Methode zum Definieren von Objekten.

	*: A thing is usually privately-named.

Section: Methode II: Die Denglisch-Variante

Es müssen deutsche Objektnamen und englische Arten-Bezeichnungen verwendet werden, was zu einem etwas unschönen Sprachen-Mix führt:

	The Keller is a room. The grammatical gender of the Keller is masculine gender.

	The Kiste is a container in the Keller, fixed in place. The grammatical gender of the Kiste is feminine gender.

	The grün Apfel is an edible thing in the Kiste. The printed name is "grün[^] Apfel[-s][m]". Understand "gruen" as the Apfel.

	The Oelkanne is a thing in the Keller. The printed name is "Ölkanne[f]".

	A Karotte is a kind of thing. It is edible. The grammatical gender of the Karotte is feminine gender. The printed plural name is "Karotten". Understand "Karotte" and "Moehre" as a Karotte. Understand "Karotten" and "Moehren" as the plural of Karotte.

	In the box are six Karotten.

Enthält der Objektname Umlaute oder ß, muss das Vokabular mit den Umschreibungen (ae, oe, ue, ss) angepasst werden(so wie bei "grün" im Beispiel). Benutzt man Umschreibungen im Objektnamen, muss der angezeigte Objektname, der printed name, nachgezogen werden (wie bei der "Ölkanne"). Der angezeigte Plural-Objektname (printed plural name) und das Plural-Vokabular für mehrere Objekte derselben Art (hier: die Karotten) müssen von Hand angepasst werden, wenn der Plural nicht wie im Englischen mit 's' am Ende gebildet wird.

Das Beispiel B "Die Jadestatue" im Anhang dieser Dokumentation benutzt die Denglisch-Methode zum Definieren von Objekten.


Section: Angabe des grammatischen Geschlechts (Genus)

Das grammatische Geschlecht (Genus) des Objekts ist für die Bildung der korrekten Formen bei der Textausgabe entscheidend und entspricht dem Genus des angezeigten Objektnamens (printed name). Jedes Objekt besitzt als Eigenschaft einen "grammatical gender", der die Werte masculine gender (männlich), feminine gender (weiblich) oder neuter gender (sächlich) annehmen kann. Der grammatical gender eines Objekts ist standardmäßig neuter gender.

(Bitte nicht wundern: Es gibt noch einen weiteren grammatical gender, den Wert no-specified-gender, der auch im Index angezeigt wird. Dieser Wert dient lediglich zu internen Kontrollzwecken bei der Initialisierung des Spiels und wird danach nicht mehr gebraucht. Der Autor kann diesen Wert getrost ignorieren.)

Objekte mit einem printed name im Plural bekommen das Attribut (Adjektiv) plural-named. Der grammatical gender ist bei Plural-Objekten irrelevant und wird deshalb auf den (beliebigen) Wert neuter gender gesetzt.

Man kann den grammatical gender für ein Objekt auf zwei Arten festlegen:

(1) Direkt im printed name wird mit einer Textersetzung, die als Kennzeichnung dient, der grammatical gender gesetzt. Das ist praktisch, weil sich das Objekt-Genus ohnehin immer nach dem printed name richtet; so können mögliche Diskrepanzen zwischen Objekt-Genus und -Namen leicht vermieden werden.

Für jedes Objekt, das auf diese Weise gekennzeichnet werden soll, muss also gesondert ein printed name angegeben werden. Für Autoren, die die Standard-Methode (siehe Section 4.2) benutzen, bedeutet das keinen Mehraufwand, da der printed name und das Vokabular ohnehin explizit definiert werden müssen. Aber auch bei der Denglisch-Methode (siehe Section 4.3) muss der printed name häufig von Hand definiert werden, um die Textersetzungen für die Endungen nachzuliefern.

Die Genus-Textersetzungen entsprechen formal den Genus-Satzbausteinen (understand tokens) beim Changing Gender (siehe Section 4.6: Feststellen und Anzeigen des grammatischen Geschlechts (Genus)):

	"[m]" (Maskulinum, männlich)
	"[f]" (Femininum, weiblich)
	"[n]" (Neutrum, sächlich)
	"[p]" (Plural, Mehrzahl)

Wichtig ist, dass die Textersetzung ohne ein zusätzliches Leerzeichen im printed name steht.

Beispiel:

	A thing is usually privately-named. A room is usually privately-named.

	The lab is a room. "Du bist hier im geheimen Labor des Doktor Saratow.". The printed name is "Labor[n]". Understand "Labor[n]" as the lab.

	The apple is a thing in the lab. The printed name is "Apfel[-s][m]". Understand "Apfel" as the apple.

	The pear is a thing in the lab. The printed name is "Birne[f]". Understand "Birne" as the pear.

	The peculiar item is in the lab. The printed name is "eigenartig[^] Ding[n], das Du irgendwo schon einmal gesehen hast". Understand "eigenartig", "Ding" as the peculiar item.

(2) Wenn keine Genus-Kennzeichnung im printed name verwendet wird, kann der grammatical gender auch direkt zugewiesen werden, was etwas mehr Schreibarbeit bedeutet, aber prinzipiell das gleiche bewirkt, wie die Kennzeichnung im printed name:

	The grammatical gender of the apple is masculine gender.
	The grammatical gender of the pear is feminine gender.

Um ein Plural-Objekt zu definieren, muss das Attribut plural-named vergeben werden:

	The marbles are plural-named.


Section: Ändern des grammatischen Geschlechts (Genus) während des Spiels

Wenn sich der printed name eines Objekts während des Spiels ändert, muss natürlich auch das dazugehörige grammatische Geschlecht angepasst werden. Das geht mit der Anweisung "re-genderise <OBJECT> to <TEXT>, <PHRASE OPTIONS>" in einem Aufwasch:

	re-genderise the vase to "Scherbenhaufen[m]";

Das bewirkt Folgendes: Der printed name des Objekts vase wird zu "Scherbenhaufen[m]", und der grammatical gender des Objekts vase bekommt den Wert masculine gender.

Die re-genderise-Phrase bietet zusätzliche Optionen:

	acting plural
	acting masculine
	acting feminine
	acting neuter

Eine dieser vier Optionen kann hinzugefügt werden, wenn kein Genus im neuen printed name angegeben wird, z.B.

	re-genderise the vase to "Scherbenhaufen", acting masculine.

Weitere Optionen sind:

	with definite article
	with no article
	with yours

Eine dieser Möglichkeiten setzt den special indefinite article (siehe Section 4.8) eines Objekts. Wird keine dieser Optionen angegeben, fällt der special indefinite gender zurück auf den Wert PENDING.

Um einen Eigennamen zu definieren steht folgende Optionen zur Verfügung:

	as proper-named (Eigenname)

Wird die Option nicht angegeben, wird implizit das Attribut improper-named vergeben (kein Eigenname).

Die Optionen können durch ein Komma miteinander kombiniert werden, z.B.

	re-genderise the vase to "Scherbenhaufen[m]";
	re-genderise the vase to "Scherbenhaufen[m]", with definite article;
	re-genderise the vase to "Scherbenhäufchen", acting neuter, with yours;
	re-genderise the vase to "Annas Vase[f]", as proper-named;

Praxis-Beispiel:

	The girl is a woman in the lab. "[Ein girl] ist hier." The printed name is "Mädchen[n]". Understand "Anna[f]" and "Maedchen[n]" as the girl.

	After examining the girl when the girl is not proper-named:
		re-genderise the girl to "Anna[f]", as proper-named;
		say "Das Mädchen sagt: 'Ich heiße übrigens [girl]. Und ich bin [gender of girl].'"


Section: Feststellen und Anzeigen des grammatischen Geschlechts (Genus)

Um herauszufinden, welches grammatische Geschlecht ein Objekt hat, ist der grammatical gender eines Objekts auschlaggebend.

	if the grammatical gender of the noun is masculine gender, ...

Man kann auch eines der folgenden Adjektive verwenden, was zum Beispiel beim Schreiben von Listen notwendig ist:

	masculine gendered
	feminine gendered
	neuter gendered

	if the noun is feminine gendered, ...
	say "[the list of feminine gendered things]";


Den Plural testet man mit

	if the noun is plural-named, ...
	say "[a list of plural-named things]";


Möchte man aber das Genus/den Plural als Wert auf Deutsch benutzen, beispielsweise in einem Ausgabetext, bietet sich die Phrase "the gender of" an. Die Werte der Genera sind "Mehrzahl", "männlich", "weiblich", "sächlich". ("Mehrzahl" ist eigentlich kein Genus, aber der Einfachheit halber wird der Plural hier gleich mitgeliefert.)

	if the gender of the noun is Mehrzahl, ...
	if the gender of the noun is männlich, ...
	if the gender of the noun is weiblich, ...
	if the gender of the noun is sächlich, ...

Die Phrase "the gender of" kann auch in Say-Texten verwendet werden:

	say "Das Genus [des noun] ist [the gender of the noun]."

Um das geänderte Genus (Changing Gender) einen Zug lang zu befragen, gibt es die Phrase "the changing gender of":

	if the changing gender of the box is sächlich, ...

Auch diese Phrase kann in Say-Texten verwendet werden:

	say "Das geänderte Genus von [dem noun] ist [the changing gender of the noun]."


Section: Die traditionellen Genus-Attribute male, female und neuter

Die Verwendung der Attribute male, female und neuter ist im Mai 2012 umgestellt worden. Die Attribute werden bei Spielbeginn automatisch in den grammatical gender übersetzt und gelöscht. Das Verhalten der Attribute wird aber noch simuliert, um die Kompatibilität mit dem traditionellen Verfahren nicht aufzugeben. Wer mag, kann also weiterhin Definitionen mit den Adjektiven male, female und neuter verwenden:

	The apple is a male edible thing in the garden.
	The pear is a thing in the garden. It is female.
	The girl is neuter.

Auch das Ändern des Genus über die traditionellen Attribute male, female und neuter wird weiterhin unterstützt:

	now the vase is male;
	now the apple is female;
	now the lady is neuter;

Die traditionellen Attribute male, female und neuter können weiterhin zum Abfragen des Genus verwendet werden, auch wenn sie intern nicht mehr vergeben werden:

	if the noun is male, ...
	if the noun is female, ...
	if the noun is neuter, ...

	say "[a list of male fruit in the garden]";

Wenn die Attribute bei Spielbeginn nicht gelöscht werden sollen, kann die dafür zuständige Regel entfernt werden:

	*: The initially genderise everything rule is not listed in any rulebook.

Die Attribute bleiben bestehen, der grammatical gender wird parallel zu ihnen gesetzt, aber nicht für die Bestimmung des Genus herangezogen. Die Verwendung der Genus-Tags im printed name sollte ohne die "initially genderise everything rule" nicht verwendet werden.

Section: Angabe des Genus für Synonyme mit abweichendem Geschlecht (Changing Gender)

Für jedes per Understand-Anweisung definierte Objektsynonym kann das Genus des Wortes mitgeliefert werden. Formal entspricht dies der Genus-Kennzeichnung im printed name. Das grammatische Geschlecht einer Vokabel wird jedoch nur zum Setzen der entsprechenden Pronomen benutzt. Für die Textausgabe ist der Changing Gender (CG) irrelevant.

Häufig kommt es vor, dass Objekte Synonyme bekommen, die ein anderes Geschlecht als das Objekt (genauer: der printed name des Objekts) haben.

	The anorak is a wearable thing in the dressing room. The printed name of the anorak is "Anorak[-s][m]".
	The description is "Eine richtig dicke Winterjacke." Understand "Anorak", "Jacke" and "Winterjacke" as the Anorak.

Was passiert nun, wenn der Spieler den Anorak lieber "Jacke" nennt, und diese mit Pronomen ansprechen möchte?

	Du siehst hier einen Anorak.

	>U ANORAK
	Eine richtig dicke Winterjacke.

	>NIMM JACKE
	In Ordnung.

	>ZIEH SIE AN
	Mir ist nicht klar, worauf sich "sie" bezieht.

Oder noch unangenehmer:

	>ZIEH SIE AN
	(Dazu hebst du die Birne erst auf.)
	Du kannst die Birne nicht anziehen!


Um das zu vermeiden und die Pronomen korrekt zu setzen, kann man einzelnen Synonymen einen von vier Attribut-Satzbausteinen folgen lassen, die das abweichende Geschlecht der Vokabel kennzeichnen. Diese Satzbausteine (understand tokens) gleichen formal den Genus-Textersetzungen im printed name, sind aber nicht damit zu verwechseln (siehe Section 4.4: Angabe des grammatischen Geschlechts (Genus)).

Die Genus-Satzbausteine heißen:

	"[m]" (Maskulinum, männlich)
	"[f]" (Femininum, weiblich)
	"[n]" (Neutrum, sächlich)
	"[p]" (Plural, Mehrzahl)

Das Token wird nach der Vokabel, die gekennzeichnet werden soll, angegeben. Zwischen Vokabel und Kennzeichnung kann ein Leerzeichen stehen, muss es aber nicht:

	The anorak is a wearable thing in the dressing room. The printed name of the anorak is "Anorak[-s][m]". The description is "Eine richtig dicke Winterjacke. Ein Erbstück."

	Understand "Parka", "Jacke[f]", "Winterjacke [f]" and "Erbstueck[n]" as the Anorak.

Der "Parka" kann, muss aber nicht, mit "[m]" gekennzeichnet werden, da er dasselbe Genus wie der "Anorak" hat.

Nun sieht der Dialog so aus:

	>U ANORAK
	Eine richtig dicke Winterjacke. Ein Erbstück.

	>NIMM JACKE
	In Ordnung.

	>ZIEH SIE AN
	Du ziehst den Anorak an.

	>DURCHSUCHE ERBSTÜCK
	Du findest nichts Interessantes.

	>ZIEH ES AUS
	Du ziehst den Anorak aus.


Section: Sonderformen des unbestimmten Artikels: DEFINITE ARTICLE, YOURS, NO ARTICLE und PENDING

Bei der Ausgabe des Objektnamens mit unbestimmtem Artikel, z.B. per "[Ein <Objekt>]", "[ein <Objekt>]" oder in einer Liste, kann man eine Sonderform des unbestimmten Artikel (indefinite article), den special indefinite article, für ein Objekt angeben. Der special indefinite article ist im Gegensatz zum indefinite article kein Text, sondern einer der drei Werte DEFINITE ARTICLE, YOURS oder NO ARTICLE (können auch klein geschrieben werden). Der special indefinite article überschreibt einen möglicherweise schon vorhandenen indefinite article.

Man kann Objektnamen statt mit einem unbestimmten Artikel mit einem bestimmten Artikel anzeigen lassen:

	The special indefinite article of the mirth mobile is DEFINITE ARTICLE.

	"Du siehst hier das Spaßmobil."

Dinge, die der Spielerfigur gehören, können bei der Ausgabe mit unbestimmtem Artikel mit dem korrekt flektierten Possessivartikel "dein" angezeigt werden:

	The special indefinite article of the wallet is YOURS.

	"Du siehst hier deine Brieftasche."

Achtung: Der special indefinite article YOURS wird *nicht* für die Ausgabe mit bestimmtem Artikel verwendet. Soll der Name eines Objekts in jedem Fall mit "dein" ausgegeben werden, muss man in die Ausgabe des angezeigten Objektnamens eingreifen und ein flektierendes "dein" voranstellen:

	Maria is a woman.

	Before printing the name of Maria:
		if current case is:
			-- nominative case: say "[if capitalised Du option is active]D[else]d[end if]eine";
			-- genitive case: say "[if capitalised Du option is active]D[else]d[end if]einer";
			-- dative case: say "[if capitalised Du option is active]D[else]d[end if]einer";
			-- accusative case: say "[if capitalised Du option is active]D[else]d[end if]eine";
		say " Frau ".

Dinge können auch ohne Artikel angezeigt werden, so als hätte man sie als Eigennamen definiert. Der einzige Unterschied ist, dass das Objekt nicht das Attribut "proper-named" bekommt. Bei Dingen, die proper-named sind, werden nie Artikel verwendet, auch nicht bei der Ausgabe mit bestimmtem Artikel. Das kann man mit "no article" umgehen:

	The special indefinite article of the Milch is NO ARTICLE. The printed name is "frisch[^] Milch[f]."

	"Du siehst hier frische Milch."

	Say "Du siehst hier [den Milch] von Bauer Henke."

	"Du siehst hier die frische Milch von Bauer Henke."

Jedes Objekt der Klasse "thing" und deren Unterklassen besitzt standardmäßig einen special indefinite article mit dem Wert PENDING. Dieser bleibt wirkungslos, bis dem special indefinite article einer der Werte DEFINITE ARTICLE, YOURS oder NO ARTICLE zugewiesen wird. Ein special indefinite article kann im weiteren Spielverlauf wieder unwirksam gemacht werden, indem man ihm den Wert PENDING zuweist.

	The book is a thing. The printed name of the book is "Buch[-es][n]".

	After examining the book for the first time:
		now the special indefinite article of the book is YOURS;
		say "Erst jetzt erkennst du, dass dies dein Tagebuch ist."

	After giving the book to Peter:
		now the special indefinite article of the book is PENDING;
		say "Du schenkst Peter dein Buch."

Section: Assemblies: Automatisch erzeugte Teile von Personen

Möchte man zum Beipiel Körperteile, sagen wir Nasen, für alle Personen erzeugen, geht das ganz einfach mit

	A Nase is a kind of thing. The plural of Nase is Nasen.
	A Nase is part of every person.

Der Inform-Compiler erzeugt nun automatisch eine Nase für jede Person im Spiel, wobei die Bezeichner, die angezeigten Objektnamen und das zum Objekt gehörige Vokabular ebenfalls angelegt werden -- nur leider auf Englisch. In GerX ist ein Workaround enthalten, der zumindest den angezeigten Objektnamen auf Deutsch ausgibt ("deine Nase", "Nase des Polizisten", "Bennos Nase" usw.). Um das englische Vokabular zu unterbinden, müssen die erzeugten Teile privately-named sein und der printed name muss nachgereicht werden:

	A Nase is privately-named.
	The printed name of a Nase is "Nase[f]".

Nun fehlt noch das deutsche Vokabular, um die Nasen entsprechend ihrer Besitzer ansprechen zu können:

	Understand "Nase[f]" and "Zinken [m]" as "[Nase]".

	Understand "[Nase] von/des/der [something related by reversed incorporation]" as a Nase.
	Understand "[Nase] [something related by reversed incorporation]" as a Nase.
	Understand "[something related by reversed incorporation] [Nase]" as a Nase.
	Understand "dein/mein/unser/euer [Nase]" or "[Nase] von dir/mir/uns/euch" as your Nase.

Nun werden "deine Nase", "Bennos Nase", "Nase des Polizisten" und so weiter als die entsprechenden Nasen erkannt.

Der Workaround hängt an Eigennamen standardmäßig ein 's' an, würde also bei Namen, die auf S auslauten (Klaus, Max, Moritz) "Klauss Gesicht", "Moritzs Nase" und "Maxs Kopf" schreiben, was keine korrekten Genitive sind. Für Personen, die einen Namen haben, der auf ein gesprochenes S endet, muss folgende Eigenschaft angegeben werden:

	Klaus is s-terminated.

Danach wird korrekt "Klaus' Gesicht", "Moritz' Nase" und "Max' Kopf" geschrieben. Falls sich der Name im Laufe des Spiels ändern und nicht mehr auf S enden sollte, kann man die Eigenschaft ganz einfach wieder wegnehmen.

Leider wird der Genitiv mit Apostroph nicht automatisch verstanden. Es empfiehlt sich also, den Namen mit Apostroph als zusätzliche Vokabel für den entsprechenden Besitzer des Körperteils anzugeben. Es ist nicht ratsam, den Namen mit Apostroph als Synonym für das Körperteil zu definieren, da es bei der Existenz mehrerer Körperteile zu Ambiguitäten kommen kann, d.h. der Parser weiß eventuell nicht, ob mit der Spielereingabe "max'" die Nase, ein Auge oder sonst ein definiertes Körperteil gemeint ist.

	Understand "Max'" as Max. Understand "Moritz'" as Moritz. Understand "Klaus'" as Klaus.


Chapter: Ausdrücke zur flexiblen Textausgabe

Section: Neue Textersetzungen müssen her

In einem Ausgabetext lässt sich auf Dinge und Werte Bezug nehmen, indem man eine Textersetzung in eckigen Klammern benutzt. Für die Ausgabe von Objektnamen mit bestimmtem bzw. unbestimmtem Artikel gibt es im englischen Original "[The noun]", "[the noun]", "[A noun]" oder "[a noun]". Diese enthalten aber keine Information über den benötigten Fall und stehen immer im Nominativ; dies gilt auch für die Textersetzungen, die in der Erweiterung Plurality von Emily Short definiert werden. Deshalb können wir sie für deutsche Ausgabetexte nicht flexibel einsetzen und müssen neue, fallspezifische Ausdrücke verwenden. Die neuen Textersetzungen, die auch die Benutzung der Erweiterung Plurality überflüssig machen, tragen jeweils den Namen des entsprechend flektierten männlichen Artikels (der, des, dem, den / ein, eines, einem, einen), weil dieser als Einziger den Kasus eindeutig repräsentiert.

Section: Objektnamen

Für die meisten Textersetzungen gibt es eine Variante mit großem Anfangsbuchstaben für Satzanfänge und eine mit kleinem Anfangsbuchstaben.

Objektnamen mit bestimmten Artikeln:

	"[Der <Objekt>] [Des <Objekt>] [Dem <Objekt>] [Den <Objekt>]"
	"[der <Objekt>] [des <Objekt>] [dem <Objekt>] [den <Objekt>]"

Objektnamen mit unbestimmten Artikeln:

	"[Ein <Objekt>] [Eines <Objekt>] [Einem <Objekt>] [Einen <Objekt>]"
	"[ein <Objekt>] [eines <Objekt>] [einem <Objekt>] [einen <Objekt>]"

Objektnamen mit Negativartikel:

	"[Kein <Objekt>] [Keines <Objekt>] [Keinem <Objekt>] [Keinen <Objekt>]"
	"[kein <Objekt>] [keines <Objekt>] [keinem <Objekt>] [keinen <Objekt>]"

Objektnamen ohne Artikel:

Im englischen Original reicht es, wenn man in Say-Texten Objektnamen ohne Artikel mit dem Objektnamen in eckigen Klammern ausgibt.

	The printed name of the Tisch is "klein[^] Tisch[-es]".

	say "[Tisch]";
	"kleiner Tisch"

Der so ausgegebene Objektname steht jedoch immer im Nominativ; um den jeweils benötigten Fall angeben zu können, gibt es folgende Möglichkeiten (mit deutschen und gleichbedeutenden englischen Phrasen):

	"[<Object> with <case>]" (cases: nominative case, genitive case, dative case, accusative case)
	"kleiner Tisch / kleinen Tisches / kleinem Tisch / kleinen Tisch"

	"[<Object> definite with <case>]" (Ausgabe wie mit bestimmtem Artikel, nur ohne den Artikel)
	"kleine Tisch / kleinen Tisches / kleinen Tisch / kleinen Tisch"

	"[<Object> indefinite with <case>]" (Ausgabe wie mit unbestimmtem Artikel, nur ohne den Artikel)
	"kleiner Tisch / kleinen Tisches / kleinen Tisch / kleinen Tisch."


Section: Pronomen, Hilfsverben und Verb-Endungen

Die Ausdrücke passen sich an Numerus und Genus des zuletzt genannten Objekts oder eines angegebenen Objekts an. Mit "zuletzt genanntem Objekt" ist das Objekt gemeint, das als letztes mit einer Textersetzung explizit angegeben wurde. Das zuletzt genannte Objekt heißt in GerX "previously named noun" (nicht zu verwechseln mit dem "prior named noun", welches in manchen englischen Erweiterungen verwendet wird) und kann vom Autor in eigenen Name-Printing-Rules als Variable des Typs "Object" befragt oder neu gesetzt werden.

Pronomen:

Auf das zuletzt genannte Objekt bezogen:

	"[Er] [Seiner] [Ihm] [Ihn]"
	"[er] [seiner] [ihm] [ihn]"


Mit angegebenem Objekt, falls es vom zuletzt genannten Objekt abweicht:

	"[Er <Objekt>] [Seiner <Objekt>] [Ihm <Objekt>] [Ihn <Objekt>]"
	"[er <Objekt>] [seiner <Objekt>] [ihm <Objekt>] [ihn <Objekt>]"

Hilfsverben:

Auf das zuletzt genannte Objekt bezogen:

	"[ist] [hat] [wird]"


Mit angegebenem Objekt, falls es vom zuletzt genannten Objekt abweicht:

	"[ist <Objekt>] [hat <Objekt>] [wird <Objekt>]"

Endungen für Verben:

Auf das zuletzt genannte Objekt bezogen:

	"[t] [et] [e]"


Mit angegebenem Objekt, falls es vom zuletzt genannten Objekt abweicht:

	"[t <Objekt>] [et <Objekt>] [e <Objekt>]"


Section: Relativpronomen

Zur Ausgabe von Relativpronomen, die sich an Genus und Numerus eines Objekts anpassen, stehen folgende Ausdrücke zur Verfügung:

	Auf das zuletzt genannte Objekt bezogen:

	"[*der*]"
	"[*dessen-deren*]"
	"[*dessen-derer*]" (für Präpositionen, die einen Genitiv verlangen)
	"[*dem*]"
	"[*den*]"

	"[*welcher*]"
	"[*welchem*]"
	"[*welchen*]"

	Mit angegebenem Objekt, falls es vom zuletzt genannten Objekt abweicht:

	"[*der* <Objekt>]"
	"[*dessen-deren* <Objekt>]"
	"[*dessen-derer* <Objekt>]" (für Präpositionen, die einen Genitiv verlangen)
	"[*dem* <Objekt>]"
	"[*den* <Objekt>]"

	"[*welcher* <Objekt>]"
	"[*welchem* <Objekt>]"
	"[*welchen* <Objekt>]"


Section: Wählbare Darstellung von "du"

Die Option

	Use capitalised Du.

veranlasst, dass alle Formen von "du" in den Standard-Texten groß geschrieben werden.

Will sich der Autor in seinen eigenen Say-Texten noch nicht sofort festlegen, ob er "du" groß oder klein schreiben soll, kann er die folgenden Ausdrücke benutzen:

	"[du]" "[dir]" "[dich]"
	"[dein]" "[deine]" "[deiner]" "[deines]" "[deinem]" "[deinen]"

	Say "Warum willst [du] denn unbedingt [deinen] Lesern alles verraten?"

Mit den Anweisungen

	Set Du to lower-case.
	Set Du to upper-case.

kann der Autor während des Spiels zwischen großem und kleinen Du wechseln.

Diese Textersetzungen werden wohl, wenn überhaupt, nur in Ausnahmefällen benutzt werden. Autoren von Extensions, die auf die deutsche Extension aufbauen, sollten ihre Standard-Antworten allerdings mit dem flexiblen "[du]" schreiben.


Section: Die universelle Endung für alle flektierten Adjektive

Zur korrekt flektierten Ausgabe von Endungen in angezeigten Objektnamen stehen Suffixe für Adjektive und Hauptworte zur Verfügung. Ob man alle Endungen für ein Ding korrekt angegeben hat, kann mit dem Debug-Befehl DEKLINIERE <DING> überprüft werden. Dieser Befehl steht nur während der Entwicklung zur Verfügung und wird beim Release entfernt.

Die universelle Adjektiv-Endung

	"[^]"

wird an den Stamm eines jeden flektierten Adjektivs, das Bestandteil des angezeigten Objektnamens ist, gehängt. Damit wird für jeden Fall die richtige Endung ausgegeben.

	The Tomate is an edible thing. The printed name is "grün[^] Tomate[f]". Understand "gruen" as the Tomate.

Die Adjektiv-Endung kann auch im indefinite article genutzt werden:

	The Murmeln are a thing in the playground. The printed name is "magisch[^] Murmeln[p]". Understand "magisch" as the Murmeln.

	The indefinite article is "einig[^]".
	"Du siehst hier einige magische Murmeln."

Section: Endungen für Substantive

	"[-n]" für Plural-Substantive, die auf "e" enden. Im Dativ wird ein "n" angehängt.

	The printed name of the Zwerge is "Zwerge[-n]".
	"Die Zwerge, der Zwerge, den Zwergen, die Zwerge."

Die Endung kann auch für männliche Substantive, die auf "e" enden (der Affe, der Bote, der Bube, der Drache, der Hase, der Junge, der Knabe, der Kollege, der Kunde, der Löwe, der Neffe, der Russe usw.; Ausnahme: der Käse) benutzt werden.

	The printed name of the Affe is "Affe[-n]".
	"Der Affe, des Affen, dem Affen, den Affen."


	"[-en]" für männliche Substantive.

	The printed name of the Student is "Student[-en]".
	"Der Student, des Studenten, dem Studenten, den Studenten."


	"[-s]" für Substantive im Genitiv.

	The printed name of the Becken is "Becken[-s]".
	"Das Becken, des Beckens, dem Becken, das Becken."


	"[-es]" für Substantive im Genitiv.

	The printed name of the Haus is "Haus[-es]".
	"Das Haus, des Hauses, das Haus, dem Haus."

Section: Bestimmte Artikel

Möchte der Autor Namen wie "Karl der Große" verwenden, muss er besondere Ausdrücke für die bestimmten Artikel, nämlich "[der]", "[die]", oder "[das]", verwenden, damit der Artikel in Ausgabetexten flektiert wird. Für Plural-Artikel gibt es den Ausdruck "[die plural]", aber Plural-Namen mit Artikel kommen wohl eher selten vor.

	The printed name of Ivan is "Ivan[-s][m] [der] Schreckliche[-n]".
	The printed name of Gertrud is "Gertrud[-es][f] [die] Große[-n] von Helfta".
	The printed name of Hui Buh is "Hui Buh[-s] [das] Schlossgespenst[-s][n]".

Denkbar wäre auch der (eher unwahrscheinliche) Fall, dass man das Genus und den Numerus für den Artikel von einem bestimmten Objekt beziehen möchte. Dazu benutzt man dann folgende Form:

	The printed name of Gerd is "Graf[-en] Gerd [-der- Gerd][m] Mutige[-n]."

Jetzt wird das Genus von Gerd (Maskulinum) und der Numerus (Singular) für den Artikel herangezogen. Das ist in diesem Fall gleichbedeutend mit "[der]" (und eigentlich sinnlos). "[-der- Objekt]", "[-die- Objekt]" und "[-das- Objekt]" sind synonym zu verwenden. (Das wird normalerweise keiner benutzen, aber wenn man doch mal auf ein Objekt verweisen will, kann man das damit tun.)


Section: Manuelles Setzen der Suffixe

In manchen Situationen kann es notwendig sein, dass der Autor die Suffixe für ein Objekt manuell setzen muss, zum Beispiel bei Manipulationen der Ausgabe des Objektnamens vor, während oder nach der "printing the name of something activity" (Writing with Inform, Kap. 17.10).

	set <article mode> suffixes from <object> with <case>;

Setzt die Suffixe für ein Objekt in einem angegebenen Fall (case). Der article mode ist entweder bare-mode (für die Ausgabe ohne Artikel), definite-mode (mit bestimmtem Artikel) oder indefinite-mode (mit unbestimmtem Artikel).

Um den aktuellen Modus der Artikel zu bestimmen, gibt es folgenden Ausdruck:

	current article mode

Den aktuellen Artikelmodus verändert man mit

	set current article mode to <article mode>;


Section: Beispiele für die Verwendung von Textersetzungen und mögliche Ausgabetexte

In den folgenden Beispielen werden einige der Textersetzungen benutzt. Als Beispielobjekt dienen bunte Murmeln.

	The Murmeln are a plural-named thing. The printed name of the Murmeln is "bunt[^] Murmeln". Understand "bunt" as the Murmeln.

	Say "Hier [ist noun] nur [ein noun], [*der*] dich nicht so richtig überzeug[t]."
	Hier sind nur bunte Murmeln, die dich nicht so richtig überzeugen.


	Say "[Der noun], mithilfe [*dessen-derer*] du den Täter überführen könntest, [ist] verschwunden."
	Die bunten Murmeln, mithilfe derer du den Täter überführen könntest, sind verschwunden.


	Say "Du erinnerst dich an [den noun], [*dessen-deren*] Verbleib ungeklärt ist."
	Du erinnerst dich an die bunten Murmeln, deren Verbleib ungeklärt ist.


	Say "Wo [ist noun] nur [der noun], mit [*dem*] du den Staatsanwalt beeindrucken wolltest?"
	Wo sind nur die bunten Murmeln, mit denen du den Staatsanwalt beeindrucken wolltest?


	Say "'Haben Sie [den noun], [*den*] ich eben aufheben wollte, irgendwo gesehen?'"
	"Haben Sie die bunten Murmeln, die ich eben aufheben wollte, irgendwo gesehen?"


	Say "'Herr Staatsanwalt, [der noun], [*welcher*] vom Tatort entfernt wurd[e], bleib[t] unauffindbar.'"
	"Herr Staatsanwalt, die bunten Murmeln, welche vom Tatort entfernt wurden, bleiben unauffindbar."


	Say "Es ist sehr ärgerlich, dass [der noun] weg [ist], mit [*welchem*] du deine Kompetenz unter Beweis stellen wolltest."
	Es ist sehr ärgerlich, dass die bunten Murmeln weg sind, mit welchen du deine Kompetenz unter Beweis stellen wolltest.


	Say "Vielleicht kannst du [den noun], [*welchen*] du dringend brauchst, irgendwo wiederfinden."
	Vielleicht kannst du die bunten Murmeln, welche du dringend brauchst, irgendwo wiederfinden.

Section: Überprüfen der deklinierten angezeigten Objektnamen

Ob man alle Endungen und Artikel für das Objekt korrekt angegeben hat, kann mit dem Debug-Befehl DEKLINIERE <DING> überprüft werden. Dieser Befehl steht nur während der Entwicklung zur Verfügung und wird beim Release entfernt.

	Werther is an improper-named man in Wahlheim. The printed name is "jung[^] Werther[-s][m]". Understand "Werther" and "jung Werther" as Werther.

	The pistol is a thing carried by Werther. The printed name is "Pistole[f]".

	>DEKLINIERE WERTHER
	Der junge Werther, des jungen Werthers, dem jungen Werther, den jungen Werther.
	Ein junger Werther, eines jungen Werthers, einem jungen Werther, einen jungen Werther.

	>DEKLINIER PISTOLE
	Die Pistole, der Pistole, der Pistole, die Pistole.
	Eine Pistole, einer Pistole, einer Pistole, eine Pistole.

In der ersten Zeile wird der Objektname mit den bestimmten Artikeln dekliniert, in der zweiten mit den unbestimmten Artikeln.

Und wir sehen, dass der junge Werther noch "ein junger Werther" sein kann. Doch Werther soll immer "der junge Werther" heißen. Also:

	The article of Werther is definite article.

	>DEKLINIERE WERTHER
	Der junge Werther, des jungen Werthers, dem jungen Werther, den jungen Werther.
	Der junge Werther, des jungen Werthers, dem jungen Werther, den jungen Werther.

Jetzt ist alles richtig.


Section: Überprüfen der Vokabel- und Genusdefinitionen (Libcheck)

Im Debug-Modus (Not for release), also während der Entwicklung, werden bei Spielbeginn die Vokabel- und Genusdefinitionen von der Libcheck-Funktion automatisch auf Unstimmigkeiten geprüft. Objekte sollten nur einen einzigen Genus haben. Vokabeln sollten keine Umlaute und 'ß' enthalten, Verben möglichst ohne Endungen angegeben werden. Libcheck gibt bei Problemen einen Bericht mit Hinweisen zur Korrektur aus. Wenn alles in Ordnung ist, meldet sich Libcheck bei Spielbeginn überhaupt nicht zu Wort.

Die Überprüfung kann jederzeit mit dem Kommando LIBCHECK wiederholt werden. Möchte man den Test zu Spielbeginn niemals ausführen lassen, muss folgende Use-Option aktiviert werden:

	*: Use skip libcheck.

Während der Laufzeit kann der Test dann aber weiterhin mit dem Kommando LIBCHECK ausgeführt werden.


Section: Debug-Meldungen

Bei der Entwicklung von längeren Spielen kann es hilfreich sein, Debug-Meldungen in den Quelltext einzufügen, die dem Tester zeigen, an welcher Stelle des Quelltextes sich die Ausführung des Programms gerade befindet. Diese Meldungen werden nur angezeigt, wenn sich das Spiel im Debug-Modus befindet (zu erkennen am Kürzel "D" im Banner des Spiels) und zusätzlich noch die Option "Use debug messages." aktiviert wurde.

Die Debug-Meldungen werden mit "[debug]" eröffnet und mit "[end debug]" abgeschlossen. Die Idee zu diesem Verfahren stammt von Erik Temple.

Beispiel:

	Instead of drinking the Milch when it is sour:
		say "[debug]### Hier wird das Trinken der Milch abgefangen! ###[end debug]";
		say "Die Milch ist sauer, die kannst du nicht trinken.".

Chapter: Listen in einem bestimmten Kasus ausgeben

Section: Wie wird der Kasus angegeben?

Für das Schreiben von Listen gibt es in GerX erweiterte Phrasen, die die englischen Original-Phrasen ersetzen sollen. Letztere können weiterhin benutzt werden, sie geben jedoch alle Listen im Nominativ aus.

Listen mit Kasus werden analog zum englischen Inform ausgegeben, nur dass nach dem Objekt bzw. der Beschreibung der aufzulistenden Objekte auch noch der Fall angegeben wird. Dazu dient die Teilphrase "with <case>"; die cases sind nominative, genitive, dative, oder accusative.

Section: Den Inhalt eines Objekts auflisten

Als Anweisung:

	list the contents of <object> with <case>, <phrase options>;

Mögliche Phrasen-Optionen (phrase options), die kombiniert werden können:

	with newlines,
	indented,
	giving inventory information,
	as a sentence,
	including contents,
	including all contents,
	tersely,
	giving brief inventory information,
	using the definite article,
	listing marked items only,
	prefacing with is/are,
	not listing concealed items,
	suppressing all articles
	and/or with extra indentation

Als Say-Phrase:

	"[contents of <object> with <case>]" (unbestimmt)
	"[the contents of <object> with <case>]" (bestimmt)


Section: Unverschachtelte Inhaltslisten anhängen (Non-nested lists)

Bei Verwendung der Use-Option "non-nested lists" wird der Inhalt von Dingen in gesonderten Listen nach der Hauptinhaltsliste ausgeführt, wenn die Inhaltsliste mit der Listenoption "as a sentence" ausgegeben wird. Möchte man als Autor nun selbst unverschachtelte Inhaltslisten verwenden, fügt man nach dem Schreiben der Inhaltsliste eine der folgenden Phrasen hinzu:

	write the/-- sublists;

Schreibt die Sub-Listen direkt nach der Inhaltsliste. Dies ist die Standard-Variante.

	write the/-- sublists with line break;

Fügt vor die Sub-Listen einen Zeilenumbruch ein.

	write the/-- sublists with paragraph break;

Fügt vor die Sub-Listen einen Absatz ein.

	write the/-- sublists with space;

Fügt vor die Sub-Listen ein Leerzeichen ein.

	write the/-- inventory sublists;

Für die unverschachtelte Ausgabe des Inventars als Satz.

Ist die Option "non-nested lists" nicht aktiv, haben die aufgeführten Phrasen keinen Effekt.


Section: Einfache Listen

Mit unbestimmtem Artikel:

	"[a list of <description> with <case>]"
	"[A list of <description> with <case>]" (Großbuchstabe am Listenanfang)

Ohne Artikel:

	"[list of <description> with <case>]"

Mit bestimmten Artikel:

	"[the list of <description> with <case>]"
	"[The list of <description> with <case>]" (Großbuchstabe am Listenanfang)

Listen mit vorangestelltem "ist"/"sind":

	"[is-are a list of <description> with <case>]" (unbestimmt)
	"[is-are list of <description> with <case>]" (ohne Artikel)
	"[is-are the list of <description> with <case>]" (bestimmt)

Die Listen mit vorangestelltem "ist"/"sind" können nur sinnvoll im Nominativ ausgegeben werden. Deshalb wird unabhängig vom angegebenen Fall der Nominativ zum Ausgeben der Liste herangezogen, womit sich die Phrasen genauso verhalten wie die Original-Phrasen ohne Kasus. Der Vollständigkeit halber werden die Phrasen mit Kasus aber trotzdem mit angeboten.

Section: Listen mit Objektinhalt

	"[a list of <description> with <case> including contents]"

Diese Phrase ignoriert eine aktivierte "Use non-nested lists"-Option und gibt die Liste immer verschachtelt aus. Die Inhaltslisten stehen im Nominativ, unabhängig vom Fall der Hauptliste.


Chapter: Neue Use-Optionen (Use options)

Section: Tiefere Einrückung und Aufzählungszeichen beim Inventar

	*: Use inventory indent.

Bewirkt eine tiefere Einrückung der einzelnen Ebenen (außer der ersten) bei der Anzeige des Inventars als Liste. Dies dient, besonders zusammen mit einer der folgenden zwei Optionen, der besseren Übersichtlichkeit des Inventars.

	*: Use inventory hyphen bullet.

Gibt vor jedem Eintrag im Inventar (als Liste) einen Spiegelstrich aus.

	*: Use inventory asterisk bullet.

Gibt vor jedem Eintrag im Inventar (als Liste) ein Sternchen aus.

Section: Listen nicht verschachtelt ausgeben

	*: Use non-nested lists.

Schreibt Listen nicht verschachtelt, sondern nacheinander. Anstelle der manchmal etwas unübersichtlichen Standard-Form

	Du siehst hier einen Holztisch (darauf sind ein Beutel (darin sind drei Bälle, eine Geldbörse (darin ist ein Knopf) und ein Bleistift) und ein Zettel), ...

wird die Liste so ausgegeben:

	Auf dem Holztisch sind ein Beutel und ein Zettel. In dem Beutel sind drei Bälle, eine Geldbörse und ein Bleistift. In der Geldbörse ist ein Knopf.

	*: Use list buffer size of at least <N>.

Klingt wie ein Minimum, meint jedoch einen Maximalwert. Damit kann man die Dimension der Listen-Puffer vergrößern, die für die Ausgabe der nicht verschachtelten Listen benutzt werden. Für <N> muss eine Zahl größer als der Default-Wert von 20 eingetragen werden, damit die Option Wirkung zeigt.

Section: "ist"/"sind" in Inhaltslisten unterdrücken

Mit dieser Option wird die Ausgabe des Hilfsverbs "ist/sind" in einer Inhaltsliste unterdückt. Anstatt standardmäßig (seit 21.06.2014)

	Du siehst hier einen Tisch (darauf sind ein Apfel und eine Birne).

heißt es dann (wie all die Jahre zuvor):

	Du siehst hier einen Tisch (darauf einen Apfel und eine Birne).


Section: Meldung zu vervollständigten Satzmustern unterdrücken

	*: Use silent inference.

Wenn der Parser ein Satzmuster vervollständigt, wird normalerweise eine entsprechende Meldung in Klammern ausgegeben.

	>ZÜNDE
	(das Seil an)
	Das ist gefährlich und wenig sinnvoll.

Stören diese Meldungen den Lesefluss zu sehr, können sie mit dieser Option komplett unterdrückt werden. Allerdings sollten dann die Antworten nicht zu allgemein gehalten sein, da der Spieler nicht mehr erfährt, worauf sich der Parser bezieht:

	>ZÜNDE
	Das ist gefährlich und wenig sinnvoll.

Diese Antwort kann irreführend sein. Deshalb sollte das angesprochene Objekt in der Antwort erwähnt werden, zum Beispiel:

	>ZÜNDE
	Das Seil ist zu nass, um es anzuzünden.


Section: Pronomen nur für sichtbare Objekte setzen

	*: Use in-scope pronoun notice.

Ist diese Option aktiviert, werden Pronomen nur mit Objekten verknüpft, die in Sicht ("in scope") sind. Dies kann nützlich sein, wenn bestimmte Aktionen Objekte benutzen, die sich nicht im Spiel befinden.

Ohne die aktivierte Option könnte Folgendes passieren:

	>DENKE AN JILL
	Du denkst an Jill, die nicht anwesend ist.

	>KÜSSE SIE
	Du siehst "sie" (Jill) hier im Moment nicht.

Mit aktivierter "in-scope pronoun notice"-Option sieht es so aus:

	>DENKE AN JILL
	Du denkst an Jill, die immer noch nicht anwesend ist.

	>KÜSSE SIE
	Du küsst Juliette, die schon die ganze Zeit neben dir steht.

Section: Pronomen für angesprochene Räume setzen

	*: Use room-related pronoun notice.

Standardmäßig werden Pronomen für Räume nicht gesetzt. Diese Option setzt die Pronomen auch für Räume, wenn man einen Raum im Kommando angesprochen hat. Nur mit Vorsicht zu genießen, weil die meisten Aktionen nicht für Räume gemacht sind. Zudem platziert unsere "location visibility rule" den aktuellen Raum nur bei bestimmten Aktionen (derzeit location-leaving, looking und smelling) in den sichtbaren Bereich (in scope).

Section: Manuelles Setzen der Pronomen

	*: Use manual pronouns.

Wird diese Option gewählt, werden die Pronomen nur auf Objekte gesetzt, die der Spieler direkt anspricht. Standardmäßig verweisen die Pronomen zunächst automatisch auf die in der Raumbeschreibung erwähnten Objekte.

Section: Eigene Debug-Meldungen anzeigen

	*: Use debug messages.

Aktiviert die Anzeige der Debug-Meldungen. Diese werden in Say-Texten mit "[debug] ... <Text> ... [end debug]" gekennzeichnet.

Section: "Du" in den Standard-Texten immer groß ausgeben

Sollte der Autor darauf bestehen, dass alle Formen von "du" in den Standard-Meldungen groß geschrieben werden sollen ("Du", wie in Briefen), ist das mit der folgenden Option möglich.

	*: Use capitalized Du.

Die Textersetzungen "[du]", "[dein]", "[deinem]", "[deinen]", "[deiner]", "[dir]" und "[dich]", die der Autor für seine eigenen Say-Texte benutzen kann, sagen dann ebenfalls ein großes "Du".

Mit den Anweisungen

	Set Du to lower-case.
	Set Du to upper-case.

kann der Autor während des Spiels zwischen großem und kleinen Du wechseln.

Section: Das Abtrennen der Wortköpfe und -Schwänze aktivieren

	*: Use compound heads.

Benutzt die in der Tabelle "Table of compound heads (continued)" angegebenen Wortköpfe (s. nächstes Kapitel).

	*: Use compound tails.

Benutzt die in der Tabelle Table of compound tails (continued) angegebenen Wortschwänze (s. nächstes Kapitel).

Section: Puffer für printed name vergrößern

Diese Option ist als Notlösung für das Setzen des Genus im printed name gedacht, falls Objektnamen von mehr als 160 Zeichen Länge verwendet werden sollen. Die Maximale Länge kann bis auf 250 erhöht werden:

	*: Use maximum printed name length of at least <N>.

<N> darf nicht größer als 250 und sollte nicht kleiner als 160 sein.

Chapter: Neue Standard-Aktionen, -Aktivitäten und -Kommandos

Section: Die Informisierung der Spielereingabe

Der GerX-Parser versteht kein natürliches Deutsch, auch wenn es für den Spieler oft so aussieht. In Wirklichkeit spricht der Parser eine simplifizierte Sprache, die "Informesisch" (engl. "Informese") genannt wird. In Informesisch gibt es keine Umlaute, kein Eszett und keine Endungen. Auch Verschmelzungen von Präposition und bestimmtem Artikel, wie z.B. "im" oder "am", existieren in Informesisch nicht. Im englischen Original-Inform wird ebenfalls Informesisch gesprochen, doch aufgrund der formalen Ähnlichkeit zwischen Englisch und Informesisch fällt dieser Umstand nur sehr selten ins Gewicht.

Damit der Parser die Spielereingabe analysieren kann, muss sie zuvor ins Informesische übersetzt werden. Als Dolmetscher tritt dazu die Inform-6-Routine LanguageToInformese (LTI) in Aktion, die in GerX durch eine Aktivität (activity) mit dem Namen

	translating a command into Informese

repräsentiert wird. In LTI werden die Umlaute ä, ö und ü sowie ß durch ihre Umschreibungen ae, oe, ue und ss ersetzt; die Flexionsendungen werden so weit abgeschnitten, bis eine Wortform vorliegt, die im Wörterbuch des Spiels existiert; zudem werden bestimmte Wortformen wie Kontraktionen von Präposition und Artikel aufgelöst, z.B. wird "im" zu "in dem". Bestimmte Zwei-Wort-Kombinationen (Zwillinge) werden ebenfalls ersetzt; standardmäßig sind das zurzeit "nur nicht" und "bis auf", die zu "ausser" werden.

Die informisierte Eingabe kann man sich mit der Trace-Funktion ab Trace-Level 2 ausgeben lassen. Für jedes Token  (Satzelement) wird die Zeichenkette der Spielereingabe in Anführungszeichen und die entsprechende Vokabel (? = unbekannte Vokabel) angezeigt, genau so, wie der Parser sie zu sehen bekommt:

	>TRACE 2
	Parser tracing set to level 2.

	>BETRACHTE DAS LOCH IM KLEINEN SCHWEIZER KÄSE
	"betracht" betracht / "das" das / "loch" loch / "in" in / "dem" dem / "klein" klein / "schweizer" ? / "kaese" kaese
	...

Der gesamte Vorgang der Umwandlung wird auch "Informisierung" genannt. Die Informisierung ist der Grund dafür, warum alle Vokabeln in Understand-Definitionen auf Informesisch angegeben werden müssen (siehe Kap. 3.1 Was sind Vokabeln?).


Section: Sicheres Manipulieren der Spielereingabe nach der Informisierung

Inform lässt Manipulationen der Spielereingabe mittels "after reading a command" zu. Diese Methode hat den großen Nachteil, dass direkt nach der Activity "reading a command" die Spielereingabe noch nicht "informisiert" wurde und deshalb immer alle möglichen Formen mit Endungen und Umlauten berücksichtigt werden müssen. Das ist extrem fehleranfällig und der Libcheck gibt obendrein grundlos Warnungen aus.

Sicherer ist es hingegen, die Spielereingabe nach der GerX-Activity "translating a command into Informese" abzufragen und zu verändern.

	*: After translating a command into Informese:

Beispiel:

	After translating a command into Informese:
		if the player's command includes "gruenlich", replace the matched text with "gruen".

Wie üblich bei der Definition von Vokabeln, gilt es auch hier, keine Umlaute und keine Endungen zu verwenden.

Das Standardverhalten der Activity "translating a command into Informese" LTI kann zusätzlich, wie bei jeder anderen Activity auch, mittels Before-Regel ergänzt und/oder mit einer For-Regel komplett ausgehebelt werden. (Das ist wohl mehr etwas was für experimentierfreudige Parser-Bastler und für normale Anwendungen nicht zu empfehlen.)

Section: Den aktuellen Raum verlassen (location-leaving)

Viele Spieler versuchen intuitiv, den aktuellen Standort (location) mit >VERLASSE RAUM oder ähnlichen Anweisungen zu verlassen, was naheliegend ist. Trotzdem ist dies kein Standardverhalten des Inform-Weltmodells. In GerX ist das Verlassen eines Raums auf diese Weise möglich. Die neue Aktion, die dieses Verhalten bewirkt, heißt "location-leaving".

	>VERLASS
	>VERLASS (DEN/DIE/DIESEN) <RAUM>
	>GEH WEG/FORT
	>GEH WEG/FORT VON HIER/DA/DORT
	>GEH WEG/FORT VON <RAUM>

Wenn der aktuelle Raum nur einen einzigen offensichtlichen Ausgang hat, wird ein Gehen in die entsprechende Richtung versucht. Gibt es mehrere Richtungen, in die man gehen kann, fragt das Spiel nach und bittet um genauere Richtungsangaben.

Für jeden Raum sind die Synonyme "Ort [m]", "Platz [m]", "Raum [m]", "Standort [m]" und "Umgebung [f]" vordefiniert; sie werden durch das Understand-Token "[basic-room-synonyms]" repräsentiert. Das Basisvokabular für Räume kann folgendermaßen erweitert werden:

	Understand "Umwelt [f]" as "[basic-room-synonyms]".

Bei der Definition von allgemeinem Raumvokabular empfiehlt es sich, das Genus des Synonyms als Changing-Gender-Attribut ("[f]") mit anzugeben, weil Räume unterschiedliche Genera bekommen können.

Der aktuelle Raum kann auch mit weiteren Synonymen angesprochen werden, wenn zusätzliches Vokabular für den einzelnen Raum definiert wird:

	The Lab is a neuter room. The printed name is "Labor". Understand "Labor" and "Laboratorium" as the Lab.

Nun kann man das Labor auch per

	>VERLASS LABOR/LABORATORIUM

verlassen.


Section: Den aktuellen Raum betrachten

Die Raumbeschreibung des aktuellen Standortes (location) kann man sich normalerweise mit den Befehlen SCHAU, SCHAU DICH UM, SCHAU HERUM/UMHER, LAGE und der Abkürzung L erneut anzeigen lassen. Intuitiv versuchen Spieler aber auch, den aktuellen Raum mit Kommandos wie BETRACHTE RAUM zu erkunden. In GerX ist das möglich.

Der Raum kann wie jedes andere sichtbare Objekt untersucht werden, wobei die Vokabeln "Ort [m]", "Platz [m]", "Raum [m]", "Standort [m]" und "Umgebung [f]" als Understand-Token "[basic-room-synonyms]" für jeden Raum vordefiniert sind. Zusätzliches Vokabular kann per Understand-Definitionen angelegt werden, um den Raum mit weiteren Synonymen anzusprechen.

Das Untersuchen eines Raumes wird in der "convert examining a room into looking rule" von der Aktion "examining" zur Aktion "looking" umgeleitet.


Section: Die Sichtbarkeit des aktuellen Raums

Der aktuelle Raum (location) ist standardmäßig nicht sichtbar, das heißt, er kann in der Spielereingabe nicht als Objekt genannt werden. Für die Aktionen "location-leaving", "examining" und "smelling" wird der Raum jedoch in den sichtbaren Bereich (in scope) platziert. Die Regel, die dafür zuständig ist, heißt "location visibility rule" und greift "after deciding the scope of the player".

Soll der aktuelle Raum niemals ansprechbar sein, kann die Regel komplett entfernt werden:

	*: The location visibility rule is not listed in any rulebook.

Wenn der Standort im Zusammenhang mit weiteren Aktionen ansprechbar sein soll, kann man das mit folgender Phrase erreichen:

	*: <ACTION> is allowing wide scope.

Mit "wide scope" ist gemeint, dass nicht nur der Inhalt des aktuellen Raumes sichtbar ist, sondern auch der Raum (als Objekt) selbst angesprochen werden kann.

Pronomen werden für einen vom Spieler genannten Raum standardmäßig nicht gesetzt, da der aktuelle Standort für die meisten Aktionen nicht "in scope" ist. Sollen dennoch Räume beim Setzen der Pronomen berücksichtigt werden, muss die Option

	*: Use room-related pronoun notice.

aktiviert werden.


Section: Inventar als Satz anzeigen

Im englischen Original-Inform wird das Inventar (die Dinge, die die Spielerfigur bei sich trägt) standardmäßig nur als Liste angezeigt. In GerX wird eine Möglichkeit zum Umschalten zwischen der Anzeige als Liste und der Ausgabe als vollständiger Satz angeboten. Die zwei neuen Aktionen, die das Umschalten steuern, heißen "wide taking inventory" und "tall taking inventory".

Anstelle von I können in den folgenden Beispielen natürlich auch die synonymen Kommandos INVENTAR, INV, BESITZ oder EIGENTUM verwendet werden.

	>I QUER/SATZ/BREIT
	>I ALS SATZ

Nach Eingabe einer dieser Anweisungen wird das Inventar als Satz angezeigt und der Inventar-Stil (dargestellt durch die Variable inventory style) auf "wide inventory" gesetzt. Beim nächsten einfachen Aufruf des Inventars z.B. per >I wird der aktuelle Stil zur Ausgabe benutzt.

	>I
	Du hast ein Glas (darin ist Wasser) und einen Apfel bei dir.

Mit aktivierter Use-Option "non-nested lists" sieht es so aus:

	>I
	Du hast ein Glas und einen Apfel bei dir. In dem Glas ist Wasser.

Die Anweisungen

	>I HOCH/LISTE/LANG
	>I ALS LISTE

zeigen das Inventar als Liste an (der Inform-Standard) und setzen den Inventar-Stil (inventory style) auf "tall inventory".

Es ist jederzeit möglich, die Variable inventory style auf einen der Werte "wide inventory" (Satz) oder "tall inventory" (Liste) zu setzen. Möchte man z.B. das Spiel standardmäßig mit der Einstellung "Inventar als Satz anzeigen" beginnen, kann die Variable gleich bei Spielbeginn geändert werden:

	When play begins: now inventory style is wide inventory.


Chapter: Spezielles Parsen

Section: Wortköpfe und -schwänze (Compound Heads und Compound Tails) von langen Wörtern abtrennen

Inform verarbeitet im Z-Code-Format nur die ersten neun Zeichen einer Vokabel. Auch im Glulx-Format ist das der Standard, die Länge der Lexikoneinträge lässt sich aber per

	Use DICT_WORD_SIZE of <N>.

ändern. Für Z-Code gibt es diese Möglichkeit leider nicht.

Bei der Verwendung von Vokabeln, die länger als 9 Zeichen sind, kann es also vorkommen, dass sich Objekte nicht unterscheiden lassen.

	Understand "Streichholz" as the Streichholz.
	Understand "Streichhoelzer" as the Packung Streichhölzer.

In dem Beispiel würden die Vokabeln für die zwei Objekte intern jeweils gleich lauten, nämlich 'streichho'. Der Parser kann das Streichholz deshalb nicht von den Streichhölzern unterscheiden. Um dieses etwas altertümliche Limit zu umgehen, kann man in GerX Wortköpfe oder -schwänze von langen Wörtern abschneiden lassen, sodass der Parser mit zwei kürzeren Vokabeln arbeiten kann.

Der Autor definiert folgende Tabelle

	Table of compound heads (continued)
	Head    	n
	"streich"    	0

und aktiviert ihre Berücksichtigung beim Parsen mit der Use-Option "Use compound heads.".
Jetzt lassen sich Streichholz und Streichhölzer folgendermaßen definieren:

	The pack of matches is a container. The printed name is "Packung[f] Streichhölzer" .Understand "streich-" and "hoelzer" as the pack.
	The match is a thing. The printed name is "Streichholz[-es][n]". Understand "streich-" and "holz" as the match.

Wichtig ist der Trennstrich am Ende der Wortkopf-Vokabel.

Analog zum Abschneiden der Köpfe kann man die Wörter auch vom Ende her abschneiden lassen.

	Table of compound tails (continued)
	Tail    	n
	"lampe"    	0

Jetzt kann man für jede Lampe auch noch "messing-", "taschen-" oder sonst irgendwas angeben. Auch hier muss der erste Wortbestandteil mit einem Trennstrich abgeschlossen werden.

Wichtig: Beide Tabellen benötigen pro Zeile zwei Einträge. Die Zahl n kann immer Null sein, da sie zurzeit noch keine Verwendung findet.


Section: Zwillinge und Synonyme (Twins und Synonyms)

Die Arrays Twins und Synonyms lassen sich bislang nur als I6-Code einbinden:

	Include (-
		Array Twins table
		'mc'			'kenzie'	"mckenzie"
		;

		Array Synonyms table
		'gegens'				"gegen das"
		'vorsichtig' 		"";
	-) after "Definitions.i6t".

Wichtig ist in den I6-Arrays, dass die/das Ausgangswort/e in einfachen Hochkommas angegeben wird, das Zielwort jedoch in Anführungsstrichen. Umlaute, Eszetts und Endungen sind, wie immer bei Vokabeln, tabu.

Es gibt aber eine I7-Alternative, die erst nach der Informisierung greift:

	After translating a command into Informese:
		if the player's command includes "mc kenzie", replace the matched text with "mckenzie".

	After translating a command into Informese:
		if the player's command includes "gegens":
			replace the matched text with "gegen das";
		if the player's command includes "vorsichtig":
			cut the matched text.

Auch hier gelten die Grundregeln zur Definition von Vokabeln: Keine Umlaute, keine Endungen. Zur Activity "translating a command into Informese" siehe auch Abschnitt Section 8.1: Die Informisierung der Spielereingabe.


Section: Englische Richtungsabkürzungen verbieten

Die englischen Richtungsabkürzungen E (East), NE (Northeast), SE (Southeast), D (Down) und U (Up) stehen dem Spieler standardmäßig zur Verfügung. Um die Abkürzungen aus dem Vokabular zu entfernen, kann der Autor Folgendes schreiben:

	*: The up object translates into I6 as "up_object".

	EnglishShortDirections is a kind of value. The EnglishShortDirections are d, ne, se, and e.

	After reading a command (this is the block English abbreviated directions rule):
		if the player's command includes "[EnglishShortDirections]":
			if the explicit error messages option is active:
				say "Ich kenne das Wort '[matched text]' nicht.";
			otherwise:
				issue miscellaneous library message number 27;
			reject the player's command.

Das up object muss auf I6-Ebene von "u_obj" in irgendetwas Anderes umbenannt werden (hier: up_object), damit das I6-Implicit-Up-Token "u" nicht mehr als "up" versteht. Je nachdem, ob explizite oder allgemeine Parser-Fehlermeldungen verwendet werden, wird eine entsprechende Nachricht ausgegeben und die Spielereingabe abgewiesen.

Dieses Beispiel unterbindet zwar die Benutzung der englischen Abkürzungen, verhindert aber auch, dass man die Abkürzungen für eigene Zwecke definieren kann, da sie schon vor dem eigentlichen Parsen abgefangen werden.


Chapter: Spezielle Grammatik-Token (Understand tokens)

Section: Dich und dir

	"[dich]": "dich / mich / uns / euch"

	Understand "leg [dich] hin" as sleeping.

Dieses Token wird als "dich", "mich", "uns" oder "euch" verstanden. Das spart einiges an Arbeit, weil man nicht alle Möglichkeiten einzeln angeben muss.

	"[dir]": "dir / mir / uns / euch"

	Understand "nimm [dir] [things]" as taking.

Dies wird als optionales "dir" verstanden, das heißt, auf das "nimm" kann "dir", "mir", "uns" oder "euch" folgen, es muss aber nicht sein.

	>NIMM ZWEI BROTE

und

	>NIMM DIR ZWEI BROTE

werden gleichermaßen interpretiert.

Section: Ein Satzelement als Dativ kennzeichnen (Dativ-Token)

	"[dativ]" / "[dative]"

Kennzeichnet ein nachfolgendes Token als Dativ.

Wo kommt das zum Einsatz? Hier mal eine Definition ohne Dativ-Token für ein Verb, das den Dativ verlangt:

	Understand "stocher in [something] herum" as poking.

Wenn der Spieler nun bei der Eingabe das Objekt unterschlägt, fragt das Spiel nach:

	>STOCHER
	Worein willst du stochern?

Diese Frage ist nicht ganz korrekt, weil das Spiel nicht weiß, dass das Verb den Dativ verlangt. Also teilen wir es mit:

	Understand "stocher in [dativ] [something] herum" as poking.

Jetzt fragt das Spiel:

	>STOCHER
	Worin willst du stochern?

	>PUDDING
	Du stocherst in dem Pudding herum.

Bei der Verwendung von verketteten (mit Schrägstrich gruppierten) Präpositionen wird die erste Präposition der Kette zur Ausgabe der Parser-Frage herangezogen:

	Understand "stocher in/unter [dativ] [something] herum" as poking.

	>STOCHER
	Worin willst du stochern?

	Understand "stocher unter/in [dativ] [something] herum" as poking.

	>STOCHER
	Worunter willst du stochern?

Section: Ein Satzelement als Substantiv kennzeichnen (Substantiv-Token)

	"[substantiv]" / "[substantive]"

Kennzeichnet ein nachfolgendes Wort im Satzmuster als Substantiv. So kann der Parser bei Rückfragen den Infinitv besser rekonstruieren.

	Understand "nimm [substantiv] platz auf [dativ] [something]" as entering.

Jetzt wird der Infinitv korrekt als "Platz nehmen" gebildet. Ohne Substantiv-Token würde der Parser "platznehmen" schreiben.

	Im Spiel:

	>NIMM PLATZ
	Worauf willst du Platz nehmen?


Section: Optionale Präpositionen

Wenn in einem Satz Präpositionen verwendet werden können, aber nicht unbedingt vorhanden sein müssen, kann man das folgende Token verwenden. Für die Präposition werden auch die jeweiligen Alternativen verstanden.

	"[hinein]": "hinein / rein / darein / herein"

	Understand "geh in [something] [hinein]" as entering.


Die Anweisungen

	>GEH INS BETT

und

	>GEH INS BETT HINEIN

sind gleichwertig.

Weitere optionale Präpositionen:

	"[dagegen]": "dagegen" / "gegen"
	"[daran]": "daran" / "dran" / "ran" / "an"
	"[darauf]": "darauf" / "drauf" / "herauf" / "rauf" / "hinauf"
	"[darueber]": "darüber" / "hinüber" / "drüber" / "herüber"
	"[darum]": "darum" / "drum" / "herum" / "rum"
	"[darunter]": "darunter" / "drunter"
	"[heraus]": "heraus" / "hinaus" / "raus" / "daraus"
	"[herunter]": "herunter" / "hinunter" / "runter" / "herab" / "hinab"
	"[hindurch]": "durch" / "hindurch"
	"[hinein]": "hinein" / "rein" / "darein" / "herein"
	"[nach]": "nach"
	"[weg]": "hinweg" / "weg" / "fort" / "ab"



Section: Erzwungene Präpositionen

	"[force nach]" / "[force in]"

Prüft den gesamten Satz und lässt das Satzmuster nur zu, wenn es das Wort "nach" bzw. "in" enthält.

	"[force nach in]"

Hier müssen "nach" und "in" im Satz vorhanden sein.


Section: Pronominaladverbien

Diese Token tragen "noun" als festen Bestandteil ihres Namens. Das ist nicht zu verwechseln mit der Variablen "noun", mit der man sich in Textausdrücken auf ein Objekt beziehen kann.

	"[noun dahinter]"

	Understand "schau [noun dahinter] [nach]" as looking under.

Dieses Token wird als Adverb verstanden, das sich auf das zuletzt angesprochene Objekt, das keine Person ist, bezieht. Dadurch wird folgende Art von Dialogen ermöglicht:

	>BETRACHTE BILDERRAHMEN
	Der Rahmen steht etwas von der Wand ab.

Jetzt ist der Bilderrahmen das zuletzt angesprochene Objekt und das Pronomen "dahinter" bezieht sich auf ihn.

	>SCHAU DAHINTER
	Hinter dem Bilderrahmen findest du einen Briefumschlag.

Weitere Pronomen:

	"[noun dagegen]"
	"[noun daran]"
	"[noun darauf]"
	"[noun darueber]"
	"[noun darum]"
	"[noun darunter]"
	"[noun heraus]"
	"[noun herunter]"
	"[noun hindurch]"
	"[noun hinein]"
	"[noun dahinter]"


	"[held darauf]"
	"[held hinein]"

Die "[held ...]"-Token verhalten sich wie die noun-Token, nur dass sie verlangen, dass ein Ding beim Spieler ist und ein implizites Taking versuchen.

Pronomen erzwingen:

	"[force pronoun]"

Dieses Token kann in Verbindung mit Präpositionen verwendet werden; so ist z.B.

	Understand "spiel [force pronoun] darauf" as playing.

gleichbedeutend mit

	Understand "spiel [noun darauf]" as playing.

Neue, nicht vordefinierte, Pronominaladverbien können damit realisiert werden, wie z.B. "davor":

	Understand "knie [force pronoun] davor nieder" as genuflecting in front of it.

Das Wort im Satzmuster, das auf "[force pronoun]" folgt ("davor"), wird als Pronomen für das zuletzt angesprochene Substantiv, das keine Person ist, interpretiert. Nun ist folgende Art von Dialog möglich:

	>BETRACHTE ALTAR
	Ein alter Altar.

	>KNIE DAVOR NIEDER
	Du kniest dich vor den Altar.

Um zu prüfen, ob der Bezug zu einem Substantiv durch ein Pronominaladverb hergestellt wurde, benutzt man folgende Phrase:

	... whether/if the/a noun has been supplied by a pronominal adverb ...

Um den Bezug zu löschen, schreibt man

	reset the pronominal adverb;

Diese Phrasen werden beispielweise in der GerX-Rule "adjust the pronominal adverb reference when removing" benutzt.


Chapter: Die I7-Standard-Erweiterungen "Basic Screen Effects", "Locksmith", "Menus" und "Rideable Vehicles"

Für die in I7 integrierten Erweiterungen Rideable Vehicles von Graham Nelson sowie Locksmith, Menus und Basic Screen Effects von Emily Short bringt GerX schon deutsche Übersetzungen mit. Die Installation zusätzlicher Erweiterungen ist nicht notwendig. Die Original-Extensions müssen vor GerX eingebunden werden, damit die englischen Standardmeldungen und Verbendefinitionen durch deutsche Entsprechungen ersetzt werden.

Das Beispiel C "John Malkovichs Toilette" demonstriert die Benutzung der Locksmith-Erweiterung.


Chapter: Die I7-Standard-Erweiterung "Basic Help Menu"

Um eine deutsche Übersetzung der in I7 enthaltenen Erweiterung "Basic Help Menu" zu nutzen, reicht es die Original-Erweiterung Basic Help Menu von Emily Short einzubinden. Weitere Extensions sind nicht nötig.

Um die Liste der Optionen zu erweitern, muss die Tabelle German Basic Help Options fortgeführt werden. Um das Einstellungsmenü zu benutzen, muss die Tabelle German Setting Options in der Spalte subtable der German Basic Help Options eingetragen werden.

Beispiel zur Nutzung:

	Include Basic Help Menu by Emily Short.

	Table of German Basic Help Options (continued)
	title	subtable	description
	"Kontakt zum Autor aufnehmen"	--	"Bei Problemen beim Spielen von [story title], schreibe mir bitte unter ..."
	"Tipps zum Spiel"	Table of Hints	--
	"Einstellungen"	Table of German Setting Options	--

	Table of Hints
	title	subtable	description	toggle
	"Was soll ich mit dem Müllcontainer tun?"	Table of Dumpster Hints		""	hint toggle rule

	Table of Dumpster Hints
	hint	used
	"Du kannst in den Container auch hineinsteigen."	a number
	"Dafür brauchst du doch jetzt wohl keine Hilfe mehr, oder?"

Die Regel zur Steuerung des Menüs heißt "German help request rule". Sie kann über diesen Namen, wie alle anderen Regeln auch, nachträglich vom Autor manipuliert werden.

Die englischen Original-Menü-Tables stehen weiterhin unter ihren ursprünglichen Namen zur Verfügung, falls jemand das Ganze zweisprachig nutzen möchte.


Chapter: GerX-Entwicklung

Section: Updates

Die aktuellste Version der GerX-Erweiterung steht unter

	"http://ifiction.pageturner.de/inform7/"

zum Download bereit.

Fehlermeldungen und Verbesserungsvorschläge sind immer herzlich willkommen!

	"fgerbig@users.sourceforge.net" and "GerX@pageturner.de"

	"http://forum.ifzentrale.de"

Maintainer der GerX-Erweiterung sind Michael Baltes und Christian Blümke.


Section: Versionshistorie

Eine Übersicht über ältere Versionen und Änderungsprotokolle gibt es im GerX-Archiv:

	"http://ifiction.pageturner.de/inform7/archiv/index.html"


Example: * Der Mantel der Finsternis - Eine Übersetzung des Demo-Spiels "Cloak of Darkness" von Roger Firth, basierend auf der Inform-7-Version von Graham Nelson und Emily Short. Dieses Beispiel benutzt die "einsprachige Methode" zum Definieren von Objekten, die in Kapitel 4.2 beschrieben ist. Das grammatische Geschlecht des Objekts wird im printed name angegeben.

    *:"Der Mantel der Finsternis" (in German)

    Include German by Team GerX.

    The story headline is "Ein einfaches Demo-Textadventure."

    Use scoring.
    The maximum score is 2.

    A thing is usually privately-named.

    The Foyer of the Opera House is a room. The printed name is "Foyer der Oper[n]". "Du stehst in einer großen, prächtig in Rot und Gold dekorierten Eingangshalle. Funkelnde Kronleuchter hängen von der Decke herab. Der Ausgang zur Straße liegt im Norden, weitere Türen befinden sich im Süden und Westen."

    Instead of going north in the Foyer, say "Du bist doch gerade erst angekommen, und draußen scheint das Wetter ohnehin nur noch schlechter zu werden."

    The Cloakroom is west of the Foyer. The printed name is "Garderobe[f]". "An den Wänden dieses kleinen Raumes befanden sich offenbar einmal Reihen von Kleiderhaken aus Messing, von denen jetzt nur noch einer geblieben ist. Der Ausgang ist eine Tür im Osten."

    The small brass hook is a scenery supporter in the Cloakroom. The printed name is "klein[^] Messinghaken[-s][m]".

    Understand "klein", "haken", "messinghaken", "kleiderhaken" and "haekchen[n]" as the hook.

    The description of the hook is "Es ist nur ein einfacher Kleiderhaken aus Messing, [if something is on the hook]mit [a list of things on the hook with dative case] daran[otherwise]der an die Wand geschraubt ist[end if]."

    The Bar is south of the Foyer. The printed name of the Bar is "Foyer-Bar[f]". The Bar is dark. "Die Bar ist nicht halb so prächtig, wie du annahmst, nachdem du das Foyer im Norden gesehen hast. Sie ist völlig leer, bis auf das Sägemehl am Boden, in dem du eine hingekritzelte Nachricht erkennen kannst."

    The scrawled message is scenery in the Bar. The printed name is "krakelig[^] Nachricht[f]". Understand "krakelig", "gekrakelt", "gekitzelt", "Nachricht", "Botschaft", "Schrift", "Boden[m]", "Saegemehl[n]" as the message.

    Neatness is a kind of value. The neatnesses are neat, scuffed, and trampled.

    The message has a neatness. The message is neat.

    Instead of examining the message:
     increase score by 1;
     say "Die Nachricht, fein säuberlich in das Sägemehl geschrieben, lautet:";
     end the story saying "Du hast gewonnen".

    Instead of examining the trampled message:
     say "Die Nachricht wurde zertrampelt. Du kannst gerade noch folgende Worte entziffern:";
     end the story saying "Du hast verloren".

    Instead of doing something other than going in the bar when in darkness:
     if the message is not trampled, now the neatness of the message
     is the neatness after the neatness of the message;
     say "Im Dunkeln? Du könntest hier leicht etwas durcheinander bringen."

    Instead of going nowhere from the bar when in darkness:
     now the message is trampled;
     say "Es ist keine gute Idee, im Dunkeln hier herumzutappen."

    The velvet cloak is a thing worn by the player. The printed name of the cloak is "Samtmantel[-s][m]". The cloak can be hung or unhung. Understand "dunkel", "schwarz", "benetzt", "Samtmantel", "Satinmantel", "Samt[n]", "Satin[n]", "Mantel", "Umhang", "Gewand[n]" as the cloak. The description of the cloak is "Ein schöner Samtmantel, mit Satin durchzogen und von Regentropfen leicht benetzt. Er ist so tief schwarz, dass es fast scheint, als entzöge er dem Raum jegliches Licht."

    Carry out taking the cloak:
     now the bar is dark.

    Carry out putting the unhung cloak on something in the cloakroom:
     now the cloak is hung;
     increase score by 1.

    Carry out putting the cloak on something in the cloakroom:
     now the bar is lit.

    Carry out dropping the cloak in the cloakroom:
     now the bar is lit.

    After putting the cloak on the hook:
     say "Du hängst den Mantel an den Haken."

    Instead of dropping or putting the cloak on when the player is not in the cloakroom:
     say "Dies ist nicht der richtige Ort, um einen so schönen Mantel herumliegen zu lassen."

    When play begins:
     say "[paragraph break]Du eilst durch die verregnete Novembernacht und bist froh, die strahlenden Lichter der Oper zu sehen. Es ist überraschend, dass hier nicht mehr Menschen sind, aber was erwartest du von so einem einfachen Beispiel ... ?"

    Understand "haeng [something preferably held] an/auf [something]" as putting it on.

    Test me with "s / n / w / inventar / häng mantel an haken / o / s / lies nachricht".


Example: * Die Jadestatue - Martin Oehms Jade-Beispiel für Inform 7. Die ausführlich kommentierte Version gibt es unter "http://www.martin-oehm.de/jade/i7-code.html". Dieses Beispiel benutzt die "Denglisch-Methode" zum Definieren von Objekten, die in Kapitel 4.3 beschrieben ist.

	*:"Die Jadestatue" by Martin Oehm (in German)

	Include German by Team GerX.

	The story headline is "Ein interaktives Exempel".

	The story description is "Das Jade-Beispiel für Inform 7".

	The Dschungel is a room. "Du stehst auf einer Lichtung im dichten Dschungel. Im Norden steht ein alter, von Ranken überzogener Schrein. Im Süden führt ein schmaler Pfad zurück in die Zivilisation." The printed name of the Dschungel is "Lichtung im Dschungel".

	Instead of going south in the Dschungel when the player has the Jadestatue: say "Du schaffst es, mit der Statue wieder zurück in die Zivilisation zu gelangen."; end the story saying "Du hast gewonnen".

	Instead of going south in the Dschungel, say "Nicht ohne die Statue!".

	Instead of going nowhere from the Dschungel, say "Dort ist der Dschungel zu dicht, es gibt keinen Pfad in diese Richtung."

	A faustgross Stein is in the Dschungel. "In der Nähe des Schreins liegt ein glatter, runder Stein im Gras." Instead of examining the Stein, say "Der Stein ist so groß wie eine Faust und außergewöhnlich glatt und rund." Understand "gross", "glatt" and "rund" as Stein. The printed name of the Stein is "faustgroß[^] Stein[m]". The Stein is portable.

	The alt Schrein is scenery in the Dschungel. Instead of examining the Schrein, say "Der alte Toltekenschrein ist fast komplett mit Efeu überwuchert." Instead of entering the Schrein, try going north. Understand "toltekisch", "Efeu" and "Ranken [p]" as Schrein. The printed name of the Schrein is "alt[^] Schrein[m]".

	The Toltekenschrein is a room. It is north of the Dschungel. "In dem kleinen Schrein ist es dunkel, nur wenig Licht fällt durch das halb verfallene Dach. Ein großer Lichtstrahl fällt auf eine Steinsäule in der Mitte des Schreins.[paragraph break]Die Lichtung liegt im Süden." Outside from the Toltekenschrein is the Dschungel. The printed name of the Toltekenschrein is "Im Schrein".

	The Steinsaeule is a supporter in the Toltekenschrein. The printed name is "Steinsäule[f]". Instead of examining the Steinsaeule, say "Die Säule ist aus glattem Stein gehauen, etwas mehr als einen Meter hoch und oben flach, wie ein Podest." Understand "Saeule", "Podest [n]" and "Steinpodest [n]" as Steinsaeule.

	The Jadestatue is on the Steinsaeule. It is portable. Instead of examining the Jadestatue, say "Es ist die Statue einer toltekischen Gottheit, komplett aus grüner Jade geschnitzt. Sie glänzt und sieht sehr wertvoll aus." The printed name is "Jadestatue[f]". Understand "gruen", "klein", "Statue", "Figur", "Jadestatue" and "Jadefigur" as Jadestatue.

	Instead of taking the Jadestatue when the Jadestatue is on the Steinsaeule and the Stein is not on the Steinsaeule: say "Als du das Gewicht der Statue von der Säule nimmst, hörst Du ein klickendes Geräusch. Kurz darauf wirst du von Giftpfeilen durchbohrt."; end the story saying "Du bist gestorben".

	When play begins: say "Endlich! Nach tagelangem Suchen im Dschungel stößt du auf eine Lichtung. Und auf etwas mehr. Vielleicht ist dies der Ort, an dem sich die Jadestatue befindet?[paragraph break]".

	Test me with "s / u mich / i / nimm den Stein / untersuche ihn / i / n / lege Stein auf Säule / untersuche die Statue / nimm sie / i / s / s".


Example: * John Malkovichs Toilette - Eine Übersetzung des Beispiels "John Malkovich's Toilet" aus der in I7 enthaltenen Locksmith-Erweiterung von Emily Short. Es wird die "einsprachige Methode" zum Definieren von Objekten benutzt, die in Kapitel 4.2 beschrieben ist.

	*:"John Malkovichs Toilette" (in German)

	Include Locksmith by Emily Short.
	Include German by Team GerX.

	A thing is usually privately-named.

	The Bathroom is a room. The printed name is "Badezimmer[n]".

	The bathroom door is a door. It is north of the Bathroom and south of the Bedroom. It is lockable and locked. The printed name of the bathroom door is "Badezimmertür[f]". Understand "Tuer", "Badezimmertuer", "Tuer des Badezimmer" and "Tuer zu dem Badezimmer" as the bathroom door. The printed name of the bedroom is "Schlafzimmer[n]".

	Before unlocking keylessly the bathroom door:
		if the bathroom door is unlocked, say "[Der bathroom door] ist schon unverriegelt." instead;
		try turning the latch instead.

	Before locking keylessly the bathroom door:
		if the bathroom door is locked, say "[Der bathroom door] ist sicher verriegelt." instead;
		try turning the latch instead.

	Before locking the bathroom door with something:
		say "Die Badezimmertür lässt sich nur verriegeln und nicht mit einem Schlüssel abschließen." instead.

	Before unlocking the bathroom door with something:
		say "Die Badezimmertür ist verriegelt und lässt sich nicht mit einem Schlüssel öffnen." instead.

	The latch is part of the bathroom door. "Ein drehbarer Knopf, der die Tür verriegelt." Understand "Knopf", "Riegel" and "drehbar" as the latch. The description of the bathroom door is "Uninteressant bis auf den Knopf zum Verriegeln der Tür." The printed name of the latch is "drehbar[^] Riegel[-s][m]".

	Instead of turning the latch:
		if the bathroom door is locked begin;
			say "Klick! Du drehst den Knopf und die Tür ist entriegelt[if the door is open] und offen[end if].";
			now the bathroom door is unlocked;
		otherwise;
			say "Klick! Du drehst den Knopf und die Tür ist verriegelt[if the door is open], aber offen; das Schloss wird einschnappen, sobald du die Tür schließt[end if].";
			now the bathroom door is locked;
		end if.

	The little black oval door is a door. It is west of the Bathroom and east of Oblivion. It is lockable and locked. The printed name is "klein[^] schwarz[^] oval[^] Tür[f]". Understand "klein", "schwarz", "oval" and "Tuer" as the oval door. The description of the oval door is "Sie befindet sich in der Wand des Duschbereichs und lässt sich wer weiß wo öffnen. Du bist dir sicher, dass sie gestern noch nicht da war." The printed name of Oblivion is "Vergessenheit[f]".

	The onyx key unlocks the oval door. It is in the Bedroom. "Auf dem Boden liegt kantig und schwarz von der Sonne beleuchtet [ein onyx key]." The printed name of the onyx key is "Onyxschlüssel[m]". Understand "Schluessel", "Schluessel aus Onyx" and "Onyxschluessel" as the onyx key.

	Test me with " u badezimmertür / schließ ovale tür auf / schließ badezimmertür auf / g / gehe durch badezimmertür / nimm schlüssel / schließ badezimmertür ab / schließ badezimmertür / s / schließ badezimmertür mit dem onyxschlüssel ab / w"
