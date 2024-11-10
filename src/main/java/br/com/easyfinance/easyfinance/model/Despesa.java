package br.com.easyfinance.easyfinance.model;

import java.sql.Date;
import java.time.LocalDate;

public class Despesa extends Operacao {
    private String categoria;
    private String pagamento;

    public Despesa() {}

    public Despesa(int codigo, String descricao, double valor, LocalDate data, String pagamento, String categoria) {
        super(codigo, descricao, valor, data);
        this.pagamento = pagamento;
        this.categoria = categoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getPagamento() {
        return pagamento;
    }

    public void setPagamento(String pagamento) {
        this.pagamento = pagamento;
    }
}
