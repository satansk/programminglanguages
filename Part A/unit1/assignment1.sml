(* date: int * int * int, year, month, day *)

(* 1 *)
fun is_older(date1: int * int * int, date2: int * int * int) =
  if #1 date1 < #1 date2
  then true
  else
      if #1 date1 = #1 date2
      then
	  if #2 date1 < #2 date2
	  then true
	  else
	      if #2 date1 = #2 date2
	      then
		  if #3 date1 < #3 date2
		  then true
		  else false
	      else false
      else false;

(* 使用逻辑操作符更加清晰，相对 if else ... *)
fun is_older_better(date1: int * int * int, date2: int * int * int) =
  let
      val y1 = #1 date1
      val y2 = #1 date2
      val m1 = #2 date1
      val m2 = #2 date2
      val d1 = #3 date1
      val d2 = #3 date2
  in
      if y1 < y2 orelse (y1 = y2 andalso m1 < m2) orelse (y1 = y2 andalso m1 = m2 andalso d1 < d2)
      then true
      else false
  end;
  
(* 2 *)
fun number_in_month(dates: (int * int * int) list, month: int) =
  if null dates
  then 0
  else
      let val tl_ans = number_in_month(tl dates, month)
      in
	  if #2 (hd dates) = month
	  then 1 + tl_ans
	  else tl_ans
      end;
(* if else 也是 expression，可以放在任何表达式可以出现的地方 *)
fun number_in_month2(dates: (int * int * int) list, month: int) =
  if null dates
  then 0
  else (if #2 (hd dates) = month then 1 else 0) + number_in_month2(tl dates, month);

(* 3 *)
fun number_in_months(dates: (int * int * int) list, months: int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months);

(* 4 *)
fun dates_in_month(dates: (int * int * int) list, month: int) =
  if null dates
  then []
  else
      let val tl_ans = dates_in_month(tl dates, month)
      in
	  if #2 (hd dates) = month
	  then hd dates :: tl_ans
	  else tl_ans
      end;

(* 5 *)
fun dates_in_months(dates: (int * int * int) list, months: int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);

(* 6 *)
fun get_nth(s: string list, n: int) =
  if n = 1
  then hd s
  else get_nth(tl s, n-1);

(* 7 *)
fun date_to_string(date: int * int * int) =
  let val month_str_list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  in
      get_nth(month_str_list, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end;

(* 8 *)
fun number_before_reaching_sum(sum: int, numbers: int list) =
  if sum <= hd numbers
  then 0
  else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers);

(* 9 *)
fun what_month(day: int) =
  let val month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
      1 + number_before_reaching_sum(day, month_days)
  end;

(* 10 *)
fun month_range(day1: int, day2: int) =
  if day1 > day2
  then []
  else what_month day1 :: month_range(day1 + 1, day2);

(* 11 *)
fun oldest(dates: (int * int * int) list) =
  if null dates
  then NONE
  else
      let fun oldest_helper dates = (* 不需要使用 (int * int * int) list 指明 dates 的类型 *)
	    if null (tl dates)
	    then hd dates
	    else
		let val tl_ans = oldest_helper (tl dates)
		in
		    if is_older (hd dates, tl_ans)
		    then hd dates
		    else tl_ans
		end
      in
	  SOME(oldest_helper dates)
      end;

(* 12，先去重，在调用 3 *)
fun number_in_months_challenge(dates: (int * int * int) list, months: int list) =
  let
      fun inside(month: int, months: int list) =
	if null months
	then false
	else
	    if month = hd months
	    then true
	    else inside(month, tl months)
		   
      fun filter months =
	if null months
	then []
	else
	    let val tl_ans = filter(tl months)
	    in
		if inside(hd months, tl months)
		then tl_ans
		else hd months :: tl_ans
	    end
  in
      number_in_months(dates, filter months)
  end;

fun dates_in_months_challenge(dates: (int * int * int) list, months: int list) =
  let
      fun inside(month: int, months: int list) =
	if null months
	then false
	else
	    if hd months = month
	    then true
	    else inside(month, tl months)

      fun filter months =
	if null months
	then []
	else
	    let val tl_ans = filter(tl months)
	    in
		if inside(hd months, tl months)
		then tl_ans
		else hd months :: tl_ans
	    end
  in
      dates_in_months(dates, filter months)
  end;
