package br.com.easyfinance.easyfinance.dao.impl;

import br.com.easyfinance.easyfinance.dao.ConnectionManager;
import br.com.easyfinance.easyfinance.dao.PaymentMethodDao;
import br.com.easyfinance.easyfinance.model.PaymentMethod;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OraclePaymentMethodDao implements PaymentMethodDao {

    Connection conexao = null;

    @Override
    public List<PaymentMethod> list() {

        conexao = ConnectionManager.getInstance().getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<PaymentMethod> list = new ArrayList<PaymentMethod>();

        try {

            stmt = conexao.prepareStatement("SELECT * FROM T_EF_PAYMENTMETHOD");
            rs = stmt.executeQuery();
            while (rs.next()) {
                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setId(rs.getInt("id_payment_method"));
                paymentMethod.setName(rs.getString("nm_payment_method"));
                list.add(paymentMethod);
            }
        }catch(Exception e) {
            e.printStackTrace();
        }finally{
            try {
                stmt.close();
                rs.close();
                conexao.close();
            }catch(Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }
}
