// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 14 November 2013

// ROBOT CHORALE
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


// The first chunk of code is taken from Bruno Ruviaro: github.com/brunoruviaro
// sccode.org/1-4Vk

////////////////////////////////////////////
// Silly formant synthesis example.
// Using Pmono or Pbind to create a voice.
// SynthDef is hardwired to bass formants.

// Evaluate SynthDef first, then scroll down for Pmono and Pbind.

(
// SynthDef
SynthDef("sillyVoice", { arg
	freq = 220,
	amp = 0.5,
	vibratoSpeed = 6,
	vibratoDepth = 4,
	vowel = 0,
	att = 0.01,
	rel = 0.1,
	lag = 1,
	gate = 1;

	var in, vibrato, env, va, ve, vi, vo, vu, snd;

	vibrato = SinOsc.kr(vibratoSpeed, mul: vibratoDepth);
	in = Saw.ar(Lag.kr(freq, lag) + vibrato);
	env = EnvGen.kr(Env.asr(att, 1, rel), gate, doneAction: 2);

	va = BBandPass.ar(
		in: in,
		freq: [ 600, 1040, 2250, 2450, 2750 ],
		bw: [ 0.1, 0.067307692307692, 0.048888888888889, 0.048979591836735, 0.047272727272727 ],
		mul: [ 1, 0.44668359215096, 0.35481338923358, 0.35481338923358, 0.1 ]);

	ve = BBandPass.ar(
		in: in,
		freq: [ 400, 1620, 2400, 2800, 3100 ] ,
		bw: [ 0.1, 0.049382716049383, 0.041666666666667, 0.042857142857143, 0.038709677419355 ],
		mul: [ 1, 0.25118864315096, 0.35481338923358, 0.25118864315096, 0.12589254117942 ]);

	vi = BBandPass.ar(
		in: in,
		freq: [ 250, 1750, 2600, 3050, 3340 ] ,
		bw: [ 0.24, 0.051428571428571, 0.038461538461538, 0.039344262295082, 0.035928143712575 ],
		mul: [ 1, 0.031622776601684, 0.15848931924611, 0.079432823472428, 0.03981071705535 ] );

	vo = BBandPass.ar(
		in: in,
		freq:[ 400, 750, 2400, 2600, 2900 ] ,
		bw: [ 0.1, 0.10666666666667, 0.041666666666667, 0.046153846153846, 0.041379310344828 ],
		mul: [ 1, 0.28183829312645, 0.089125093813375, 0.1, 0.01 ]);

	vu = BBandPass.ar(
		in: in,
		freq: [ 350, 600, 2400, 2675, 2950 ],
		bw: [ 0.11428571428571, 0.13333333333333, 0.041666666666667, 0.044859813084112, 0.040677966101695 ],
		mul: [ 1, 0.1, 0.025118864315096, 0.03981071705535, 0.015848931924611 ]);

	snd = SelectX.ar(Lag.kr(vowel, lag), [va, ve, vi, vo, vu]);
	snd = Mix.new(snd);
	Out.ar(0, snd!2 * env * amp);
}).add;
)


// Play around with these examples/
// Vowels a e i o u correspond to number 0 1 2 3 4

// Example 1
(
Pmono(
	"sillyVoice",
	\note, Pseq([5, 7, 9, 11], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.61, 1.7),
	\amp, 0.2,
	\vibratoSpeed, Pwhite(6,7),
	\vibratoDepth, 4,
	\vowel, Pwrand([0, 2], [0.8, 0.2], inf),
	\lag, 0.5
).play;
)

// Example 2
(
Pmono(
	"sillyVoice",
	\note, Pseq([-5, -3, -1, 0], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.61, 1.7),
	\amp, 0.2,
	\vibratoSpeed, Pwhite(6,7),
	\vibratoDepth, 4,
	\vowel, Pwrand([0, 1], [0.8, 0.2], inf),
	\lag, 0.5
).play;
)

// Example 3
(
Pbind(
	\instrument, "sillyVoice",
	\note, Prand([0, 5, 7, 9], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.61, 1.7),
	\amp, 0.2,
	\vibratoSpeed, Pwhite(6,8),
	\vibratoDepth, 4,
	\vowel, Pwrand([0, 1], [0.8, 0.2], inf),
	\legato, 1,
	\att, 1.1,
	\rel, 2.5
).play;
)

// (end Bruno's code)

// RYAN
// This plays Es ist ein Ros entsprungen
(
~soprano = [72, 72, 72, 74, 72, 72, 69, 70, 69, 67, /*EOFL (tied)*/ 65, 64, 65, 72, 72, 72, 74, 72, 72, 69, /*EO2L*/ 70, 69, 67, 65, 64, 65, /*EO3L*/ /*rest --> */ \rest, 69, 67, 64, 65, 62, 60, 62, 64, /*rest -->*/ \rest, 72, 72, 72, 74, 72, 72, 69, /*EO4L*/ 70, 69, 67, 65, 64, 65];
~sop_dur = [4, 2, 2, 2, 2, 4, 4, 4, 2, /*tied note -->*/ 4, /*EO1L*/ 4, 2, 4, 4, 2, 2, 2, 2, 4, 4, /*EO2L*/ 4, 2, 4, 4, 2, 4, /*EO3L*/ /*rest -->*/ 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 4, 4, /*EO4L*/ 4, 2, 4, 4, 2, 4];

~alto = [ 69, 69, 65, 65, 65, 64, 62, 62, 60, /*EO1L*/ 62, 57, 60, 60, 69, 69, 65, 65, 65, 64, 62, /*EO2L*/ 62, 60, 62, 57, 60, 60, /*EO3L*/ \rest, 65, 62, 60, 60, 59, 60, \rest, 64, 67, 65, 65, 65, 64, 62, /*EO4L*/ 62, 65, 62, 64, 65, 67, 60, 60 ];
~alto_dur = [4, 2, 2, 2, 2, 4, 4, 4, 4, /*EO1L*/ 3, 1, 4, 4, 4, 2, 2, 2, 2, 4, 4, /*EO2L*/ 4, 4, 3, 1, 4, 4, /*EO3L*/ /*rest --> */ 2, 2, 2, 2, 2, 2, 4, /*rest --> */ 2, 2, 2, 2, 2, 2, 4, 4, /*EO4L*/ 4, 2, 2, 2, 2, 2, 2, 4];

~tenor = [60, 60, 57, 58, 57, 55, 53, 53, 57, 60, /*EO1L*/ 58, 57, 55, 57, 60, 60, 57, 58, 60, 55, 53, /*EO2L*/ 53, 57, 60, 58, 57, 55, 57, /*EO3L*/ \rest, 60, 58, 57, 57, 55, 57, \rest, 55, 55, 57, 58, 57, 55, 54, /*EO4L*/ 55, 60, 58, 57, 55, 57];
~teno_dur = [4, 2, 2, 2, 2, 4, 4, 4, 2, 2, /*EO1L*/ 2, /*tie --> */ 4, 2, 4, 4, 2, 2, 2, 2, 4, 4, /*EO2L*/ 4, 2, 2, 2, 4, 2, 4, /*EO3L*/ 2, 2, 2, 2, 2, 2, 4, 2, 2, 2, 2, 2, 2, 4, 4, /*EO4L*/ 4, 2, 2, 4, 4, 4];

~bass = [53, 53, 53, 58, 53, 48, 50, 46, 53, 52, /*EO1L*/ 50, 48, 41, 53, 53, 53, 58, 53, 48, 50, /*EO2L*/ 46, 53, 52, 50, 48, 41, /*EO3L*/ /*rest -->*/ \rest, 53, 55, 57, 53, 55, 48, /*rest -->*/ \rest, 48, 52, 53, 46, 53, 48, 50, /*EO4L*/ 43, 45, 46, 48, 48, 41];
~bass_dur = [4, 2, 2, 2, 2, 4, 4, 4, 2, 2, /*EO1L*/ 4, 4, 4, 4, 2, 2, 2, 2, 4, 4, /*EO2L*/ 4, 2, 2, 4, 4, 4, /*EO3L*/ /*rest -->*/ 2, 2, 2, 2, 2, 2, 4, /*rest -->*/ 2, 2, 2, 2, 2, 2, 4, 4, /*EO4L*/ 4, 2, 2, 4, 4, 4];
)

(
// soprano
Pbind(
	\instrument, "sillyVoice",
	\midinote, Pseq(~soprano, 1),
	\dur, Pseq(~sop_dur/2, 1),
	\rel, Pwhite(1, 1.2),
	\vowel, Prand([0, 1, 2, 3, 4], inf),
	\amp, 0.4
).play;
// alto
Pbind(
	\instrument, "sillyVoice",
	\midinote, Pseq(~alto, 1),
	\dur, Pseq(~alto_dur/2, 1),
	\rel, Pwhite(1, 1.2),
	\vowel, Prand([0, 1, 2, 3, 4], inf),
	\amp, 0.4
).play;
// tenor
Pbind(
	\instrument, "sillyVoice",
	\midinote, Pseq(~tenor, 1),
	\dur, Pseq(~tenor_dur, 1),
	\rel, Pwhite(1, 1.2),
	\vowel, Prand([0, 1, 2, 3, 4], inf),
	\amp, 0.4
).play;
// bass
Pbind(
	\instrument, "sillyVoice",
	\midinote, Pseq(~bass, 1),
	\dur, Pseq(~bass_dur/2, 1),
	\rel, Pwhite(1, 1.2),
	\vowel, Prand([0, 1, 2, 3, 4], inf),
	\amp, 0.4
).play;
)

// recording
s.record;
s.stopRecording;