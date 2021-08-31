:- consult(utils).

main:-
    open('C:\\Master\\KRR\\krr\\test.txt', read, InputFile),
    read(InputFile, Clauses),
    read(InputFile, Questions),
    close(InputFile),
    write(Clauses), write('\n\n'), write(Questions), write('\n'),
    solve(Clauses, Questions).


get_negative_literals(Clause, NegativeLiterals):-
    include([In]>>is_atom_negated(In), Clause, FilteredLiterals),
    maplist([In, Out]>>negation(In, Out), FilteredLiterals, NegativeLiterals).

get_positive_literal(Clause, PositiveLiteral):-
    include([In]>>not(is_atom_negated(In)), Clause, FilteredLiterals),
    [PositiveLiteral|_] = FilteredLiterals.

get_all_literals_one_clause(Clause, AllLiterals):-
    get_negative_literals(Clause, NegativeLiterals),
    get_positive_literal(Clause, PositiveLiteral),
    append(NegativeLiterals, [PositiveLiteral], AllLiterals).

get_all_literals_all_clauses(Clauses, AllLiterals):-
    maplist([In, Out]>>get_all_literals_one_clause(In, Out), Clauses, ListAllLiterals),
    flatten(ListAllLiterals, FlattenedAllLiterals),
    sort(FlattenedAllLiterals, AllLiterals).


all_solved(Literals, Solved):-
    append(Solved, Literals, Reunion),
    sort(Solved, SortedSolved),
    sort(Reunion, SortedReunion),
    SortedSolved = SortedReunion.


solve(KB, Questions):-
    get_all_literals_all_clauses(KB, AllLiterals),
    write(AllLiterals), nl, nl,
    solve_rec(KB, Questions, AllLiterals, []).


solve_rec(KB, Questions, UnsolvedLiterals, SolvedLiterals):-
    % write(UnsolvedLiterals), write('\n'),
    % not(member(_, UnsolvedLiterals)).
    all_solved(Questions, SolvedLiterals).

solve_rec(KB, Questions, UnsolvedLiterals, SolvedLiterals):-
    select(Clause, KB, _),
    % write('UnsolvedLiterals: '), write(UnsolvedLiterals), write(' SolvedLiterals: '), write(SolvedLiterals), nl,
    % write('Selected Clause: '), write(Clause), nl,
    get_positive_literal(Clause, PositiveLiteral),
    get_negative_literals(Clause, NegativeLiterals),
    
    % write('Positive Literal: '), write(PositiveLiteral), nl,
    % write('Negative Literal: '), write(NegativeLiterals), nl, nl,
    
    member(PositiveLiteral, UnsolvedLiterals),
    all_solved(NegativeLiterals, SolvedLiterals),

    append(SolvedLiterals, [PositiveLiteral], UpdatedSolvedLiterals),
    delete(UnsolvedLiterals, PositiveLiteral, UpdatedUnsolvedLiterals),

    solve_rec(KB, Questions, UpdatedUnsolvedLiterals, UpdatedSolvedLiterals).