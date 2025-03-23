import express from 'express';
import mysql from 'mysql';
import cors from 'cors';
const app = express();

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "Lyming@08",
  database: "quiz_app",
});

app.use(express.json());
app.use(cors());

// Endpoint to fetch all users
app.get("/users", (req, res) => {
  const q = "SELECT * FROM users";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json({ error: err.message });
    return res.json(data);
  });
});

// Endpoint to register a new user
app.post("/signup", (req, res) => {
  const { username, email, password } = req.body;

  // Validate if the required fields are provided
  if (!username || !email || !password) {
    return res.status(400).json({ error: 'Please provide all required fields' });
  }

  // Check if the user with the same email already exists
  const checkEmailQuery = "SELECT * FROM users WHERE email = ?";
  db.query(checkEmailQuery, [email], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    // If email already exists, return error
    if (result.length > 0) {
      return res.status(400).json({ error: 'Email already exists' });
    }

    // Check if the username already exists
    const checkUsernameQuery = "SELECT * FROM users WHERE username = ?";
    db.query(checkUsernameQuery, [username], (err, result) => {
      if (err) return res.status(500).json({ error: err.message });

      // If username already exists, return error
      if (result.length > 0) {
        return res.status(400).json({ error: 'Username already exists' });
      }

      // Proceed with inserting the new user if both email and username are unique
      const q = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
      const values = [username, email, password];

      db.query(q, values, (err, data) => {
        if (err) {
          return res.status(500).json({ error: err.message });
        }
        return res.status(201).json({
          message: "User has been registered successfully!",
          userId: data.insertId, // This provides the ID of the newly inserted user
        });
      });
    });
  });
});

app.post("/login", (req, res) => {
  const { user, password } = req.body;

  if (!user || !password) {
    return res.status(400).json({ error: "Please provide both username and password" });
  }

  // Query to find the user by username
  const q = "SELECT * FROM users WHERE username = ?";
  db.query(q, [user], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    if (result.length === 0) {
      return res.status(400).json({ error: "User not found" });
    }

    const userData = result[0];

    // Check if the password matches (no hashing here for simplicity)
    if (password !== userData.password) {
      return res.status(400).json({ error: "Incorrect password" });
    }

    // Return success message along with user role
    return res.status(200).json({
      message: "Login successful",
      role: userData.role,  // Send the role to the frontend
    });
  });
});

app.get('/categories', (req, res) => {
  const sql = "SELECT id, name FROM categories";
  db.query(sql, (err, results) => {
      if (err) {
          console.error(err);
          return res.status(500).json({ error: 'Database error' });
      }
      res.json(results);
  });
});

// Endpoint to add a quiz question
app.post("/add-quiz", (req, res) => {
  const { type, difficulty, category_id, question, correct_answer, incorrect_answers } = req.body;

  const sql = "INSERT INTO quiz_questions (type, difficulty, category_id, question, correct_answer, incorrect_answers) VALUES (?, ?, ?, ?, ?, JSON_ARRAY(?))";

  db.query(sql, [type, difficulty, category_id, question, correct_answer, incorrect_answers.join(', ')], (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: "Quiz question added successfully!" });
  });
});

app.get('/question', (req, res) => {
  const { amount, category, difficulty, type } = req.query;

  // Build the SQL query dynamically based on the filters provided
  let sql = "SELECT q.id, q.question, q.correct_answer, q.incorrect_answers, q.type, q.difficulty, q.category_id FROM quiz_questions q";
  
  const conditions = [];
  const params = [];

  // Filter by category
  if (category) {
      conditions.push("q.category_id = ?");
      params.push(category); // category should be passed as category_id
  }

  // Filter by difficulty
  if (difficulty) {
      conditions.push("q.difficulty = ?");
      params.push(difficulty);
  }

  // Filter by type
  if (type) {
      conditions.push("q.type = ?");
      params.push(type);
  }

  // Add conditions to SQL if any exist
  if (conditions.length > 0) {
      sql += " WHERE " + conditions.join(" AND ");
  }

  // Limit the number of questions returned based on `amount`
  sql += " LIMIT ?";

  // Add the `amount` to params
  params.push(parseInt(amount));

  // Execute the query with the conditions
  db.query(sql, params, (err, results) => {
      if (err) {
          console.error(err);
          return res.status(500).json({ error: 'Database error' });
      }
      res.json(results);  // Return the questions to the client
  });
});


app.listen(8800, () => {
  console.log('Connected to backend!');
});
