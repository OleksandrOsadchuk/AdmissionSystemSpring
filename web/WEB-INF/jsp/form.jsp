<%-- 
    Document   : form
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
        <title><fmt:message key="Lform"/></title>
	<link rel = "stylesheet" href="<c:url value="/css/index.css"/>">
        <style>
            form  { text-align:center; display: table;}     
            p     { display: table-row; padding: 10px; }
            label { display: table-cell; text-align: right; padding: 10px;}
            input { display: table-cell; padding: 10px;}
            button{display:table-cell;}
            .fclass {text-align: center; margin: auto; width: 100px; padding:20px;}
        </style>
</head>
<body>
        
    <div id="top"><fmt:message key="Ladmissionsystem"/></div>

    <!-- case style format -->
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
    <li><a style="background-color:${colorST}" href="<c:url value = 'list?tab=Student'/>"><fmt:message key="Lstudent"/></a>
    <li><a style="background-color:${colorCS}" href="<c:url value = 'list?tab=Course'/>"><fmt:message key="Lcourse"/></a>
    <li><a style="background-color:${colorRE}" href="<c:url value = 'list?tab=Result'/>"><fmt:message key="Lresult"/></a>
    </div>

    <div id="middle">
            
    <span>${message}</span><br><br>

    <c:choose>
        <c:when test="${tab=='Student'}">
            <form action="${operationValue}" method="get">
                <p><label><fmt:message key="Lstudentid"/>(1..99):</label><input type="number" name="id" value="${idValue}"></p>
                <p><label><fmt:message key="Lfname"/></label><input type="text" name="fn" value="${list[0].firstName}"></p>
                <p><label><fmt:message key="Llastname"/></label><input type="text" name="ln" value="${list[0].lastName}" ></p>
                <p><label><fmt:message key="Lgender"/>&nbsp(<fmt:message key="Lmf"/>)</label><input type="text" name="gender" value="${list[0].gender}"></p>
                <p><label><fmt:message key="Lemail"/></label><input type="text" name="email" value="${list[0].email}" ></p>
                <p><label><fmt:message key="Lstartdate"/> (<fmt:message key="Lyyyymmdd"/>)</label><input type="text" name="sdate" value="${list[0].startDate}"></p>
                <input type="hidden" name="tab" value="Student">
                <p>&nbsp</p>
                <p><label></label><input class="fclass" type="submit" value="${submitLabel}"></p>
            </form>

        </c:when>

        <c:when test="${tab=='Course'}">

           <form action="${operationValue}" method="get">
               <p><label><fmt:message key="Lcourseid"/> (1..99):</label><input type="number" name="id" value="${idValue}"></p>
               <p><label><fmt:message key="Lcoursename"/></label><input type="text" name="cn" value="${list[0].name}"></p>
               <p><input type="hidden" name="tab" value="Course"></p>
               <p>&nbsp</p>
               <p><label></label><input class="fclass" type="submit" value="${submitLabel}"></p>
            </form> 

        </c:when>

        <c:when test="${tab=='Result'}">

           <form action="${operationValue}" method="get">

               <p>
                   <label> <fmt:message key="Lstudentid"/> </label>
                   <label>
                        <select style="width:100%" name="sid" required>
                            <c:forEach var="sid" items="${sidList}"><option value="${sid}">${sid}</option></c:forEach>
                        </select>
                   </label>
               </p>
               <p>
                   <label><fmt:message key="Lcourseid"/></label>
                   <label>
                        <select style="width:100%" name="cid" required>
                            <c:forEach var="cid" items="${cidList}"> <option value="${cid}">${cid}</option></c:forEach>
                        </select>
                   </label>
               </p>

                <p><label><fmt:message key="Lmark"/>1:(1..99)</label><input type="number" name="m1" value="${list[0].mark1}"></p>
                <p><label><fmt:message key="Lmark"/>2:(1..99)</label><input type="number" name="m2" value="${list[0].mark2}"></p>
                <p><input type="hidden" name="tab" value="Result"></p>
                <p>&nbsp</p>
                <p><label></label><input class="fclass" type="submit" value="${submitLabel}"></p>
            </form>

        </c:when>

        <c:otherwise>
            <p> Welcome! </p>
        </c:otherwise>
     </c:choose>
           
	</div>

        
            
	<div id="footer">
	(c) Oleksandr / MCIT.  Programming For Mobile Class, 2016 
	</div>
    </body>
</html>
