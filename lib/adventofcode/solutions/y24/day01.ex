defmodule AdventOfCode.Solutions.Y24.Day01 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.read!()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(fn line ->
      line
      |> String.split(~r/\s+/)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  def part_one(problem) do
    problem
    |> Enum.unzip()
    |> then(fn {list1, list2} -> {Enum.sort(list1), Enum.sort(list2)} end)
    |> then(fn {list1, list2} -> Enum.zip(list1, list2) end)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part_two(problem) do
    problem
    |> Enum.unzip()
    |> then(fn {list1, list2} -> {list1, Enum.frequencies(list2)} end)
    |> then(fn {list1, frequencies} ->
      Enum.map(list1, fn n -> n * Map.get(frequencies, n, 0) end)
    end)
    |> Enum.sum()
  end
end
