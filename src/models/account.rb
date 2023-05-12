class Account < ActiveRecord::Base
  def initialize first_name, last_name, nickname, password
    @first_name = first_name
    @last_name = last_name
    @password = password
    @progress = 0
    # @id es creado por ActiveRecord::Base
  end

end
