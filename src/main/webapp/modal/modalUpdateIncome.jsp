<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal fade" id="modalUpdateIncome" tabindex="-1" aria-labelledby="modalUpdateIncomeLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalUpdateIncomeLabel">Atualizar Receita</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="income" method="post">
                    <input type="hidden" value="update" name="action">
                    <input type="hidden" value="${income.id}" name="id" required>
                    <input type="hidden" name="user-id" value="${user.getId()}" required>

                    <div class="form-group mb-3">
                        <label for="id-update-description">Nome</label>
                        <input type="text" name="description" id="id-update-description" class="form-control"
                               value="${income.description}" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-value">Valor</label>
                        <input type="text" name="value" id="id-update-value" class="form-control"
                               value="${income.value}" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-date">Data</label>
                        <input type="date" name="date" id="id-update-date" class="form-control" value="${income.date}"
                               required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-update-source">Fonte</label>
                        <input type="text" name="source" id="id-update-source" class="form-control"
                               value="${income.source}" required>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        <% if (request.getAttribute("showModal") != null && (boolean) request.getAttribute("showModal")) { %>
        const modal = new bootstrap.Modal(document.getElementById('modalUpdateIncome'));
        modal.show();
        <% } %>
    });
</script>
