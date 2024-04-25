const express = require("express");
const router = express.Router();
const authController = require("../controller/authController.js");
const userController = require('../controller/userController');
const addProductRouter = require("../controller/addProduct.js");
const Controller = require('../controller');

router.post('/login', authController.login);
router.post('/register',authController.signup);
router.post('/otp',authController.verifOTP);

router.get('/homePage', authController.home);
router.get('/inventory', authController.pagePrincipale);
router.get('/product', authController.afficheProd);

//=========================PAGE====================================
// Route pour ajouter un produit
router.post('/addProduit', addProductRouter.addProduit);


//=============================CRUD===================================

// CRUD utilisateur:
router.post('/create', userController.create);
router.get('/:id', userController.getById);
router.put('/:id', userController.updateById);
router.delete('/:id', userController.deleteById);

// CRUD produit:
router.get('/products', userController.getAllProducts);
router.get('/products/:id', userController.getProductById);
router.post('/products', userController.createProduct);
router.put('/products/:id', userController.updateProduct);
router.delete('/products/:id', userController.deleteProduct);

//CRUD client:
router.post('/clients', userController.createClient);
router.get('/clients/:id', userController.getClientById);
router.put('/clients/:id', userController.updateClientById);
router.delete('/clients/:id', userController.deleteClientById);


module.exports = router;

