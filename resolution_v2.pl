:- consult(utils).

main:-
    open('clauses.txt', read, InputFile),
    read(InputFile, Clauses),
    close(InputFile),
    sort(Clauses, KB),
    resolution(KB),
    write('\n\n\n').

resolution(KB):-
    member([], KB).

resolution(KB):-
    select(Clause1, KB, RestKB1),
    select(Clause2, KB, RestKB2),
    not(Clause1 = Clause2),
    can_resolve(Clause1, Clause2),    
    resolve(Clause1, Clause2, Resolvent),
    append(KB, [Resolvent], ReunionKB),
    sort(ReunionKB, ExtendedKB),
    not(KB = ExtendedKB),

    write('Resolving: '), write(Clause1), write(' and '), write(Clause2), write('\n'),
    write('Resulting in new clause: '), write(Resolvent), write('\n'),
    write('Extended KB is: '), write(ExtendedKB), write('\n\n'),

    resolution(ExtendedKB).

can_resolve(Clause1, Clause2):-
    select(Literal1, Clause1, RestClause1),
    select(Literal2, Clause2, RestClause2),
    negation(Literal1, Literal2).

resolve(Clause1, Clause2, Resolvent):-
    select(Literal1, Clause1, RestClause1),
    select(Literal2, Clause2, RestClause2),
    negation(Literal1, Literal2),

    delete(Clause1, Literal1, UpdatedClause1),
    delete(Clause2, Literal2, UpdatedClause2),
    append(UpdatedClause1, UpdatedClause2, Reunion),
    sort(Reunion, Resolvent).