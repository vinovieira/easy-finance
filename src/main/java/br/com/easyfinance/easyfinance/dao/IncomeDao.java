package br.com.easyfinance.easyfinance.dao;

import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.model.Income;

import java.util.List;

public interface IncomeDao {
    void create(Income income) throws DBException;
    void update(Income income) throws DBException;
    void delete(Integer id) throws DBException;
    Income read(Integer id);
    List<Income> list();
}
