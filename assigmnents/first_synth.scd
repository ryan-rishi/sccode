// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 08 October 2013

// FIRST SYNTH
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Define a synth that takes in arguments
(
SynthDef("improvedSynth", {arg freq, level, attack, release, loudspeaker=0 ;
	var snd;
	snd = SinOsc.ar(freq: freq, mul: EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release, level: level)));
	Out.ar(loudspeaker, snd);
}).add;
)

// Synth Usage
Synth("improvedSynth", [\freq, 500, \level, 0.2, \attack, 2, \release, 4, \loudspeaker, 1]);

// Note: you don't have to specify loudspeaker (0=left, 1=right), but you can if you'd like to specify
// which channel you want.