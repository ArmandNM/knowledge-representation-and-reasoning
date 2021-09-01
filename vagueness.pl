main:-
    open('C:\\Master\\KRR\\krr\\rules.txt', read, InputFile),
    read(InputFile, Rules),
    close(InputFile),

    [FirstRule | _] = Rules,
    [Connector | [[Premise1, Premise2], [Conclusion]]] = FirstRule,

    Curves = [[service, poor, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              [service, good, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              [service, excellent, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              
              [food, rancid, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              [food, delicious, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              
              [tip, stingy, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]],
              [tip, normal, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 50, 13]],
              [tip, generous, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]]],

    get_value(tip, normal, Curves, 11, YValue),
    write('Value: '), write(YValue), nl, nl,

    write(Connector), nl,
    write(Premise1), nl,
    write(Premise2), nl,
    write(Conclusion), nl.


get_value(Attribute, Category, Curves, XValue, YValue):-
    select(AttributeCurve, Curves, _),
    [Attribute, Category, CurveValues] = AttributeCurve,
    nth0(XValue, CurveValues, YValue).

% solve(ServiceRating, FoodRating, Curves, TipPercentage):-
