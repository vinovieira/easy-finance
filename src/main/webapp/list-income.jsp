<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>EasyFinance</title>
    <meta name="viewport" content="width=device-width, initialscale=1.0">
    <link rel="stylesheet" href="./resources/css/bootstrap.css">
</head>
<body>
<%@include file="header.jsp"%>
<div class="container">
    <div class="mt-5 ms-5 me-5">
        <div class="card mb-3">
            <div class="card-header">
                LISTA DE RECEITA
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
            <div class="card-body table-responsive">
                <h5 class="card-title">Gestão de Receitas</h5>
                <p class="card-text">Mantenha os dados dos seus
                    produtos sempre atualizados e acessíveis.</p>
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>Descrição</th>
                        <th class="text-end">Valor</th>
                        <th class="text-end">Data</th>
                        <th class="text-center">Fonte</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${incomes}" var="income">
                        <tr>
                            <td>${income.description}</td>
                            <td class="text-end">${income.value}</td>
                            <td class="text-center">
                                <fmt:parseDate
                                        value="${income.date}"
                                        pattern="yyyy-MM-dd"
                                        var="dateFmt" />
                                <fmt:formatDate
                                        value="${dateFmt}"
                                        pattern="dd-MM-yyyy" />
                            </td>
                            <td class="text-end">${income.source}</td>

                            <td class="text-center">
                                <c:url value="income" var="link">
                                    <c:param name="action" value="open-edit-form"/>
                                    <c:param name="id" value="${income.id}"/>
                                </c:url>
<%--                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalUpdateIncome" onclick="${link}">--%>
<%--                                    Editar--%>
<%--                                </button>--%>
                                <a href="${link}" class="btn btn-primary">Editar</a>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="idDelete.value = ${income.id}">
                                    Excluir
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCadastroReceita">
                    Cadastrar Receita
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Modais -->
<div class="modal fade" id="modalCadastroReceita" tabindex="-1" aria-labelledby="modalCadastroReceitaLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalCadastroReceitaLabel">Cadastro de Receita</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="income?action=create" method="post">
                    <div class="form-group mb-3">
                        <label for="id-description">Descrição</label>
                        <input type="text" name="description" id="id-description" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-value">Valor</label>
                        <input type="text" name="value" id="id-value" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-date">Data</label>
                        <input type="date" name="date" id="id-date" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-source">Fonte</label>
                        <input type="text" name="source" id="id-source" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Salvar</button>
                </form>
            </div>
        </div>
    </div>
</div>
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

                <form action="income" method="post">
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
<div class="modal fade" id="modalUpdateIncome" tabindex="-1" aria-labelledby="modalUpdateIncomeLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalUpdateIncomeLabel">Atualizar Receita</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="income" method="post">
                    <input type="hidden" value="update" name="action">
                    <input type="hidden" value="${income.id}" name="id">

                    <div class="form-group mb-3">
                        <label for="id-update-description">Nome</label>
                        <input type="text" name="description" id="id-update-description" class="form-control" value="${income.description}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-value">Valor</label>
                        <input type="text" name="value" id="id-update-value" class="form-control" value="${income.value}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-date">Data</label>
                        <input type="date" name="date" id="id-update-date" class="form-control" value="${income.date}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-source">Fonte</label>
                        <input type="text" name="source" id="id-update-source" class="form-control" value="${income.source}">
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="income?action=list" class="btn btn-warning">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
<script src="resources/js/bootstrap.bundle.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        <% if (request.getAttribute("mostrarModal") != null && (boolean) request.getAttribute("mostrarModal")) { %>
        const modal = new bootstrap.Modal(document.getElementById('modalUpdateIncome'));
        modal.show();
        <% } %>
    });
</script>
</body>
</html>