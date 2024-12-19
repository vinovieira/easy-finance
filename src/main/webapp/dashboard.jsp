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
<body data-bs-theme="light">
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
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-secondary dropdown-toggle"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                        Selecione o mês
                                    </button>
                                    <ul class="dropdown-menu" id="monthDropdown">
                                        <li><a class="dropdown-item" href="#" data-month="1">Janeiro</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="2">Fevereiro</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="3">Março</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="4">Abril</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="5">Maio</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="6">Junho</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="7">Julho</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="8">Agosto</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="9">Setembro</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="10">Outubro</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="11">Novembro</a></li>
                                        <li><a class="dropdown-item" href="#" data-month="12">Dezembro</a></li>
                                    </ul>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-secondary dropdown-toggle"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                        Selecione o ano
                                    </button>
                                    <ul class="dropdown-menu" id="yearDropdown">
                                        <li><a class="dropdown-item" href="#" data-year="2024">2024</a></li>
                                        <li><a class="dropdown-item" href="#" data-year="2023">2023</a></li>
                                        <li><a class="dropdown-item" href="#" data-year="2022">2022</a></li>
                                    </ul>
                                </div>
                                <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()">Sempre</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-4 mb-3">
                        <div class="mb-3">
                            <div class="card border-success">
                                <div class="card-body " id="incomeCard">
                                    <h5 class="card-title">Receitas</h5>
                                    <h2 class="card-text" id="incomeSum">
                                        <fmt:formatNumber value="${incomeSum}" type="currency" groupingUsed="true"
                                                          maxFractionDigits="2" minFractionDigits="2"
                                                          currencyCode="BRL"/>
                                    </h2>
                                    <button type="button" class="btn btn-outline-success" data-bs-toggle="modal"
                                            data-bs-target="#modalCreateIncome">
                                        Adicionar Receita
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="card border-danger">
                                <div class="card-body " id="expenseCard">
                                    <h5 class="card-title">Despesas</h5>
                                    <h2 class="card-text" id="expenseSum">
                                        <fmt:formatNumber value="${expenseSum}" type="currency" groupingUsed="true"
                                                          maxFractionDigits="2" minFractionDigits="2"
                                                          currencyCode="BRL"/>
                                    </h2>
                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                            data-bs-target="#modalCreateExpense">
                                        Adicionar Despesa
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="card border-primary">
                                <div class="card-body">
                                    <h5 class="card-title">Saldo</h5>
                                    <h2 class="card-text" id="balanceSum">
                                        <fmt:formatNumber value="${incomeSum - expenseSum}" type="currency" groupingUsed="true"
                                                          maxFractionDigits="2" minFractionDigits="2"
                                                          currencyCode="BRL"/>
                                    </h2>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <table class="table" id="operationsTable">
                            <thead>
                            <tr>
                                <th colspan="4" class="text-center">Atividades Recentes</th>
                            </tr>
                            </thead>
                            <tbody id="tableBody">
                            <c:forEach items="${dashboardList}" var="operation">
                                <tr class="operation-row" data-month="${operation.date.monthValue}" data-year="${operation.date.year}">
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
                                                          currencyCode="BRL"/>
                                    </td>
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

<script>
    let incomeSum = 0;
    let expenseSum = 0;

    function applyFilters(month, year) {
        const rows = document.querySelectorAll('.operation-row');
        incomeSum = 0;
        expenseSum = 0;

        rows.forEach(row => {
            const rowMonth = row.getAttribute('data-month');
            const rowYear = row.getAttribute('data-year');
            const value = parseFloat(row.querySelector('td:nth-child(3)').textContent.replace('R$', '').replace('.', '').replace(',', '.'));

            if ((month && rowMonth !== month) || (year && rowYear !== year)) {
                row.style.display = 'none';
            } else {
                row.style.display = '';
                if (row.querySelector('td:nth-child(1) i').classList.contains('fa-arrow-right-from-bracket')) {
                    expenseSum += value;
                } else {
                    incomeSum += value;
                }
            }
        });

        updateSums();
    }

    function updateSums() {
        document.getElementById('incomeSum').textContent = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(incomeSum);
        document.getElementById('expenseSum').textContent = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(expenseSum);
        document.getElementById('balanceSum').textContent = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(incomeSum - expenseSum);
    }

    document.querySelectorAll('#monthDropdown .dropdown-item').forEach(item => {
        item.addEventListener('click', (e) => {
            const month = e.target.getAttribute('data-month');
            applyFilters(month, null);
        });
    });

    document.querySelectorAll('#yearDropdown .dropdown-item').forEach(item => {
        item.addEventListener('click', (e) => {
            const year = e.target.getAttribute('data-year');
            applyFilters(null, year);
        });
    });

    function clearFilters() {
        applyFilters(null, null);
    }

    applyFilters((new Date().getMonth() + 1).toString().padStart(2, '0'), null);

</script>

<%@include file="footer.jsp" %>
<%@include file="modal/modalCreateIncome.jsp"%>
<%@include file="modal/modalCreateExpense.jsp"%>
<script src="resources/js/bootstrap.bundle.js"></script>
</body>
</html>
