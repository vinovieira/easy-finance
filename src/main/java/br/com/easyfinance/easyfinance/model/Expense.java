package br.com.easyfinance.easyfinance.model;

import java.time.LocalDate;

public class Expense extends Operation {
    private Integer isPaid;
    private Category category;
    private PaymentMethod paymentMethod;

    public Expense() {
    }

    public Expense(Integer id, String description, double value, LocalDate date, Integer userId, Integer isPaid) {
        super(id, description, value, date, userId);
        this.isPaid = isPaid;
    }

    public Integer getIsPaid() {
        return isPaid;
    }

    public void setPaid(Integer isPaid) {
        this.isPaid = isPaid;
    }

    public void setIsPaid(Integer isPaid) {
        this.isPaid = isPaid;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Override
    public String toString() {
        return "Expense{" +
                "getIsPaid=" + isPaid +
                ", categoryId=" + category.getId() +
                ", paymentMethodId=" + paymentMethod.getId() +
                '}';
    }
}
