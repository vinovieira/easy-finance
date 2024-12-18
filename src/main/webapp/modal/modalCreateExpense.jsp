<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
