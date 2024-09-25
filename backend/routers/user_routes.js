const express = require('express');
const router = express.Router();
const userController = require('../controller/user_controller');

 
router.get('/students', userController.getAllStudents);
router.post('/student/createStudent', userController.createStudent);
router.put('/student/updateStudent/:id', userController.updateStudent);
router.delete('/student/deleteStudent/:id', userController.deleteStudent);

module.exports = router;