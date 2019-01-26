program fourfour; 

const size = 6; 

type fifo = record 
	q: array[0..size-1] of integer; 
	end_of_q: integer; 
end; 

var 
	graph: array [0..size-1, 0..size-1] of integer = ((0, 1, 0, 0, 1, 1), 
													  (1, 0, 1, 0, 1, 0), 
													  (0, 1, 0, 1, 0, 0), 
													  (0, 0, 1, 0, 1, 0),
													  (1, 1, 0, 1, 0, 0),
													  (1, 0, 0, 0, 0, 0)); 
	visited: array [0..size-1] of boolean; 
	parent: array [0..size-1] of integer; 

procedure InitQ(var queue: fifo); 
var i: integer; 
begin 
	for i := 0 to size-1 do queue.q[i] := -1; 
	queue.end_of_q := 0; 
end; 

procedure PushQ(var queue: fifo; elem: integer); 
begin 
	{if (queue.end_of_q = size) then 
	begin 
		writeln('No more place in queue'); 
		exit; 
	end;} 
	queue.q[queue.end_of_q] := elem; 
	queue.end_of_q := queue.end_of_q + 1; 
end; 

function PopQ(var queue: fifo): integer; 
var i, tmp: integer; 
begin 
	{if (queue.end_of_q = 0) then 
	begin 
		writeln('The queue is empty'); 
		exit; 
	end;}
	tmp := queue.q[0]; 
	for i := 0 to queue.end_of_q-2 do queue.q[i] := queue.q[i + 1]; 
	queue.q[queue.end_of_q - 1] := -1; 
	queue.end_of_q := queue.end_of_q - 1; 
	PopQ := tmp; 
end; 

procedure PrintQ(queue: fifo); 
var i: integer; 
begin 
	for i := 0 to size-1 do write(queue.q[i]); 
end; 

procedure InitGSearch(); 
var i: integer; 
begin 
	for i := 0 to size-1 do 
	begin 
		visited[i] := FALSE; 
		parent[i] := -1; 
	end; 
end; 

procedure BFS(start: integer); 
var 
	queue: fifo; 
	current, i: integer; 
begin 
	InitQ(queue); 
	InitGSearch(); 
	PushQ(queue, start); 
	visited[start] := TRUE; 
	while queue.end_of_q <> 0 do 
	begin 
		current := PopQ(queue); 
		{write(current, ' ');}
		for i:=0 to size-1 do 
		begin 
			if (graph[current, i] <> 0) and (not visited[i]) then 
			begin 
				PushQ(queue,i); 
				visited[i] := TRUE;
				parent[i] := current;
			end; 
		end; 
	end; 
end; 

procedure FindPath(start, finish: integer);
begin
	BFS(start);
	if ((start = finish) or (finish = -1)) then
		write(start)
	else
	begin
		FindPath(start, parent[finish]);
		write(finish);
	end; 
end;

begin
	FindPath(0, 3);
end.