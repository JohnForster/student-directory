@students = []

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry, #{filename} not found."
    exit
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name, cohort = *STDIN.gets.chomp.split(', ')
  
  while name != nil do
    # add the student hash to the array
    cohort = "no" if cohort == nil
    students << {name: name.to_sym, cohort: cohort.to_sym, hobby: :running}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name, cohort = STDIN.gets.chomp.split(', ')
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_names(students)
  #Select specific letter:
  #students.select! { |student| student[:name].downcase[0] == 'a' }
  
  #Select shorter than 12 letters:
  #students.select! { |student| student[:name].length < 12 }
  
  students.each_with_index { |student, i| 
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  }
  
  

  #Loop as while:
  #i = 0
  #while i < students.length
  #  puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)"
  #  i += 1
  #end
  
  
end

def print_footer(names)
  ending = names.count == 1 ?  "." :  "s."
  puts "Overall, we have #{names.count} great student" + ending
  puts ''
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_names(@students) if @students.length > 0
  print_footer(@students)
end

def process(selection)
  puts ''
  case selection.downcase
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9", "exit"
    exit
  else 
    puts "I did not recognise that selection."
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each { |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  }
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each { |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  }
  file.close
end

try_load_students
interactive_menu