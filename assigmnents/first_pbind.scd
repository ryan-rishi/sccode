// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 16 October 2013

// FIRST PBIND
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// === HIHAT ===
(
SynthDef("hihat", { arg freq=8000, amp=0.2, attack=0.02, release=0.1, cutoff=5000, done=2, channel=0;

	var snd, env, tmp;

	env = EnvGen.kr(Env.perc(
		attackTime: attack,
		releaseTime: release,
		level: amp),
		doneAction: done);

	tmp = PinkNoise.ar(mul: env*amp/2) + WhiteNoise.ar(mul: env*amp/2);

	snd = HPF.ar(in: tmp, freq: cutoff);

	Out.ar(channel, snd);

}).add;
)

Synth("hihat");

(
Pbind(
	\instrument, "hihat",
	\dur, 0.15,
	\amp, Pseq([0.4, 0.2, 0.2, 0.2, 0.4, 0.2, 0.2, 0.2], inf),
	\cutoff, 4000,
	\channel, Pseq([1, 0, 1, 1, 0, 1, 0, 0], inf),
).play;
)



// === SLEEPING LESSONS ===

// The next Synth/Pbind is meant to sound like the beginning of "Sleeping
// Lessons" by The Shins (http://www.youtube.com/watch?v=-vm8uWFgBRc)
(
SynthDef("sleeping_lessons", { arg freq=440, amp=0.2, attack=0.05, release=1, done=2, channel=0;

	var snd, env;

	env = EnvGen.kr(Env.perc(
		attackTime: attack,
		releaseTime: release,
		level: amp),
		doneAction: done);

	snd = SinOsc.ar(
		freq: freq,
		mul: env);

	Out.ar(channel, snd);

}).add;
)

// Why is it still using a minor scale?
// How can I change the starting frequency (other than -8 in degree)?
(
Pbind(
	\instrument, "sleeping_lessons",
	\dur, 1/8,
	\scale, Scale.major,
	\degree, Pseq([1, 1, 3, 3, 5, 5, 6, 6, 7, 7, 6, 6, 5, 5, 3, 3] -8, inf),
	\amp, Pseq([0.25, 0.2], inf),
	\attack, 0.05,
	\release, 0.2,
	\channel, Pseq([0,1], inf),
).play;
)


// === begin garbage ===

// Synth("synth1");
//
// (
// Pbind(
// 	\instrument, "synth1",
// 	\dur, 0.25,
// 	\freq, Pbind(
// 		\degree, Pseq([1, 2, 3, 4, 5, 6, 7] -8, inf),
// 		\sclae, Scale.phrygian,
// 	).play;,
// 	\channel, Pseq([1, 0, 1, 1, 0, 1, 0, 0], inf),
// 	\scale, Scale.phrygian,
// ).play;
// )
//
// (
// Pbind(
// 	\instrument, "synth1",
// 	\attack, 0.05,
// 	\release, 1,
// 	\degree, Pseq([1, 2, 3, 4, 5, 6, 7, 8] -8, inf),
// 	\dur, 0.25,
// 	\scale, Scale.phrygian,
// ).play;
// )