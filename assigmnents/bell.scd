// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 11 October 2013

// BELL
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Synth using SinOsc and EnvGen
(
SynthDef("bleh", { arg freq = 440, attack = 0.1, release = 3, amp = 0.3, done = 2, channel = 0;
	var snd;
	snd = EnvGen.kr(
		Env.perc(
			attackTime: attack,
			releaseTime: release),
		doneAction: done
	) * SinOsc.ar(
		freq: Line.kr(start: freq, end: freq*0.95),
		mul: EnvGen.kr(
			Env.perc(
				attackTime: attack,
				releaseTime: release,
				level: amp),
			doneAction: done
	));
	Out.ar(channel, snd);
}).add;
)

Synth("bleh", [\freq, 880, \attack, 0.05, \release, 3, \amp, 0.6, \done, 2]);


// Bell using Klank and EnvGen

// I saw a .scd with a "Klank" sound and I liked the sound, so I made one
// myself following this documentation:
// "http://danielnouri.org/docs/SuperColliderHelp/UGens/Filters/Klank.html"

// definition
(
SynthDef("kbell", { arg root = 440, attack = 0.2, release = 3, amp = 0.3, done = 2, bus = 0;
	var snd;
	snd = Klank.ar(`[
		[root, 2*root, 5/2*root, 3*root],
		[0.4, 0.2, 0.1, 0.05],
		[	EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release)),
			EnvGen.kr(Env.perc(attackTime: 0.9*attack, releaseTime: 0.9*release), doneAction: done),
			EnvGen.kr(Env.perc(attackTime: 0.8*attack, releaseTime: 0.8*release), doneAction: done),
			EnvGen.kr(Env.perc(attackTime: 0.7*attack, releaseTime: 0.7*release), doneAction: done)],
	],
	Impulse.ar(1/release), root, 0, 1); // Is there a way to
	Out.ar(bus, snd);
}).send(s);
)

// usage
Synth("kbell", [\root, 440, \attack, 0.05, \release, 5]);
// how do I get it to sound more resonant?

//recording
s.record;
s.stopRecording;