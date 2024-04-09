const User = require('../model/users'); // Importez le modèle users

module.exports = {
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
  }
};
