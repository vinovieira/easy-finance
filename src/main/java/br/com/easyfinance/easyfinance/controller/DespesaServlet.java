package br.com.easyfinance.easyfinance.controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import br.com.easyfinance.easyfinance.dao.DespesaDao;
import br.com.easyfinance.easyfinance.exception.DBException;
import br.com.easyfinance.easyfinance.factory.DaoFactory;
import br.com.easyfinance.easyfinance.model.Despesa;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/despesas")
public class DespesaServlet extends HttpServlet {

    private DespesaDao dao;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");

        switch (acao) {
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

    private void excluir(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int codigo = Integer.parseInt(req.getParameter("codigoExcluir"));
        try {
            dao.remover(codigo);
            req.setAttribute("mensagem", "Produto removido!");
        } catch (DBException e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro ao atualizar!");
        }
        listar(req, resp);
    }

    private void cadastrar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String descricao = req
                    .getParameter("descricao");
            double valor = Double
                    .parseDouble(req.getParameter("valor"));
            LocalDate data = LocalDate
                    .parse(req.getParameter("data"));
            String pagamento = req
                    .getParameter("pagamento");
            String categoria = req
                    .getParameter("categoria");

            Despesa despesa = new Despesa(
                    0,
                    descricao,
                    valor,
                    data,
                    pagamento,
                    categoria
            );

            dao.cadastrar(despesa);

            req.setAttribute("mensagem", "Produto cadastrado!");

        } catch (DBException db) {
            db.printStackTrace();
            req.setAttribute("erro", "Erro ao cadastrar");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Por favor, valide os dados");
        }
        //req.getRequestDispatcher("lista-despesa.jsp").forward(req, resp);
        listar(req,resp);
    }

    private void editar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int codigo = Integer.parseInt(req.getParameter("codigo"));
            String descricao = req
                    .getParameter("descricao");
            double valor = Double
                    .parseDouble(req.getParameter("valor"));
            LocalDate data = LocalDate
                    .parse(req.getParameter("data"));
            String pagamento = req
                    .getParameter("pagamento");
            String categoria = req
                    .getParameter("categoria");

            Despesa despesa = new Despesa(
                    codigo,
                    descricao,
                    valor,
                    data,
                    pagamento,
                    categoria
            );

            dao.atualizar(despesa);

            req.setAttribute("mensagem", "Produto atualizado!");
        } catch (DBException db) {
            db.printStackTrace();
            req.setAttribute("erro", "Erro ao atualizar");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Por favor, valide os dados");
        }
        listar(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");

        switch (acao) {
            case "listar":
                listar(req, resp);
                break;
            case "abrir-form-edicao":
                abrirFormEdicao(req, resp);
        }

    }

    private void abrirFormEdicao(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("codigo"));
        Despesa despesa = dao.buscar(id);
        req.setAttribute("despesa", despesa);
//        req.getRequestDispatcher("editar-despesa.jsp")
//                .forward(req, resp);
        req.setAttribute("mostrarModal", true);
        listar(req, resp);
    }

    private void listar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Despesa> lista = dao.listar();
        req.setAttribute("despesas", lista);
        req.getRequestDispatcher("lista-despesa.jsp")
                .forward(req, resp);
    }

    @Override
    public void init(ServletConfig config) throws ServletException {

        super.init(config);
        dao = DaoFactory.getDespesaDao();

    }
}
