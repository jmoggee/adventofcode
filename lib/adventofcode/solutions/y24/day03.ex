defmodule AdventOfCode.Solutions.Y24.Day03 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(problem)
    |> Enum.reduce(0, fn [_, a, b], acc ->
      acc + String.to_integer(a) * String.to_integer(b)
     end)
  end

  def part_two(problem) do
    ~r/mul\((\d{1,3}),(\d{1,3})\)|do(?:n't)?\(\)/
    |> Regex.scan(problem)
    |> Enum.reduce({0, true}, fn
      ["do()" | _], {acc, _} -> {acc, true}
      ["don't()" | _], {acc, _} -> {acc, false}
      [_, a, b], {acc, true} -> {acc + String.to_integer(a) * String.to_integer(b), true}
      _, {acc, false} -> {acc, false}
     end)
    |> elem(0)
  end
end
