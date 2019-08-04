# FileとDirectoryを管理する
# お題：Consoleクラスから、`ls`すると、FileとDirectoryの一覧が表示される

class Common
  def initialize(name)
    @name = name
  end

  attr_accessor :name
end


class FileTask < Common
  def initialize(name)
    super(name)
  end
end

class Directory < Common
  def initialize(name)
    super(name)
    @files = []
  end

  attr_accessor :files

  def add(file)
    @files << file
  end
end


class Console
  def initialize(*files)
    @root = files
  end

  def ls
    @root.each do |f|
      if f.class == Directory
        puts f.name
        f.files.each { |ff| puts " L #{ff.name}" }
      else
        puts f.name
      end
    end
  end
end

file_a = FileTask.new('hoge.rb')
file_b = FileTask.new('fuga.rb')
file_c = FileTask.new('piyo.rb')
dir_a = Directory.new('hoge')
dir_a.add(file_a)
dir_a.add(file_b)

con = Console.new(file_a, file_b, file_c, dir_a)
con.ls

# ```出力
# hoge.rb
# fuga.rb
# piyo.rb
# hoge
#  L hoge.rb
# ```