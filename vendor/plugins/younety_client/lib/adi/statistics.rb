module Younety
  module Rails #:nodoc:
    module ModelExtentions
      module ActsAsAdi
        module Statistics

          def statistics
            @statistics ||= self.adi.stats_summary
          end
          
        end
      end
    end
  end
end