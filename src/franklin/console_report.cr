require "ecr/macros"

module Franklin
  class ConsoleReport
    property search_terms : String
    property collated_results : Hash(Item, Array(Availability))

    def initialize(@search_terms, @collated_results)
    end

    ECR.def_to_s "src/franklin/templates/console_report.ecr"
  end
end
