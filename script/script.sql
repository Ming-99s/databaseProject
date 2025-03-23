create DATABASE quiz_app;
USE quiz_app;

-- Create the users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the categories table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Create the quiz_questions table with a foreign key to categories
CREATE TABLE quiz_questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('multiple', 'boolean') NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
    category_id INT NOT NULL,
    question TEXT NOT NULL,
    correct_answer VARCHAR(255) NOT NULL,
    incorrect_answers JSON NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Insert default categories
INSERT INTO categories (id, name) VALUES 
(9, 'General Knowledge'),
(10, 'Entertainment: Books'),
(11, 'Science & Nature'),
(12, 'Sports'),
(13, 'History');

select * from categories;
select * from quiz_questions;
-- ALTER TABLE users ADD COLUMN role ENUM('admin', 'user') DEFAULT 'user';

-- delete from users where id<800;
-- ALTER TABLE users AUTO_INCREMENT = 1;
-- select * from users;
-- UPDATE users SET role = 'admin' WHERE id = 1;
-- ALTER TABLE users ADD CONSTRAINT unique_username UNIQUE (username);

-- General Knowledge
INSERT INTO quiz_questions (type, difficulty, category_id, question, correct_answer, incorrect_answers)
VALUES
('multiple', 'easy', 9, 'What is the capital of Japan?', 'Tokyo', JSON_ARRAY('Seoul', 'Beijing', 'Osaka')),
('boolean', 'medium', 9, 'Is the Earth round?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 9, 'Which is the longest river in the world?', 'Amazon', JSON_ARRAY('Nile', 'Yangtze', 'Ganges')),
('multiple', 'easy', 9, 'Which planet is known as the Red Planet?', 'Mars', JSON_ARRAY('Venus', 'Earth', 'Jupiter')),
('boolean', 'medium', 9, 'Is the Earth flat?', 'False', JSON_ARRAY('True')),
('multiple', 'easy', 9, 'What is the national flower of Japan?', 'Cherry Blossom', JSON_ARRAY('Lotus', 'Rose', 'Tulip')),
('boolean', 'easy', 9, 'Is the Eiffel Tower in Paris?', 'True', JSON_ARRAY('False')),
('multiple', 'medium', 9, 'Which is the largest continent?', 'Asia', JSON_ARRAY('Africa', 'Europe', 'America')),
('multiple', 'hard', 9, 'Which country has the most islands?', 'Sweden', JSON_ARRAY('Finland', 'Norway', 'Indonesia')),
('boolean', 'medium', 9, 'Is Africa the largest continent by population?', 'True', JSON_ARRAY('False')),

-- Entertainment: Books
('multiple', 'easy', 10, 'Who wrote "To Kill a Mockingbird"?', 'Harper Lee', JSON_ARRAY('J.K. Rowling', 'Jane Austen', 'George Orwell')),
('boolean', 'medium', 10, 'Is "The Great Gatsby" written by F. Scott Fitzgerald?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 10, 'Who is the author of the "Lord of the Rings" series?', 'J.R.R. Tolkien', JSON_ARRAY('George R.R. Martin', 'C.S. Lewis', 'J.K. Rowling')),
('multiple', 'medium', 10, 'Which book series is about a young wizard attending Hogwarts School of Witchcraft and Wizardry?', 'Harry Potter', JSON_ARRAY('Percy Jackson', 'The Chronicles of Narnia', 'The Hunger Games')),
('boolean', 'easy', 10, 'Is "The Hobbit" a book by J.R.R. Tolkien?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 10, 'Which novel begins with the line, "Call me Ishmael"?', 'Moby Dick', JSON_ARRAY('Pride and Prejudice', 'The Catcher in the Rye', '1984')),
('boolean', 'medium', 10, 'Is the author of "1984" George Orwell?', 'True', JSON_ARRAY('False')),
('multiple', 'easy', 10, 'Who wrote "Pride and Prejudice"?', 'Jane Austen', JSON_ARRAY('Charlotte Brontë', 'Emily Dickinson', 'Virginia Woolf')),
('multiple', 'hard', 10, 'Which author wrote the book "Brave New World"?', 'Aldous Huxley', JSON_ARRAY('H.G. Wells', 'Ray Bradbury', 'Philip K. Dick')),
('multiple', 'medium', 10, 'Which book won the Pulitzer Prize for Fiction in 2019?', 'The Overstory', JSON_ARRAY('The Underground Railroad', 'The Goldfinch', 'Normal People')),

-- Science & Nature
('multiple', 'easy', 11, 'What is the atomic number of Helium?', '2', JSON_ARRAY('1', '4', '3')),
('boolean', 'medium', 11, 'Is the boiling point of water 100°C at sea level?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 11, 'What is the chemical symbol for water?', 'H2O', JSON_ARRAY('CO2', 'O2', 'H2')),
('multiple', 'medium', 11, 'Which planet is closest to the Sun?', 'Mercury', JSON_ARRAY('Venus', 'Earth', 'Mars')),
('boolean', 'hard', 11, 'Is the human body made up of 60% water?', 'True', JSON_ARRAY('False')),
('multiple', 'easy', 11, 'What gas do plants absorb from the atmosphere?', 'Carbon Dioxide', JSON_ARRAY('Oxygen', 'Nitrogen', 'Hydrogen')),
('multiple', 'medium', 11, 'What is the chemical symbol for gold?', 'Au', JSON_ARRAY('Ag', 'Fe', 'Pb')),
('boolean', 'easy', 11, 'Is the Earth round?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 11, 'What is the atomic number of Uranium?', '92', JSON_ARRAY('94', '88', '90')),
('boolean', 'medium', 11, 'Is oxygen a gas at room temperature?', 'True', JSON_ARRAY('False')),

-- Sports
('multiple', 'easy', 12, 'Which country won the 2018 FIFA World Cup?', 'France', JSON_ARRAY('Brazil', 'Germany', 'Argentina')),
('boolean', 'medium', 12, 'Is Roger Federer a tennis player?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 12, 'Which team won the most NBA championships?', 'Boston Celtics', JSON_ARRAY('Los Angeles Lakers', 'Chicago Bulls', 'Golden State Warriors')),
('multiple', 'easy', 12, 'In which sport would you perform a slam dunk?', 'Basketball', JSON_ARRAY('Football', 'Tennis', 'Baseball')),
('boolean', 'medium', 12, 'Is Usain Bolt a sprinter?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 12, 'Who won the 100 meters final at the 2008 Olympics?', 'Usain Bolt', JSON_ARRAY('Tyson Gay', 'Asafa Powell', 'Justin Gatlin')),
('multiple', 'easy', 12, 'How many players are on a football team?', '11', JSON_ARRAY('9', '10', '12')),
('boolean', 'hard', 12, 'Is Lionel Messi a soccer player?', 'True', JSON_ARRAY('False')),
('multiple', 'medium', 12, 'Which country is the host for the 2022 FIFA World Cup?', 'Qatar', JSON_ARRAY('Russia', 'Brazil', 'England')),
('multiple', 'easy', 12, 'In which sport is the term "hole-in-one" used?', 'Golf', JSON_ARRAY('Tennis', 'Basketball', 'Football')),

-- History
('multiple', 'easy', 13, 'Who was the first man to walk on the moon?', 'Neil Armstrong', JSON_ARRAY('Yuri Gagarin', 'Buzz Aldrin', 'Michael Collins')),
('multiple', 'medium', 13, 'Who was the first president of the United States?', 'George Washington', JSON_ARRAY('Abraham Lincoln', 'Thomas Jefferson', 'John Adams')),
('boolean', 'hard', 13, 'Was Cleopatra the last Pharaoh of Egypt?', 'True', JSON_ARRAY('False')),
('multiple', 'easy', 13, 'In which year did World War I begin?', '1914', JSON_ARRAY('1912', '1920', '1939')),
('boolean', 'medium', 13, 'Did Napoleon Bonaparte die in exile?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 13, 'Who was the first emperor of China?', 'Qin Shi Huang', JSON_ARRAY('Han Wudi', 'Emperor Wu', 'Li Shimin')),
('multiple', 'easy', 13, 'What is the name of the ship that sank in 1912?', 'Titanic', JSON_ARRAY('Lusitania', 'Queen Mary', 'Britannic')),
('boolean', 'medium', 13, 'Was the Berlin Wall torn down in 1989?', 'True', JSON_ARRAY('False')),
('multiple', 'hard', 13, 'Who was the prime minister of the United Kingdom during World War II?', 'Winston Churchill', JSON_ARRAY('Neville Chamberlain', 'Clement Attlee', 'Edward Heath')),
('multiple', 'easy', 13, 'Who was the first emperor of the Roman Empire?', 'Augustus', JSON_ARRAY('Julius Caesar', 'Tiberius', 'Nero'));

