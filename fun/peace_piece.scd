/* This is just a little routine I wrote to play "Piece Peace" by Bill Evans.
It's still pretty rough, but I'm just playing around with it.
Like everything else, press ctrl + b to boot the server, then evaluate
the SynthDef (ctrl + enter), and then play the pbinds (ctrl + enter).
Press ctrl + . to stop all sounds.

Copyright 2013 Ryan Rishi
2013 October 22
*/
(
SynthDef("pp_bass", {arg freq=440, amp=0.2, attack=0.05, release=2;
	var snd, env;
	env = EnvGen.kr(Env.perc( attackTime: attack, releaseTime: release, level: amp), doneAction: 2);
	snd = SinOsc.ar(freq: freq, mul: env);
	Out.ar(0, snd);
}).add;
)


// bass
(
{
var user_tempo=46;
var tempo=60*(1/user_tempo);
Pbind(\instrument, "pp_bass",
	\dur, 	Pseq([Pseq([1/2, 3]*tempo, 1), Pseq([1, 3]*tempo, inf)], inf),
	\degree, Pseq([5, 1]-8, inf),
	\amp, 0.2,
	\attack, 0.12,
	\release, 2
).play;

// piano
(tempo*1/2).wait;
Pbind(
	\dur, Pseq([Rest(tempo), tempo, tempo, Rest(tempo)], inf),
	\amp, 0.1,
	\degree, Pseq([
		[-3, -2, 0, 3],
		[-1, 0, 2]
		// [0, 8, 8, 0],
		// [0, 8, 6, 0],
		// [0, 7, 5, 0]], inf)
	], inf),
	\scale, Scale.major,
).play;
}.fork;
)
)
