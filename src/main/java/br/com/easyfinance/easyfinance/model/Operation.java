package br.com.easyfinance.easyfinance.model;

import java.time.LocalDate;

public abstract class Operation {
    private Integer id;
    private String description;
    private double value;
    private LocalDate date;
    private Integer userId;

    public Operation() {
    }

    public Operation(Integer id, String description, double value, LocalDate date, Integer userId) {
        this.id = id;
        this.description = description;
        this.value = value;
        this.date = date;
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
         this.userId = userId;
    }
}
