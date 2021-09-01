:- consult(sld_derivations).


% Temperature
patient_temperature_to_literal(Temperature, TemperatureLiteral):-
    Temperature > 38,
    TemperatureLiteral = [temp_gt_38].

patient_temperature_to_literal(Temperature, TemperatureLiteral):-
    Temperature =< 38,
    TemperatureLiteral = [].

% Sick days
patient_sick_days_to_literal(SickDays, SickDaysLiteral):-
    SickDays >= 2,
    SickDaysLiteral = [sick_2days].

patient_sick_days_to_literal(SickDays, SickDaysLiteral):-
    SickDays < 2,
    SickDaysLiteral = [].

% Muscle pain
patient_muscle_pain_to_literal(MusclePain, MusclePainLiteral):-
    MusclePain = yes,
    MusclePainLiteral = [muscle_pain].

patient_muscle_pain_to_literal(MusclePain, MusclePainLiteral):-
    MusclePain = no,
    MusclePainLiteral = [].

% Cough
patient_cough_to_literal(Cough, CoughLiteral):-
    Cough = yes,
    CoughLiteral = [cough].

patient_cough_to_literal(Cough, CoughLiteral):-
    Cough = no,
    CoughLiteral = [].


% Interactive Console 
main:-
    repeat,
    PriorKB = [[n(cough),n(infection),pneumonia],
               [n(temp_gt_38),fever],
               [n(muscle_pain),n(fever),flu],
               [n(sick_2days),n(fever),infection]],

    write('PriorKB: '), write(PriorKB), nl,

    write('\nHola\n\n'),
    write('What is patient temperature?\n'),
    read(Temperature), nl,
    patient_temperature_to_literal(Temperature, TemperatureLiteral),

    write('For how many days has the patient been sick?\n'),
    read(SickDays), nl,
    patient_sick_days_to_literal(SickDays, SickDaysLiteral),

    write('Has patient muscle pain?\n'),
    read(MusclePain), nl,
    patient_muscle_pain_to_literal(MusclePain, MusclePainLiteral),

    write('Has patient cough?\n'),
    read(Cough), nl,
    patient_cough_to_literal(Cough, CoughLiteral),

    write('Temperature: '), write(TemperatureLiteral), nl,
    write('SickDays: '), write(SickDaysLiteral), nl,
    write('MusclePain: '), write(MusclePainLiteral), nl,
    write('Cough: '), write(CoughLiteral), nl,

    sort([TemperatureLiteral, SickDaysLiteral,MusclePainLiteral, CoughLiteral], PatientKBWithEmptyClauses),
    delete(PatientKBWithEmptyClauses, [], PatientKB),
    append(PriorKB, PatientKB, KB),
    Questions = [pneumonia],

    write('KB '), write(KB), nl, nl,

    (solve(KB, Questions) -> write('Pneumonia: YES\n') ; write('Pneumonia: NO\n') ),

    write('\nLook at another patient?\n'),
    read(AnotherPatient),
    AnotherPatient = stop,
    !.