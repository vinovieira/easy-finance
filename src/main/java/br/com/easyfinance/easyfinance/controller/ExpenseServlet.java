package br.com.easyfinance.easyfinance.controller;

import br.com.easyfinance.easyfinance.dao.CategoryDao;
import br.com.easyfinance.easyfinance.dao.PaymentMethodDao;
import br.com.easyfinance.easyfinance.model.Category;
import br.com.easyfinance.easyfinance.model.PaymentMethod;
import br.com.easyfinance.easyfinance.model.User;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import br.com.easyfinance.easyfinance.dao.ExpenseDao;
import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.factory.DaoFactory;
import br.com.easyfinance.easyfinance.model.Expense;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/expense")
public class ExpenseServlet extends HttpServlet {

    private ExpenseDao dao;
    private CategoryDao categoryDao;
    private PaymentMethodDao paymentMethodDao;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        switch (action) {
            case ("create"):
                create(req, resp);
                break;
            case ("update"):
                update(req, resp);
                break;
            case ("delete"):
                delete(req, resp);
        }

    }

    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idDelete"));
        try {
            dao.delete(id);
            req.setAttribute("mensagem", "Produto removido!");
        } catch (DBException e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro ao atualizar!");
        }
        list(req, resp);
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String description = req
                    .getParameter("description");
            double value = Double
                    .parseDouble(req.getParameter("value"));
            LocalDate date = LocalDate
                    .parse(req.getParameter("date"));
            int userId = Integer
                    .parseInt(req.getParameter("user-id"));
            int isPaid = Integer
                    .parseInt(req.getParameter("is-paid"));
            int categoryId = Integer
                    .parseInt(req.getParameter("category"));
            int paymentMethodId = Integer
                    .parseInt(req.getParameter("payment"));

            Expense expense = new Expense(
                    0,
                    description,
                    value,
                    date,
                    userId,
                    isPaid,
                    categoryId,
                    paymentMethodId
            );

            dao.create(expense);

            req.setAttribute("mensagem", "Produto cadastrado!");

        } catch (DBException db) {
            db.printStackTrace();
            req.setAttribute("erro", "Erro ao create");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Por favor, valide os dados");
        }
        //req.getRequestDispatcher("list-expense.jsp").forward(req, resp);
        list(req,resp);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer
                    .parseInt(req.getParameter("id"));
            String description = req
                    .getParameter("description");
            double value = Double
                    .parseDouble(req.getParameter("value"));
            LocalDate date = LocalDate
                    .parse(req.getParameter("date"));
            int userId = Integer
                    .parseInt(req.getParameter("user-id"));
            int isPaid = Integer
                    .parseInt(req.getParameter("is-paid"));
            int categoryId = Integer
                    .parseInt(req.getParameter("category"));
            int paymentMethodId = Integer
                    .parseInt(req.getParameter("payment"));

            Expense expense = new Expense(
                    id,
                    description,
                    value,
                    date,
                    userId,
                    isPaid,
                    categoryId,
                    paymentMethodId
            );

            dao.update(expense);

            req.setAttribute("mensagem", "Produto atualizado!");
        } catch (DBException db) {
            db.printStackTrace();
            req.setAttribute("erro", "Erro ao atualizar");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Por favor, valide os dados");
        }
        list(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        switch (action) {
            case "list":
                list(req, resp);
                break;
            case "open-update-form":
                openUpdateForm(req, resp);
        }

    }

    private void openUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        int id = Integer.parseInt(req.getParameter("id"));
        Expense expense = dao.read(id);
        req.setAttribute("expense", expense);

        if (user.getId() != expense.getUserId()){
            req.setAttribute("erro", "Acesso negado!");
            list(req, resp);
            return;
        }
        req.setAttribute("showModal", true);
//        req.getRequestDispatcher("list-expense.jsp").forward(req, resp);
        list(req, resp);
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        List<PaymentMethod> paymentMethodList = paymentMethodDao.list();
        req.setAttribute("paymentMethodList", paymentMethodList);

        List<Category> categoryList = categoryDao.list();
        req.setAttribute("categoryList", categoryList);

        List<Expense> list = dao.list(userId);
        req.setAttribute("expenses", list);

        req.getRequestDispatcher("list-expense.jsp")
                .forward(req, resp);
    }

    @Override
    public void init(ServletConfig config) throws ServletException {

        super.init(config);
        dao = DaoFactory.getExpenseDao();
        categoryDao = DaoFactory.getCategoryDao();
        paymentMethodDao = DaoFactory.getPaymentMethodDao();
    }
}
