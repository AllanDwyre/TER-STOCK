const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// CRUD utilisateur:
router.post('/create', userController.create);
router.get('/:id', userController.getById);
router.put('/:id', userController.updateById);
router.delete('/:id', userController.deleteById);

module.exports = router;
