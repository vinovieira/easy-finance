package br.com.easyfinance.easyfinance.model;

import java.time.LocalDate;

public class Income extends Operation {
    private String source;

    public Income() {}

    public Income(Integer id, String description, double value, LocalDate date, Integer userId, String source) {
        super(id, description, value, date, userId);
        this.source = source;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
}
