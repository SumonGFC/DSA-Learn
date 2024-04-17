# Output the numbers 1 to 1000000, one line at a time, to std out

dups = ["dup1","dup2","dup3","dup4","dup5","dup6","dup7"]

 1_000_000.times do |i|
   if rand <= 0.00005
     puts i
   elsif rand <= 0.5         # sprinkle in some duplicate lines
     puts dups[rand(0..6)]
   else
     puts ""                 # sprinkle in some blank lines
   end
 end

# 100.times do |i|
#   if rand <= 0.8
#     puts i
#   elsif rand <= 0.5         # sprinkle in some duplicate lines
#     puts dups[rand(0..6)]
#   else
#     puts ""                 # sprinkle in some blank lines
#   end
# end
