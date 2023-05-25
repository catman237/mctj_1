defmodule Mctj.Workouts do
  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.Workouts.Workout

  def list_workouts do
    Repo.all(Workout)
  end

  def list_user_workouts(id) do
    Workout
    |> where(user_id: ^id)
    |> Repo.all()
  end

  def get_workout!(id), do: Repo.get!(Workout, id)

  def create_workout(attrs \\ %{}) do
    %Workout{}
    |> Workout.changeset(attrs)
    |> Repo.insert()
  end

  def update_workout(%Workout{} = workout, attrs) do
    workout
    |> Workout.changeset(attrs)
    |> Repo.update()
  end

  def delete_workout(%Workout{} = workout) do
    Repo.delete(workout)
  end

  def delete_workout_by_id(id) do
    Repo.delete(get_workout!(id))
  end

  def change_workout(%Workout{} = workout, attrs \\ %{}) do
    Workout.changeset(workout, attrs)
  end

  def list_workouts_week(day),
    do:
      Enum.filter(
        list_workouts(),
        &Timex.between?(&1.inserted_at, Timex.beginning_of_week(day), Timex.end_of_week(day))
      )

  def generate_workout_name(),
    do: "#{Timex.now() |> Timex.weekday() |> Timex.day_shortname()}_default_workout"
end
