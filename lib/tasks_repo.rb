require 'sequel'

class TasksRepo

  def initialize(db)
    @tasks_table = db[:tasks]
  end

  def create(attributes)
    @tasks_table.insert(attributes)
  end

  def all
    @tasks_table.to_a
  end

  def find(id)
    locate_task(id).to_a.first
  end

  def update(id, new_attributes)
    locate_task(id).update(new_attributes)
  end

  def delete(id)
    locate_task(id).delete
  end

  private
  def locate_task(id)
    @tasks_table.where(:id => id)
  end
end