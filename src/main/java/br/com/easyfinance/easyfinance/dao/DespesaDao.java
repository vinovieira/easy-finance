package br.com.easyfinance.easyfinance.dao;

import br.com.easyfinance.easyfinance.model.Despesa;
import br.com.easyfinance.easyfinance.exception.DBException;

import java.util.List;

public interface DespesaDao {
    void cadastrar(Despesa despesa) throws DBException;
    void atualizar(Despesa despesa) throws DBException;
    void remover(int codigo) throws DBException;
    Despesa buscar(int id);
    List<Despesa> listar();
}
