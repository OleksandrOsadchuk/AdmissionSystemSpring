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
        <title>Student Details</title>
	<link rel = "stylesheet" href="<c:url value="/css/index.css"/>">
        <style>
            .green  {background-color:#ddffee;}
            .red    {background-color:#ffe2e2;}
            .greenfont  {color:limegreen; font-weight: bold}
            .redfont    {color:crimson; font-weight: bold}
             /*.td30 td,th {padding-left:20px; padding-right:20px; height: 40px;}*/
             /*table.td5 td {padding-bottom: 5px; padding-top: 5px;}*/
             table {width:75%;}
            .lbutton {display: inline-block; margin: 20px;}
            /*.th1 {border: 0; height: 20px;}*/
            .trLo th,td{height: 20px;}
            .trHi th,td{height: 30px;}
        </style>
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
            
            <form action="findId" method="get">
                <label><fmt:message key="Lfindstud"/>&nbsp</label><input type="number" name="id">
                <input type="hidden" name="tab" value="Student">
                <input type="submit" value="<fmt:message key="Lsearch"/>" id="highlight">
                <a class="midA" href="addForm?tab=Student"><fmt:message key="Laddstud"/></a>
            </form>

            <c:set var="s" value="${list[0]}"/>
            <p> <b> ${message} ID: ${s.id} </b> </p>
            
            <table class="trHi">
                <tr>
                    <th><fmt:message key="Lfname"/> </th>
                    <th><fmt:message key="Llastname"/></th>
                    <th><fmt:message key="Lgender"/> </th>
                    <th><fmt:message key="Lemail"/> </th>
                    <th><fmt:message key="Lstartdate"/> </th>
                </tr>

                <tr style="text-align: left">
                    <td>   <c:out value="${s.firstName}" />    </td>
                    <td>   <c:out value="${s.lastName}" />     </td>
                    <td>   <c:out value="${s.gender}" />     </td>
                    <td>   <c:out value="${s.email}" />     </td>
                    <td>   <c:out value="${s.startDate}" />     </td>
                </tr>
                
            </table>
         
            <table>
                <tr class="trHi" style="text-align: left">
                    <td colspan="5" style="text-align: left;">
                        <fmt:message key="Lassignedcourses"/>:
                        <c:if test="${empty listrp}"> <fmt:message key="nothingfoundM"/></c:if>
                        
                    </td>
                </tr>
                <c:if test="${not empty listrp}">
                    <tr>
                        <th><fmt:message key="Lcourseid"/> </th>
                        <th><fmt:message key="Lcoursename"/> </th>
                        <th><fmt:message key="Lmark"/>1 </th>
                        <th><fmt:message key="Lmark"/>2 </th>
                        <th>Grade</th>
                    </tr>
                    <c:forEach var="r" items="${listrp}">
                    <tr style="text-align: left">
                        <td><a href="findId?tab=Course&id=${r.courseId}">${r.courseId}</a></td>
                        <td>${r.courseName}</td>
                        <c:set var="color" value="${r.mark1 le 60 ? 'red': 'green'}"/>
                        <td class="${color}"> ${r.mark1}</td>
                        <c:set var="color" value="${r.mark2 le 60 ? 'red': 'green'}"/>
                        <td class="${color}"> ${r.mark2}</td>
                        <c:set var="color" value="${r.grade ge 'D' ? 'redfont':'greenfont'}"/>
                        <td class="${color}">${r.grade}</td>
                    </tr>
                    </c:forEach>
                </c:if>
                </table>
                    
            <br>
                <a class="midA" href="addForm?tab=Result&sid=${s.id}"><fmt:message key="Laddresult"/></a>
                <a class="midA lbutton" href="editForm?tab=Student&id=${s.id}">
                            <fmt:message key="Ledit"/>&nbsp<fmt:message key="Lfile"/></a>&nbsp&nbsp
                <a class="midA lbutton" href="delete?tab=Student&id=${s.id}">
                    <fmt:message key="Ldelete"/>&nbsp<fmt:message key="Lfile"/></a>
            <br><br>
            
            <form action="email" method="get">
                <label><fmt:message key="Lgetemail"/></label><input type="text" name="mailAddr">
                <input type="hidden" name="tab" value="${tab}" >
                <input type="submit" value="<fmt:message key="Lget"/>" id="highlight">
            </form> 
                    
	</div>
                    
                    
                       
                        

	<div id="footer">
	(c) Oleksandr / MCIT.  Programming For Mobile Class, 2016
	</div>

    </body>
</html>
