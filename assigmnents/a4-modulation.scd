// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 25 October 2013

// ASSIGNMENT 4 - FREQUENCY/AMPLITUDE MODULATION
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// SynthDefs
(
// Amplitude Modulation
SynthDef("amsynth", {arg carrFreq=440, modFreq=50, attack=0.05, release=2, amp=0.2;
	var env, mod, snd;
	env = EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release, level: amp), doneAction: 2);
	mod = LFPulse.kr(freq: modFreq);
	snd = SinOsc.ar(freq: carrFreq, mul: env * mod);
	Out.ar(0, snd!2);
}).add;

// Frequency Modulation
SynthDef("fmsynth", {arg carrFreq=440, modFreq=50, range=50, attack=0.05, release=2, amp=0.2;
	var env, mod, snd;

	env = EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release, level: amp), doneAction: 2);
	mod = LFPulse.ar(freq: modFreq, mul: range);
	snd = SinOsc.ar(freq: carrFreq + mod, mul: env);

	Out.ar(0, snd!2);
}).add;
)


// testing
Synth("amsynth");
Synth("fmsynth", [\range, 50, \carrFreq, 440, \modFreq, 100]); // this sounds like a somewhat decent bell


// sequencing with pbinds
(
{
var user_tempo=112;                    // change value of user_tempo to change actual tempo (bpm)
var tempo=60*(1/user_tempo);

Pbind(\instrument, "fmsynth",
	\carrFreq, Pseq([123, 456, 789, 012, 345, 678, 234, 567, 890], inf),
	\dur, tempo/3,
	\release, 0.5,
	\modFreq, 0,
		\amp, Pseq([0.4, 0.2, 0.1], 48)
	//\amp, Prand([0.012, 0.345, 0.6789], inf)
).play;

	(tempo*4).wait;

Pbind(\instrument, "fmsynth",
	\carrFreq, Pseq([123, 456, 789, 123, 012, 345, 678, 012, 234, 567, 890, 234], inf),
	\dur, tempo*2/3,
	\release, 0.5,
	\modFreq, 100,
		\amp, Pseq([0.3, 0.1, 0.1, 0.1], 32)
).play;

	(tempo*4).wait;

	Pbind(\instrument, "amsynth",
	\carrFreq, Pseq([123, 456, 789, 123, 012, 345, 678, 012, 234, 567, 890, 234], inf),
	\dur, tempo*2/3,
	\release, 0.5,
	\modFreq, 30,
	\amp, Pseq([0.1, 0.2, 0.4], 48)
).play;

	(tempo*4).wait;

	Pbind(\instrument, "amsynth",
		\carrFreq, 27.5,
		\dur, Pseq([tempo], 88),
		\release, tempo,
		\modFreq, 50
	).play;

	Pbind(
		\dur, tempo,
		\amp, Pseq([0.1], 64)
	).play;

}.fork;
)


// recording
s.record;
s.stopRecording;