(

var env = EnvGen.kr(Env.adsr(attackTime: 0.05, decayTime: 0.1, sustainLevel: 0.2, releaseTime: 3, peakLevel: 0.8), doneAction: 2);
{ SinOsc.ar(freq: 200, mul: env) + SinOsc.ar(freq: 600, mul: env)}.play;
{ SinOsc.ar(freq: 600, mul: 0.5)}.play;

)

(
SynthDef("bass", { arg attack=0.05, decay=0.1, susLevel=0.4, release=3, amp=0.5, freq=55 /*,vibrato=1*/;
	var env, pluck, /*vibrato_int,*/ snd;

	env = EnvGen.kr(Env.adsr(attackTime: attack, decayTime: decay, sustainLevel: Decay.ar(Impulse.ar(freq: 1, mul: susLevel), 0.2), releaseTime: release, peakLevel: amp), doneAction: 2);
	pluck = SinOsc.ar(freq: freq*2, mul: EnvGen.kr(Env.perc(attackTime: attack, releaseTime: release, level: amp*0.7), doneAction: 2));
	// vibrato_int = SinOsc.kr(freq: freq, mul: vibrato);
	snd = /*pluck + */SinOsc.ar(freq: freq, mul: env) + SinOsc.ar(freq: freq*2, mul: env/2);

	Out.ar(0, snd!2);
}).add;
)

Synth("bass", [\freq, 55]);
{SinOsc.ar(freq: [440, 450], mul: 0.4)}.play;



(
Pbind(
	\instrument, "bass",
	\freq, Pseq([55, 80], inf),
	\amp, 0.4,
).play;
)

// plot
(
{ SinOsc.kr(
	freq: 110,
	mul: SinOsc.kr(
		freq: SinOsc.kr(
			freq: 110,
			mul: 1),
		mul: 1)
)}.play;
)


{ SinOsc.ar( freq: 110*2, mul: EnvGen.kr(Env.perc(attackTime: 0.05, releaseTime: 3, level: 0.2), doneAction: 2)) + SinOsc.ar(freq: 110, mul: EnvGen.kr(Env.adsr(attackTime: 0.05, decayTime: 0.1, sustainLevel: 0.2, releaseTime: 3, peakLevel: 0.5))) + SinOsc.ar(freq: 110*2, mul: EnvGen.kr(Env.adsr(attackTime: 0.05, decayTime: 0.1, sustainLevel: 0.2, releaseTime: 3, peakLevel: 0.5), doneAction: 2)) }.play;

{ EnvGen.kr(Env.perc)}.plot;

{Line.kr(0.5, 0, 3)}.plot;

{ Decay.ar(0, 1, 1, 0)}.plot;

plot({Decay.ar(Impulse.ar(freq: 1, mul: 0.4), 0.01)});