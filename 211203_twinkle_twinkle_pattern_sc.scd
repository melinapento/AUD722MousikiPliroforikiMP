// fork variations
//
(
{
	var sound1;
	sound1 = { SinOsc.ar(261.63, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(261.63, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(392, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(392, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(440, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(440, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(392, 0, 0.1).dup }.play;
	1.5.wait;
	sound1.release;
	sound1 = { SinOsc.ar(349.23, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(349.23, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(329.63, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(329.63, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(293.66, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(293.66, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	sound1 = { SinOsc.ar(261.63, 0, 0.1).dup }.play;
	1.5.wait;
	sound1.release;
}.fork;

)

60.midicps;

(
{
	var pattern, longNote;
	pattern = { | note = 60 |
		var frequency, synth;
		frequency = note.midicps;
		2 do: {
			synth = Synth("sine", [freq: frequency]);
			1.wait;
			synth.release(0.01);
		}
	};
		longNote= { | note = 60 |
		var frequency, synth;
		frequency = note.midicps;
		synth = Synth("sine", [freq: frequency]);
		2.wait;
		synth.release(0.01);

	};
	2 do: {
	pattern.(60);
	pattern.(67);
	pattern.(69);
	longNote.(67);
	pattern.(65);
	pattern.(64);
	pattern.(62);
	longNote.(60);
	}
}.fork;



)


//: Variant using synthdef
//: 1: define a synthdef and add it to the server.
(
SynthDef("sine", { | freq = 440, amp = 0.1 |
	var src, env;
	src = SinOsc.ar(freq, 0, amp);
	env = Env.adsr;
	Out.ar(0, src.dup * env.kr(gate: \gate.kr(1), doneAction: 2))
}).add;
)
//: 2: Test the synthdef;
{
	var synth;
	synth = Synth("sine");
	1.wait; // wait for 1 second
	synth.release;
}.fork;
//: The yield message stops a routine until it receives "next".
(
r = {
	var synth;
	synth = Synth("sine");
	\anything.yield; // stay here until receiving "next"
	synth.release;
}.fork
)
//: Run this line to release the synth:
r.next;
//==================== repeat a note many times
//:
(
{
	var note;
	note = { // this function plays a note.
		var synth;
		synth = Synth("sine");
		1.wait; // wait for 1 second
		synth.release;
	};
	// run the note function 5 times.
	5 do: {
		note.value;
		0.2.wait;
	}
}.fork
)

//==================== repeat a note in different frequencies.
//:
(
{
	var note;
	note = { | freq = 440 |
		var synth;
		synth = Synth("sine", [freq: freq]);
		0.1.wait; // wait for 1 second
		synth.release;
	};
	// run the note function 5 times.
	5 do: { | i |
		note.((60 + i).midicps);
		0.2.wait;
	};
}.fork
)

//: earlier example, using functions instead of synthdefs.
//
(
{
	var sound1, sound2;
	sound1 = { SinOsc.ar(400, 0, 0.1).dup }.play;
	1.wait;
	sound1.release;
	0.1.wait;
	sound1 = { SinOsc.ar(800, 0, 0.1).dup }.play;
	0.5.wait;
	sound1.release;
}.fork;
)
