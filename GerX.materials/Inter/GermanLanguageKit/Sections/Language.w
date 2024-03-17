Language Template.

The fundamental definitions needed by the parser and the verb
library in order to specify the language of play -- that is, the language
used for communications between the story file and the player.

@h Identification.

=
Constant GERMANLANGUAGEKIT = 1;

@h Vocabulary.

=
Constant AGAIN1__WD     = 'again';
Constant AGAIN2__WD     = 'g//';
Constant AGAIN3__WD     = 'nochmal';
Constant OOPS1__WD      = 'oh';
Constant OOPS2__WD      = 'hoppla';
Constant OOPS3__WD      = 'huch';
Constant UNDO1__WD      = 'undo';
Constant UNDO2__WD      = 'zurueck';
Constant UNDO3__WD      = 'rueckgaengig';

Constant ALL1__WD       = 'all';
Constant ALL2__WD       = 'alles';
Constant ALL3__WD       = 'jede';
Constant ALL4__WD       = 'saemtlich';
Constant ALL5__WD       = 'alles';
Constant AND1__WD       = 'und';
Constant AND2__WD       = 'sowie';
Constant AND3__WD       = 'und';
Constant BUT1__WD       = 'ohne';
Constant BUT2__WD       = 'ausser';
Constant BUT3__WD       = 'ausser';
Constant ME1__WD        = 'mich';
Constant ME2__WD        = 'dich';
Constant ME3__WD        = 'mir';
Constant OF1__WD        = 'von';
Constant OF2__WD        = 'aus';
Constant OF3__WD        = 'von';
Constant OF4__WD        = 'von';
Constant OTHER1__WD     = 'andere';
Constant OTHER2__WD     = 'restlich';
Constant OTHER3__WD     = 'verbleibend';
Constant THEN1__WD      = 'dann';
Constant THEN2__WD      = 'sodann';
Constant THEN3__WD      = 'danach';

Constant NO1__WD        = 'n//';
Constant NO2__WD        = 'nein';
Constant NO3__WD        = 'nein';
Constant YES1__WD       = 'j//';
Constant YES2__WD       = 'ja';
Constant YES3__WD       = 'y//';

Constant AMUSING__WD    = 'amusing';
Constant FULLSCORE1__WD = 'voll';
Constant FULLSCORE2__WD = 'punkte';
Constant QUIT1__WD      = 'e//';
Constant QUIT2__WD      = 'ende';
Constant RESTART__WD    = 'neustart';
Constant RESTORE__WD    = 'laden';

@h Pronouns.

=
Array LanguagePronouns table

	! word	possible GNAs					connected
	!		to follow:						to:
	!		  a     i
	!		  s  p  s  p
	!		  mfnmfnmfnmfn

	'er'	$$100000100000					NULL   ! m-Nom
	'sie'	$$010111010111					NULL   ! f-Nom/Akk
	'es'	$$001000001000					NULL   ! n-Nom/Akk
	'ihn'	$$100000100000					NULL   ! m-Akk
	'ihm'	$$101000101000					NULL   ! m/n-Dat
	'ihr'	$$010000010000					NULL   ! f-Dat
	'ihnen'	$$000111000111					NULL   ! p/Dat
	'spez.'	$$000000111111					NULL   ! Adverbialpron.
	'ihm/r'	$$000000111111					NULL   ! Adverbialpron.
	;

@h Descriptors.

=
Array LanguageDescriptors table

	! word		possible GNAs   descriptor      connected 
	!			to follow:      type:           to:
	!			  a     i
	!			  s  p  s  p
	!			  mfnmfnmfnmfn

	'der'		$$110111110111	DEFART_PK	   NULL   ! m-Nom, f-Dat, f/p-Gen
	'die'		$$010111010111	DEFART_PK	   NULL   ! f/p-Nom/Akk
	'das'		$$001000001000	DEFART_PK	   NULL   ! n-Nom/Akk
	'dem'		$$101000101000	DEFART_PK	   NULL   ! m/n-Dat
	'den'		$$100111100111	DEFART_PK	   NULL   ! m-Akk, p-Dat
	'des'		$$101000101000	DEFART_PK	   NULL   ! m/n-Gen

	'einen'		$$100000100000	INDEFART_PK	 NULL   ! m-Akk
	'ein'		$$101000101000	INDEFART_PK	 NULL   ! m/n-Nom, n-Akk
	'einem'		$$101000101000	INDEFART_PK	 NULL   ! m/n-Dat
	'eine'		$$010000010000	INDEFART_PK	 NULL   ! f-Nom/Akk
	'einer'		$$010000010000	INDEFART_PK	 NULL   ! f-Dat/Gen
	'eines'		$$101000101000	INDEFART_PK	 NULL   ! m/n-Gen

	'dies'		$$001000001000	POSSESS_PK	  0	  ! Demonstrativpronomen
	'diese'		$$010111010111	POSSESS_PK	  0	  ! für "hier"
	'dieser'	$$110111110111	POSSESS_PK	  0
	'diesem'	$$101000101000	POSSESS_PK	  0
	'diesen'	$$100111100111	POSSESS_PK	  0
	'dieses'	$$101000101000	POSSESS_PK	  0

	'jene'		$$010111010111	POSSESS_PK	  1	  ! Demonstrativpronomen
	'jener'		$$110111110111	POSSESS_PK	  1	  ! für "dort"
	'jenem'		$$101000101000	POSSESS_PK	  1
	'jenen'		$$100111100111	POSSESS_PK	  1
	'jenes'		$$101000101000	POSSESS_PK	  1

	'mein'		$$101000101000	POSSESS_PK	  0	  ! Possesivpronomen
	'meine'		$$010111010111	POSSESS_PK	  0
	'meiner'	$$010111010111	POSSESS_PK	  0
	'meinem'	$$101000101000	POSSESS_PK	  0
	'meinen'	$$100111100111	POSSESS_PK	  0
	'meines'	$$101000101000	POSSESS_PK	  0

	'dein'		$$101000101000	POSSESS_PK	  1	  ! Possesivpronomen
	'deine'		$$010111010111	POSSESS_PK	  1
	'deiner'	$$010111010111	POSSESS_PK	  1
	'deinem'	$$101000101000	POSSESS_PK	  1
	'deinen'	$$100111100111	POSSESS_PK	  1
	'deines'	$$101000101000	POSSESS_PK	  1

	'sein'		$$001000001000	POSSESS_PK	  'him'
	'seine'		$$010111010111	POSSESS_PK	  'him'
	'seiner'	$$110111110111	POSSESS_PK	  'him'
	'seinem'	$$101000101000	POSSESS_PK	  'him'
	'seinen'	$$100111100111	POSSESS_PK	  'him'
	'seines'	$$101000101000	POSSESS_PK	  'him'

	'ihr'		$$001000001000	POSSESS_PK	  'her'
	'ihre'		$$010111010111	POSSESS_PK	  'her'
	'ihrer'		$$110111110111	POSSESS_PK	  'her'
	'ihrem'		$$101000101000	POSSESS_PK	  'her'
	'ihren'		$$100111100111	POSSESS_PK	  'her'
	'ihres'		$$101000101000	POSSESS_PK	  'her'

	'deren'		$$111111111111	POSSESS_PK	  'them'
	'dessen'	$$111111111111	POSSESS_PK	  'it'
	;

@h Numbers.

=
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

@h Time.

=
[ LanguageTimeOfDay hours mins i;
	if (hours < 0 || hours > 23 || mins < 0 || mins > 59) rfalse;
	print hours/10, hours%10, ":", mins/10, mins%10;
];

@h Directions.

=
[ LanguageDirection d;
	print (name) d;
];

@h Translation.

=
[ LanguageToInformese; ];

@h Articles.

=
Constant LanguageAnimateGender   = male;
Constant LanguageInanimateGender = neuter;

Constant LanguageContractionForms = 0;

[ LanguageContraction text;
	return 0;
];

Array LanguageArticles -->
	"die"		"das"		"der"		"die"		! bestimmte Artikel
	"der"		"des"		"des"		"der"	
	"den"		"dem"		"dem"		"der"	
	"die"		"das"		"den"		"die"	
	0			"ein"		"ein"		"eine"		! unbestimmte Artikel
	0			"eines"		"eines"		"einer"	
	0			"einem"		"einem"		"einer"	
	0			"ein"		"einen"		"eine"	
	"keine"		"kein"		"kein"		"keine"		! verneinte
	"keiner"	"keines"	"keines"	"keiner"	! unbestimmte Artikel
	"keinen"	"keinem"	"keinem"	"keiner"	
	"keine"		"kein"		"keinen"	"keine"
	;

                   !             a           i
                   !             s     p     s     p
                   !             m f n m f n m f n m f n

Array LanguageGNAsToArticles --> 0 0 0 1 1 1 0 0 0 1 1 1;

@h Commands.
|LanguageVerbLikesAdverb| is called by |PrintCommand| when printing an |UPTO_PE|
error or an inference message.  Words which are intransitive verbs, i.e.,
which require a direction name as an adverb ("walk west"), not a noun
("I only understood you as far as wanting to touch the ground"), should
cause the routine to return |true|.

|LanguageVerbMayBeName| is called by |NounDomain| when dealing with
the player's reply to a "Which do you mean, the short stick or the
long stick?" prompt from the parser. If the reply is another verb
(for example, LOOK) then the previous ambiguous command is discarded
unless it is one of these words which could be both a verb and an
adjective in a |name| property.

=
[ LanguageVerb i;
    switch (i) {
      'i//','inv','inventory':
               print "take inventory";
      'l//':   print "look";
      'x//':   print "examine";
      'z//':   print "wait";
      default: rfalse;
    }
    rtrue;
];

[ LanguageVerbLikesAdverb w;
	if (w == 'geh' or 'lauf' or 'renn' or 'wander' or 'fluecht' or 'flieh' or 'schreit' or 'spazier')
		rtrue;

	if (w == 'schau' or 'seh' or 'sieh' or 'blick' or 'lug' or 'guck' or 'kuck')
		rtrue;

    rfalse;
];

! ----------------------------------------------------------------------------
!  In deform wird das ganz pragmatisch gehandhabt: Alle möglichen Objekte sind
!  bekannt. Wenn das Wort zu dessen name-Einträgen gehört, so soll das Wort
!  nicht als Verb behandelt werden, ansonsten schon. Das fängt keine komplexen
!  parse_name-Konstrukte ab, aber schließlich wird dies auch nur aufgerufen,
!  wenn w ein Verb sein kann. Außerdem ist die Abfrage so kontextsensitiv.
! ----------------------------------------------------------------------------
[ LanguageVerbMayBeName w	i;
	for (i=0 : i < number_matched : i++) {
		if (WordInProperty(w, match_list-->i, name)) rtrue;
	}
	rfalse;
];

@h Stubs.
To reduce the need for conditional compilation, we provide these stub
routines:

=
[ LanguageIsVerb buffer parse verb_wordnum;
	rfalse;
];
