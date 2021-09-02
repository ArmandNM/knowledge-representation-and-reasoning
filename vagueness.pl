main:-
    repeat,

    open('C:\\Master\\KRR\\krr\\rules.txt', read, InputFile),
    read(InputFile, Rules),
    close(InputFile),

    [FirstRule | _] = Rules,
    % [Connector | [[Premise1, Premise2], [Conclusion]]] = FirstRule,

    Curves = [[service, poor, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              [service, good, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              [service, excellent, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              
              [food, rancid, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              [food, delicious, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
              
              [tip, stingy, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]],
              [tip, normal, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 50, 13]],
              [tip, generous, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]]],

    write('\nHola! Please leave a review!\n\n'),
    
    write('Insert service rating:\n'),
    read(ServiceRatingPlus1), nl,
    ServiceRating is ServiceRatingPlus1 - 1,

    write('Insert food rating:\n'),
    read(FoodRatingPlus1), nl,
    FoodRating is FoodRatingPlus1 - 1,

    % get_value(tip, normal, Curves, 11, YValue),
    % write('Value: '), write(YValue), nl, nl,

    % write(Connector), nl,
    % write(Premise1), nl,
    % write(Premise2), nl,
    % write(Conclusion), nl.

    solve(ServiceRating, FoodRating, Curves, Rules, TipPercentage).
    % rule_to_combined_curve(ServiceRating, FoodRating, FirstRule, Curves, CombinedCurve),
    % write(CombinedCurve).


get_values(Attribute, Category, Curves, CurveValues):-
    select(AttributeCurve, Curves, _),
    [Attribute, Category, CurveValues] = AttributeCurve.

get_value(Attribute, Category, Curves, XValue, YValue):-
    get_values(Attribute, Category, Curves, CurveValues),
    nth0(XValue, CurveValues, YValue).

combine_values(Connector, Value1, Value2, Result):-
    Connector = and,
    min_list([Value1, Value2], Result).

combine_values(Connector, Value1, Value2, Result):-
    Connector = or,
    max_list([Value1, Value2], Result).

rule_to_combined_curve(ServiceRating, FoodRating, Rule, Curves, CombinedCurve):-
    [Connector | [[Premise1, Premise2], [Conclusion]]] = Rule,

    member(AttributePrem1/CategoryPrem1, [Premise1]),
    member(AttributePrem2/CategoryPrem2, [Premise2]),
    member(AttributeConc/CategoryConc, [Conclusion]),

    get_value(AttributePrem1, CategoryPrem1, Curves, ServiceRating, YValueService),
    get_value(AttributePrem2, CategoryPrem2, Curves, FoodRating, YValueFood),

    combine_values(Connector, YValueService, YValueFood, Level),

    get_values(AttributeConc, CategoryConc, Curves, ConcCurveValues),
    maplist({Level}/[In, Out]>>min_list([Level, In], Out), ConcCurveValues, CombinedCurve).

 

solve(ServiceRating, FoodRating, Curves, Rules, TipPercentage):-
    % maplist()
    maplist({ServiceRating, FoodRating, Curves}/[In, Out]>>rule_to_combined_curve(ServiceRating, FoodRating, In, Curves, Out), Rules, CombinedCurves),
    nl, nl, nl, write(CombinedCurves), nl, nl, nl,
    TipPercentage = 1.
