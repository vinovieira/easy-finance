package br.com.easyfinance.easyfinance.dao.impl;
import br.com.easyfinance.easyfinance.dao.ConnectionManager;
import br.com.easyfinance.easyfinance.dao.DespesaDao;
import br.com.easyfinance.easyfinance.model.Despesa;
import br.com.easyfinance.easyfinance.exception.DBException;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class OracleDespesaDao implements DespesaDao {

    private Connection conexao;

    @Override
    public void cadastrar(Despesa despesa) throws DBException {
        PreparedStatement stmt = null;

        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "INSERT INTO T_EF_DESPESA " +
                "(ID_DESPESA, DS_DESPESA, VALOR_DESPESA, " +
                "DATA_DESPESA, CATEGORIA_DESPESA, FORMA_PAGAMENTO) " +
                "VALUES (SQ_TB_DESPESA.NEXTVAL, ?, ?, ?, ?, ?)";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, despesa.getDescricao());
            stmt.setDouble(2, despesa.getValor());
            stmt.setDate(3, Date.valueOf(despesa.getData()));
            stmt.setString(4, despesa.getCategoria());
            stmt.setString(5, despesa.getPagamento());
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
    public void atualizar(Despesa despesa) throws DBException {
        PreparedStatement stmt = null;
        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "UPDATE T_EF_DESPESA SET " +
                "DS_DESPESA= ?, " +
                "VALOR_DESPESA= ?, " +
                "DATA_DESPESA= ?, " +
                "CATEGORIA_DESPESA= ?, " +
                "FORMA_PAGAMENTO= ? " +
                "WHERE ID_DESPESA= ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, despesa.getDescricao());
            stmt.setDouble(2, despesa.getValor());
            stmt.setDate(3, Date.valueOf(despesa.getData()));
            stmt.setString(4, despesa.getCategoria());
            stmt.setString(5, despesa.getPagamento());
            stmt.setInt(6, despesa.getCodigo());
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
    public void remover(int codigo) throws DBException {
        PreparedStatement stmt = null;
        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "DELETE FROM T_EF_DESPESA WHERE ID_DESPESA = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
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
    public Despesa buscar(int id) {
        Despesa despesa = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_DESPESA WHERE ID_DESPESA = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()){
                int codigo = rs.getInt("ID_DESPESA");
                String descricao = rs.getString("DS_DESPESA");
                double valor = rs.getDouble("VALOR_DESPESA");
                LocalDate data = rs.getDate("DATA_DESPESA").toLocalDate();
                String categoria = rs.getString("CATEGORIA_DESPESA");
                String pagamento = rs.getString("FORMA_PAGAMENTO");
                despesa = new Despesa(codigo, descricao, valor, data, pagamento, categoria);
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
        return despesa;
    }

    @Override
    public List<Despesa> listar() {
        List<Despesa> lista = new ArrayList<Despesa>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_DESPESA";
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();

            //Percorre todos os registros encontrados
            while (rs.next()) {
                int codigo = rs.getInt("ID_DESPESA");
                String descricao = rs.getString("DS_DESPESA");
                double valor = rs.getDouble("VALOR_DESPESA");
                LocalDate data = rs.getDate("DATA_DESPESA").toLocalDate();
                String categoria = rs.getString("CATEGORIA_DESPESA");
                String pagamento = rs.getString("FORMA_PAGAMENTO");
                Despesa despesa = new Despesa(codigo, descricao, valor, data, pagamento, categoria);
                lista.add(despesa);
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
