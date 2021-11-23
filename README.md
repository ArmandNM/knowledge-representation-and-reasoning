# Knowledge Representation and Reasoning

Assignments for the Knowledge Representation and Reasoning class taught at the Artificial Intelligence master program at University of Bucharest. All implementations are done in **Prolog**.

### Assignment 1 - Resolution
S is a finite set of propositional clauses, written in CNF in the format \[[w, s, n(p)], [a, n(w), r, t], [q]]. With n(p) the negation of p is noted.

- Implement the Resolution procedure. For the input data S, the procedure will display SATISFIABLE, respectively UNSATISFIABLE, as it is the case. Set  strategy for choosing which pair of clauses to use when Resolution rule is applied.

The input data will be read from a file and the results will be displayed in a file.

The procedure will be implemented in the version presented at the course (from Ronald Brachman, Hector Levesque. Knowledge representation and reasoning, Morgan Kaufmann 2004).

Suggestion for implementation:

```Prolog
res(KB) :- member([], KB).
res(KB) :- …choose two clauses from KB, apply Resolution, add the Resolvent (if new) to KB
=>newKB…, res(newKB).
```

### Assignment 2 - Davis-Putnam SAT procedure
S is a finite set of propositional clauses, written in CNF in the format \[\[w, s, n(p\)], [a, n(w), r, t], [q]]. With n(p) the negation of p is noted.

- Implement the Davis-Putnam SAT procedure. For the input data S, the procedure will display YES, respectively NOT, as S is satisfiable or not. In the case of YES, the procedure will also display the truth values assigned to the literals (i.e. the solution {w/true; s/false; p/false ...}). Choose two strategies of selection of the atom to perform the • operation and compare the results.

The input data will be read from a file and the results will be displayed in a file.

The procedure will be implemented in the version presented at the course (from Ronald Brachman, Hector Levesque. Knowledge representation and reasoning, Morgan Kaufmann 2004).

Suggestion for implementation:

```Prolog
dp([],[]).
dp(L,_):-member([],L),!,fail.
dp(L,[C/A|S]):- … choose the atom C, perform the • operation for C; respectively for n(C) … in
both cases, for the resulting list of clauses, L1… dp(L1,S).
```

### Assignment 3 - Horn Reasoning
The following rules and questions are given:

Rules:
- If patient has cough and patient has infection then patient has pneumonia.
- If temperature is more than 38 then patient has fever.
- If patient has muscle pain and patient has fever then patient has flu.
- If patient was sick for at least 2 days and patient has fever then patient has infection.

Questions:
- What is patient temperature? (answer is a number)
- For how many days has the patient been sick? (answer is a number)
- Has patient muscle pain? (answer is yes/no)
- Has patient cough? (answer is yes/no)

1. The program interface should address the questions to the user. Based on the answers, the system will know whether or not the patient has cough, the temperature is more than 38 and patient was sick for at least 2 days and the patient has muscle pain.
2. The knowledge must be expressed as positive Horn propositional clauses, in the form \[[n(w), s, n(p)], [a, n(w), n(r), n(t)], [q]]. With n(p) the negation of p was noted (this is provided just for example).
3. Only the user’s answers will be given at the console; the KB expressed as a list of lists is read from a file.
4. Based on KB and the answers provided by the user, the system should say whether or not “patient has pneumonia” can be logically entailed. The output (of both reasoning algorithms) is written on the console.
5. The reasoning mechanisms are the backward chaining and forward chaining algorithms. Both procedures will be implemented in the versions presented at the course (from Ronald Brachman, Hector Levesque. Knowledge representation and reasoning, Morgan Kaufmann 2004).
6. The program should run (that means asking for user’s answers and providing the output) repeatedly until “stop” is written in the console.

### Assignment 4 - Vagueness, uncertainty and degrees of belief
The following rules are given:

Rules:
1. If the service is poor or the food is rancid then the tip is stingy.
2. If the service is good then the tip is normal.
3. If the service is excellent or the food is delicious then the tip is generous.

You must define the degree curves for the predicates: *poor*, *good*, *excellent*, *rancid*, *delicious*, *stingy*, *normal* and *generous*.

1. The program interface should ask the user what are his/her ratings for service and food (on a 10-point scale) and it should return a recommendation for the tip (as a percentage between 0-25).
2. We assume that the premises of a rule are connected with only one type of connector (or/and).
The rules will be represented in any format you consider appropriate.
Just as a suggestion, the rule “If the service is poor or the food is rancid then the tip is stingy” may be written as *[or , [service/poor, food/rancid] , [tip/stingy] ]*.
3. Only the user’s ratings will be given at the console; the rules must be read from a file.
4. The reasoning procedure will be implemented in the version presented at the course C8 p.23 (from Ronald Brachman, Hector Levesque. Knowledge representation and reasoning, Morgan Kaufmann 2004).
For the last step of “Defuzzification”, the aggregated degree curve may be discrete (computed only for the inputs 0, 1,…, 25).
5. The program should run (that means asking for user’s ratings and providing the output) repeatedly until “stop” is written in the console.