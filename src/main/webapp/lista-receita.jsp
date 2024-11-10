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
                    <c:forEach items="${receitas}" var="receita">
                        <tr>
                            <td>${receita.descricao}</td>
                            <td class="text-end">${receita.valor}</td>
                            <td class="text-center">
                                <fmt:parseDate
                                        value="${receita.data}"
                                        pattern="yyyy-MM-dd"
                                        var="dataFmt" />
                                <fmt:formatDate
                                        value="${dataFmt}"
                                        pattern="dd-MM-yyyy" />
                            </td>
                            <td class="text-end">${receita.fonte}</td>

                            <td class="text-center">
                                <c:url value="receitas" var="link">
                                    <c:param name="acao" value="abrir-form-edicao"/>
                                    <c:param name="codigo" value="${receita.codigo}"/>
                                </c:url>
<%--                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAtualizarReceita" onclick="${link}">--%>
<%--                                    Editar--%>
<%--                                </button>--%>
                                <a href="${link}" class="btn btn-primary">Editar</a>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#excluirModal" onclick="codigoExcluir.value = ${receita.codigo}">
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
                <form action="receitas?acao=cadastrar" method="post">
                    <div class="form-group mb-3">
                        <label for="id-descricao">Descrição</label>
                        <input type="text" name="descricao" id="id-descricao" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-valor">Valor</label>
                        <input type="text" name="valor" id="id-valor" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-data">Data</label>
                        <input type="date" name="data" id="id-data" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-fonte">Fonte</label>
                        <input type="text" name="fonte" id="id-fonte" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Salvar</button>
                </form>
            </div>
        </div>
    </div>
</div>
<div
        class="modal fade"
        id="excluirModal"
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

                <form action="receitas" method="post">
                    <input
                            type="hidden"
                            name="acao"
                            value="excluir">
                    <input
                            type="hidden"
                            name="codigoExcluir"
                            id="codigoExcluir">
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
<div class="modal fade" id="modalAtualizarReceita" tabindex="-1" aria-labelledby="modalAtualizarReceitaLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAtualizarReceitaLabel">Atualizar Receita</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="receitas" method="post">
                    <input type="hidden" value="editar" name="acao">
                    <input type="hidden" value="${receita.codigo}" name="codigo">

                    <div class="form-group mb-3">
                        <label for="id-editar-descricao">Nome</label>
                        <input type="text" name="descricao" id="id-editar-descricao" class="form-control" value="${receita.descricao}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-editar-valor">Valor</label>
                        <input type="text" name="valor" id="id-editar-valor" class="form-control" value="${receita.valor}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-editar-data">Data</label>
                        <input type="date" name="data" id="id-editar-data" class="form-control" value="${receita.data}">
                    </div>
                    <div class="form-group mb-3">
                        <label for="id-editar-fonte">Fonte</label>
                        <input type="text" name="fonte" id="id-editar-fonte" class="form-control" value="${receita.fonte}">
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="receitas?acao=listar" class="btn btn-warning">Cancelar</a>
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
        const modal = new bootstrap.Modal(document.getElementById('modalAtualizarReceita'));
        modal.show();
        <% } %>
    });
</script>
</body>
</html>