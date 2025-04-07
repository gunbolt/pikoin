module Bolt
  extend Phlex::Kit
end

# Allow using Bolt::ComponentName instead Components::Bolt::ComponentName
Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components/bolt"), namespace: Bolt
)

# Allow using Bolt::ComponentName instead Bolt::ComponentName::ComponentName
Rails.autoloaders.main.collapse(Rails.root.join("app/components/bolt/*"))
