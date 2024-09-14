# == Schema Information
#
# Table name: conversations
#
#  id                   :uuid             not null, primary key
#  analysis             :jsonb            not null
#  grow                 :boolean          default(FALSE), not null
#  last_analysis_at     :datetime
#  last_observations_at :datetime
#  public_access        :boolean          default(FALSE), not null
#  settings             :jsonb            not null
#  title                :string           not null
#  transcript           :jsonb            not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  bot_id               :uuid
#  user_id              :uuid             default("81570655-73f4-4619-b92f-fae5d5e06bc4"), not null
#
# Indexes
#
#  index_conversations_on_bot_id         (bot_id)
#  index_conversations_on_public_access  (public_access)
#  index_conversations_on_title          (title)
#  index_conversations_on_user_id        (user_id)
#
FactoryBot.define do
  factory :conversation do
    analysis { {} }

    association :bot
    association :user

    transient do
      message_count { 0 }
    end

    after(:create) do |conversation, evaluator|
      create_list(:message, evaluator.message_count, conversation: conversation)
    end
  end
end
