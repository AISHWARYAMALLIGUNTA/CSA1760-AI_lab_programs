% Initial state: monkey and box at floor, banana hanging from ceiling
initial(state(at_door, at_window, on_floor, has_not)).

% Goal state: monkey has banana
goal(state(_, _, _, has)).

% move the monkey from one place to another
move(state(Monkey, Box, on_floor, H), go(Monkey, NewPlace), state(NewPlace, Box, on_floor, H)).

% push the box from one place to another
move(state(Monkey, Monkey, on_floor, H), push(Monkey, NewPlace), state(NewPlace, NewPlace, on_floor, H)).

% climb on the box
move(state(Monkey, Box, on_floor, H), climb, state(Box, Box, on_box, H)).

% grasp the banana if standing on the box
move(state(Monkey, Box, on_box, has_not), grasp, state(Monkey, Box, on_box, has)).

% solve the problem by finding a sequence of moves from initial state to goal state
solve(S, S, []).

solve(S, G, [Move|Moves]) :-
    move(S, Move, S1),
    solve(S1, G, Moves).

% start solving the problem
start :-
    initial(S),
    goal(G),
    solve(S, G, Moves),
    write('Moves: '), write(Moves), nl.
