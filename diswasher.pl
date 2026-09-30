%
% Dishwasher Troubleshooting Expert System
%
% Dynamic predicates allow conditions to be removed
% from the knowledge base during execution.
:- dynamic dishwasher_not_starting/1.
:- dynamic low_water_level/1.
:- dynamic dishes_dirty/1.
:- dynamic water_not_draining/1.
:- dynamic unusual_noise/1.

%
% KNOWLEDGE BASE
%
% Define the dishwasher
dishwasher(dishwasher1).

% Known dishwasher conditions
dishwasher_not_starting(dishwasher1).
low_water_level(dishwasher1).
dishes_dirty(dishwasher1).
water_not_draining(dishwasher1).
unusual_noise(dishwasher1).

%
% TROUBLESHOOTING RULES
%
% Rule 1: Dishwasher is not starting
action(check_power_and_latch) :-
    dishwasher_not_starting(dishwasher1).

% Rule 2: Water level is low
action(check_water_inlet) :-
    low_water_level(dishwasher1).

% Rule 3: Dishes remain dirty
action(check_spray_arms_and_detergent) :-
    dishes_dirty(dishwasher1).

% Rule 4: Water is not draining
action(check_drain_filter_and_hose) :-
    water_not_draining(dishwasher1).

% Rule 5: Dishwasher is making unusual noise
action(check_spray_arm_and_objects) :-
    unusual_noise(dishwasher1).

%
% STOP CONDITION
%
% Stop when all known conditions have been handled.
action(stop) :-
    \+ dishwasher_not_starting(_),
    \+ low_water_level(_),
    \+ dishes_dirty(_),
    \+ water_not_draining(_),
    \+ unusual_noise(_).

%
% PERFORM TROUBLESHOOTING ACTIONS
%
perform(check_power_and_latch) :-
    retract(dishwasher_not_starting(dishwasher1)),
    format("Dishwasher is not starting. Check power supply and door latch.~n").

perform(check_water_inlet) :-
    retract(low_water_level(dishwasher1)),
    format("Water level is low. Check water inlet and water supply.~n").

perform(check_spray_arms_and_detergent) :-
    retract(dishes_dirty(dishwasher1)),
    format("Dishes remain dirty. Check spray arms and detergent.~n").

perform(check_drain_filter_and_hose) :-
    retract(water_not_draining(dishwasher1)),
    format("Water is not draining. Check drain filter and drain hose.~n").

perform(check_spray_arm_and_objects) :-
    retract(unusual_noise(dishwasher1)),
    format("Unusual noise detected. Check spray arm and internal objects.~n").

perform(stop) :-
    format("Dishwasher troubleshooting completed. Stopping...~n").

%
% MAIN CONTROL LOOP
%
start :-
    action(Action),
    perform(Action),
    (   Action = stop
    ->  true
    ;   start
    ).