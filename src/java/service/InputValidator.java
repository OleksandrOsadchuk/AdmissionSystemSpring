/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 *
 * @author Oleksandr
 */
public class InputValidator implements ApplicationContextAware {

    private static ApplicationContext ac;

    public List validateItemInput(HttpServletRequest request, ResourceBundle mb) {
        boolean validated = false;
        String msg = "";
        List list = new ArrayList();

        if (request.getParameter("tab").equalsIgnoreCase("Student")) {
            if (!request.getParameter("id").matches("\\d+")) {
                msg = mb.getString("Vmustbenum");
            } else if ((request.getParameter("fn").length() < 3)
                    || (request.getParameter("fn").matches(".*\\d+.*"))) {
                msg = mb.getString("Vfirstnametoo");
            } else if ((request.getParameter("ln").length() < 3)
                    || (request.getParameter("ln").matches(".*\\d+.*"))) {
                msg = mb.getString("Vlastnametoo");
            } else if (!request.getParameter("gender").equalsIgnoreCase("M")
                    && !request.getParameter("gender").equalsIgnoreCase("F")) {
                msg = mb.getString("Vgender");
            } else if (!request.getParameter("email").matches("[a-z0-9](\\.?[a-z0-9_-]){0,}@[a-z0-9-]+\\.([a-z]{1,6}\\.)?[a-z]{2,6}")){
                msg = mb.getString("incorrectaddrM");
            } else if (!request.getParameter("sdate").matches(
                    "(199[0-9]|200[0-9]|201[0-6])-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|30)")) {
                msg = mb.getString("Vdatemust");
            } else {
                validated = true;
            }

        } else if (request.getParameter("tab").equalsIgnoreCase("Course")) {
            if (!request.getParameter("id").matches("\\d+")) {
                msg = mb.getString("Vmustbenum");
            } else if ((request.getParameter("cn").length() < 3) || (request.getParameter("cn").matches("\\d+"))) {
                msg = mb.getString("Vcoursename");
            } else {
                validated = true;
            }

        } else if (request.getParameter("tab").equalsIgnoreCase("Result")) {
            if (!(request.getParameter("sid").matches("\\d+")
                    && request.getParameter("cid").matches("\\d+"))) {
                msg = mb.getString("Vmustbenum");
            } else if (!(request.getParameter("m1").matches("(\\d)|(\\d{2})")
                    && request.getParameter("m2").matches("(\\d)|(\\d{2})"))) {
                msg = mb.getString("Vmarkmust");
            } else {
                validated = true;
            }
        }
        list.add(0, validated);
        list.add(1, msg);
        return list;
    }

    public boolean validateEmailAddress(HttpServletRequest request) {
        String s = request.getParameter("mailAddr");
        if (s.matches("[a-z0-9](\\.?[a-z0-9_-]){0,}@[a-z0-9-]+\\.([a-z]{1,6}\\.)?[a-z]{2,6}")) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public void setApplicationContext(ApplicationContext ac) throws BeansException {
        this.ac = ac;
    }

}
