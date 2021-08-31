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

is_atom_negated(Atom):-
    term_to_atom(Atom, XAtom),
    atom_chars(XAtom, XChars),
    is_negated(XChars).

is_negated([FirstChar, SecondChar | RestChars]):-
    FirstChar == 'n',
    SecondChar == '(',
    last(RestChars, LastChar),
    LastChar == ')'.