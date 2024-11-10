package br.com.easyfinance.easyfinance.model;

import java.sql.Date;
import java.time.LocalDate;

public abstract class Operacao {
    private int codigo;
    private String descricao;
    private double valor;
    private LocalDate data;
    private String pagamento;

    public Operacao() {
    }

    public Operacao(int codigo, String descricao, double valor, LocalDate data, String pagamento) {
        this.codigo = codigo;
        this.descricao = descricao;
        this.valor = valor;
        this.data = data;
        this.pagamento = pagamento;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int id) {
        this.codigo = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public String getPagamento() {
        return pagamento;
    }

    public void setPagamento(String pagamento) {
        this.pagamento = pagamento;
    }
}
