package br.com.easyfinance.easyfinance.factory;

import br.com.easyfinance.easyfinance.dao.DespesaDao;
import br.com.easyfinance.easyfinance.dao.ReceitaDao;
import br.com.easyfinance.easyfinance.dao.UsuarioDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleDespesaDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleReceitaDao;
import br.com.easyfinance.easyfinance.dao.impl.OracleUsuarioDao;
import br.com.easyfinance.easyfinance.model.Receita;

public class DaoFactory {
    public static DespesaDao getDespesaDao() {
        return new OracleDespesaDao();
    }
    public static ReceitaDao getReceitaDao() {
        return new OracleReceitaDao();
    }
    public static UsuarioDao getUsuarioDao() {
        return new OracleUsuarioDao();
    }
}
