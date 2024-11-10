package br.com.easyfinance.easyfinance.dao;

import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.model.Receita;

import java.util.List;

public interface ReceitaDao {
    void cadastrar(Receita receita) throws DBException;
    void atualizar(Receita receita) throws DBException;
    void remover(int codigo) throws DBException;
    Receita buscar(int id);
    List<Receita> listar();
}
