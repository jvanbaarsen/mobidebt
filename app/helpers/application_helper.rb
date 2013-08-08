module ApplicationHelper
  def colorize_credits(credits)
    if credits >= 0
      %Q{<span class="text-success">#{credits}</span>}
    else
      %Q{<span class="text-error">#{credits}</span>}
    end
  end
end

