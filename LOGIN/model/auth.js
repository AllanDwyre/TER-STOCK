// API POUR VERIF NUM TEL

module.exports = {
    selectLogInName: function (connection, username, callback) {
        connection.query("SELECT * FROM login.users WHERE username = ?", [username], callback);
    },
    selectLogInEmail: function (connection, usermail, callback){
        connection.query("SELECT * FROM login.users WHERE user_mail = ?", [usermail], callback);
    },
    selectSignUpTel: function (connection, user_tel, callback) {
        connection.query("SELECT * FROM users WHERE user_tel = ?", [user_tel], callback);
    },
    insert: function (connection, user_id, username, usermail, user_date, user_tel, callback) {
        var credentials = [[user_id, username , usermail, user_date, user_tel]];
        connection.query("INSERT INTO login.users (user_id, username, user_mail, user_tel, user_date_naiss) VALUES (?, ?, ?, ?, ?)", [credentials], callback);
    }
};