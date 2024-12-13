package br.com.easyfinance.easyfinance.model;

import java.time.LocalDate;

public class Expense extends Operation {
    private Integer isPaid;
    private Integer categoryId;
    private Integer paymentMethodId;

    public Expense() {
    }

    public Expense(Integer id, String description, double value, LocalDate date, Integer userId, Integer isPaid, Integer categoryId, Integer paymentMethodId) {
        super(id, description, value, date, userId);
        this.isPaid = isPaid;
        this.categoryId = categoryId;
        this.paymentMethodId = paymentMethodId;
    }

    public Integer getIsPaid() {
        return isPaid;
    }

    public void setPaid(Integer isPaid) {
        this.isPaid = isPaid;
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

    @Override
    public String toString() {
        return "Expense{" +
                "getIsPaid=" + isPaid +
                ", categoryId=" + categoryId +
                ", paymentMethodId=" + paymentMethodId +
                '}';
    }
}
