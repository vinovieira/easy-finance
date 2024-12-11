package br.com.easyfinance.easyfinance.model;

import br.com.easyfinance.easyfinance.util.EncryptionUtils;

public class User {

    private Integer id;
    private String name;
    private String email;
    private String password;

    public User(Integer id, String name, String email, String password) {
        super();
        this.id = id;
        this.name = name;
        this.email = email;
        setPassword(password);
    }

    public User() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return name;
    }

    public void setNome(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        try {
            this.password = EncryptionUtils.toEncrypt(password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}