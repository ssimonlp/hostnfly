module DateValidator
  def self.extended(obj)
    obj.class_eval do
      validate :start_date_before_end_date

      private

      def start_date_before_end_date
        proc { |instance| instance.start_date < instance.end_date }
      end
    end
  end
end