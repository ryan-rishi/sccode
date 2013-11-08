// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 2013 November 8

// ASSIGNMENT 5 - KARPLUS-STRONG TUTORIAL / MINI-SONG USING PLUCK
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

(
// "pluck" from Bruno
SynthDef("pluck", {arg amp = 0.1, freq = 440, decay = 5, coef = 0.1, impulse=0;
	var env, snd;
	env = EnvGen.kr(Env.linen(0, decay, 0), doneAction: 2);
	snd = Pluck.ar(
		in: WhiteNoise.ar(amp),
		trig: Impulse.kr(impulse),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: decay,
		coef: coef);
	Out.ar(0, [snd, snd]);
}).add;

SynthDef("blah", {arg freq = 440, amp = 0.2, tempo = 60;
	var env, snd;
	env = EnvGen.kr(Env.perc(attackTime: tempo/2, releaseTime: tempo/2, level: amp, curve: 4), doneAction: 2);
	snd = SinOsc.ar(freq: freq, mul: env);
	Out.ar(0, snd!2);
}).add;
)

(
Pbind(
	\instrument, "pluck",
	\midinote, Prand([Prand([57, 59, 60, 62, 64, 65, 68, 69], 1)+(12*Prand([-4, -3, -2, -1, 0, 1, 2, 3], 1))], inf),
	\impulse, Pwhite(0, 20),
	\dur, 2
).play;
)


// testing
(
Pbind(
	\instrument, "blah",
	\midinote, Pseq([
		[62, 65, 69],
		[62, 65, 70],
		[60, 65, 69],
		[61, 64, 69]
	], inf),
	\dur, 4
).play;
)

// actual
(
{
	var user_tempo = 120;
	var tempo = 60*(1/user_tempo);

	Pbind(
		\instrument, "blah",
		\midinote, Pseq([
			[62, 65, 69],
			[62, 65, 70],
			[60, 65, 69],
			[61, 64, 69]
		], inf),
		\dur, tempo,
		\tempo, tempo
	).play;

	(
		Pbind(
			\instrument, "pluck",
			\midinote, Pseq([
				Pseq([[62, 65, 69]], 4),		// dm
				Pseq([[62, 65, 70]], 4),		// Bb
				Pseq([[60, 65, 69]], 4),		// F
				Pseq([[61, 64, 69]], 4)		// A
			], inf),
			\dur, tempo/4, 				// 16th notes
			\coef, 0.5
		).play;
	);

	(tempo*8).wait;

	Pbind(
		\instrument, "pluck",
		\midinote, Pseq([
			Pser([62, 65, 69], 8),
			Pser([62, 65, 70], 8),
			Pser([60, 65, 69], 8),
			Pser([61, 64, 69], 8)
		], inf),
		\dur, tempo/8,
		\coef, 0.3
	).play;

}.fork;
)


// recording
s.record;
s.stopRecording;