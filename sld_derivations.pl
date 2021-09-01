:- consult(utils).

main_sld_backwards:-
    open('C:\\Master\\KRR\\krr\\test.txt', read, InputFile),
    read(InputFile, Clauses),
    read(InputFile, Questions),
    close(InputFile),
    write(Clauses), write('\n\n'), write(Questions), write('\n'),
    solve(Clauses, Questions).

get_negative_literals(Clause, NegativeLiterals):-
    include([In]>>is_atom_negated(In), Clause, FilteredLiterals),
    maplist([In, Out]>>negation(In, Out), FilteredLiterals, NegativeLiterals).

solve(_, Questions):-
    not(member(_, Questions)).

solve(KB, Questions):-
    [Q1|TailQuestion] = Questions,
    select(Clause, KB, _),
    member(Q1, Clause),
    get_negative_literals(Clause, NegativeLiterals),
    append(TailQuestion, NegativeLiterals, LiteralsReunion),
    sort(LiteralsReunion, NewQuestions),
    solve(KB, NewQuestions).