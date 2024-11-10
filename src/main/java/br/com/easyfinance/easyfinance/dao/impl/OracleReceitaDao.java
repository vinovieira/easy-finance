package br.com.easyfinance.easyfinance.dao.impl;

import br.com.easyfinance.easyfinance.dao.ConnectionManager;
import br.com.easyfinance.easyfinance.dao.ReceitaDao;
import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.model.Receita;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class OracleReceitaDao implements ReceitaDao {

    private Connection conexao;

    @Override
    public void cadastrar(Receita receita) throws DBException {
        PreparedStatement stmt = null;

        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "INSERT INTO T_EF_RECEITA " +
                "(ID_RECEITA, DS_RECEITA, VALOR_RECEITA, " +
                "DATA_RECEITA, FONTE) " +
                "VALUES (SQ_TB_RECEITA.NEXTVAL, ?, ?, ?, ?)";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, receita.getDescricao());
            stmt.setDouble(2, receita.getValor());
            stmt.setDate(3, Date.valueOf(receita.getData()));
            stmt.setString(4, receita.getFonte());
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
    public void atualizar(Receita receita) throws DBException {
        PreparedStatement stmt = null;
        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "UPDATE T_EF_RECEITA SET " +
                "DS_RECEITA= ?, " +
                "VALOR_RECEITA= ?, " +
                "DATA_RECEITA= ?, "+
                "FONTE= ? " +
                "WHERE ID_RECEITA= ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, receita.getDescricao());
            stmt.setDouble(2, receita.getValor());
            stmt.setDate(3, Date.valueOf(receita.getData()));
            stmt.setString(4, receita.getFonte());
            stmt.setInt(5, receita.getCodigo());
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
    public void remover(int codigo) throws DBException {
        PreparedStatement stmt = null;
        conexao = ConnectionManager.getInstance().getConnection();
        String sql = "DELETE FROM T_EF_RECEITA WHERE ID_RECEITA = ?";
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
    public Receita buscar(int id) {
        Receita receita = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_RECEITA WHERE ID_RECEITA = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()){
                int codigo = rs.getInt("ID_RECEITA");
                String descricao = rs.getString("DS_RECEITA");
                double valor = rs.getDouble("VALOR_RECEITA");
                LocalDate data = rs.getDate("DATA_RECEITA").toLocalDate();
                String fonte = rs.getString("FONTE");
                receita = new Receita(codigo, descricao, valor, data, fonte);
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
        return receita;
    }

    @Override
    public List<Receita> listar() {
        List<Receita> lista = new ArrayList<Receita>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conexao = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT * FROM T_EF_RECEITA";
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();

            //Percorre todos os registros encontrados
            while (rs.next()) {
                int codigo = rs.getInt("ID_RECEITA");
                String descricao = rs.getString("DS_RECEITA");
                double valor = rs.getDouble("VALOR_RECEITA");
                LocalDate data = rs.getDate("DATA_RECEITA").toLocalDate();
                String fonte = rs.getString("FONTE");
                Receita receita = new Receita(codigo, descricao, valor, data, fonte);
                lista.add(receita);
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
