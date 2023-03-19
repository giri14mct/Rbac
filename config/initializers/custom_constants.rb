class InvalidParams < StandardError; end

class PayloadTooLarge < StandardError; end

class UnAuthorized < StandardError; end

class Forbidden < StandardError; end

EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/.freeze
