package br.com.easyfinance.easyfinance.model;

import java.time.LocalDate;

public class Receita extends Operacao {
    private String fonte;

    public Receita() {}

    public Receita(int codigo, String descricao, double valor, LocalDate data, String fonte) {
        super(codigo, descricao, valor, data);
        this.fonte = fonte;
    }

    public String getFonte() {
        return fonte;
    }

    public void setFonte(String fonte) {
        this.fonte = fonte;
    }
}
