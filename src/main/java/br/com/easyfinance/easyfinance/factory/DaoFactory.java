package br.com.easyfinance.easyfinance.factory;

import br.com.easyfinance.easyfinance.dao.DespesaDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleDespesaDao;

public class DaoFactory {
    public static DespesaDao getDespesaDao() {
        return new OracleDespesaDao();
    }
}
