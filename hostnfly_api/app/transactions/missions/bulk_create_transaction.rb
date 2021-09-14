module Missions
  class BulkCreateTransaction < ::ApplicationTransaction
    tee :params
    step :generate_missions

    def params(input)
      @listings = input.fetch(:resource)
    end

    def generate_missions(input)
      @listings.each do |listing|
        transaction = Missions::CreateTransaction.call(resource: listing)
        if transaction.failure?
          Failure(input.merge(error: transaction.failure[:error]))
        end
      end
      Success(input)
    end
  end
end
