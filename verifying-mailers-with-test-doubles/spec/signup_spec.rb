require "spec_helper"
require "signup"
require "support/fake_logger"
describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      account = stub_created(Account)
      user = stub_created(User)
      mailer = double("mailer", subject: "Example subject")
      logger = FakeLogger.new()

      signup = Signup.new(
        logger: logger,
        email: "user@example.com",
        account_name: "Example"
      )
        
      allow(SignupMailer).to receive(:signup).and_return(mailer)
      allow(mailer).to receive(:deliver)

      result = signup.save

      expect(Account).to have_received(:create!).with(name: "Example")
      expect(User).to have_received(:create!).with(account: account, email: "user@example.com")
      expect(SignupMailer).to have_received(:signup).with(account: account, user: user)
      expect(mailer).to have_received(:deliver)
      expect(logger.messages).to include(info: ["Delivered message: Example subject"])
      expect(result).to be(true)
    end
  end

  def stub_created(model)
    double(model.name).tap do |instance|
      allow(model).to receive(:create!).and_return(instance)
    end
  end
end
