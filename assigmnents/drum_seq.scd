// Ryan Rishi
// B. Ruviaro
// MUSC 115
// 18 October 2013

// DRUM SEQUENCE
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// SynthDefs from Bruno
(
SynthDef("hihat", {arg amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000;
        var snd = WhiteNoise.ar(amp);
        var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
        snd = HPF.ar(snd * env, ffreq);
        Out.ar(0, snd!2);
}).add;

SynthDef("snare", {arg amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000;
        var snd1 = WhiteNoise.ar(amp);
        var snd2 = SinOsc.ar(sinfreq,0,amp);
        var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
        var sum = HPF.ar(snd1 * env, ffreq)+(snd2*env);
        Out.ar(0, sum!2);
}).add;

SynthDef("kick", {arg amp = 0.3, sinfreq = 60, glissf = 0.9, att = 0.01, rel = 0.45;
        var gliss = XLine.kr(sinfreq, sinfreq*glissf, rel);
        var snd = SinOsc.ar(gliss);
        var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
        snd = snd * env * amp;
        Out.ar(0, snd!2);
}).add;

SynthDef("kick3", {arg punch = 1, amp = 1;
    var freq = EnvGen.kr(Env([400, 66], [0.08], -3)),
        sig = Normalizer.ar(SinOsc.ar(freq, 0.5pi, punch).distort, 1) * amp
            * EnvGen.kr(Env([0, 1, 0.8, 0], [0.01, 0.1, 0.2]), doneAction: 2);
    Out.ar(0, sig ! 2);
}).add;
)

// Hip Hop drum beat
(
(
// select from here...
var user_tempo=84;
var tempo=60*(1/user_tempo);

Pbind(
	\instrument, "hihat",
	\dur, 1/4*tempo
).play;


Pbind(
	\instrument, "kick",
	\dur, Pseq([3/2*tempo, tempo, 3/4*tempo, 3/4*tempo], inf),
	\amp, 0.5,
	\sinfreq, 70,
	\att, 0.05,
	\rel, 1
).play;

Pbind(
	\instrument, "snare",
	\dur, Pseq([Rest(tempo), tempo], inf),
	\sinfreq, 280,
).play;
// ...to here.

// 6/8 Drum Beat
// (
// var user_tempo=84;                          // uncomment for just 6/8
// var tempo=60*(1/user_tempo);                // uncomment for just 6/8

Pbind(
	\instrument, "hihat",
	\dur, 1/6*tempo,
	\amp, Pseq([0.4, 0.2, 0.15], inf)
).play;

Pbind(
	\instrument, "kick",
	\dur, Pseq([5/6*tempo, tempo, 4/6*tempo, 5/6*tempo, 4/6*tempo], inf),
	\amp, 0.4,
	\sinfreq, 70,
	\att, 0.05,
	\rel, 1
).play;

Pbind(
	\instrument, "snare",
	\dur, Pseq([Rest(tempo), tempo], inf),
	\amp, 0.2,
	\sinfreq, 210
).play;

)
)

// recording
s.record;
s.pauseRecording;
s.stopRecording;