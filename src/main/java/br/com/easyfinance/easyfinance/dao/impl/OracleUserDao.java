package br.com.easyfinance.easyfinance.dao.impl;

import br.com.easyfinance.easyfinance.dao.ConnectionManager;
import br.com.easyfinance.easyfinance.dao.UserDao;
import br.com.easyfinance.easyfinance.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OracleUserDao implements UserDao {

    private Connection conexao;

    @Override
    public User validateUser(User user) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conexao = ConnectionManager
                    .getInstance()
                    .getConnection();

            String sql = "SELECT ID_USER, NM_USER, EMAIL_USER " +
                        "FROM T_EF_USERS " +
                        "WHERE EMAIL_USER = ? AND PASSWORD_USER = ?";

            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            rs = stmt.executeQuery();

            if (rs.next()){
                return new User(rs.getInt("id_user"),
                                rs.getString("nm_user"),
                                rs.getString("email_user"),
                                null);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                stmt.close();
                rs.close();
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}