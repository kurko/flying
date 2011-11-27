module Kernel
  def site(referer, *options)
    bot = Flying::Bot::Up.new(referer, options)
    Flying.add_bot(bot)
  end
  
  def start
    Flying.start
  end
end