# Container usable in any DryTransaction instance as follow
# class FooTransaction < ::ApplicationTransaction
#   include Dry::Transaction(container: ::LockableContainer)
#
#   around :lockabe, with: 'lockable'
#
#   step :foo
#   step :bar
# end
#
# Action:
# surround transaction input[:resource].with_lock block to ensure access to resource
# is thread safe
# Any exception will raise an ActiveRecord::Rollback and a Dry::Monads.Failure will
# be returned
class LockableContainer
  extend Dry::Container::Mixin

  register(:lockable) do |input, &block|
    result = nil

    begin
      input[:resource].with_lock do
        result = block.(Dry::Monads.Success(input))
        result
      end
    rescue StandardError => e
      Dry::Monads.Failure(message: e.message)
    end
  end
end
