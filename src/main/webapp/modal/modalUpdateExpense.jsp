<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        <% if (request.getAttribute("showModal") != null && (boolean) request.getAttribute("showModal")) { %>
        console.log("showModal = true");
        const modal = new bootstrap.Modal(document.getElementById('modalUpdateExpense'));
        modal.show();
        <% } %>
    });
</script>
