defmodule AdventOfCode.Solutions.Y24.Day02 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.read!()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn values -> Enum.map(values, &String.to_integer/1) end)
  end

  def part_one(problem) do
    Enum.count(problem, &safe_sequence?/1)
  end

  def part_two(problem) do
    Enum.count(problem, &can_be_made_safe?/1)
  end

  defp safe_sequence?(numbers), do: safe_sequence?(numbers, nil)

  defp safe_sequence?([_], _), do: true

  defp safe_sequence?([a, b | rest], nil) do
    cond do
      valid_diff?({b, a}) -> safe_sequence?([b | rest], :inc)
      valid_diff?({a, b}) -> safe_sequence?([b | rest], :dec)
      true -> false
    end
  end

  defp safe_sequence?([a, b | rest], direction) do
    if valid_diff?(if direction == :inc, do: {b, a}, else: {a, b}) do
      safe_sequence?([b | rest], direction)
    else
      false
    end
  end

  defp valid_diff?({a, b}) do
    diff = b - a
    diff >= 1 and diff <= 3
  end

  defp can_be_made_safe?(numbers) do
    if safe_sequence?(numbers) do
      true
    else
      try_remove_one(numbers)
    end
  end

  defp try_remove_one(numbers) do
    numbers
    |> Enum.with_index()
    |> Enum.any?(fn {_, i} -> safe_after_removing?(numbers, i) end)
  end

  defp safe_after_removing?(numbers, index) do
    numbers
    |> List.delete_at(index)
    |> safe_sequence?()
  end
end
