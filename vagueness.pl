main:-
    open('C:\\Master\\KRR\\krr\\rules.txt', read, InputFile),
    read(InputFile, Rules),
    close(InputFile),

    [FirstRule | _] = Rules,
    [Connector | [[Premise1, Premise2], [Conclusion]]] = FirstRule,

    write(Connector), nl,
    write(Premise1), nl,
    write(Premise2), nl,
    write(Conclusion), nl.