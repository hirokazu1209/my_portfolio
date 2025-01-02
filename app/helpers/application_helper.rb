module ApplicationHelper
  def custom_order(message)
    order = {
      "名前" => 1,
      "メールアドレス" => 2,
      "パスワード" => 3,
    }
    # メッセージの最初の部分に基づいて順序を決定
    order.each { |key, value| return value if message.start_with?(key) }
    999 # その他のメッセージは最後に表示
  end
end
