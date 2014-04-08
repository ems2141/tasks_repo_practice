require 'tasks_repo'

describe TasksRepo do

  it "creates tasks" do
    db = Sequel.connect('postgres://gschool_user:password@localhost/tasks_test')
    db.create_table! :tasks do
      primary_key :id
      String :name
    end

    repo = TasksRepo.new(db)
    repo.create(name: 'walk the dog')
    repo.create(name: 'water the plant')
    tasks = repo.all

    expected_tasks = [
        {id: 1, name: 'walk the dog'},
        {id: 2, name: 'water the plant'}
    ]
    expect(tasks).to match_array(expected_tasks)
  end

end