<html lang="en"><head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>	
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v4.0.1">
    <title>Dashboard Template · Bootstrap</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/dashboard/">
    <!-- Bootstrap core CSS -->
<!-- <link href="/docs/4.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    Favicons
<link rel="apple-touch-icon" href="/docs/4.5/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/4.5/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/4.5/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/4.5/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/4.5/assets/img/favicons/safari-pinned-tab.svg" color="#563d7c">
<link rel="icon" href="/docs/4.5/assets/img/favicons/favicon.ico">
<meta name="msapplication-config" content="/docs/4.5/assets/img/favicons/browserconfig.xml">
<meta name="theme-color" content="#563d7c"> -->

<style>
.center {text-align: center;}
.page-link {display: inline-block !important;}
</style>
<jsp:include page="../inc/adminHeader.jsp"/>

<div class="container-fluid">
  <div class="row">
<jsp:include page="../inc/adminSidebar.jsp"/>
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Dashboard</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
          <div class="btn-group mr-2">
            <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>
            <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
          </div>
          <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
            This week
          </button>
        </div>
      </div>

      <%-- <canvas class="my-4 w-100 chartjs-render-monitor" id="myChart" width="517" height="218" style="display: block; width: 517px; height: 218px;"></canvas> --%>

      <h2 style="text-align:center;">결제 목록</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr align="center">
              <th>번호</th>
              <th>출발지</th>
              <th>도착지</th>
              <th>결제시간</th>
              <th>가격</th>
              <th>기차시간</th>
              <th>좌석</th>
              <th>고객 이메일</th>
              <th>고객 아이디</th>
              <th>열차 종류</th>
              <th>열차 번호</th>
            </tr>
          </thead>
	<c:choose>
	
			<c:when test="${payList == null}">
				<tr>
					<td colspan="5"><b>등록된 회원이 없습니다.</b></td>
				</tr>
			</c:when>
			<c:when test="${payList != null}">
				<c:forEach var="pay" items="${payList }">
				<c:url var="url4" value="/adm/payInfo.do?num=${pay.num}">
					<c:param name="reser_id" value="${pay.reser_id}"/>
				</c:url>
					<tr align="center" onclick="location.href='${url4}'"> 
						<td>${pay.num }</td>
						<td>${pay.depplacename }</td>
						<td>${pay.arrplacename }</td>
						<td>${pay.reser_date }</td>
						<td>${pay.adultcharge }</td>
						<td>${pay.depplandtime }</td>
						<td>${pay.seat }</td>
						<td>${pay.reser_email }</td>
						<td>${pay.reser_id}</td>
						<td>${pay.traingradename }</td>
						<td>${pay.trainno}</td>
						
						
						<td><a href="delpay.do?num=${pay.num}"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
</svg></a></td>
						
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	
	<div class="center">
   <c:if test="${count > 0}">
      <c:if test="${startPage > pageBlock}">
         <c:url var="url1" value="/adm/payMember.do">
            <c:param name="pageNum" value="${startPage-pageBlock}"/>
         </c:url>
         <a style="font-size: x-large;" class="page-link" href='${url1}'>Previous</a>
      </c:if>
      <c:forEach var="i" begin="${startPage}" end="${endPage}">
      <c:url var="url2" value="/adm/payMember.do">
      <c:param name="pageNum" value="${i}"/>
      </c:url>
         <a style="font-size: x-large;" class="page-link" href='${url2}'>${i}</a>
      </c:forEach>
      
      <c:if test="${endPage < pageCount}">
         <c:url var="url3" value="/adm/payMember.do">
            <c:param name="pageNum" value="${startPage+pageBlock}"/>
         </c:url>
         <a style="font-size: x-large;" class="page-link" href='${url3}'>Next</a>
      </c:if>
   </c:if>
</div>
      </div>
    </main>
  </div>
</div>

<jsp:include page="../inc/footer.jsp"/>
</body></html>