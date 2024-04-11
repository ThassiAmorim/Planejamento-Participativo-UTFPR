class Activity < ApplicationRecord
  self.inheritance_column = :_type_disabled # Desativa o STI para o atributo type
end
