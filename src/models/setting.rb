class Setting < ActiveRecord::Base
  enum theme: { default: 'default', dark: 'dark', light: 'light' }
  
  validates :theme, presence: true
  validates :programming_font, presence: true
end
