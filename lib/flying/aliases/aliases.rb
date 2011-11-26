module Kernel
  def site(referer, *options)
    process = Flying::Bot::Up.new
    assessment = process.assess(referer, options)
    puts process.message unless assessment
  end
end