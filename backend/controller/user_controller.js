const mysql = require('mysql');
const util = require('util');

const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'root',
  database: 'olibf',
  password: "",
});


const getConnection = util.promisify(pool.getConnection).bind(pool);
const query = util.promisify(pool.query).bind(pool);

exports.getAllStudents = async (req, res) => {
  try {
    const connection = await getConnection();
    const results = await query('SELECT * FROM student');
    connection.release();
    res.status(200).json(results);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error occurred' });
  }
};

exports.getStudentProfile = async (req, res) => {
  try {
    const connection = await getConnection();
    const results = await query('SELECT * FROM student WHERE id = ?', [req.params.id]);
    connection.release();
    
    if (results.length === 0) {
      return res.status(404).json({ message: 'user not found' });
    }

    res.status(200).json(results[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error occurred' });
  }
};

exports.createStudent = async (req, res) => {
  try {
    const connection = await getConnection();
    const params = req.body;
    if (!params.firstname || !params.lastname || !params.course || !params.year || typeof params.enrolled !== 'boolean') {
      return res.status(400).json({ error: 'All fields are required and enrolled must be a boolean.' });
    }

    const results = await query('INSERT INTO student SET ?', {
      firstname: params.firstname,
      lastname: params.lastname,
      course: params.course,
      year: params.year,
      enrolled: params.enrolled,
    });
    connection.release();

    res.status(200).json({ message: `Record of ${params.lastname}, ${params.firstname} has been added.` });
  } catch (error) {
    console.error('Error during student creation:', error);
    res.status(500).json({ error: 'Failed to create student. ' + error.message });
  }
};


exports.updateStudent = async (req, res) => {
  try {
    const connection = await getConnection();
    const params = req.body;
    const id = req.params.id;
    const results = await query('UPDATE student SET ? WHERE id = ?', [params, id]);
    connection.release();
    
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'user not found' });
    }

    res.status(200).json({ message: `Record of ${params.last_name}, ${params.first_name} has been updated.` });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error occurred' });
  }
};

exports.deleteStudent = async (req, res) => {
  try {
    const connection = await getConnection();
    const results = await query('DELETE FROM student WHERE id = ?', [req.params.id]);
    connection.release();

    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'user not found' });
    }

    res.status(200).json({ message: `Record with ID #${req.params.id} has been deleted.` });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error occurred' });
  }
};
