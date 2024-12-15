package br.com.easyfinance.easyfinance.model;

public class PaymentMethod {
    private Integer id;
    private String name;

    public PaymentMethod(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    public PaymentMethod() {}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "PaymentMethod{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
