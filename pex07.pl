% pex5.pl
% USAFA UFO Sightings 2024
%
% name: 
%
% Documentation: 
%

% The query to get the answer(s) or that there is no answer
% ?- solve.
% Each cadet saw a UFO on a different day
cadet(c4c_smith).
cadet(c4c_garcia).
cadet(c4c_chen).
cadet(c4c_jones).

day(tue).
day(wed).
day(thu).
day(fri).

ufo(weather_ballon).
ufo(kite).
ufo(fighter_aircraft).
ufo(cloud).

solve :-
    cadet(TueCadet), cadet(WedCadet), cadet(ThuCadet), cadet(FriCadet),
    all_different([TueCadet, WedCadet, ThuCadet, FriCadet]),
    
    ufo(TueUfo), ufo(WedUfo), ufo(ThuUfo), ufo(FriUfo),
    all_different([TueUfo, WedUfo, ThuUfo, FriUfo]),
    
    Triples = [ [TueCadet, tue, TueUfo],
                [WedCadet, wed, WedUfo],
                [ThuCadet, thu, ThuUfo],
                [FriCadet, fri, FriUfo] ],
    
    % 1. C4C Smith did not see a weather balloon, nor kite.
    \+ member([c4c_smith, _, weather_balloons], Triples),
    \+ member([c4c_smith, _, kite], Triples),
    
    % 2. The one who saw the kite isn’t C4C Garcia. 
    \+ member([c4c_garcia, _, kite], Triples),
    
    % 3. The kite was not sighted on Tuesday.
    \+ member([_, tue, kite], Triples),
    
    % 4. Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([c4c_garcia, _, weather_ballon], Triples),
    \+ member([c4c_jones, _, weather_ballon],  Triples),
    
    % 5. Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    (member([c4c_chen, fri, _], Triples));
    (member([_, fri, fighter_aircraft], Triples)),
    
    % 6. C4C Jones did not make their sighting on Tuesday.
    \+ member([c4c_jones, tue, _], Triples),
    
    %7. C4C Smith saw an object that turned out to be a cloud.
    member([c4c_smith, _, cloud], Triples),
    
    %8. The fighter aircraft was spotted on Friday.
    member([_, fri, figher_aircraft], Triples),
    
    %9. The weather balloon was not spotted on Wednesday.
    \+ member([_, wed, weather_ballon], Triples),
    
    tell(TueCadet, tue, TueUfo),
    tell(WedCadet, wed, WedUfo),
    tell(ThuCadet, thu, ThuUfo),
    tell(FriCadet, fri, FriUfo).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('On '), write(Y), write(' '), write(X),
    write(' saw: '), write(Z), write('.'), nl.
