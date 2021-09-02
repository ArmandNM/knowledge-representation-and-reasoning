:- consult(sld_derivations).


% Reads
student_reads_to_literal(Reads, ReadsLiteral):-
    Reads > 8,
    ReadsLiteral = [reads_more_than_8_hours].

student_reads_to_literal(Reads, ReadsLiteral):-
    Reads =< 8,
    ReadsLiteral = [].

% Smart
student_smart_to_literal(Smart, SmartLiteral):-
    Smart = yes,
    SmartLiteral = [smart].

student_smart_to_literal(Smart, SmartLiteral):-
    Smart = no,
    SmartLiteral = [].

% Parties
student_parties_to_literal(Parties, PartiesLiteral):-
    Parties = yes,
    PartiesLiteral = [likes_parties].

student_parties_to_literal(Parties, PartiesLiteral):-
    Parties = no,
    PartiesLiteral = [].

% Contests
student_contsts_to_literal(Contests, ContestsLiteral):-
    Contests = yes,
    ContestsLiteral = [participates_contests].

student_contsts_to_literal(Contests, ContestsLiteral):-
    Contests = no,
    ContestsLiteral = [].


% Interactive Console 
main:-
    repeat,

    PriorKB = [[n(reads_more_than_8_hours), motivated],
               [n(smart), n(motivated), good_grades],
               [n(likes_parties), n(motivated), drop_school],
               [n(good_grades), n(participates_contests), receive_awards]],

    write('PriorKB: '), write(PriorKB), nl,

    write('\nHola\n\n'),
    write('How many hours does the student read daily?\n'),
    read(Reads), nl,
    student_reads_to_literal(Reads, ReadsLiteral),

    write('Is the student smart?\n'),
    read(Smart), nl,
    student_smart_to_literal(Smart, SmartLiteral),

    write('Does the student like parties?\n'),
    read(Parties), nl,
    student_parties_to_literal(Parties, PartiesLiteral),

    write('Does the student participate in contests?\n'),
    read(Contests), nl,
    student_contsts_to_literal(Contests, ContestsLiteral),

    write('Reads: '), write(ReadsLiteral), nl,
    write('Smart: '), write(SmartLiteral), nl,
    write('Parties: '), write(PartiesLiteral), nl,
    write('Contests: '), write(ContestsLiteral), nl,

    sort([ReadsLiteral, SmartLiteral, PartiesLiteral, ContestsLiteral], StudentKBWithEmptyClauses),
    delete(StudentKBWithEmptyClauses, [], StudentKB),
    append(PriorKB, StudentKB, KB),
    Questions = [receive_awards],

    write('KB '), write(KB), nl, nl,

    (solve(KB, Questions) -> write('Awards: YES\n') ; write('Awards: NO\n') ),

    write('\nLook at another student?\n'),
    read(AnotherStudent),
    AnotherStudent = stop,
    !.