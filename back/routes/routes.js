const express = require("express");
const router = express.Router();
//const authController = require("../controller/authController.js");
const userController = require("../controller/userController.js");
const addProduct = require("../controller/addProductController.js");
const loginController = require("../controller/loginController.js");
const addProductController = require("../controller/addProductController.js");
const orderController = require("../controller/orderController.js");
const addOrderController = require("../controller/addOrderController.js");
const productController = require("../controller/productController.js");

router.post("/login", loginController.login);
router.post("/register", loginController.signup);
router.get("/homePage", loginController.home);
router.get("/homePage/getUser", loginController.getUser);

/* ------ SI ON A LE TEMPS D'INCLURE OTP ---- 

router.post('/login', authController.login);
router.post('/register',authController.signup);
router.post('/otp',authController.verifOTP);
router.get('/homePage', authController.home);
 ---------- */

/*router.get('/inventory', authController.pagePrincipale);
router.get('/product', authController.afficheProd);*/

//=========================PAGE====================================
// Route pour ajouter un produit
router.get("/Product/add", addProduct.addProduit);
router.get("/Inventory");
router.get(
  "/Inventory/fetchPagination",
  productController.getProductPagination
);
router.get("/Order", orderController.showOrders);
router.get("Order/newOrder", addOrderController.newOrder);

/*=============================CRUD===================================

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
*/

module.exports = router;
