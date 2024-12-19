package br.com.easyfinance.easyfinance.controller;

import br.com.easyfinance.easyfinance.dao.ExpenseDao;
import br.com.easyfinance.easyfinance.dao.IncomeDao;
import br.com.easyfinance.easyfinance.factory.DaoFactory;
import br.com.easyfinance.easyfinance.model.Expense;
import br.com.easyfinance.easyfinance.model.Income;
import br.com.easyfinance.easyfinance.model.Operation;
import br.com.easyfinance.easyfinance.model.User;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private ExpenseDao expenseDao;
    private IncomeDao incomeDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        expenseDao = DaoFactory.getExpenseDao();
        incomeDao = DaoFactory.getIncomeDao();
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");

        switch(action){
            case "list":
                list(req, resp);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        int userId = user.getId();

        List<Income> incomeList = incomeDao.list(userId);
        List<Expense> expenseList = expenseDao.list(userId);

        List<Operation> dashboardList = getSortedOperationList(incomeList, expenseList);

        req.setAttribute("dashboardList", dashboardList);
        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);

    }

    private List<Operation> getSortedOperationList(List<Income> incomeList, List<Expense> expenseList) {
        List<Operation> dashboardList = new ArrayList<>();
        dashboardList.addAll(incomeList);
        dashboardList.addAll(expenseList);

        dashboardList.sort((t1, t2) -> { return t2.getDate().compareTo(t1.getDate()); });

        return dashboardList;
    };
}
