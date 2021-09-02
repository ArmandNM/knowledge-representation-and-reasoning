:- consult('..\\utils.pl').

main:-
    open('C:\\Master\\KRR\\krr\\Davis_Putnam\\test2_dp.txt', read, InputFile),
    read(InputFile, Clauses),
    close(InputFile),
    sort(Clauses, KB),
    write(Clauses), write('\n'),
    davis_putnam(KB, SAT, Values),
    write('SAT: '), write(SAT), write('\n'),
    write('Output: '), write(Values), write('\n\n\n').

clause_contains_atom(Clause, Atom):-
    member(Atom, Clause).

clause_not_contains_atom(Clause, Atom):-
    not(member(Atom, Clause)).

clauses_containing_atom(Clauses, Atom, FilteredClauses):-
    include({Atom}/[In]>>clause_contains_atom(In, Atom), Clauses, FilteredClauses).

count_clauses_containing_atom(Clauses, Atom, Count):-
    clauses_containing_atom(Clauses, Atom, FilteredClauses),
    length(FilteredClauses, Count).

clauses_without_atom_or_negation(Clauses, Atom, FilteredClauses):-
    include({Atom}/[In]>>clause_not_contains_atom(In, Atom), Clauses, ItermFilteredClauses),
    negation(Atom, NotAtom),
    include({NotAtom}/[In]>>clause_not_contains_atom(In, NotAtom), ItermFilteredClauses, FilteredClauses).

clauses_containing_only_negation(Clauses, Atom, FilteredClauses):-
    include({Atom}/[In]>>clause_not_contains_atom(In, Atom), Clauses, ItermFilteredClauses),
    negation(Atom, NotAtom),
    include({NotAtom}/[In]>>clause_contains_atom(In, NotAtom), ItermFilteredClauses, FilteredClauses).

eliminate(Clauses, Atom, ResultingClauses):-
    clauses_without_atom_or_negation(Clauses, Atom, Clauses1),
    clauses_containing_only_negation(Clauses, Atom, Clauses2),
    negation(Atom, NotAtom),
    maplist({NotAtom}/[In, Out]>>delete(In, NotAtom, Out), Clauses2, SimplifiedClauses2),
    append(Clauses1, SimplifiedClauses2, Reunion),
    sort(Reunion, ResultingClauses).

davis_putnam(Clauses, SAT, []):-
    not(member(_, Clauses)),
    SAT = 'YES'.

davis_putnam(Clauses, SAT, []):-
    member([], Clauses),
    SAT = 'NO'.

davis_putnam(Clauses, SAT, Values):-
    flatten(Clauses, Atoms),
    sort(Atoms, UniqueAtoms),
    maplist({Clauses}/[In, Out]>>count_clauses_containing_atom(Clauses, In, Out), UniqueAtoms, ClausesCount),
    pairs_keys_values(Pairs, ClausesCount, UniqueAtoms),
    keysort(Pairs, AscSortedPairs),
    reverse(AscSortedPairs, DescSortedPairs),
    % write(DescSortedPairs), write('\n'),
    pairs_values(DescSortedPairs, DescSortedAtoms),
    [FirstAtom|Tail] = DescSortedAtoms,
    % write('lit: '), write(FirstAtom), write('\n'),
    eliminate(Clauses, FirstAtom, ResultingClauses1),
    davis_putnam(ResultingClauses1, SAT1, Values1),
    (SAT1 = 'YES' -> SAT = 'YES', append([[FirstAtom, 'true']], Values1, Values), !;
                       negation(FirstAtom, NotFirstAtom),
                       eliminate(Clauses, NotFirstAtom, ResultingClauses2),
                       davis_putnam(ResultingClauses2, SAT, Values2),
                       append([[FirstAtom, 'false']], Values2, Values)).