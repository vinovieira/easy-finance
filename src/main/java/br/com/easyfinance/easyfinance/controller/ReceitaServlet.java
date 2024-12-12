package br.com.easyfinance.easyfinance.controller;

import br.com.easyfinance.easyfinance.dao.IncomeDao;
import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.factory.DaoFactory;
import br.com.easyfinance.easyfinance.model.Income;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/income")
public class ReceitaServlet extends HttpServlet {

    private IncomeDao dao;

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

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
                    .parseInt(req.getParameter("userId"));
            String source = req
                    .getParameter("source");

            Income income = new Income(
                    0,
                    description,
                    value,
                    date,
                    userId,
                    source
            );

            dao.create(income);

            req.setAttribute("mensagem", "Produto cadastrado!");

        } catch (DBException db) {
            db.printStackTrace();
            req.setAttribute("erro", "Erro ao create");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Por favor, valide os dados");
        }
        //req.getRequestDispatcher("list-income.jsp").forward(req, resp);
        list(req,resp);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String description = req
                    .getParameter("description");
            double value = Double
                    .parseDouble(req.getParameter("value"));
            LocalDate date = LocalDate
                    .parse(req.getParameter("date"));
            int userId = Integer
                    .parseInt(req.getParameter("userId"));
            String source = req
                    .getParameter("source");

            Income income = new Income(
                    id,
                    description,
                    value,
                    date,
                    userId,
                    source
            );

            dao.update(income);

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
        Income income = dao.read(id);
        req.setAttribute("income", income);
//        req.getRequestDispatcher("update-income.jsp")
//                .forward(req, resp);
        req.setAttribute("showModal", true);
        list(req, resp);
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Income> list = dao.list();
        req.setAttribute("incomes", list);
        req.getRequestDispatcher("list-income.jsp")
                .forward(req, resp);
    }

    @Override
    public void init(ServletConfig config) throws ServletException {

        super.init(config);
        dao = DaoFactory.getIncomeDao();

    }
}
