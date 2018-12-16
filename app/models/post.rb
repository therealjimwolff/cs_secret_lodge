class Post < ApplicationRecord

    # Validations
    validates :header, presence: true, length: {minimum:3}
    validates :content, presence: true, length: {maximum: 280}

    # References
    belongs_to :user

end
