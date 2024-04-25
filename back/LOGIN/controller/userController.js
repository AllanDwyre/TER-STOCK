const User = require('../model/tables/users.js');

module.exports = {
  //----------------------utilisateur----------------------------
  // app.post : /users
  create: async (req, res) => {
    try {
      const { USER_ID, USERNAME, USER_MAIL, USER_TEL, USER_DATE_NAISS } = req.body;
      const newUser = await User.create({ USER_ID, USERNAME, USER_MAIL, USER_TEL, USER_DATE_NAISS });
      res.status(201).json({ message: "Utilisateur créé avec succès", user: newUser });
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  },
  //app.get : /users/:id
  getById: async (req, res) => {
    const id = req.params.id;
    try {
      const user = await User.findByPk(id);
      if (user) {
        res.status(200).json({ user });
      } else {
        res.status(404).json({ message: "Utilisateur non trouvé" });
      }
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  },
  //app.patch : /users/:id
  updateById: async (req, res) => {
    const id = req.params.id;
    try {
      const [updatedRows] = await User.update(req.body, { where: { USER_ID: id } });
      if (updatedRows > 0) {
        res.status(200).json({ message: "Utilisateur mis à jour avec succès" });
      } else {
        res.status(404).json({ message: "Utilisateur non trouvé" });
      }
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  },
  //app.delete : /users/:id
  deleteById: async (req, res) => {
    const id = req.params.id;
    try {
      const deletedRows = await User.destroy({ where: { USER_ID: id } });
      if (deletedRows > 0) {
        res.status(200).json({ message: "Utilisateur supprimé avec succès" });
      } else {
        res.status(404).json({ message: "Utilisateur non trouvé" });
      }
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  },

  //----------------Client-------------------------------
  // Créer un nouveau client
  createClient : async (req, res) => {
    try {
        const clientData = req.body;
        const newClient = await Client.create(clientData);
        res.status(201).json(newClient);
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la création du client: ' + error.message });
    }
  },
  // Récupérer un client par son ID
  getClientById : async (req, res) => {
    try {
        const clientId = req.params.id;
        const client = await Client.findByPk(clientId);
        if (!client) {
            return res.status(404).json({ message: 'Client non trouvé' });
        }
        res.json(client);
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la récupération du client: ' + error.message });
    }
  },
  // Mettre à jour un client par son ID
  updateClientById : async (req, res) => {
    try {
        const clientId = req.params.id;
        const newData = req.body;
        const client = await Client.findByPk(clientId);
        if (!client) {
            return res.status(404).json({ message: 'Client non trouvé' });
        }
        await client.update(newData);
        res.json(client);
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la mise à jour du client: ' + error.message });
    }
  },
  // Supprimer un client par son ID
  deleteClientById : async (req, res) => {
    try {
        const clientId = req.params.id;
        const client = await Client.findByPk(clientId);
        if (!client) {
            return res.status(404).json({ message: 'Client non trouvé' });
        }
        await client.destroy();
        res.json({ message: 'Client supprimé avec succès' });
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la suppression du client: ' + error.message });
    }
  },
  //---------------------- Produit ------------------------------
  // Créer un nouveau produit
  createProduct: async (req, res) => {
    try {
      const productData = req.body;
      const newProduct = await Produit.create(productData);
      res.status(201).json(newProduct);
    } catch (error) {
      res.status(500).json({ message: 'Erreur lors de la création du produit : ' + error.message });
    }
  },

  // Récupérer tous les produits
  getAllProducts: async (req, res) => {
    try {
      const produits = await Produit.findAll();
      res.json(produits);
    } catch (error) {
      res.status(500).json({ message: 'Erreur lors de la récupération des produits : ' + error.message });
    }
  },

  // Récupérer un produit par son ID
  getProductById: async (req, res) => {
    try {
      const productId = req.params.id;
      const produit = await Produit.findByPk(productId);
      if (!produit) {
        return res.status(404).json({ message: 'Produit non trouvé' });
      }
      res.json(produit);
    } catch (error) {
      res.status(500).json({ message: 'Erreur lors de la récupération du produit : ' + error.message });
    }
  },

  // Mettre à jour un produit par son ID
  updateProduct: async (req, res) => {
    try {
      const productId = req.params.id;
      const newData = req.body;
      const produit = await Produit.findByPk(productId);
      if (!produit) {
        return res.status(404).json({ message: 'Produit non trouvé' });
      }
      await produit.update(newData);
      res.json(produit);
    } catch (error) {
      res.status(500).json({ message: 'Erreur lors de la mise à jour du produit : ' + error.message });
    }
  },

  // Supprimer un produit par son ID
  deleteProduct: async (req, res) => {
    try {
      const productId = req.params.id;
      const produit = await Produit.findByPk(productId);
      if (!produit) {
        return res.status(404).json({ message: 'Produit non trouvé' });
      }
      await produit.destroy();
      res.json({ message: 'Produit supprimé avec succès' });
    } catch (error) {
      res.status(500).json({ message: 'Erreur lors de la suppression du produit : ' + error.message });
    }
  }
};

