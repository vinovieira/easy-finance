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
                LISTA DE DESPESAS
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
                <h5 class="card-title">Gestão de Despesas</h5>
                <p class="card-text">Mantenha suas despesas sob controle!</p>
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>Descrição</th>
                        <th class="text-end">Valor</th>
                        <th class="text-end">Data</th>
                        <th>Pago</th>
                        <th class="text-center">Categoria</th>
                        <th class="text-center">Forma de Pagamento</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${expenses}" var="expense">
                        <tr>
                            <td>${expense.description}</td>
                            <td class="text-end">${expense.value}</td>
                            <td class="text-center">
                                <fmt:parseDate
                                        value="${expense.date}"
                                        pattern="yyyy-MM-dd"
                                        var="dateFmt" />
                                <fmt:formatDate
                                        value="${dateFmt}"
                                        pattern="dd-MM-yyyy" />
                            </td>
                            <td class="text-end">${expense.isPaid}</td>
                            <td class="text-end">${expense.categoryId}</td>
                            <td class="text-end">${expense.paymentMethodId}</td>

                            <td class="text-center">
                                <c:url value="expense" var="link">
                                    <c:param name="action" value="open-update-form"/>
                                    <c:param name="id" value="${expense.id}"/>
                                </c:url>
<%--                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalUpdateExpense" onclick="${link}">--%>
<%--                                    Editar--%>
<%--                                </button>--%>
                                <a href="${link}" class="btn btn-primary">Editar</a>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="idDelete.value = ${expense.id}">
                                    Exluir
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCreateExpense">
                    Cadastrar Despesa
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Modais -->
<div class="modal fade" id="modalCreateExpense" tabindex="-1" aria-labelledby="modalCreateExpenseLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalCreateExpenseLabel">Cadastro de Despesa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="expense?action=create" method="post">
                    <input type="hidden" value="${user.getId()}" name="user-id">
                    <div class="form-group mb-3">
                        <label for="id-description">Descrição</label>
                        <input type="text" name="description" id="id-description" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-value">Valor</label>
                        <input type="text" name="value" id="id-value" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-date">Data da Despesa</label>
                        <input type="date" name="date" id="id-date" class="form-control">
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="is-paid" value="1" required ${expense.isPaid == 1 ? "checked" : ""}> Pago
                        </label>
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="is-paid" value="0" ${expense.isPaid == 0 ? "checked" : ""}> Não Pago
                        </label>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-category">Categoria</label>
                        <input type="text" name="category" id="id-category" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-payment-method">Forma de Pagamento</label>
                        <input type="text" name="payment" id="id-payment-method" class="form-control">
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
<div class="modal fade" id="modalUpdateExpense" tabindex="-1" aria-labelledby="modalUpdateExpenseLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalUpdateExpenseLabel">Atualizar Despesa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="expense" method="post">
                    <input type="hidden" value="update" name="action">
                    <input type="hidden" value="${expense.id}" name="id">
                    <input type="hidden" value="${user.getId()}" name="user-id">

                    <div class="form-group mb-3">
                        <label for="id-update-description">Nome</label>
                        <input type="text" name="description" id="id-update-description" class="form-control" value="${expense.description}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-value">Valor</label>
                        <input type="text" name="value" id="id-update-value" class="form-control" value="${expense.value}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-date">Data da Despesa</label>
                        <input type="date" name="date" id="id-update-date" class="form-control" value="${expense.date}">
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="is-paid" value="1" required ${expense.isPaid == 1 ? "checked" : ""}> Pago
                        </label>
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="is-paid" value="0" ${expense.isPaid == 0 ? "checked" : ""}> Não Pago
                        </label>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-category">Categoria</label>
                        <input type="text" name="category" id="id-update-category" class="form-control" value="${expense.categoryId}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-payment-method">Forma de Pagamento</label>
                        <input type="text" name="payment" id="id-update-payment-method" class="form-control" value="${expense.paymentMethodId}">
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="expense?action=list" class="btn btn-warning">Cancelar</a>
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
        console.log("DOM Loaded");
        <% if (request.getAttribute("showModal") != null && (boolean) request.getAttribute("showModal")) { %>
        console.log("showModal = true");
        const modal = new bootstrap.Modal(document.getElementById('modalUpdateExpense'));
        modal.show();
        <% } %>
    });
</script>
</body>
</html>