package br.com.easyfinance.easyfinance.dao.impl;
import br.com.easyfinance.easyfinance.dao.ConnectionManager;
import br.com.easyfinance.easyfinance.dao.ExpenseDao;
import br.com.easyfinance.easyfinance.model.Expense;
import br.com.easyfinance.easyfinance.exception.DBException;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class OracleExpenseDao implements ExpenseDao {

    private Connection conexao;

    @Override
    public void create(Expense expense) throws DBException {
        PreparedStatement stmt = null;

        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "INSERT INTO T_EF_EXPENSE " +
                "(id_expense, ds_expense, value_expense, " +
                "date_expense, user_id, isPaid_expense, category_id, payment_method_id) " +
                "VALUES (SQ_TB_EXPENSE.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, expense.getDescription());
            stmt.setDouble(2, expense.getValor());
            stmt.setDate(3, Date.valueOf(expense.getData()));
            stmt.setInt(4, expense.getUserId());
            stmt.setInt(5, expense.isPaid() ? 1 : 0);
            stmt.setInt(6, expense.getCategoryId());
            stmt.setInt(7, expense.getPaymentMethodId());
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
    public void update(Expense expense) throws DBException {
        PreparedStatement stmt = null;
        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "UPDATE T_EF_EXPENSE SET " +
                "ds_expense= ?, " +
                "value_expense= ?, " +
                "date_expense= ?, " +
                "user_id= ?, " +
                "isPaid_expense= ? " +
                "category_id= ? " +
                "payment_method_id= ? " +
                "WHERE id_expense= ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, expense.getDescription());
            stmt.setDouble(2, expense.getValor());
            stmt.setDate(3, Date.valueOf(expense.getData()));
            stmt.setInt(4, expense.getUserId());
            stmt.setInt(5, expense.isPaid() ? 1 : 0);
            stmt.setInt(6, expense.getCategoryId());
            stmt.setInt(7, expense.getPaymentMethodId());
            stmt.setInt(8, expense.getId());
            stmt.executeUpdate();

            System.out.println("Despesa atualizada com sucesso!");

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
        String sql = "DELETE FROM T_EF_EXPENSE WHERE id_expense = ?";
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
    public Expense read(Integer id) {
        Expense expense = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_EXPENSE WHERE id_expense = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()){
                int id_expense = rs.getInt("id_expense");
                String description = rs.getString("ds_expense");
                double value = rs.getDouble("value_expense");
                LocalDate date = rs.getDate("date_expense").toLocalDate();
                int userId = rs.getInt("user_id");
                boolean isPaid = rs.getBoolean("isPaid_expense");
                int categoryId = rs.getInt("category_id");
                int paymentMethodId = rs.getInt("payment_method_id");
                expense = new Expense(id_expense, description, value, date, userId, isPaid, categoryId, paymentMethodId);
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
        return expense;
    }

    @Override
    public List<Expense> list() {
        List<Expense> lista = new ArrayList<Expense>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_EXPENSE";
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();

            //Percorre todos os registros encontrados
            while (rs.next()) {
                int id_expense = rs.getInt("id_expense");
                String description = rs.getString("ds_expense");
                double value = rs.getDouble("value_expense");
                LocalDate date = rs.getDate("date_expense").toLocalDate();
                int userId = rs.getInt("user_id");
                boolean isPaid = rs.getBoolean("isPaid_expense");
                int categoryId = rs.getInt("category_id");
                int paymentMethodId = rs.getInt("payment_method_id");
                Expense expense = new Expense(id_expense, description, value, date, userId, isPaid, categoryId, paymentMethodId);
                lista.add(expense);
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
