<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="pt_BR"/>

<!DOCTYPE html>
<html>
<head>
    <title>EasyFinance</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initialscale=1.0">
    <link rel="stylesheet" href="./resources/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
          integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<%@include file="header.jsp" %>
<div class="container">
    <div class="mt-5 ms-md-5 me-md-5">
        <div class="card mb-3">
            <div class="card-header">
                DASHBOARD
            </div>
            <c:if test="${not empty mensagem}">
                <div class="alert alert-success ms-2 me-2 m-auto mt-2">
                        ${mensagem}
                </div>
            </c:if>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger ms-2 me-2 m-auto mt-2">
                        ${erro}
                </div>
            </c:if>
            <div class="card-body table-responsive row mb-3 justify-content-between align-items-center">
                <div class="col-sm-4 mb-3">
                    <h5 class="card-title">Gestão de Finanças</h5>
                    <p class="card-text">Mantenha suas finanças sob controle!</p>
                </div>
                <div class="mb-3 col-sm-auto">
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Filtros</h5>
                            <div class="btn-group d-flex flex-wrap" role="group" aria-label="Basic outlined example">
                                <c:url value="dashboard" var="link">
                                    <c:param name="action" value="list"/>
                                    <c:param name="dateStart" value="${LocalDate.now().minusWeeks(1)}"/>
                                    <c:param name="dateEnd" value="${LocalDate.now()}"/>
                                </c:url>
                                <a type="button" class="btn btn-outline-secondary" href="${link}">Últimos 7 dias</a>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-secondary dropdown-toggle"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                        Selecione o mês
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">Janeiro</a></li>
                                        <li><a class="dropdown-item" href="#">Fevereiro</a></li>
                                        <li><a class="dropdown-item" href="#">Março</a></li>
                                    </ul>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-secondary dropdown-toggle"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                        Selecione o ano
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">2024</a></li>
                                        <li><a class="dropdown-item" href="#">2023</a></li>
                                        <li><a class="dropdown-item" href="#">2022</a></li>
                                    </ul>
                                </div>

                                <button type="button" class="btn btn-outline-secondary">Sempre</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4 mb-3">
                        <div class="mb-3">
                            <div class="card border-success">
                                <div class="card-body ">
                                    <h5 class="card-title">Receitas</h5>
                                    <h2 class="card-text">
                                        <fmt:formatNumber value="${incomeSum}" type="currency" groupingUsed="true"
                                                          maxFractionDigits="2" minFractionDigits="2"
                                                          currencyCode="BRL"/>
                                    </h2>
                                    <a href="#" class="btn btn-outline-success">Adicionar Receita</a>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="card border-danger">
                                <div class="card-body ">
                                    <h5 class="card-title">Despesas</h5>
                                    <h2 class="card-text">
                                        <fmt:formatNumber value="${expenseSum}" type="currency" groupingUsed="true"
                                                          maxFractionDigits="2" minFractionDigits="2"
                                                          currencyCode="BRL"/>
                                    </h2>
                                    <a href="#" class="btn btn-outline-danger">Adicionar Despesa</a>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="card border-primary">
                                <div class="card-body">
                                    <h5 class="card-title">Saldo</h5>
                                    <h2 class="card-text"><fmt:formatNumber value="${incomeSum - expenseSum}"
                                                                            type="currency" groupingUsed="true"
                                                                            maxFractionDigits="2" minFractionDigits="2"
                                                                            currencyCode="BRL"/></h2>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <table class="table">
                            <thead>
                            <tr>
                                <th colspan="4" class="text-center">Atividades Recentes</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${dashboardList}" var="operation">
                                <tr>
                                    <td class="text-end">
                                        <c:choose>
                                            <c:when test="${operation.getClass() == 'class br.com.easyfinance.easyfinance.model.Expense' }">
                                                <i class="text-danger fa-solid fa-arrow-right-from-bracket"></i>
                                            </c:when>
                                            <c:when test="${operation.getClass() == 'class br.com.easyfinance.easyfinance.model.Income' }">
                                                <i class="text-success fa-solid fa-arrow-right-to-bracket"></i>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>${operation.description}${operation.date > LocalDate.now() ? " <span class='badge text-bg-warning'>futura</span>": ""}</td>
                                    <td class="text-end ${operation.getClass() == 'class br.com.easyfinance.easyfinance.model.Expense' ? "text-danger-emphasis" : "text-success-emphasis"}">
                                        <fmt:formatNumber value="${operation.value}" type="currency" groupingUsed="true"
                                                          maxFractionDigits="2" minFractionDigits="2"
                                                          currencyCode="BRL"/></td>
                                    <td class="text-end">
                                        <fmt:parseDate
                                                value="${operation.date}"
                                                pattern="yyyy-MM-dd"
                                                var="dateFmt"/>
                                        <fmt:formatDate
                                                value="${dateFmt}"
                                                pattern="dd MMM"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modais -->
<div
        class="modal fade"
        id="deleteModal"
        tabindex="-1"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1
                        class="modal-title fs-5"
                        id="exampleModalLabel">
                    Confirmar Exclusão
                </h1>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <h4>Você confirma a exclusão deste produto?</h4>
                <p><strong>Atenção!</strong> Esta ação é irreversível.</p>
            </div>
            <div class="modal-footer">

                <form action="expense" method="post">
                    <input
                            type="hidden"
                            name="action"
                            value="delete">
                    <input
                            type="hidden"
                            name="idDelete"
                            id="idDelete">
                    <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">
                        Não
                    </button>
                    <button
                            type="submit"
                            class="btn btn-danger">
                        Sim
                    </button>
                </form>

            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
<script src="resources/js/bootstrap.bundle.js"></script>
</body>
</html>