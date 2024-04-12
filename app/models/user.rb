class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    admin
  end

  # before_create :set_default_admin - setar se não tiver nenhum usuario como admin

  private

  def set_default_admin
    self.admin = true if self.admin.nil?
  end

end
