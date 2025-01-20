require 'factory_bot_rails'

if Rails.env.production?
  puts '本番環境では seed を実行しません'
  exit
end

Category.create([
  { name: 'バックエンド' },
  { name: 'フロントエンド' },
  { name: 'インフラ' }
])

FactoryBot.create(:user)

Category.all.each do |category|
  # 3.times文を使って、当月・1ヶ月前・2ヶ月前のデータを作成する
  3.times do |n|
    Item.create(
      name: "#{category.name}のタイトル#{n + 1}",
      study_time: 60,
      user_id: 1,
      category_id: category.id,
      created_at: n.month.ago
    )
  end

  if category.errors.any?
    puts "#{category.name}: #{category.errors.full_messages.join(', ')}"
  end
end