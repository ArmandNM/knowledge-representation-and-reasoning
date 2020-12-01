main:-
    open('clauses.txt', read, InputFile),
    read(InputFile, Clauses),
    close(InputFile),
    write(Clauses),

    (found_empty_clause(Clauses) -> write('Satisfiable');
        solve(Clauses, Clauses, Clause1, Clause2, Result),
        write(Clause1),
        write(Clause2),
        write('-----------'),
        write(Result),
        write('\n\n##########\n\n'),
        (Result == [] -> write('Unsatisfiable.');
            append(Result, Clauses, UpdatedClauses),
            open('clauses.txt', write, OutputFile),
			write(OutputFile, UpdatedClauses),
			write(OutputFile, '.'),
			close(OutputFile),
            main)).

found_empty_clause(Clauses):-
    member([], Clauses).

solve([], _, _, _, []).
solve([HClause | TClauses], OriginalClauses, Clause1, Clause2, Result):-
    find_matching_clause(HClause, TClauses, SelectedClause, SelectedTerm),

    (not(SelectedClause == []) -> Clause1 = HClause,
                                  Clause2 = SelectedClause,
                                  resolve(Clause1, Clause2, SelectedTerm, Result),
                                  [HResult | _] = Result,
                                  not(member(HResult, OriginalClauses)),
                                  !;
                                  solve(TClauses, OriginalClauses, Clause1, Clause2, Result)).

find_matching_clause(_, [], [], []).
find_matching_clause(Clause, [HClause | TClauses], SelectedClause, SelectedTerm):-
    can_resolve(Clause, HClause, CandidateSelectedTerm),

    (not(CandidateSelectedTerm == []) -> SelectedClause = HClause,
                                         SelectedTerm = CandidateSelectedTerm,
                                         !;
                                         find_matching_clause(Clause, TClauses, SelectedClause, SelectedTerm)).

can_resolve([], _, []).
can_resolve([HTerm | TTerm], Clause2, SelectedTerm):-
    negation(HTerm, NotHTerm),
    (member(NotHTerm, Clause2) -> SelectedTerm = HTerm,
                                  !;
                                  can_resolve(TTerm, Clause2, SelectedTerm)).

resolve(Clause1, Clause2, SelectedTerm, [Result]):-
    negation(SelectedTerm, NotSelectedTerm),
    delete(Clause1, SelectedTerm, UpdatedClause1),
    delete(Clause2, NotSelectedTerm, UpdatedClause2),
    append(UpdatedClause1, UpdatedClause2, Reunion),
    sort(Reunion, Result).


negation(X, NotX):-
    term_to_atom(X, XAtom),
    atom_chars(XAtom, XChars),
    not(is_negated(XChars)),
    NotX = n(X),
    !.

negation(X, NotX):-
    term_to_atom(X, XAtom),
    atom_chars(XAtom, XChars),
    is_negated(XChars),
    atom_length(XAtom, Length),
    DesiredLeength is Length - 3,
    sub_atom(XAtom, 2, DesiredLeength, _, NotXAtom),
    term_to_atom(NotX, NotXAtom),
    !.

is_negated([FirstChar, SecondChar | RestChars]):-
    FirstChar == 'n',
    SecondChar == '(',
    last(RestChars, LastChar),
    LastChar == ')'.