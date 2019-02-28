task :generate_questions => :environment do
  questions = [
    {
      body: 'What is your favorite colour?',
      answer_choices: ['red', 'green', 'blue']
    },
    {
      body: 'What data base do your prefer?',
      answer_choices: ['Postgresql', 'MySql', 'Mongo']
    },
    {
      body: 'What is your favorite pet?',
      answer_choices: ['Cat', 'Dog', 'Elephant']
    },
  ]

  Question.create(questions)
  puts 'Done!'
end
