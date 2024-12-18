<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="pt_BR"/>

<!DOCTYPE html>
<html>
<head>
    <title>EasyFinance</title>
    <meta name="viewport" content="width=device-width, initialscale=1.0">
    <link rel="stylesheet" href="./resources/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
          integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.13.6/sorting/currency.js"></script>

</head>
<body>
<%@include file="header.jsp" %>
<div class="container">
    <div class="mt-5 ms-md-5 me-md-5">
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
                <div class="row justify-content-between">
                    <div class="col-sm-4 mb-3">
                        <div class="mb-3">
                            <div class="card border-danger">
                                <div class="card-body ">
                                    <h5 class="card-title">Despesas</h5>
                                    <h2 class="card-text">
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
                    </div>
                    <div class="mb-3 col-sm-auto">
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Filtros</h5>
                                <div class="btn-group d-flex flex-wrap" role="group"
                                     aria-label="Basic outlined example">
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
                </div>
                <script>
                    $(document).ready(function () {
                        $('#myTable').DataTable({
                            columnDefs: [
                                {
                                    targets: 1,
                                    type: 'num',
                                    render: function (data, type, row) {
                                        if (type === 'sort' || type === 'type') {
                                            return parseFloat(data.replace(/[^\d,-]/g, '').replace(',', '.')) || 0;
                                        }
                                        return data;
                                    }
                                }
                            ],
                            language: {
                                url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/pt-BR.json"
                            }
                        });
                    });
                </script>
                <table id="myTable" class="display" class="table table-sm">
                    <thead>
                    <tr>
                        <th>Descrição</th>
                        <th class="text-end">Valor</th>
                        <th class="text-end">Data</th>
                        <th class="text-center">Pago</th>
                        <th class="text-center">Categoria</th>
                        <th class="text-center">Forma de Pagamento</th>
                        <th class="text-center">Ação</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${expenses}" var="expense">
                        <tr>
                            <td>${expense.description}${expense.date > LocalDate.now() ? " <span class='badge text-bg-warning'>futura</span>": ""}</td>
                            <td class="text-end"><fmt:formatNumber value="${expense.value}" type="currency"
                                                                   groupingUsed="true" maxFractionDigits="2"
                                                                   minFractionDigits="2" currencyCode="BRL"/></td>
                            <td class="text-end">
                                <fmt:parseDate
                                        value="${expense.date}"
                                        pattern="yyyy-MM-dd"
                                        var="dateFmt"/>
                                <fmt:formatDate
                                        value="${dateFmt}"
                                        pattern="dd MMM"/>
                            </td>
                            <td class="text-center">
                                <div class="text-center form-switch">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            role="switch"
                                            id="switch-ispaid-list"
                                            disabled
                                        ${expense.isPaid == 1 ? "checked" : ""}>
                                        <%--                                    <label class="form-check-label" for="switch-ispaid-list"></label>--%>
                                </div>
                            </td>
                            <td class="text-center">${expense.category.name}</td>
                            <td class="text-center">${expense.paymentMethod.name}</td>

                            <td class="text-center">
                                <c:url value="expense" var="link">
                                    <c:param name="action" value="open-update-form"/>
                                    <c:param name="id" value="${expense.id}"/>
                                </c:url>
                                <a href="${link}" class="btn btn-outline-warning btn-sm"><i
                                        class="fa-regular fa-pen-to-square"></i></a>
                                <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#deleteModal" onclick="idDelete.value = ${expense.id}">
                                    <i class="fa-regular fa-trash-can"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                        data-bs-target="#modalCreateExpense">
                    Adicionar Despesa
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Modais -->
<div class="modal fade" id="modalCreateExpense" tabindex="-1" aria-labelledby="modalCreateExpenseLabel"
     aria-hidden="true">
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
                        <input type="text" name="description" id="id-description" class="form-control"
                               placeholder="Conta de Luz Casa" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-value">Valor</label>
                        <input type="text" name="value" id="id-value" class="form-control" placeholder="560.45"
                               required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-date">Data da Despesa</label>
                        <input type="date" name="date" id="id-date" class="form-control" value="${LocalDate.now()}">
                    </div>
                    <div class="form-check form-switch mb-3">
                        <input
                                class="form-check-input"
                                type="checkbox"
                                role="switch"
                                id="switch-ispaid-create"
                                onchange="updateSwitchValue(this)">
                        <label class="form-check-label" for="switch-ispaid-create">Pago</label>
                        <input type="hidden" name="is-paid" id="switchCreateHiddenInput" value="0">
                    </div>
                    <script>
                        function updateSwitchValue(switchElement) {
                            const value = switchElement.checked ? 1 : 0;
                            document.getElementById('switchCreateHiddenInput').value = value;
                        }
                    </script>
                    <div class="form-floating mb-3">
                        <select class="form-select" name="category" id="id-category" required
                                aria-label="Floating label select example">
                            <option selected>Selecione...</option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        <label for="id-category">Categoria</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" name="payment" id="id-payment-method" required
                                aria-label="Floating label select example">
                            <option selected>Selecione...</option>
                            <c:forEach items="${paymentMethodList}" var="paymentMethod">
                                <option value="${paymentMethod.id}">${paymentMethod.name}</option>
                            </c:forEach>
                        </select>
                        <label for="id-payment-method">Forma de Pagamento</label>
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
<div class="modal fade" id="modalUpdateExpense" tabindex="-1" aria-labelledby="modalUpdateExpenseLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalUpdateExpenseLabel">Atualizar Despesa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="expense" method="post">
                    <input type="hidden" value="update" name="action">
                    <input type="hidden" value="${expense.id}" name="id" required>
                    <input type="hidden" value="${user.getId()}" name="user-id" required>

                    <div class="form-group mb-3">
                        <label for="id-update-description">Nome</label>
                        <input type="text" name="description" id="id-update-description" class="form-control"
                               value="${expense.description}" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-value">Valor</label>
                        <input type="text" name="value" id="id-update-value" class="form-control"
                               value="${expense.value}" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-date">Data da Despesa</label>
                        <input type="date" name="date" id="id-update-date" class="form-control" value="${expense.date}"
                               required>
                    </div>
                    <div class="form-check form-switch mb-3">
                        <input
                                class="form-check-input"
                                type="checkbox"
                                role="switch"
                                id="switch-ispaid-update"
                                onchange="updateSwitchValue(this)"
                        ${expense.isPaid == 1 ? "checked" : ""}>
                        <label class="form-check-label" for="switch-ispaid-update">Pago</label>
                        <input type="hidden" name="is-paid"
                               id="switchUpdateHiddenInput" ${expense.isPaid == 1 ? "value='1'" : "value='0'"}>
                    </div>
                    <script>
                        function updateSwitchValue(switchElement) {
                            const value = switchElement.checked ? 1 : 0;
                            document.getElementById('switchUpdateHiddenInput').value = value;
                        }
                    </script>
                    <div class="form-floating mb-3">
                        <select class="form-select" name="category" id="id-update-category" required
                                aria-label="Floating label select example">
                            <option>Selecione...</option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}" ${expense.category.id == category.id ? "selected" : ""} >${category.name}</option>
                            </c:forEach>
                        </select>
                        <label for="id-update-category">Categoria</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" name="payment" id="id-update-payment-method" required
                                aria-label="Floating label select example">
                            <option>Selecione...</option>
                            <c:forEach items="${paymentMethodList}" var="paymentMethod">
                                <option value="${paymentMethod.id}" ${expense.paymentMethod.id == paymentMethod.id ? "selected" : ""} >${paymentMethod.name}</option>
                            </c:forEach>
                        </select>
                        <label for="id-update-payment-method">Forma de Pagamento</label>
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
<%@include file="footer.jsp" %>
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