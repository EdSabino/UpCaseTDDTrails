class FakeLogger

    attr_accessor :messages

    def initialize()
        @messages = {
            error: [],
            info: []
        }
    end

    def info(message)
        messages[:info] << message
    end

    def error(message)
        messages[:error] << message
    end

end