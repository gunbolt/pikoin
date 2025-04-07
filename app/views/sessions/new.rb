module Views
  module Sessions
    class New < Views::Base
      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
              end
            end

            Bolt.PageBody do
              form_with scope: :session, url: session_path do |form|
                Bolt.Stack do
                  Bolt.Panel do
                    Bolt.Stack do
                      Bolt.FieldWrapper do
                        Bolt.Label form, :email
                        Bolt.EmailField form,
                          :email,
                          autofocus: true,
                          autocomplete: "email",
                          value: email_value
                      end

                      Bolt.FieldWrapper do
                        Bolt.Label form, :password
                        Bolt.PasswordField form,
                          :password,
                          autocomplete: "current-password",
                          value: password_value
                      end
                    end
                  end

                  Bolt.Stack gap: :sm do
                    Bolt.Submit form
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
