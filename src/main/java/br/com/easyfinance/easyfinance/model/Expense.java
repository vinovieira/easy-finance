package br.com.easyfinance.easyfinance.model;

import java.time.LocalDate;

public class Expense extends Operation {
    private boolean isPaid;
    private Integer categoryId;
    private Integer paymentMethodId;

    public Expense() {
    }

    public Expense(Integer id, String description, double value, LocalDate date, Integer userId, boolean isPaid, Integer categoryId, Integer paymentMethodId) {
        super(id, description, value, date, userId);
        this.isPaid = isPaid;
        this.categoryId = categoryId;
        this.paymentMethodId = paymentMethodId;
    }

    public boolean isPaid() {
        return isPaid;
    }

    public void setPaid(boolean paid) {
        isPaid = paid;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getPaymentMethodId() {
        return paymentMethodId;
    }

    public void setPaymentMethodId(Integer paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }
}
