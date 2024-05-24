const sequelize = require("../config/db");
const KEY = process.env.DEV_KEY;
var jwt = require("jsonwebtoken");
const produit_vendu = require("../model/tables/produit_vendu");
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);

module.exports = {
  // recuperer tout les produits
  getAllProducts: async (req, res) => {
    try {
      const products = await db.PRODUIT.findAll();
      res.json(products);
    } catch (error) {
      res.status(500).json({
        message:
          "Erreur lors de la récupération des produits: " + error.message,
      });
    }
  },
  getProductPagination: async (req, res) => {
    try {
      const start = parseInt(req.query.start);
      const limit = parseInt(req.query.limit);

      if (isNaN(start) || isNaN(limit)) {
        throw new Error("start and limit must be enter as a positive number !");
      }
      console.log(`Product pagination => start : ${start}, limit : ${limit}`);

      models.produit
        .findAll({
          include: [
            {
              model: models.inventaire_produit,
              as: "inventaire_produits",
              required: true,
            },
          ],
          order: [["PRODUIT_ID", "ASC"]],
          offset: start,
          limit: limit,
        })
        .then((result) => {
          const formattedResult = result.map((produit) => {
            return produit.dataValues;
          });
          console.table(formattedResult);
          console.table(
            formattedResult.map((produit) => {
              return produit.inventaire_produits[0].dataValues;
            })
          );
          res.status(200).json(result);
        })
        .catch((error) => {
          console.error("Error fetching products:", error);
        });
    } catch (error) {
      res.status(500).json({
        message:
          "Erreur lors de la récupération des produits: " + error.message,
      });
    }
  },

  // recuperer un seul produit specifique
  getProductById: async (req, res) => {
    try {
      const productId = parseInt(req.query.id);
      console.log(`Product fecthing... => id : ${productId}`);

      const product = await models.produit.findByPk(productId, {
        include: [
          {
            model: models.inventaire_produit,
            as: "inventaire_produits",
            required: true,
          },
        ],
      });

      if (!product) {
        return res.status(404).json({ message: "Produit non trouvé" });
      }
      console.table(product.dataValues);

      res.json(product);
    } catch (error) {
      res.status(500).json({
        message: "Erreur lors de la récupération du produit: " + error.message,
      });
    }
  },
  // Creer un nouveau produit
  createProduct: async (req, res) => {
    try {
      const productData = req.body;
      const newProduct = await db.PRODUIT.create(productData);
      res.status(201).json(newProduct);
    } catch (error) {
      res.status(500).json({
        message: "Erreur lors de la création du produit: " + error.message,
      });
    }
  },
  // Update un produit en lui passant en parametre un id
  updateProduct: async (req, res) => {
    try {
      const productId = req.params.id;
      const newData = req.body;
      const product = await db.PRODUIT.findByPk(productId);
      if (!product) {
        return res.status(404).json({ message: "Produit non trouvé" });
      }
      await product.update(newData);
      res.json(product);
    } catch (error) {
      res.status(500).json({
        message: "Erreur lors de la mise à jour du produit: " + error.message,
      });
    }
  },
  // Delete un produit en lui passant en parametre un id
  deleteProduct: async (req, res) => {
    try {
      const productId = req.params.id;
      const product = await db.PRODUIT.findByPk(productId);
      if (!product) {
        return res.status(404).json({ message: "Produit non trouvé" });
      }
      await product.destroy();
      res.json({ message: "Produit supprimé avec succès" });
    } catch (error) {
      res.status(500).json({
        message: "Erreur lors de la suppression du produit: " + error.message,
      });
    }
  },

  getTopSellingProduct: async (req, res) => {
    try {
      models.produit
      .findAll({
        include: [
          {
            model: models.produit_vendu,
            as: "produit_vendus",
            required: true,
          },
        ],
        attributes: ['NOM'],
        order: [[sequelize.col("QUANTITE"), "DESC"]],
        limit: 10,
      })
      .then((result) => {
        const formattedResult = result.map((produit) => {
          return produit.dataValues;
        });
        console.table(formattedResult);
        console.table(
          formattedResult.map((produit) => {
            return produit.dataValues;
          })
        );
        res.status(200).json(result);
      })
      .catch((error) => {
        console.error("Error fetching top selling product:", error);
      });
  } catch (error) {
    res.status(500).json({
      message:
        "Erreur lors de la récupération du top selling product: " + error.message,
    });
  }
}
//   getTopSellingProduct: async (req, res) => {
//       try {
//         models.produit_vendu
//         .findAll({
//           include: [
//             {
//               model: models.produit,
//               as: "PRODUIT",
//               required: true,
//             },
//           ],
//           attributes: ['NOM'],
//           order: [["QUANTITE", "DESC"]],
//           limit: 1,
//         })
//         .then((result) => {
//           const formattedResult = result.map((produit_vendu) => {
//             return produit_vendu.dataValues;
//           });
//           console.table(formattedResult);
//           console.table(
//             formattedResult.map((produit_vendu) => {
//               return produit_vendu.produit[0].dataValues;
//             })
//           );
//           res.status(200).json(result);
//         })
//         .catch((error) => {
//           console.error("Error fetching top selling product:", error);
//         });
//     } catch (error) {
//       res.status(500).json({
//         message:
//           "Erreur lors de la récupération du top selling product: " + error.message,
//       });
//     }
// }
};
