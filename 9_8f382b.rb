require 'csv'

input_folder_1 = ARGV[0]
input_folder_2 = ARGV[1]
def is_digit? (digit)
  digit =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
end
help = []
CSV.open("first_folder.csv", "w") do |csv_array|
  Dir.glob(input_folder_1 + "*").each do |files|
    names = files.split("/").last.split("_")
    if names.size == 3
      name1 = files.split("/").last.split("_").first
      name2 = names[1]
      digit = names[2].split(".").first
      ext = names[2].split(".").last
      if (ext == "rb") && (is_digit?(digit) == 0) && (name1 != nil) && (name2 != nil)
        csv_array << [name2,name1]
      end
    end
  end
end

my_csv = CSV.read 'first_folder.csv'
CSV.open("result.csv","w") do |csv_array|
  Dir.glob(input_folder_2 + "*").each do |files|
    time = 0
    names = files.split("/").last.split("_")
    if names.size == 3
      name1 = files.split("/").last.split("_").first
      name2 = names[1]
      digit = names[2].split(".").first
      ext = names[2].split(".").last

      if (ext == "rb") && (is_digit?(digit) == 0) && (name1 != nil) && (name2 != nil)
        my_csv.each{ |elements|
          if name2 != elements[0] && name1 != elements[1] && time == 0
            csv_array << [name2,name1]
          elsif name2 == elements[0] && name1 == elements[1]
            time = time + 1
          end
        }
      end
    end
  end
end
my_csv = CSV.read 'result.csv'
help = my_csv
help.uniq!
help.sort! { |a, b| a[1] <=> b[1] }
CSV.open("result.csv","w") do |csv|
  help.each {|element| csv << element}
end
