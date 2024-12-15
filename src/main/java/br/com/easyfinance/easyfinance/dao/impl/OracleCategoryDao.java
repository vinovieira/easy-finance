package br.com.easyfinance.easyfinance.dao.impl;

import br.com.easyfinance.easyfinance.dao.CategoryDao;
import br.com.easyfinance.easyfinance.dao.ConnectionManager;
import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OracleCategoryDao implements CategoryDao {

    Connection conexao = null;

    @Override
    public List<Category> list() {
        conexao = ConnectionManager.getInstance().getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Category> list = new ArrayList<Category>();
        String sql = "SELECT * FROM T_EF_CATEGORY";

        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                Category category = new Category();
                category.setId(rs.getInt("id_category"));
                category.setName(rs.getString("nm_category"));
                list.add(category);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            try {
                rs.close();
                stmt.close();
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}
