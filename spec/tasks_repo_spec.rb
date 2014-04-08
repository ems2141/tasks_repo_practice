require 'tasks_repo'

describe TasksRepo do

  before do
    db = Sequel.connect('postgres://gschool_user:password@localhost/tasks_test')
    db.create_table! :tasks do
      primary_key :id
      String :name
    end
    @repo = TasksRepo.new(db)
  end

  it "creates tasks" do
    @repo.create(name: 'walk the dog')
    @repo.create(name: 'water the plant')
    tasks = @repo.all

    expected_tasks = [
        {id: 1, name: 'walk the dog'},
        {id: 2, name: 'water the plant'}
    ]
    expect(tasks).to match_array(expected_tasks)
  end

  it "allows user to find 1 task by id" do
    @repo.create(name: 'walk the dog')
    @repo.create(name: 'water the plant')
    expected_task = {id: 2, name: 'water the plant'}

    expect(@repo.find(2)).to eq(expected_task)
  end

  it 'allows user to update a task' do
    @repo.create(name: 'walk the dog')
    @repo.create(name: 'water the plant')

    @repo.update(1, :name => 'wash the car')

    expected_tasks = [
        {id: 1, name: 'wash the car'},
        {id: 2, name: 'water the plant'}
    ]
    expect(@repo.all).to match_array(expected_tasks)
  end

  it "allows user to delete a task by id" do
    @repo.create(name: 'walk the dog')
    @repo.create(name: 'water the plant')

    @repo.delete(1)

    expected_tasks = [
        {id: 2, name: 'water the plant'}
    ]

    expect(@repo.all).to eq(expected_tasks)
  end
end