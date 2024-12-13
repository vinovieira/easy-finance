package br.com.easyfinance.easyfinance.dao;

import br.com.easyfinance.easyfinance.model.Expense;
import br.com.easyfinance.easyfinance.exception.DBException;

import java.util.List;

public interface ExpenseDao {
    void create(Expense expense) throws DBException;
    void update(Expense expense) throws DBException;
    void delete(Integer id) throws DBException;
    Expense read(Integer id);
    List<Expense> list(int uId) throws DBException;
}
