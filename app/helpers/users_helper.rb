module UsersHelper
  def safe_zip(a1, a2)
    combined = []
    if a1.length > a2.length
      a1.each_with_index do |a1_member, index|
        if !a2[index].nil?
          combined.append([a1_member, a2[index]])
        else
          combined.append([a1_member, nil])
        end
      end
    else
        a2.each_with_index do |a2_member, index|
          if !a1[index].nil?
            combined.append([a1[index], a2_member])
          else
            combined.append([nil, a2_member])
          end
        end
    end
    combined
  end
end
