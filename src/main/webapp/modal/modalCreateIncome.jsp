<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal fade" id="modalCreateIncome" tabindex="-1" aria-labelledby="modalCreateIncomeLabel"
     aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalCreateIncomeLabel">Cadastro de Receita</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="income?action=create" method="post">
          <input type="hidden" name="user-id" value="${user.getId()}" required>
          <div class="form-group mb-3">
            <label for="id-description">Descrição</label>
            <input type="text" name="description" id="id-description" class="form-control"
                   placeholder="Salário" required>
          </div>
          <div class="form-group mb-3">
            <label for="id-value">Valor</label>
            <input type="text" name="value" id="id-value" class="form-control" placeholder="12950.67"
                   required>
          </div>
          <div class="form-group mb-3">
            <label for="id-date">Data</label>
            <input type="date" name="date" id="id-date" class="form-control" value="${LocalDate.now()}">
          </div>
          <div class="form-group mb-3">
            <label for="id-source">Fonte</label>
            <input type="text" name="source" id="id-source" class="form-control" placeholder="Google"
                   required>
          </div>
          <button type="submit" class="btn btn-primary">Salvar</button>
        </form>
      </div>
    </div>
  </div>
</div>
