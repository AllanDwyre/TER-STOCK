const sequelize = require("../config/db");
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

  overviewProduct : async(req,res) => {
    try{
      const prodNom = req.query.nom;

      const productInformation = await models.produit.findOne({
        where: {
          NOM : prodNom
        } 
      });

      console.table(productInformation.dataValues);

      return res.json(productInformation);

    }catch (error) {
      res.status(500).json({
        message: "Erreur lors de la récupération du produit: " + error.message,
      });
    }
  },









/************  CRUD PRODUIT ***************/

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
      console.log(`Top Selling Product =>`);
      await models.produit
        .findAll({
          include: [
            {
              model: models.produit_vendu,
              as: "produit_vendus",
              attributes: [],
              required: true,
            },
          ],
          attributes: ['NOM'],
          order: [[sequelize.col('produit_vendus.QUANTITE'), "DESC"]],
        })
        .then((result) => {
          if (result.length > 0) {
            const topProduct = result[0].dataValues;
            console.table([topProduct]); 
            res.status(200).json(topProduct);
          } else {
            res.status(404).json({ message: "No products found" });
          }
        })
        .catch((error) => {
          console.error("Error fetching top selling product:", error);
          res.status(500).json({
            message: "Error fetching top selling product: " + error.message,
          });
        });
    } catch (error) {
      res.status(500).json({
        message:
          "Erreur lors de la récupération du top selling product: " + error.message,
      });
    }
  },

  // getProductsOverview: async (req,res) => {
  //   try {
  //     consolelog("Products Overview =>");
  //     await models.produit.findAll({
  //       attributes: [
  //         'NOM',
  //         'SKU',
  //         'CLASSE',
  //         'PRIX_UNIT',
  //         [col('Categorie.NOM_CATEGORIE'), 'NOM_CATEGORIE'],
  //         'QUANTITE',
  //         [fn('COALESCE', literal('otw.OTW'), 0), 'OTW']
  //       ],
  //       include: [
  //         {
  //           model: categorie,
  //           attributes: [],
  //           required: true
  //         },
  //         {
  //           model: ligne_commande,
  //           attributes: [],
  //           include: [
  //             {
  //               model: commande,
  //               attributes: [],
  //               where: {
  //                 DATE_REEL_RECU: {
  //                   [Op.is]: null
  //                 }
  //               },
  //               include: [
  //                 {
  //                   model: commande_fournisseur,
  //                   attributes: []
  //                 }
  //               ]
  //             }
  //           ],
  //           required: false
  //         }
  //       ],
  //       subQuery: false,
  //       group: [
  //         'Produit.PRODUIT_ID',
  //         'Produit.NOM',
  //         'Produit.SKU',
  //         'Produit.CLASSE',
  //         'Produit.PRIX_UNIT',
  //         'Categorie.NOM_CATEGORIE',
  //         'Produit.QUANTITE',
  //         'otw.OTW'
  //       ],
  //       raw: true,
  //       having: literal(`
  //         EXISTS (
  //           SELECT 
  //             COUNT(*) as OTW
  //           FROM 
  //             COMMANDE c
  //             JOIN LIGNE_COMMANDE l ON c.COMMANDE_ID = l.COMMANDE_ID
  //             JOIN COMMANDE_FOURNISSEUR cf ON cf.COMM_FOURN_ID = l.COMMANDE_ID
  //           WHERE 
  //             DATE_REEL_RECU IS NULL
  //             AND l.PRODUIT_ID = Produit.PRODUIT_ID
  //           GROUP BY 
  //             l.PRODUIT_ID
  //         )
  //       `)
  //     });
  //   } catch (error){
  //       res.status(500).json({
  //       message:
  //         "Erreur lors de la récupération des produits overview: " + error.message,
  //     });
  //   }
  // }
};
