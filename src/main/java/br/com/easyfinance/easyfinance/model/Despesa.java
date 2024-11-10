package br.com.easyfinance.easyfinance.model;

import java.sql.Date;
import java.time.LocalDate;

public class Despesa extends Operacao {
    private String categoria;

    // Construtor padrão
    public Despesa() {}

    // Construtor com argumentos
    public Despesa(int codigo, String descricao, double valor, LocalDate data, String pagamento, String categoria) {
        super(codigo, descricao, valor, data, pagamento);
        this.categoria = categoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
}
