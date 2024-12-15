package br.com.easyfinance.easyfinance.factory;

import br.com.easyfinance.easyfinance.dao.*;
import br.com.easyfinance.easyfinance.dao.impl.*;

public class DaoFactory {
    public static ExpenseDao getExpenseDao() {
        return new OracleExpenseDao();
    }
    public static IncomeDao getIncomeDao() {
        return new OracleIncomeDao();
    }
    public static UserDao getUserDao() { return new OracleUserDao(); }
    public static CategoryDao getCategoryDao() {return new OracleCategoryDao(); }
    public static PaymentMethodDao getPaymentMethodDao(){return new OraclePaymentMethodDao(); }
//    public static SourceDao getSourceDao() {return new OracleSourceDao(); }
}
