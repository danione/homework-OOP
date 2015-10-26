require 'csv'

input_folder = ARGV[0]
def is_digit? (digit)
  digit =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
end
CSV.open("result.csv","w") do |csv|
 Dir.glob(input_folder + "*").each do |file|
  names = file.split("/").last.split("_")
  if names.size == 3
    name1 = names[0]
    name2 = names[1]
    ext = names[2].split(".").last
    digit = names[2].split(".").first
    if (name1 != nil) && (name2 != nil) && (ext == "rb") && (is_digit?(digit) == 0)
      if name2.size == 5
        csv << [name1,name2]
      end
    end
  end
  end
end

my_csv = CSV.read 'result.csv'
my_csv.sort! { |a, b| a[1] <=> b[1] }
CSV.open("result.csv","w") do |csv|
  my_csv.each {|element| csv << element}
end
