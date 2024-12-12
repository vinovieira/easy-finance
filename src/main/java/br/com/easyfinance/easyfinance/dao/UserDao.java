package br.com.easyfinance.easyfinance.dao;

import br.com.easyfinance.easyfinance.model.User;

public interface UserDao {
    User validateUser(User user);
    }
