
module Memory = struct
  type t = {buf: string array; last_entry: int; first_entry: int; cursor: int;}
  let size = 200
  let make () = 
    {buf = Array.init size (fun _ -> ""); first_entry = 0; last_entry = 1; cursor = 1;}

  let go_back m =
    if m.cursor <> m.first_entry then
      {m with cursor = (m.cursor - 1 + size) mod size}
    else
      m
  
  let go_fw m =
    if m.cursor <> m.last_entry then
      {m with cursor = (m.cursor + 1) mod size}
    else
      m

  let current m = m.buf.(m.cursor)

  let add s m =
    let cc = (m.last_entry + 1) mod size in
    m.buf.(cc) <- s;

    let m1 = {m with cursor = cc; last_entry = cc;} in
    if cc <> m1.first_entry then m1 else {m1 with last_entry = (cc + 1) mod size;}

  (* to the last entry *)
  let scroll m = {m with cursor = m.last_entry}
end

let max_size = 50

type t = {mem: Memory.t; cur: int; len: int; buf: char array } 

let make () = {cur = 0; len = 0; buf = Array.make max_size ' '; mem = Memory.make()}

let left c = if c.cur > 0 then {c with cur = c.cur-1} else c

let right c = if c.cur < c.len then {c with cur = c.cur+1} else c

(* remove the char at the position x *)
let remove x c =
  if 0 <= x && x < c.len then
  ( for i = x to c.len-2 do
      c.buf.(i) <- c.buf.(i+1) 
    done;
    c.buf.(c.len-1) <- ' ';
    true
  )
  else
    false

let delete c =
  if remove c.cur c then
    {c with len = c.len - 1}
  else 
    c

let backspace c = 
  if remove (c.cur-1) c then
    {c with cur = c.cur-1; len = c.len - 1}
  else 
    c

let insert ch c =
  if c.len < max_size then
  ( for i = c.len downto c.cur+1 do
      c.buf.(i) <- c.buf.(i-1)
    done;
    c.buf.(c.cur) <- ch;
    { c with cur = c.cur+1; len = c.len + 1 }
  )
  else
    c

let string_of_buf c =
  let s = String.make c.len ' ' in
  for i = 0 to c.len-1 do s.[i] <- c.buf.(i) done;
  s

let fill s c =
  let len = min max_size (String.length s) in
  for i = 0 to len-1 do
    c.buf.(i) <- s.[i]
  done;
  {c with len; cur = len;}


let up c = 
  let c = fill (Memory.current c.mem) c in
  {c with mem = Memory.go_back c.mem}

let down c =
  let sh = (c.mem.Memory.last_entry - c.mem.Memory.cursor + Memory.size) mod Memory.size in

  if sh >= 2 then
  ( let c = {c with mem = Memory.go_fw c.mem} in
    let c = {c with mem = Memory.go_fw c.mem} in
    let c = fill (Memory.current c.mem) c in
    {c with mem = Memory.go_back c.mem}
  )
  else
  ( let c = {c with mem = Memory.scroll c.mem} in
    fill "" c 
  )

let cancel c =
  let c = fill "" c in
  {c with mem = c.mem |> Memory.scroll}

let enter c =
  let s = (string_of_buf c) |> String.trim in
  
  let c = cancel c in

  if s = "" then 
    ("", c)
  else
    let c = {c with mem = c.mem |> Memory.add s} in
    (s, c)
  

