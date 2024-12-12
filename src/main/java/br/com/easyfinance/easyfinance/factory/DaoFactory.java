package br.com.easyfinance.easyfinance.factory;

import br.com.easyfinance.easyfinance.dao.ExpenseDao;
import br.com.easyfinance.easyfinance.dao.IncomeDao;
import br.com.easyfinance.easyfinance.dao.UserDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleExpenseDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleIncomeDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleUserDao;

public class DaoFactory {
    public static ExpenseDao getExpenseDao() {
        return new OracleExpenseDao();
    }
    public static IncomeDao getIncomeDao() {
        return new OracleIncomeDao();
    }
    public static UserDao getUserDao() { return new OracleUserDao(); }
}
