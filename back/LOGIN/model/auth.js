// API POUR VERIF NUM TEL

module.exports = {
    selectLogInName: function (connection, username, callback) {
        connection.query("SELECT * FROM login.users WHERE user_name = ?", [username], callback);
    },
    selectLogInFirstName: function (connection, user_first_name, callback) {
        connection.query("SELECT * FROM login.users WHERE user_first_name = ?", [user_first_name], callback);
    },
    selectLogInEmail: function (connection, usermail, callback){
        connection.query("SELECT * FROM login.users WHERE user_mail = ?", [usermail], callback);
    },
    selectSignUpTel: function (connection, user_tel, callback) {
        connection.query("SELECT * FROM users WHERE user_tel = ?", [user_tel], callback);
    },
    insert: function (connection, username, user_first_name, usermail, user_date, user_tel, callback) {
        var credentials = [[username, user_first_name, usermail, user_date, user_tel]];
        connection.query("INSERT INTO login.users (username, password) VALUES ?", [credentials], callback);
    }
};