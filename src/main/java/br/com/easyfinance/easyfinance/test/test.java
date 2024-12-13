package br.com.easyfinance.easyfinance.test;

import br.com.easyfinance.easyfinance.dao.ExpenseDao;
import br.com.easyfinance.easyfinance.dao.UserDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleExpenseDao;
import br.com.easyfinance.easyfinance.factory.DaoFactory;
import br.com.easyfinance.easyfinance.model.Expense;
import br.com.easyfinance.easyfinance.model.User;

import java.util.List;

public class test {
    public static void main(String[] args) {
        User user = new User(1, "Silvino", "test@123.com", "123456");
        UserDao userDao = DaoFactory.getUserDao();
        System.out.println(userDao.validateUser(user));

        System.out.println("==================================");
        ExpenseDao expenseDao = DaoFactory.getExpenseDao();
        List<Expense> lista = expenseDao.list(1);
        for (Expense e : lista) {
            System.out.println(e);
        }
    }
}
