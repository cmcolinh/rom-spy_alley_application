# frozen_string_literal: true

RSpec.describe SpyAlleyApplication::Results::BuyEquipment::RussianPassword do
  let(:change_orders, &->{ChangeOrdersMock::new})
  let(:action_hash, &->{{player_action: 'roll'}})
  let(:do_nothing, &->{CallableStub::new})
  let(:buy_equipment, &->{CallableStub::new})
  let(:buy_russian_password) do
    SpyAlleyApplication::Results::BuyEquipment::RussianPassword::new(
      do_nothing: do_nothing,
      buy_equipment: buy_equipment
    )
  end
  it 'calls do_nothing if the player has no money' do
    player_model = PlayerMock::new(money: 0, equipment: [])
    buy_russian_password.(
      player_model: player_model,
      change_orders: change_orders,
      action_hash:  action_hash
    )
    expect(do_nothing.called_with).not_to eql({})
  end
  it 'does not call buy_equipment if the player has no money' do
    player_model = PlayerMock::new(money: 0, equipment: [])
    buy_russian_password.(
      player_model: player_model,
      change_orders: change_orders,
      action_hash:  action_hash
    )
    expect(buy_equipment.called_with).to eql({})
  end
  it 'calls do_nothing if the player already has the russian password' do
    player_model = PlayerMock::new(money: 0, equipment: ['russian password', 'french password'])
    buy_russian_password.(
      player_model: player_model,
      change_orders: change_orders,
      action_hash:  action_hash
    )
    expect(do_nothing.called_with).not_to eql({})
  end
  it 'does not call buy_equipment if the player already has the russian password' do
    player_model = PlayerMock::new(money: 0, equipment: ['russian password'])
    buy_russian_password.(
      player_model: player_model,
      change_orders: change_orders,
      action_hash:  action_hash
    )
    expect(buy_equipment.called_with).to eql({})
  end
  it 'does not call do_nothing if the player has money and does not have the russian password' do
    player_model = PlayerMock::new(money: 5, equipment: ['french password'])
    buy_russian_password.(
      player_model: player_model,
      change_orders: change_orders,
      action_hash:  action_hash
    )
    expect(do_nothing.called_with).to eql({})
  end
  it 'does calls buy_equipment offering to buy russian password if the player has money " +
    "and does not have the russian password' do

    player_model = PlayerMock::new(money: 5, equipment: [])
    buy_russian_password.(
      player_model: player_model,
      change_orders: change_orders,
      action_hash:  action_hash
    )
    expect(buy_equipment.called_with[:purchase_options]).to match_array(['russian password'])
  end
  it 'does calls buy_equipment giving a buy limit of 1 if the player has money " +
    "and does not have the russian password' do

    player_model = PlayerMock::new(money: 5, equipment: [])
    buy_russian_password.(
      player_model: player_model,
      change_orders: change_orders,
      action_hash:  action_hash
    )
    expect(buy_equipment.called_with[:purchase_limit]).to eql(1)
  end
end
