main(Output):-
    open('clauses.txt', read, InputFile),
    read(InputFile, Clauses),
    close(InputFile),

    (found_empty_clause(Clauses) -> write('Satisfiable');
        solve(Clauses, Clauses, Clause1, Clause2, Result),
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
    find_matching_clause(HClause, TClauses, SelectedClause),

    (not(SelectedClause == []) -> Clause1 = HClause,
                                  Clause2 = SelectedClause,
                                  resolve(Clause1, Clause2, Result),
                                  [HResult | _] = Result,
                                  not(member(HResult, OriginalClauses)),
                                  !;
                                  solve(TClauses, OriginalClauses, Clause1, Clause2, Result)).




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





% solve(_, [], _, []).
% solve([HClause, TClauses], Clause1, Clause2, Result):-
%     find_matching_clause(HClause, TClauses, SelectedClause)


%     (can_resolve(HClause, TClauses, SelectedClause) ->
%         Clause1 = HClause,
%         Clause2 = SelectedClause,
%         resolve(Clause1, Clause2, Result);
    
%         solve(TClauses, Clause1, Clause2, Result)).


% find_matching_clause(_, [], []):-
%     pass

% can_resolve(Clause, Clauses, SelectedClause):-



% pick_and_resolve(Clauses, )


% pickl([], []).
% resolution([HClause | TClauses], ResultedClause):-


% resolve(Clause1, Clause2, Result):-
%     pass

% apply([Cl1 | _], X):-
%     negation(Cl1, X).

