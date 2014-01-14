(
SynthDef("granular_sampling", {arg trigger = 0, graindur = 0.2, sndbuf, transp = 1, pos = 0, pan = 0, envbuf = -1, amp = 1, gate = 1;
	var env, snd;
	env = EnvGen.kr(Env.asr, gate, levelScale: amp, doneAction: 2);
	snd = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.kr(trigger),
		dur: graindur,
		sndbuf: sndbuf,
		rate: transp,
		pos: pos,
		pan: pan,
		envbufnum: envbuf);
	Out.ar(0, snd * env);
}).add;
)

// sound files must be mono
b = Buffer.read(s, "/Users/rrishi/Documents/SCU/2 1 Fall 2013/MUSC 115/SCC/samples/such-great-heights-mono.wav");
x = Buffer.readChannel(s, "/Users/rrishi/Documents/SCU/2 1 Fall 2013/MUSC 115/SCC/samples/mom-voicemail.wav", channels: [0]);
p = Buffer.read(s, "/Users/rrishi/Documents/SCU/2 1 Fall 2013/MUSC 115/SCC/samples/peace-piece-mono.wav");
x.numChannels	// display number of channels for selected file
(
SynthDef("play", { arg file;
	var snd = PlayBuf.ar(1, file);
	Out.ar(0, snd!2);
}).add;
)
Synth("play", [\file, x]);


// to read one channel of stereo file:
a = Buffer.readChannel(s, "/Users/rrishi/Documents/SCU/2 1 Fall 2013/MUSC 115/SCC/samples/mom-voicemail.wav", channels: [0]);
a.play;
(
Pbind(
	\instrument, "granular_sampling",
	\trigger, 0, // zero means 1 note = 1 grain. Get thicker with  higher numbers.
	\graindur, Pwhite(0, 2), // try different grain durations
	\sndbuf, a, // choose sound filef
	\transp, 1, // transpose!
	\pos, Pseq([0.5, 0.2, 0.3, 0.6], inf),//Pwhite(0, 1), // position in the sound to read
	\pan, 0, //Pwhite(-1, 1), // left to right speakers (-1 to 1)
	\amp, 1,//Pwhite(0.5, 0.7), // amplitude
	\envbuf, 0.4, // -1 is just the default grain envelope
	\dur, Pwhite(0, 1/50); // duration of Pbind notes
).play;
)

[Pwhite(0, 1)!100]
[0....10]

(
Pbind(
	\midinote, Prand([35, 70], inf),
	\dur, Pseq([1, ((Pwhite(0, 1))!50)], 8),
).play;
)