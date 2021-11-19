Server.default.boot
Synth.new(\default);

(1..3);

(2..-2);

(5..1);

(5..5);

(1, 1.5..3);

(1,1.5..-3);

(1,0.5..-3);


(3@5);

`1;

`(1);

(
var mysound;
mysound = Synth(\default);
{mysound.release(10);}//.defer(5);
)

Env.adsr.plot;

//----------

{}; // Does not run

{}.value; // Runs

{} ! n // Runs n times and collects the result of each iteration.

{}.defer(1); // Runs after one second

{}.play; // Creates a Synth out of the function (Plays a sound)

{}.scope; // Like "play" but also opens a scope

{}.fork; // Creates a routine (Plays the function on a separate thread in its own time. Waiting between individual statements becomes possible.)

{}.loop; // Repeats the function indefinately. If the function does not include a wait statement it will crash sclang.

{}.do; //

{}.while({}); // Repeatedly runs the receiver function and the argument action as long as the receiver function returns "true"

(
var list;
list = (1..5);
list.pop;
list;
)

(
var list;
list = (5..1);
{ list.size > 0 }.while({
	list.pop.postln;
});
)
//: Alternative 1
(
var count;
count = 1;
{ count <= 5 }.while({
	count.postln;
	count = count + 1;
})
)
// Alternative 2 (using do)
5 do: { | i | postln(i + 1) };
//: Alternative 3
(1..5) do: { | i | i.postln };
//: Alternative 4
{ | i | postln(i + 1) } ! 5;









{}.respondsTo(\blah);

{}.respondsTo(\fork);

{}.respondsTo(\if);

{}.respondsTo(\while);

