package br.com.easyfinance.easyfinance.dao;

import br.com.easyfinance.easyfinance.model.PaymentMethod;

import java.util.List;

public interface PaymentMethodDao {
    List<PaymentMethod> list();
}
