defmodule Eefest2019handson do
  @moduledoc """
  Documentation for Eefest2019handson.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Eefest2019handson.hello()
      :world

  """
  def hello do
    :world
  end

  def myfunc do
    "hello world"
  end

  def sleep_rand(n) do
    t = :rand.uniform(n)
    :timer.sleep(t)
    t
  end

  def exec_seq(n) do
    Enum.map(1..n, fn(_) -> sleep_rand(1000) end)
  end

  def exec_par(n) do
    tasks = Enum.map(1..n, fn(_) -> Task.async(Eefest2019handson, :sleep_rand, [1000]) end)
    results = Enum.map(tasks, fn(pid) -> Task.await(pid) end)
    results
  end

  def measure(f) do
    {time, _} = :timer.tc(Eefest2019handson, f, [])
    {f, time}
  end

  def handson1() do
    sleep_rand(1000)
  end
  def handson2() do
    exec_seq(10)
  end
  def handson3() do
    exec_seq(100)
  end
  def handson4() do
    exec_par(10)
  end
  def handson5() do
    exec_par(100)
  end
  def handson6() do
    exec_par(1000)
  end

  def handson() do
    tasks = [:handson1, :handson2, :handson3, :handson4, :handson5, :handson6]
    Enum.map(tasks, fn(t) -> measure(t) end)
  end

end
