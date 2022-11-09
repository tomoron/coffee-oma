class ProductDecorator < ApplicationDecorator
  delegate_all

  def rate_average_num
    if reviews_count.zero?
      return 0
    end

    (rate_average * 2).floor / 2.to_f
  end

  def rate_average
    if reviews_count.zero?
      return 0
    end

    (rate_sum.to_f / reviews_count).floor(1)
  end

  def image_url(i = 0)
    images[i].url
  end

  def price_delimited
    price.to_s(:delimited)
  end
end
