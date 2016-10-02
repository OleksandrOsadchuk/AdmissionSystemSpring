/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import beans.Course;
import beans.Item;
import beans.Result;
import beans.Student;
import dao.Dao;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import service.EmailSender;
import service.InputValidator;
import service.OutputConverter;
import service.ResultProfiler;

/**
 *
 * @author Oleksandr
 */
@Controller
public class MainController {

    String msg, tabName;
    List<Item> itemList;
    List l, sidList,cidList;
    int lastIdSt, lastIdCs, lastIdRe, lastId, editId, r;
    Item inputItem;

    //Language setup
    ResourceBundle mb = ResourceBundle.getBundle("conf/Messages", new Locale("en", "CA"));
    Locale currentLocale = new Locale("en", "CA");

    static ApplicationContext ctx = new ClassPathXmlApplicationContext("conf/applicationContext.xml");
    Dao dao = (Dao) ctx.getBean("dao");
    InputValidator validator = (InputValidator) ctx.getBean("validator");

    @RequestMapping(value = "/lng", method = RequestMethod.GET)
    public ModelAndView changeENFR(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("index");
        currentLocale = new Locale(request.getParameter("lng"), "CA");
        mb = ResourceBundle.getBundle("conf/Messages", currentLocale);
        //mav.addObject("message", "Welcome to Student Admission System!");
        mav.addObject("message", mb.getString("welcomeM"));
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView displayIndex() {
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("message", mb.getString("welcomeM"));
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("index");

        tabName = request.getParameter("tab");
        itemList = dao.getAll(tabName);
        if (itemList.isEmpty()) {
            msg = mb.getString("noM") + mb.getString(tabName) + mb.getString("foundM");
        } else {
            l = this.processItemList(itemList);
        }
        msg = mb.getString("listofM") + " " + mb.getString(tabName) + "s";
        if (tabName.equalsIgnoreCase("result")) {
            msg = mb.getString("examresultsM");
        }

        mav.addObject("message", msg);
        mav.addObject("list", l);
        mav.addObject("tab", tabName);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/findId", method = RequestMethod.GET)
    public ModelAndView findId(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("index");
        tabName = request.getParameter("tab");
        inputItem = this.buildItemIdTabname(request);
        if ((itemList = dao.getId(inputItem)).isEmpty()) {
            msg = mb.getString("nothingfoundM");
            l = null;
        } else {
            msg = mb.getString("foundM") + " " + mb.getString("entriesM") + " " + mb.getString(tabName) + " : " + itemList.size();
            l = this.processItemList(itemList);
           
            // STUDENT FILE DISPLAY //
            if(tabName.equalsIgnoreCase("Student")){
                List<Student> lst = l;
                mav.setViewName("student");
                msg=mb.getString("Lstudentdata");
                
                List listRP = new ArrayList();
                
                List<Result> lr = dao.getAll("Result");
                List<Course> lc = dao.getAll("Course");
                String cName="";
                for(Result r : lr){
                   
                    if(r.getStudentId()==lst.get(0).getId()) {
                        for(Course c: lc){
                            if(c.getId()==r.getCourseId()) cName = c.getName();
                        }
                        ResultProfiler rp = new ResultProfiler(r.getCourseId(), cName, r.getMark1(), r.getMark2());
                        listRP.add(rp);
                     }
                    
                }
                
                    mav.addObject("listrp", listRP);
            }
                
        }
        mav.addObject("message", msg);
        mav.addObject("list", l);
        mav.addObject("tab", tabName);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public ModelAndView delete(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("index");
        inputItem = this.buildItemIdTabname(request);
        r = dao.delete(inputItem);
        if (r < 1) {
            msg = mb.getString("wasnotdeletedM");
        } else {
            msg = mb.getString("deletedM") + " " + r + " " + mb.getString("positionM");
        }
        itemList = dao.getAll(tabName);
        l = this.processItemList(itemList);

        mav.addObject("message", msg);
        mav.addObject("list", l);
        mav.addObject("tab", tabName);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView add(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("index");

        List vldt = (List) validator.validateItemInput(request, mb);
        boolean validated = (boolean) vldt.get(0);
        msg = (String) vldt.get(1);

        if (validated) {
            inputItem = buildItemFull(request);
            //check if the new result is for existing studID courseID
            if (tabName.equalsIgnoreCase("Result")) {
                Result rr = (Result) inputItem;
                Student ss = (Student) ctx.getBean("student");
                Course cc = (Course) ctx.getBean("course");
                ss.setId(rr.getStudentId());
                cc.setId(rr.getCourseId());
                if (dao.getId(ss).isEmpty() || dao.getId(cc).isEmpty()) {
                    msg = mb.getString("studentcoursenotM");
                    mav.addObject("submitLabel", mb.getString("addM"));
                    mav.addObject("operationValue", "add");
                    mav.setViewName("form");
                    mav.addObject("message", msg);
                    mav.addObject("locale", currentLocale);
                    mav.addObject("tab", tabName);
                    return mav;
                }
            }
            r = dao.add(inputItem);
            if (r < 1) {
                msg = mb.getString("cantaddM");
            } else {
                msg = mb.getString("addedposM") + " " + r;
            }
            l = this.processItemList(dao.getAll(tabName));
            mav.addObject("list", l);

        } else {
            mav.addObject("submitLabel", mb.getString("addM"));
            mav.addObject("operationValue", "add");
            mav.addObject("idValue", (lastId + 1));
            mav.setViewName("form");
            if(tabName.equalsIgnoreCase("Result")) {
                buildStudCouseIdLists(request);
                mav.addObject("cidList",cidList);
                mav.addObject("sidList",sidList);
            }
        }
        mav.addObject("message", msg);
        mav.addObject("tab", tabName);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public ModelAndView update(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("index");

        List vldt = (List) validator.validateItemInput(request, mb);
        boolean validated = (boolean) vldt.get(0);
        msg = (String) vldt.get(1);

        if (validated) {
            inputItem = buildItemFull(request);
            r = dao.update(inputItem);
            if (r < 1) {
                msg = mb.getString("cantupdateM");
            } else {
                msg = mb.getString("updatedposM") + " " + r;
            }
            l = this.processItemList(dao.getAll(tabName));
            mav.addObject("list", l);
        } else {
            mav.addObject("list", l); // get values back from the same 'l' from editForm(call) 
            mav.addObject("submitLabel", mb.getString("savechangesM"));
            mav.addObject("operationValue", "update");
            mav.addObject("idValue", editId);
            if(tabName.equalsIgnoreCase("Result")) {
                buildStudCouseIdLists(request);
                mav.addObject("cidList",cidList);
                mav.addObject("sidList",sidList);
            }
            mav.setViewName("form");
        }
        mav.addObject("message", msg);
        mav.addObject("tab", tabName);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/addForm", method = RequestMethod.GET)
    public ModelAndView addForm(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("form");
        tabName=request.getParameter("tab");
        
        msg = mb.getString("pleasefillM");
        if (tabName.equals("Result")) {
            msg = mb.getString("fillresultM");
        }
        mav.addObject("submitLabel", mb.getString("addM"));
        mav.addObject("operationValue", "add");
        mav.addObject("idValue", (lastId + 1));
        
        if(tabName.equalsIgnoreCase("Result")) {
            buildStudCouseIdLists(request);
            mav.addObject("cidList",cidList);
            mav.addObject("sidList",sidList);
        }
            
        mav.addObject("message", msg);
        mav.addObject("tab", tabName);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/editForm", method = RequestMethod.GET)
    public ModelAndView editForm(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("form");

        inputItem = this.buildItemIdTabname(request);
        l = this.processItemList(dao.getId(inputItem));
        
        if(tabName.equalsIgnoreCase("Result")) {
            buildStudCouseIdLists(request);
            mav.addObject("cidList",cidList);
            mav.addObject("sidList",sidList);
        }
        
//        if(tabName.equalsIgnoreCase("Result")){
//            List<Result> rList = l;
//            List cidList = new ArrayList();
//            List sidList = new ArrayList();
//            for (Result r: rList ){
//                if(!cidList.contains(r.getCourseId())) cidList.add(r.getCourseId());
//                if(!sidList.contains(r.getStudentId())) sidList.add(r.getStudentId());
//            }
//            Collections.sort(cidList);Collections.sort(sidList);
//            mav.addObject("cidList",cidList);
//            mav.addObject("sidList",sidList);
//        }
        
        mav.addObject("list", l);
        mav.addObject("submitLabel", mb.getString("savechangesM"));
        mav.addObject("operationValue", "update");
        mav.addObject("tab", tabName);
        mav.addObject("idValue", editId);
        mav.addObject("message", mb.getString("pleaseeditM"));// ??mav.addObject("idValue", editId);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @RequestMapping(value = "/email", method = RequestMethod.GET)
    public ModelAndView email(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = new ModelAndView("index");
        if (validator.validateEmailAddress(request)) {
            String mailAddr = request.getParameter("mailAddr");
            EmailSender es = (EmailSender) ctx.getBean("emailsender");
            OutputConverter oc = (OutputConverter) ctx.getBean("outputconverter");
            String content = oc.htmlOut(l);
            msg = mb.getString("wassenttoM") + " " + es.sendMail(mailAddr, content);
        } else {
            msg = mb.getString("incorrectaddrM");
        }
        mav.addObject("list", l);
        mav.addObject("message", msg);
        mav.addObject("tab", tabName);
        mav.addObject("locale", currentLocale);
        return mav;
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleAllException(Exception ex) {
        ModelAndView model = new ModelAndView("404");
        model.addObject("message", "" + ex);

        return model;

    }

    private List processItemList(List<Item> itemList) {
        List lst = new ArrayList();
        if (tabName.equalsIgnoreCase("Student")) {
            for (Item i : itemList) {
                Student st = (Student) i;
                lst.add(st);
                if (lastIdSt < st.getId()) {
                    lastIdSt = st.getId();
                }
                lastId = lastIdSt;
                editId = st.getId();
            }
        } else if (tabName.equalsIgnoreCase("Course")) {
            for (Item i : itemList) {
                Course cs = (Course) i;
                lst.add(cs);
                if (lastIdCs < cs.getId()) {
                    lastIdCs = cs.getId();
                }
                lastId = lastIdCs;
                editId = cs.getId();
            }
        } else if (tabName.equalsIgnoreCase("Result")) {
            for (Item i : itemList) {
                Result rr = (Result) i;
                lst.add(rr);
                if (lastIdRe < rr.getStudentId()) {
                    lastIdRe = rr.getStudentId();
                }
                lastId = lastIdRe;
                editId = rr.getStudentId();
            }
        }
        return lst;
    }

    private Item buildItemIdTabname(HttpServletRequest request) {
        tabName = request.getParameter("tab");

        if (tabName.equalsIgnoreCase("Student")) {
            inputItem = (Student) ctx.getBean("student");
            if (request.getParameter("id") != "") {
                inputItem.setId(Integer.parseInt(request.getParameter("id")));
            } else {
                inputItem.setId(0);
            }
        } else if (tabName.equalsIgnoreCase("Course")) {
            inputItem = (Course) ctx.getBean("course");
            if (request.getParameter("id") != "") {
                inputItem.setId(Integer.parseInt(request.getParameter("id")));
            } else {
                inputItem.setId(0);
            }
        } else if (tabName.equalsIgnoreCase("Result")) {
            Result re = (Result) ctx.getBean("result");
            if (request.getParameter("sid") != "") {
                re.setStudentId(Integer.parseInt(request.getParameter("sid")));
            } else {
                re.setStudentId(0);
            }
            if (request.getParameter("cid") != "") {
                re.setCourseId(Integer.parseInt(request.getParameter("cid")));
            } else {
                re.setCourseId(0);
            }
            inputItem = re;
        }
        return inputItem;
    }

    private Item buildItemFull(HttpServletRequest request) {

        Item inputItem = null;

        if (request.getParameter("tab").equalsIgnoreCase("Student")) {
            Student s = (Student) ctx.getBean("student"); //new Student();
            s.setId(Integer.parseInt(request.getParameter("id")));
            s.setFirstName(request.getParameter("fn"));
            s.setLastName(request.getParameter("ln"));
            s.setEmail(request.getParameter("email"));
            s.setGender(request.getParameter("gender"));
            s.setStartDate(request.getParameter("sdate"));
            inputItem = s;

        } else if (request.getParameter("tab").equalsIgnoreCase("Course")) {
            Course cs = (Course) ctx.getBean("course");   //new Course();
            cs.setId(Integer.parseInt(request.getParameter("id")));
            cs.setName(request.getParameter("cn"));
            inputItem = cs;

        } else if (request.getParameter("tab").equalsIgnoreCase("Result")) {
            Result re = (Result) ctx.getBean("result");   //new Result();
            re.setStudentId(Integer.parseInt(request.getParameter("sid")));
            re.setCourseId(Integer.parseInt(request.getParameter("cid")));
            re.setMark1(Integer.parseInt(request.getParameter("m1")));
            re.setMark2(Integer.parseInt(request.getParameter("m2")));
            inputItem = re;
        }
        return inputItem;
    }

    /////Controller ends here...
    private String logClassLoaderVars() {

        ClassLoader cl = ClassLoader.getSystemClassLoader();
        URL[] urls = ((URLClassLoader) cl).getURLs();
        String out = new String();
        for (URL url : urls) {
            out += url.getFile() + "<br>";
        }
        return out;
    }

    private void buildStudCouseIdLists(HttpServletRequest request) {
        String sid, cid;
            if(request.getParameter("sid")==null) sid="";
                else sid=request.getParameter("sid");
            if(request.getParameter("cid")==null) cid="";
                else cid=request.getParameter("cid");
            List<Student> ls = dao.getAll("Student");
            List<Course> lc = dao.getAll("Course");
            sidList = new ArrayList();
            cidList = new ArrayList();
            
            if(sid.equalsIgnoreCase(""))
                for (Student s: ls){ if(!sidList.contains(s.getId())) sidList.add(s.getId());}
            else
                sidList.add(sid);
            
            if(cid.equalsIgnoreCase(""))
                for (Course c: lc ){ if(!cidList.contains(c.getId())) cidList.add(c.getId());}
            else
                cidList.add(cid);
            
            Collections.sort(sidList);
            Collections.sort(cidList);
    }

}
