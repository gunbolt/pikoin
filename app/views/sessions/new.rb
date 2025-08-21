module Views
  module Sessions
    class New < Views::Base
      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle { "pikoin" }
                Bolt.PageSubtitle { t("Log into your account") }
              end
            end

            Bolt.PageBody do
              Bolt.Form scope: :session, url: session_path do |form|
                Bolt.Stack do
                  Bolt.Panel do
                    Bolt.Stack do
                      form.field_wrapper do
                        form.label :email, t("Email address")
                        form.email_field :email,
                          autofocus: true,
                          autocomplete: "email",
                          value: email_value
                      end

                      form.field_wrapper do
                        form.label :password, t("Password")
                        form.password_field :password,
                          autocomplete: "current-password",
                          value: password_value
                      end
                    end
                  end

                  Bolt.Stack gap: :sm do
                    form.submit t("Sign in")
                  end
                end
              end
            end
          end
        end
      end

      def email_value
        Constants::DEV_USER_EMAIL if Rails.env.development?
      end

      def password_value
        Constants::DEV_USER_PASSWORD if Rails.env.development?
      end
    end
  end
end
