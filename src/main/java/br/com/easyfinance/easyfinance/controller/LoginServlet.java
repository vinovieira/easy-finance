package br.com.easyfinance.easyfinance.controller;

import br.com.easyfinance.easyfinance.bo.EmailBo;
import br.com.easyfinance.easyfinance.dao.UserDao;
import br.com.easyfinance.easyfinance.exception.EmailException;
import br.com.easyfinance.easyfinance.factory.DaoFactory;
import br.com.easyfinance.easyfinance.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDao dao;
    private EmailBo bo;

    public LoginServlet() {
        dao = DaoFactory.getUserDao();
        bo = new EmailBo();
    }

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(null, null,email, password);
        User authenticatedUser = dao.validateUser(user);

        if (authenticatedUser != null) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(3600);
            session.setAttribute("user", authenticatedUser);

            String mensagem =
                    "Um login foi realizado na plataforma em " + LocalDate.now();
//            request.getRequestDispatcher("home.jsp").forward(request, response);
            response.sendRedirect("dashboard?action=list");

            try {
                bo.enviarEmail(email, "Login Realizado", mensagem);
            } catch (EmailException e) {
                e.printStackTrace();
            }

        }else {
            request.setAttribute("erro", "Usuário e/ou senha inválidos");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        session.invalidate();
        request.getRequestDispatcher("home.jsp").forward(request, response);

    }
}