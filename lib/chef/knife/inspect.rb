require 'chef/knife'

class Chef
  class Knife
    class Inspect < Knife

      CHECKLISTS = %w[Cookbooks DataBags DataBagItems Environments Roles]

      deps do
        require "health_inspector"
      end

      banner "knife inspect"

      def run
        results = CHECKLISTS.map do |checklist|
          HealthInspector::Checklists.const_get(checklist).run(self)
        end

        exit ! results.include?(false)
      end
    end
  end
end
