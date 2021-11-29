Env.new(levels: [0, 1, 0.9, 0], times: [0.1, 0.5, 1], curve: [-5, 0, -5]).plot;

(
{
    EnvGen.kr(
        Env(
            levels: [0, 0.1, 0.2, 0.3],
            times: [0.1, 0.1, 0.1],
            curve: 15
        ),
        gate: Impulse.kr(3)
    );
}.plot(duration: 1);
)

// an envelope in a synth
(
{
    var env = Env([0, 1, 0.5, 1, 0], [0.01, 0.5, 0.02, 0.5]);
    SinOsc.ar(470) * EnvGen.kr(env, doneAction: Done.freeSelf)
}.play
)
// an envelope to control a parameter in a pattern
(
Pbind(
    \note,  Env([0, 12, 6, 13, 0], [1, 5, 2, 10]),
    \dur, 0.1
).play
)

Env([0, 1, 0], [1, 1], \lin).plot;
Env([0, 1, 0], [1, 1], \sine).plot;
Env([0, 1, 0], [1, 1], \step).plot;
Env([0, 1, 0], [1, 1], \hold).plot;

Env([0, 1, 0], [1, 1], [1, 1]).plot;
Env([0, 1, 0], [1, 1], [10, 10]).plot;
Env([0, 1, 0], [1, 1], [10, -10]).plot;
Env([0, 1, 0], [1, 1], [-10, 10]).plot;

Env([0, 1, 0], [1, 1], \lin).test;
Env([0, 1, 0], [1, 1], \sine).test;
Env([0, 1, 0], [1, 1], [1, 1]).test;
Env([0, 1, 0], [1, 1], [10, 10]).test;
Env([0, 1, 0], [1, 1], [10, -10]).test;
Env([0, 1, 0], [1, 1], [-10, 10]).test;

{ SinOsc.ar(Env([400, 1200, 400], [1, 1], \lin).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;
{ SinOsc.ar(Env([400, 1200, 400], [1, 1], \sine).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;
{ SinOsc.ar(Env([400, 1200, 400], [1, 1], [1, 1]).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;
{ SinOsc.ar(Env([400, 1200, 400], [1, 1], [10, 10]).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;
{ SinOsc.ar(Env([400, 1200, 400], [1, 1], [10, -10]).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;
{ SinOsc.ar(Env([400, 1200, 400], [1, 1], [-10, 10]).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;
{ SinOsc.ar(Env([400, 1200, 400], [1, 1], \step).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;
{ SinOsc.ar(Env([400, 1200, 400], [1, 1], \hold).kr(doneAction: 2, timeScale: 2), 0, 0.1).dup }.play;

Env([0, 1, 0], [1, 1], \lin).test;
Env([0, 1, 0], [1, 1], \sine).test;
Env([0, 1, 0], [1, 1], [1, 1]).test;
Env([0, 1, 0], [1, 1], [10, 10]).test;
Env([0, 1, 0], [1, 1], [10, -10]).test;
Env([0, 1, 0], [1, 1], [-10, 10]).test;


Env([0, 1, 0], [1, 1], \lin).test;

(
{

}
)

Env([0, 1, 0], [1, 1], \sine).plot;
Env([0, 1, 0], [1, 1], \sine).test;

(

)
