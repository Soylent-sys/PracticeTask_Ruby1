require "csv" #CSVファイルを扱うためのライブラリの読み込み

loop do # 1~3以外の数字を入力した場合、再度入力を要求する

  puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する / 3 → 既存のメモの内容を見る"
  
  memo_type = gets.to_i #ユーザーの入力値を取得、数値へ変換
  
  if memo_type === 1 # 新規作成モード
    new_file_name = ""
    
    # 名前入力ｰｰ同じ名前のファイルがある場合は名前入力をやり直す
    loop do
      puts "作成するメモのファイル名（拡張子なし）を入力してください。"
    
      new_file_name = gets.chomp!
      
      if File.exist?("#{new_file_name}.csv")
        puts "同じ名前のファイルが既にあります。"
        puts ""
      elsif new_file_name.match(/^\.|:+/).nil? === false  # 禁止文字フィルター（Mac準拠）
        puts "ファイル名に使用できない文字が含まれています。"
        puts ""
      else
        break
      end
    end
    
    # メモの入力
    puts ""
    puts "メモしたい内容を入力してください。"
    puts "入力が完了したら Ctrl + D を押してください。"
    
    input_value = readlines(chomp: true)
    
    CSV.open("#{new_file_name}.csv", 'w') do |array|
      array << input_value
    end
    
    puts ""
    puts "以下の内容でメモを保存しました。"
    
    file_content = CSV.read("#{new_file_name}.csv")
    puts file_content

    break
    
  elsif memo_type === 2 # 既存ファイル編集モード
    edit_file_name = ""
    
    # 編集ファイル名入力ｰｰ同じ名前のファイルが無い場合は名前入力をやり直す
    loop do
      puts "編集するメモのファイル名（拡張子なし）を入力してください。"
    
      edit_file_name = gets.chomp!
      
      if File.exist?("#{edit_file_name}.csv")
        break
      else
        puts "入力した名前のファイルは存在しません。"
        puts ""
      end
    end
    
    # 編集するメモの内容確認
    file_content = CSV.read("#{edit_file_name}.csv")
    puts ""
    puts "以下の内容のファイルを編集します。"
    puts file_content
    
    # メモの追記入力
    puts ""
    puts "メモに追記したい内容を入力してください。"
    puts "入力が完了したら Ctrl + D を押してください。"
    
    input_value = readlines(chomp: true)
    
    CSV.open("#{edit_file_name}.csv", 'a') do |array|
      array << input_value
    end
    
    puts ""
    puts "以下の内容でメモを保存しました。"
    
    file_content = CSV.read("#{edit_file_name}.csv")
    puts file_content

    break
    
  elsif memo_type === 3 # 既存ファイル閲覧モード
    show_file_name = ""
    
    # 編集ファイル名入力ｰｰ同じ名前のファイルが無い場合は名前入力をやり直す
    loop do
      puts "閲覧するメモのファイル名（拡張子なし）を入力してください。"
    
      show_file_name = gets.chomp!
      
      if File.exist?("#{show_file_name}.csv")
        break
      else
        puts "入力した名前のファイルは存在しません。"
        puts ""
      end
    end
    
    file_content = CSV.read("#{show_file_name}.csv")
    
    puts ""
    puts "#{show_file_name}.csvの内容を表示します。"
    puts file_content

    break

  else
    puts "1、2、３のいずれかの数字を入力してください。"
    puts ""
  end
end

puts ""
puts "メモアプリを終了します。お疲れさまでした！"
