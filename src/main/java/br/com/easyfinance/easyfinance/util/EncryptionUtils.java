package br.com.easyfinance.easyfinance.util;

import java.math.BigInteger;
import java.security.MessageDigest;

public class EncryptionUtils {

    public static String toEncrypt(String password) throws Exception {
        //Obtém a instância de um algoritmo
        MessageDigest md= MessageDigest.getInstance("MD5");

        //Passa os dados a serem criptografados e estipula encoding padrão
        md.update(password.getBytes("ISO-8859-1"));

        //Gera a chave criptografada em array de Bytes para posterior hashing
        BigInteger hash= new BigInteger(1, md.digest());

        //Retorna a password criptografada
        return hash.toString(16);
    }

}
