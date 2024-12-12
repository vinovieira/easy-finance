package br.com.easyfinance.easyfinance.controller;

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

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/expense")
public class ExpenseServlet extends HttpServlet {

    private ExpenseDao dao;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        switch (action) {
            case ("cadastrar"):
                cadastrar(req, resp);
                break;
            case ("editar"):
                editar(req, resp);
                break;
            case ("excluir"):
                excluir(req, resp);
        }

    }

    private void excluir(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idExcluir"));
        try {
            dao.delete(id);
            req.setAttribute("mensagem", "Produto removido!");
        } catch (DBException e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro ao atualizar!");
        }
        list(req, resp);
    }

    private void cadastrar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String description = req
                    .getParameter("description");
            double value = Double
                    .parseDouble(req.getParameter("value"));
            LocalDate date = LocalDate
                    .parse(req.getParameter("date"));
            int userId = Integer
                    .parseInt(req.getParameter("userId"));
            boolean isPaid = Boolean
                    .parseBoolean(req.getParameter("isPaid"));
            int categoryId = Integer
                    .parseInt(req.getParameter("categoryId"));
            int paymentMethodId = Integer
                    .parseInt(req.getParameter("paymentMethodId"));

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
            req.setAttribute("erro", "Erro ao cadastrar");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Por favor, valide os dados");
        }
        //req.getRequestDispatcher("list-expense.jsp").forward(req, resp);
        list(req,resp);
    }

    private void editar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
                    .parseInt(req.getParameter("userId"));
            boolean isPaid = Boolean
                    .parseBoolean(req.getParameter("isPaid"));
            int categoryId = Integer
                    .parseInt(req.getParameter("categoryId"));
            int paymentMethodId = Integer
                    .parseInt(req.getParameter("paymentMethodId"));

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
            case "open-edit-form":
                openEditForm(req, resp);
        }

    }

    private void openEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Expense expense = dao.read(id);
        req.setAttribute("expense", expense);
//        req.getRequestDispatcher("editar-expense.jsp")
//                .forward(req, resp);
        req.setAttribute("showModal", true);
        list(req, resp);
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Expense> list = dao.list();
        req.setAttribute("expenses", list);
        req.getRequestDispatcher("list-expense.jsp")
                .forward(req, resp);
    }

    @Override
    public void init(ServletConfig config) throws ServletException {

        super.init(config);
        dao = DaoFactory.getDespesaDao();

    }
}
