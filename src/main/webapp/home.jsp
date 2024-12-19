<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>EasyFinance - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./resources/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
          integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body data-bs-theme="light" class="vh-100">
<%@include file="header.jsp" %>
<div class="container m-auto d-flex flex-column h-100">
    <c:if test="${empty user}">
        <div class="card col-4 m-auto">
            <div class="card-body">
                <h3 class="card-title">Login</h3>
                <span class="navbar-text text-danger" style="margin-right:10px">
                        ${erro }
                </span>
                <form action="login" method="post">
                    <div class="mb-3">
                        <label for="exampleInputEmail1" class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" placeholder="E-mail"
                               id="exampleInputEmail1" aria-describedby="emailHelp">
                        <div id="emailHelp" class="form-text">Nós nunca compartilhamos seu email com ninguém.</div>
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Senha</label>
                        <input type="password" name="password" placeholder="Senha" class="form-control"
                               id="exampleInputPassword1">
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="exampleCheck1">
                        <label class="form-check-label" for="exampleCheck1">Lembre-se de mim.</label>
                    </div>
                    <button type="submit" class="btn btn-outline-primary">Entrar</button>
                    <div class="card-body">
                        <p class="card-text text-center">Não tem conta? <a href="#" class="card-link">Cadastre-se</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty user}">
        <h1 class="mt-3">Bem-vindo a EasyFinance!</h1>
        <h5>Seu login foi efetuado com sucesso!</h5>
    </c:if>
</div>
<%@include file="footer.jsp" %>
<script src="resources/js/bootstrap.bundle.js"></script>
</body>
</html>