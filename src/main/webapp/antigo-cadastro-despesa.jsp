<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Cadastro de despesas</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./resources/css/bootstrap.css">
</head>
<body>
<%@include file="header.jsp" %>
<div class="container">
  <div class="mt-5 ms-5 me-5">
    <div class="card mb-3">
      <div class="card-header">
        CADASTRO DE DESPESA
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

      <div class="card-body">
        <form action="despesas?acao=cadastrar" method="post">
          <div class="form-group">
            <label for="id-nome">Nome</label>
            <input type="text" name="descricao" id="id-nome"
                   class="form-control">
          </div>
          <div class="form-group">
            <label for="id-valor">Valor</label>
            <input type="text" name="valor" id="id-valor"
                   class="form-control">
          </div>
          <div class="form-group">
            <label for="id-fabricacao">Data de
              Fabricação</label>
            <input type="date" name="data" id="id-fabricacao" class="form-control">
          </div>
          <div class="form-group">
            <label for="id-forma-pagamento">Forma de Pagamento</label>
            <input type="text" name="pagamento" id="id-forma-pagamento"
                   class="form-control">
          </div>
          <div class="form-group">
            <label for="id-categoria">Categoria</label>
            <input type="text" name="categoria" id="id-categoria"
                   class="form-control">
          </div>
          <input type="submit" value="Salvar" class="btn btn-primary mt-3">
        </form>
      </div>
    </div>
  </div>
</div>
<%@include file="footer.jsp" %>
<script src="resources/js/bootstrap.bundle.js"></script>
</body>
</html>