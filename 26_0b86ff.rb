require 'csv'

input_folder_1 = ARGV[0]
input_folder_2 = ARGV[1]
def if_digit(digit)
  digit =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
end

my_csv = []

Dir.glob(input_folder_1 + "*").each do |file|
  names = file.split("/").last.split("_")
  if names.size == 3
    name1 = names[0]
    name2 = names[1]
    digit = names[2].split(".").first
    ext = names[2].split(".").last
    if name1 != nil && name2 != nil && if_digit(digit) == 0 && ext == "rb"
      if name1.size == 5
        my_csv << [name2,name1]
      end
    end
  end
end
CSV.open("result.csv","w") do |csv|
  Dir.glob(input_folder_2 + "*").each do |file|
    names = file.split("/").last.split("_")
    if names.size == 3
      name1 = names[0]
      name2 = names[1]
      digit = names[2].split(".").first
      ext = names[2].split(".").last
      if name1 != nil && name2 != nil && if_digit(digit) == 0 && ext == "rb"
        if name1.size == 5
          my_csv.each do |element|
              if element[0] == name2 && element[1] == name1
                csv << [name2,name1]
              end
          end
        end
      end
    end
  end
end

my_csv = CSV.read 'result.csv'
my_csv.sort! { |a, b| a[0] <=> b[0] }
CSV.open("result.csv","w") do |csv_array|
  my_csv.each {|element| csv_array << element}
end
