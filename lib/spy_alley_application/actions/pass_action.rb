# frozen_string_literal: true

module SpyAlleyApplication
  module Actions
    class PassAction
      def call(change_orders:, player_model:, target_player_model: nil, action_hash:)
        change_orders.add_pass_action
        'pass'
      end
    end
  end
end