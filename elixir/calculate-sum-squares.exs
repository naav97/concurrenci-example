defmodule ThreadValues do
  defp sum_of_squares(num, i, count) do
    if i > num do
      count
    else
      sum_of_squares(num, i + 1, count + (i * i))
    end
  end
  defp sum_from_to(i, p_end, re) do
    if i > p_end do
      re
    else
      sum_from_to(i + 1, p_end, re + sum_of_squares(i, 0, 0))
    end
  end
  def run(start, p_end) do
    result = sum_from_to(start, p_end, 0)
    IO.puts("Sum of squares from #{start} to #{p_end} is #{result}!")
    result
  end
end

ranges = [
  {100, 200},
  {201, 300},
  {301, 400},
  {401, 500},
  {501, 600},
]

thread_values = for {start, p_end} <- ranges do
  Task.async(fn -> ThreadValues.run(start, p_end) end)
end

results = for tv <- thread_values do
  Task.await(tv)
end

total = Enum.sum(results)
IO.puts("Total Sum is: #{total}")
