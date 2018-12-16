class User < ApplicationRecord
    attr_accessor :remember_token

    # References
    has_many :posts

    # Filters
    before_save :downcase_email

    # Validations
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :name, presence: true, length: {minimum:3, maximum:30}, uniqueness: {case_sensitive: false}
    validates :email, presence: true, length: {maximum:255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

    has_secure_password
    validates :password, presence: true, length: {minimum:6, maximum: 60}, allow_nil: true

    # Remember user in database for auto log in
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Forgets user by nullify remember_digest
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Generate digest of given token
    def User.digest(token)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(token, cost: cost)
    end

    # Generate random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Returns true if remember_token is valid
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    
    # Private methods
    private

        # Before filters

        # Make email lower-case
        def downcase_email
            email.downcase!
        end

end
