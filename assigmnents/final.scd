// Ryan Rishi
// B. Ruviaro
// MUSC 115 - Experimental Sound Design
// 11 December 2013

// FINAL PROJECT
// To hear my final project, visit https://soundcloud.com/ryan-rishi-scu/final
(

SynthDef("reverse", { arg freq=440, amp=0.2, attack=1, release=0.01, curve=4;
	var env, snd;
	env = EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release, level: amp, curve: curve), doneAction: 2);
	snd = SinOsc.ar(freq: freq, mul: env) + SinOsc.ar(freq: 2*freq, mul: env);
	Out.ar(0, snd!2);
}).add;

SynthDef("partials", { arg freq=220, amp=0.2, attack=0.01, release=1, partials=4, modulation=0;
	var env, mod, snd_blip, snd_sin, snd;
	env = EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release, level: amp), doneAction: 2);
	snd_blip = Blip.ar(freq: freq, numharm: partials, mul: env);
	snd_sin = SinOsc.ar(freq: freq, mul: env);
	snd = Mix.ar([snd_blip, snd_sin]);
	Out.ar(0, snd!2);
}).add;

)


// testing
FreqScope.new

x = Synth("partials", [\freq, [60, 64, 69, 72].midicps, \attack, 5, \release, 2, \partials, 0, \amp, 0.05]);
x.free;

"/Users/rrishi/Music/iTunes/iTunes Media/Tones/590324main_ringtone_kennedy_WeChoose.m4r"

(
{
	// C, Ab, F, G ??
	//the song is 32*4/60 = ~2.13 minutes long

	// bass
	Pbind(
		\instrument, "partials",
		\freq, Pseq([36, 44, 41, 43].midicps, 10),
		\attack, 3,
		\release, 3,
		\dur, 4,
		\partials, Pseq([Pseq([2], 4), Pseq([3], 4)], 64)
	).play;

	16.wait;

	// chords
	Pbind(
		\instrument, "partials",
		\freq, Pseq([
			[60, 63, 67, 72],	// C-Eb-G-C		cm
			[57, 63, 69, 72],	// A-C-Eb-A		a dim
			[60, 63, 67, 72],	// C-Eb-G-C		cm
			[53, 65, 69, 72],	// F-F-A-C		F
			[57, 65, 69, 72],	// A-F-F-C		F_6
			[58, 65, 70, 74],	// Bb-F-Bb-D	Bb
			[59, 67, 67, 74],	// B-G-G-D		G_6?
			[60, 67, 69, 72]	// C-G-A-C		cm6
		].midicps, 8),
		\attack, 2,
		\release, 1,
		\dur, 2,
		\partials, Pwhite(3, 7),
		\modulation, 1,
		\amp, 0.1
	).play;

	16.wait;

	// reverse
	Pbind(
		\instrument, "reverse",
		\freq, Prand([72, 64, 75, 77, 79, 80, 82, 84].midicps, 64+8),	// Cm
		\amp, 0.25,
		\attack, Pwhite(2, 4),
		\dur, Pwhite(0, 4),
		\curve, 4,
		\bus, Prand([0, [0, 1], 1], 64)
	).play;
}.fork
)

// RECORDING
s.record;
s.stopRecording;
