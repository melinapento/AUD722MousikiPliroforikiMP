(
SynthDef(\paulstretchMono, { |out = 0, bufnum, envBufnum, pan = 0, stretch = 50, window = 0.25, amp = 1, rate = 1 |
	// Paulstretch for SuperCollider
	// Based on the Paul's Extreme Sound Stretch algorithm by Nasca Octavian PAUL
	// https://github.com/paulnasca/paulstretch_python/blob/master/paulstretch_steps.png
	//
	// By Jean-Philippe Drecourt
	// http://drecourt.com
	// April 2020
	//
	// Arguments:
	// out: output bus (stereo output)
	// bufnum: the sound buffer. Must be Mono. (Use 2 instances with Buffer.readChannel for stereo)
	// envBufnum: The grain envelope buffer created as follows:
	//// envBuf = Buffer.alloc(s, s.sampleRate, 1);
	//// envSignal = Signal.newClear(s.sampleRate).waveFill({|x| (1 - x.pow(2)).pow(1.25)}, -1.0, 1.0);
	//// envBuf.loadCollection(envSignal);
	// pan: Equal power panning, useful for stereo use.
	// stretch: stretch factor (modulatable)
	// window: the suggested grain size, will be resized to closest fft window size
	// amp: amplification
	var trigPeriod, sig, chain, trig, pos, fftSize;
	// Calculating fft buffer size according to suggested window size
	fftSize = 2**floor(log2(window*SampleRate.ir));
	// Grain parameters
	// The grain is the exact length of the FFT window
	trigPeriod = fftSize/SampleRate.ir;
	trig = Impulse.ar(1/trigPeriod);
	pos = Demand.ar(trig, 0, demandUGens: Dseries(0, trigPeriod/stretch));
	// Extraction of 2 consecutive grains
	// Both grains need to be treated together for superposition afterwards
	sig = [GrainBuf.ar(1, trig, trigPeriod, bufnum, rate, pos, envbufnum: envBufnum),
		GrainBuf.ar(1, trig, trigPeriod, bufnum, rate, pos + (trigPeriod/(2*stretch)), envbufnum: envBufnum)]*amp;
	// FFT magic
	sig = sig.collect({ |item, i|
		chain = FFT(LocalBuf(fftSize), item, hop: 1.0, wintype: -1);
		// PV_Diffuser is only active if its trigger is 1
		// And it needs to be reset for each grain to get the smooth envelope
		chain = PV_Diffuser(chain, 1 - trig);
		item = IFFT(chain, wintype: -1);
	});
	// Reapply the grain envelope because the FFT phase randomization removes it
	sig = sig*PlayBuf.ar(1, envBufnum, 1/(trigPeriod), loop:1);
	// Delay second grain by half a grain length for superposition
	sig[1] = DelayC.ar(sig[1], trigPeriod/2, trigPeriod/2);
	// Panned output
	Out.ar(out, Pan2.ar(Mix.new(sig), pan));
}).add;
)

// Example
(
{
	var envBuf, envSignal, buffer;
	buffer = Buffer.read(s,Platform.userHomeDir +/+ "Music/mono_01.wav");
	// The grain envelope
	envBuf = Buffer.alloc(s, s.sampleRate, 1);
	envSignal = Signal.newClear(s.sampleRate).waveFill({|x| (1 - x.pow(2)).pow(1.25)}, -1.0, 1.0);
	envBuf.loadCollection(envSignal);
	s.sync();
	// Runs indefinitely
	Synth(\paulstretchMono, [\bufnum, buffer.bufnum, \envBufnum, envBuf.bufnum]);
}.fork;
)

// Example 2: changing the stretch parameter
(
{
	var envBuf, envSignal, buffer;
	buffer = Buffer.read(s, Platform.userHomeDir +/+ "Music/mono_01.wav");
	// The grain envelope
	envBuf = Buffer.alloc(s, s.sampleRate, 1);
	envSignal = Signal.newClear(s.sampleRate).waveFill({|x| (1 - x.pow(2)).pow(1.25)}, -1.0, 1.0);
	envBuf.loadCollection(envSignal);
	s.sync();
	// Runs indefinitely
	~paulStretch1 = Synth(\paulstretchMono, [\bufnum, buffer.bufnum, \envBufnum, envBuf.bufnum]);
	"playing with default stretch = 50".postln;
}.fork;
)

~paulStretch1.set(\stretch, 4);
~paulStretch1.set(\stretch, 3);
~paulStretch1.set(\stretch, 30);

~paulStretch1.set(\rate, 2.5);
(
r = {
	loop {
		~paulStretch1.set(\rate, 0.15 rrand: 3.5);
		5.wait;
	}
}.fork;
)

r;


r.stop;

~paulStretch1.set(\stretch, 2);
~paulStretch1.set(\stretch, 1);
~paulStretch1.set(\stretch, 0.5);
~paulStretch1.set(\stretch, 300);


~paulStretch1.set(\stretch, 15);
~paulStretch1.set(\window, 4);

(
q = {
	100 do: { | count |
		postf("counting! : %\n", count);
		1.wait;
	}
}.fork;
)

l = [30, 35, 5, 10, 25];
l = l add: l.last;
d = [0] ++ [10, 20, 1, 50, 52];

[l, d].flop;

[d, l].flop;



l add: 10000;
l.last;
l add: l.last;

(
q = {
	var durations, levels, totalDuration;
	totalDuration = 300;
	durations = [30, 35, 5, 10, 25];
	levels =    [70, 30, 50, 15, 2];
	durations = [0] ++ durations.normalizeSum * totalDuration;
	levels = levels add: levels.last;
	[durations, levels].flop; do: { | dl |
		postf("duration: %, level %\n", dl[0], dl[1]);
		dl[0].wait;
		~paulStretch1.set(\stretch, dl[1]);
	}
}.fork;
)



//:
a = [30, 35, 5, 10, 25];
n = a * (300 / a.sum);
n.sum;
// TRICK!
n = a.normalizeSum * 300;
n.sum;

a.normalizeSum


[30, 5, 70]
[1, 2, 1]

[[0, 30], [4, 10], [0.5, 20]]






//:
(
q = {
	[30, 35, 5, 10, 25] do: { | count |
		postf("counting! : %\n", count);
		1.wait;
	};
	"SCORE FINISHED!".postln;
}.fork;
)

(
q = {
	[30, 35, 5, 10, 25] do: { | count |
		postf("counting! : %\n", count);
		1.wait;
	};
	"SCORE FINISHED!".postln;
}.fork;
)



q.stop;
q.reset;
q.resume;
q.play;


q.reset.play;


//:
(
b = Bus.control;
{
	var src;
	src = SinOsc.kr(10.reciprocal).range(0.5, 1.5);
	Out.kr(b.index, src);
}.play;
)

(
b = Bus.control;
{
	var src;
	src = LFNoise2.kr(3.reciprocal).range(0.15, 2.5);
	Out.kr(b.index, src);
}.play;
)

Server.default.scope

//:
~paulStretch1.map(\rate, b.index);

(Platform.userHomeDir +/+ "Music/01-211027_1436.wav").pathMatch

c = Buffer.read(s,Platform.userHomeDir +/+ "Music/01-211027_1436.wav");

c

b.play

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
b

d = Buffer.read(s,Platform.userHomeDir +/+ "Music/mono.wav");
d

