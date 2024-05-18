const express = require("express");
const router = express.Router();
const controllers = require("../controller/Controllers");
const auth = require("../utils/middleware").auth;

router.post("/login", controllers.loginController.login);
router.post("/register", controllers.loginController.signup);
router.get("/homePage", auth, controllers.loginController.home);
router.get("/homePage/getUser", auth, controllers.loginController.getUser);

/* ------ SI ON A LE TEMPS D'INCLURE OTP ---- 

router.post('/login', controllers.authController.login);
router.post('/register',authController.signup);
router.post('/otp',authController.verifOTP);
router.get('/homePage', controllers.authController.home);
 ---------- */

/*router.get('/inventory', authController.pagePrincipale);
router.get('/product', authController.afficheProd);*/


//router.get("/Inventrory/getTopSelling", inventoryController.getProduitPlusVendu);

//=========================PAGE====================================
// Route pour ajouter un produit
router.get("/Product", auth, controllers.productController.getProductById);

router.get("/Product/add", auth, controllers.addProductController.addProduit);
router.get(
  "/Inventory/fetchPagination",
  auth,
  controllers.productController.getProductPagination
);
router.get("/Order", auth, controllers.orderController.showOrders);
router.get("Order/newOrder", auth, controllers.addOrderController.newOrder);

/*=============================CRUD===================================

// CRUD utilisateur:
router.post('/create', controllers.userController.create);
router.get('/:id', controllers.userController.getById);
router.put('/:id', controllers.userController.updateById);
router.delete('/:id', controllers.userController.deleteById);

// CRUD produit:
router.get('/products', controllers.userController.getAllProducts);
router.get('/products/:id', controllers.userController.getProductById);
router.post('/products', controllers.userController.createProduct);
router.put('/products/:id', controllers.userController.updateProduct);
router.delete('/products/:id', controllers.userController.deleteProduct);

//CRUD client:
router.post('/clients', controllers.userController.createClient);
router.get('/clients/:id', controllers.userController.getClientById);
router.put('/clients/:id', controllers.userController.updateClientById);
router.delete('/clients/:id', controllers.userController.deleteClientById);
*/

module.exports = router;
