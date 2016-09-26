<%--
    Document   : index
    Created on : May 31, 2016, 6:21:28 PM
    Author     : oleksandr
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<fmt:setLocale value= "${locale}"/>
<fmt:setBundle basename="conf.Messages"/>

<!DOCTYPE html>
<html>
    
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Admission</title>
	<link rel = "stylesheet" href="<c:url value="/css/index.css"/>">
    </head>
    <body>
        <div id="top"><fmt:message key="Ladmissionsystem"/></div>

        <!-- process colors for btns -->
        <c:choose>
            <c:when test="${tab=='Student'}">
                <c:set var="colorST"  value="aqua"/>
                <c:set var="colorCS"  value=""/>
                <c:set var="colorRE"  value=""/>
            </c:when>
            <c:when test="${tab=='Course'}">
                <c:set var="colorST"  value=""/>
                <c:set var="colorCS"  value="aqua"/>
                <c:set var="colorRE"  value=""/>
            </c:when>
            <c:when test="${tab=='Result'}">
                <c:set var="colorST"  value=""/>
                <c:set var="colorCS"  value=""/>
                <c:set var="colorRE"  value="aqua"/>
            </c:when>
            <c:otherwise>
                <c:set var="colorST"  value=""/>
                <c:set var="colorCS"  value=""/>
                <c:set var="colorRE"  value=""/>
            </c:otherwise>
        </c:choose>

        <div id="nav">
	<ul>
            <li><a style="background-color:${colorST}" href="list?tab=Student"><fmt:message key="Lstudent"/></a> </li>
            <li><a style="background-color:${colorCS}" href="list?tab=Course"><fmt:message key="Lcourse"/></a> </li>
            <li><a style="background-color:${colorRE}" href="list?tab=Result"><fmt:message key="Lresult"/></a> </li>
        </ul>
        </div>
        
        <div id="enfr">
            <a class="topA" id="highlight" href="lng?lng=en">EN</a>
            <a class="topA" id="highlight" href="lng?lng=fr">FR</a>
        </div>

	<div id="middle">

            <c:choose>
                <c:when test="${tab=='Student'}">

                    <form action="findId" method="get">
                        <label><fmt:message key="Lfindstud"/>&nbsp</label><input type="number" name="id">
                        <input type="hidden" name="tab" value="Student">
                        <input type="submit" value="<fmt:message key="Lsearch"/>" id="highlight">
                        <a class="midA" href="addForm?tab=Student" id="highlight"><fmt:message key="Laddstud"/></a>
                    </form>

                <p>${message}</p>
                <table>
                    <tr>
                        <th>id </th>
                        <th><fmt:message key="Lfname"/> </th>
                        <th><fmt:message key="Llastname"/></th>
                        <th><fmt:message key="Lgender"/> </th>
                        <th><fmt:message key="Lstartdate"/> </th>
                        <th><fmt:message key="Laction"/> </th>
                    </tr>
                <c:forEach var="s" items="${list}">
                    <tr style="text-align: left">

                        <td>   <c:out value="${s.id}" />           </td>
                        <td>   <c:out value="${s.firstName}" />    </td>
                        <td>   <c:out value="${s.lastName}" />     </td>
                        <td>   <c:out value="${s.gender}" />     </td>
                        <td>   <c:out value="${s.startDate}" />     </td>
                        <td>
                            <a href="editForm?tab=Student&id=${s.id}"><fmt:message key="Ledit"/></a> &nbsp&nbsp
                            <a href="delete?tab=Student&id=${s.id}"><fmt:message key="Ldelete"/></a>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
                    <br>
                    

                </c:when>

                <c:when test="${tab=='Course'}">

                    <form action="findId" method="get">
                        <label><fmt:message key="Lfindcourse"/>&nbsp</label><input type="number" name="id">
                        <input type="hidden" name="tab" value="Course">
                        <input type="submit" value="<fmt:message key="Lsearch"/>" id="highlight">
                        <a class="midA" href="addForm?tab=Course" id="highlight"><fmt:message key="Laddcourse"/></a>
                    </form>

                <p>${message}</p>
                <table>
                    <tr>
                        <th><fmt:message key="Lcourseid"/></th>
                        <th><fmt:message key="Lcoursename"/></th>
                        <th><fmt:message key="Laction"/></th>
                    </tr>
                <c:forEach var="cs" items="${list}">
                    <tr style="text-align: left">
                        <td>   <c:out value="${cs.id}" />      </td>
                        <td>   <c:out value="${cs.name}" />    </td>
                        <td>
                            <a href="editForm?tab=Course&id=${cs.id}"><fmt:message key="Ledit"/></a> &nbsp&nbsp
                            <a href="delete?tab=Course&id=${cs.id}"><fmt:message key="Ldelete"/></a>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
                <br>
                </c:when>

                <c:when test="${tab=='Result'}">

                   <form action="findId" method="get">
                        <label><fmt:message key="Lfindresult"/> &nbsp</label><input type="number" name="sid" style="width:50px;">
                        <label><fmt:message key="Landcourse"/> &nbsp</label><input type="number" name="cid" style="width:50px;">
                        <input type="hidden" name="tab" value="Result">
                        <input type="submit" value="<fmt:message key="Lsearch"/>" id="highlight">
                        <a class="midA" href="addForm?tab=Result" id="highlight"><fmt:message key="Laddresult"/></a>
                    </form>
                <p>${message}</p>
                <table>
                    <tr>
                        <th><fmt:message key="Lstudentid"/> </th>
                        <th><fmt:message key="Lcourseid"/> </th>
                        <th><fmt:message key="Lmark"/>1 </th>
                        <th><fmt:message key="Lmark"/>2 </th>
                        <th><fmt:message key="Laction"/></th>
                    </tr>
                <c:forEach var="r" items="${list}">
                    <tr style="text-align: left">
                        <td><a href="findId?tab=Student&id=${r.studentId}">${r.studentId}</a></td>
                        <td><a href="findId?tab=Course&id=${r.courseId}">${r.courseId}</a></td>
                        <td>   <c:out value="${r.mark1}" />    </td>
                        <td>   <c:out value="${r.mark2}" />    </td>
                        <td>
                            <a href="editForm?tab=Result&sid=${r.studentId}&cid=${r.courseId}"><fmt:message key="Ledit"/></a> &nbsp&nbsp
                            <a href="delete?tab=Result&sid=${r.studentId}&cid=${r.courseId}"><fmt:message key="Ldelete"/></a>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
                <br>
                </c:when>
                    
                <c:otherwise>
                    <p>${message}</p>
                    <p><fmt:message key="Lpleasechoose"/></p>
                    <br>
                    <div style="font-size:80%; border: 1px solid gray; display:inline-block; padding:20px">                       
                        Server info: <br>
                        Tomcat Version :
                        <%= application.getServerInfo() %><br>    
                        Servlet Specification Version :
                        <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %> <br>    
                        JSP version :
                        <%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %><br>
                    </div>
                   
                </c:otherwise>
                    
             </c:choose>
                    
             <c:if test="${(tab=='Student')||(tab=='Course')||(tab=='Result')}">
                <form action="email" method="get">
                    <label><fmt:message key="Lgetemail"/></label><input type="text" name="mailAddr">
                    <input type="hidden" name="tab" value="${tab}" >
                    <input type="submit" value="<fmt:message key="Lget"/>" id="highlight">
                </form> 
             </c:if>
                    
	</div>

	<div id="footer">
	(c) Oleksandr / MCIT.  Programming For Mobile Class, 2016
	</div>

    </body>
</html>
