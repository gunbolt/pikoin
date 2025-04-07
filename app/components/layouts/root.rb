module Components
  module Layouts
    class Root < Base
      include Phlex::Rails::Layout

      private

      def view_template(&)
        doctype

        html do
          head do
            title { "pikoin" }

            meta name: "viewport", content: "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
            meta name: "apple-mobile-web-app-capable", content: "yes"
            meta name: "mobile-web-app-capable", content: "yes"
            meta name: "robots", content: "noindex,nofollow"

            csrf_meta_tags
            csp_meta_tag

            # Enable PWA manifest for installable apps (make sure to enable in config/routes.rb too!)
            # link rel: "manifest", href: pwa_manifest_path(format: :json)

            link rel: "icon", href: "/icon.png", type: "image/png"
            link rel: "icon", href: "/icon.svg", type: "image/svg+xml"
            link rel: "apple-touch-icon", href: "/icon.png"

            # stylesheet_link_tag :app, data_turbo_track: :reload
            javascript_include_tag :application, data_turbo_track: :reload, type: :module
            stylesheet_link_tag :application, data_turbo_track: :reload
          end

          body do
            yield

            Components::Layouts.Flash
          end
        end
      end
    end
  end
end
