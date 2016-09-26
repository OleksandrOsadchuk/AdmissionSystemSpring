/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author pear
 */
public class EmailSender {

    private String username, password,
            authKEY, starttlsKEY, hostKEY, portKEY,
            authVAL, starttlsVAL, hostVAL, portVAL;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAuthKEY() {
        return authKEY;
    }

    public void setAuthKEY(String authKEY) {
        this.authKEY = authKEY;
    }

    public String getStarttlsKEY() {
        return starttlsKEY;
    }

    public void setStarttlsKEY(String starttlsKEY) {
        this.starttlsKEY = starttlsKEY;
    }

    public String getHostKEY() {
        return hostKEY;
    }

    public void setHostKEY(String hostKEY) {
        this.hostKEY = hostKEY;
    }

    public String getPortKEY() {
        return portKEY;
    }

    public void setPortKEY(String portKEY) {
        this.portKEY = portKEY;
    }

    public String getAuthVAL() {
        return authVAL;
    }

    public void setAuthVAL(String authVAL) {
        this.authVAL = authVAL;
    }

    public String getStarttlsVAL() {
        return starttlsVAL;
    }

    public void setStarttlsVAL(String starttlsVAL) {
        this.starttlsVAL = starttlsVAL;
    }

    public String getHostVAL() {
        return hostVAL;
    }

    public void setHostVAL(String hostVAL) {
        this.hostVAL = hostVAL;
    }

    public String getPortVAL() {
        return portVAL;
    }

    public void setPortVAL(String portVAL) {
        this.portVAL = portVAL;
    }

    public String sendMail(String mailTo, String content) {

        Properties pps = new Properties();
        pps.put(authKEY, authVAL);
        pps.put(starttlsKEY, starttlsVAL);
        pps.put(hostKEY, hostVAL);
        pps.put(portKEY, portVAL);

        Authenticator ar = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };

        Session session = Session.getInstance(pps, ar);

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("StudentAdmissionSystem@system.com"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mailTo));
            msg.setSubject("List from Admission System");
            msg.setContent(content, "text/html; charset=utf-8");
            //msg.setText(content);
            Transport.send(msg);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        return mailTo;
    }

}
