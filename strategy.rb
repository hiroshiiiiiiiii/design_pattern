class Payroll
  def initialize(name, worked_hours, employee_object)
    @name = name
    @worked_hours = worked_hours
    @employee_object = employee_object
  end

  attr_reader :name, :worked_hours
  attr_accessor :employee_object

  def output
    puts self
    @employee_object.output(self)
  end
end

# Interface
class Employee
  def output
    raise 'ストラテジークラスにoutputメソッドを定義してね'
  end
end

# 正社員
class FullTimeWorker < Employee
  STANDARD_TIME = 160

  def initialize(hourly_wage, basic_salary)
    @hourly_wage = hourly_wage
    @basic_salary = basic_salary
  end

  def output(payroll)
    "#{payroll.name}さんの給与は#{salary(payroll)}円です"
  end

  private

  def salary(payroll)
    return @basic_salary if @hourly_wage <= STANDARD_TIME

    @basic_salary + (@hourly_wage * overtime(payroll.worked_hours))
  end

  def overtime(worked_hours)
    worked_hours - STANDARD_TIME
  end
end

# インターン
class Intern < Employee
  def initialize(hourly_wage)
    @hourly_wage = hourly_wage
  end

  def output(payroll)
    "#{payroll.name}さんの給与は#{salary(payroll)}円です"
  end

  private

  def salary(payroll)
    @hourly_wage * payroll.worked_hours
  end
end

# 業務委託
class Subcontractor < Employee
  def initialize(basic_salary, lower_limit_time, upper_limit_time)
    @basic_salary = basic_salary
    @lower_limit_time = lower_limit_time
    @upper_limit_time = upper_limit_time
  end

  def output(payroll)
    "#{payroll.name}さんの給与は#{salary(payroll)}円です"
  end

  private

  def salary(payroll)
    return @basic_salary if (@lower_limit_time..@upper_limit_time).include?(payroll.worked_hours)

    time = if payroll.worked_hours < @lower_limit_time
      over_or_less_time(payroll.worked_hours, @lower_limit_time)
    else
      over_or_less_time(payroll.worked_hours, @upper_limit_time)
    end

    @basic_salary + (basic_wage * time)
  end

  def over_or_less_time(worked_hours, standard_time)
    worked_hours - standard_time
  end

  def basic_wage
    @basic_salary / 160
  end
end

payroll = Payroll.new('john', 10, Intern.new(1_000))
puts payroll.output

payroll = Payroll.new('ben', 180, FullTimeWorker.new(1_200, 250_000))
puts payroll.output

payroll = Payroll.new('anna', 160, FullTimeWorker.new(1_200, 220_000))
puts payroll.output

payroll = Payroll.new('taro', 200, Subcontractor.new(1000_000, 140, 180))
puts payroll.output
