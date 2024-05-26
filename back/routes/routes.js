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
//produit
router.get("/Products", auth, controllers.productController.getProductById);
router.post("/Products", auth, controllers.addProductController.addProduit);
router.get("Product/Overview", auth, controllers.productController.overviewProduct);

//inventory
router.get(
  "/Inventory/fetchPagination",
  auth,
  controllers.productController.getProductPagination
);
router.get(
  "/Inventory/TotalProductsCount",
  auth,
  controllers.inventoryNINAController.getTotalProductsCount
);
router.get(
  "/inventory/TotalCategories",
  auth,
  controllers.inventoryNINAController.getTotalCategories
);
router.get(
  "/inventory/TopSellingProduct",
  auth,
  controllers.inventoryNINAController.getTopSellingProduct
);
router.get(
  "/inventory/LowStockProductsCount",
  auth,
  controllers.inventoryNINAController.getLowStockProductsCount
);

//order
router.get("/Order", auth, controllers.orderController.showOrders);
router.post("Order/newOrder", auth, controllers.addOrderController.newOrder);
router.get("/Order/TotalOrdersCount",auth,controllers.ordersController.getTotalOrdersCount);
router.get("/Order/TotalOrdersreceived",auth,controllers.ordersController.getTotalOrdersReceived);
router.get("/Order/TotalOrdersreturned",auth,controllers.ordersController.getReturnOrdersCount);
router.get("/Order/TotalOrdersInTransitClient",auth,controllers.ordersController.getOrdersInTransitClient);
router.get("/Order/TotalOrdersInTransitFournisseur",auth,controllers.ordersController.getOrdersInTransitFournisseur);
router.get("/Order/OrderByDate", auth, controllers.ordersController.getOrderByDate);

//Home Page 
router.get("/homePage/totalProducts", auth, controllers.HomePageController.getTotalProductsCount);
router.get("/homePage/totalOrders", auth, controllers.HomePageController.getTotalOrders);
router.get("/homePage/totalfournisseur", auth, controllers.HomePageController.getNumberSupplier);
router.get("/homePage/seuilProducts", auth, controllers.HomePageController.getReplenishmentLevel);
router.get("/homePage/barre", auth, controllers.HomePageController.getSalesAndPurchasesByMonth);



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
