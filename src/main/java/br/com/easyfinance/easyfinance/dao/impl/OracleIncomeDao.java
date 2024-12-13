package br.com.easyfinance.easyfinance.dao.impl;

import br.com.easyfinance.easyfinance.dao.ConnectionManager;
import br.com.easyfinance.easyfinance.dao.IncomeDao;
import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.model.Income;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class OracleIncomeDao implements IncomeDao {

    private Connection conexao;

    @Override
    public void create(Income income) throws DBException {
        PreparedStatement stmt = null;

        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "INSERT INTO T_EF_INCOME " +
                "(id_income, ds_income, value_income, " +
                "date_income, user_id, source_income) " +
                "VALUES (SQ_TB_INCOME.NEXTVAL, ?, ?, ?, ?, ?)";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, income.getDescription());
            stmt.setDouble(2, income.getValue());
            stmt.setDate(3, Date.valueOf(income.getDate()));
            stmt.setInt(4, income.getUserId());
            stmt.setString(5, income.getSource());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao executar SQL: " + e.getMessage());
            e.printStackTrace();
            throw new DBException("Erro ao cadastrar", e); // Inclui a causa original
        } finally {
            try {
                conexao.close();
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    public void update(Income income) throws DBException {
        PreparedStatement stmt = null;
        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "UPDATE T_EF_INCOME SET " +
                "ds_income= ?, " +
                "value_income= ?, " +
                "date_income= ?, "+
                "user_id= ?, "+
                "source_income= ? " +
                "WHERE id_income= ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, income.getDescription());
            stmt.setDouble(2, income.getValue());
            stmt.setDate(3, Date.valueOf(income.getDate()));
            stmt.setInt(4, income.getUserId());
            stmt.setString(5, income.getSource());
            stmt.setInt(6, income.getId());
            stmt.executeUpdate();

            System.out.println("Receita atualizada com sucesso!");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new DBException("Erro ao atualizar.");
        } finally {
            try {
                stmt.close();
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void delete(Integer id) throws DBException {
        PreparedStatement stmt = null;
        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "DELETE FROM T_EF_INCOME WHERE id_income = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new DBException("Erro ao remover.");
        } finally {
            try {
                stmt.close();
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public Income read(Integer id) {
        Income income = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_INCOME WHERE id_income = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()){
                int id_income = rs.getInt("id_income");
                String description = rs.getString("ds_income");
                double value = rs.getDouble("value_income");
                LocalDate date = rs.getDate("date_income").toLocalDate();
                Integer userId = rs.getInt("user_id");
                String source = rs.getString("source_income");
                income = new Income(id_income, description, value, date, userId, source);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                stmt.close();
                rs.close();
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return income;
    }

    @Override
    public List<Income> list() {
        List<Income> lista = new ArrayList<Income>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_INCOME";
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();

            //Percorre todos os registros encontrados
            while (rs.next()) {
                int id_income = rs.getInt("id_income");
                String description = rs.getString("ds_income");
                double value = rs.getDouble("value_income");
                LocalDate date = rs.getDate("date_income").toLocalDate();
                Integer userId = rs.getInt("user_id");
                String source = rs.getString("source_income");
                Income income = new Income(id_income, description, value, date, userId, source);
                lista.add(income);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                stmt.close();
                rs.close();
                conexao.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return lista;
    }
}
