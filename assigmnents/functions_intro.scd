// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 07 October 2013

// FUNCTIONS INTRO
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


// Simple Functions

// Convert years to days
~yearsToDays = { arg years ; years * 365 };
~yearsToDays.value(5)

// Convert meters to miles
~metersToMiles = { arg meters; meters * 1/1609.34 } ;
~metersToMiles.value(10000)


// SuperCollider functions

// myGreatChord
(
~myGreatChord = { arg root;
	{ SinOsc.ar( freq: root,    mul: 0.25) }.play;    // root
	{ SinOsc.ar( freq: root/2,  mul: 0.25) }.play;    // octave below
	{ SinOsc.ar( freq: root*2,  mul: 0.25) }.play;    // octave above
	{ SinOsc.ar( freq: root+32,	mul: 0.25) }.play;    // root + 32 Hz
};
)
~myGreatChord.value(440);

// eightOpen
(
~eightOpen = { arg root;
	{ SinOsc.ar( freq: root, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
	{ SinOsc.ar( freq: root*3/2, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
	{ SinOsc.ar( freq: root*5/2, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
	{ SinOsc.ar( freq: root*3, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
};
)

// I-III-IV-V chord progression starting on A
~eightOpen.value(110);
~eightOpen.value(110*5/4);
~eightOpen.value(110*4/3);
~eightOpen.value(110*3/2);

// I-IV-V-IV chord progression starting on A
~eightOpen.value(110);
~eightOpen.value(110*4/3);
~eightOpen.value(110*3/2);
~eightOpen.value(110*4/3);
~eightOpen.value(110);


// fourChord (takes in four frequencies and plays them all at once)

~fourChord = { arg noteOne, noteTwo, noteThree, noteFour;
	{ SinOsc.ar( freq: noteOne, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
	{ SinOsc.ar( freq: noteTwo, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
	{ SinOsc.ar( freq: noteThree, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
	{ SinOsc.ar( freq: noteFour, mul: EnvGen.kr( Env.triangle( dur: 3, level: 1)))}.play;
};
)
~fourChord.value(110, 110*3/2, 100*5/2, 110*3);
