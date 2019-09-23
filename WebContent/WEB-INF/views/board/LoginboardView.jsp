<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
	<script>
		function boardUpdateForm(){
		     var form = document.getElementById("boardUpdateForm");
			      form.submit();
		}

		$j(document).ready(function(){
			
			$j("#delete").on("click",function(){
				var $frm = $j('.boardUpdateForm');
				var param = $frm.serialize();
				
				$j.ajax({
				    url : "/board/boardDeleteAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
						
						alert("메세지:"+data.success);
						
						location.href = "/board/boardList.do?pageNo=1";
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert(param);
				    	alert("삭제실패");
				    }
				});
			});
		});
	</script>
</head>
<body>

	
	<form id="boardUpdateForm" class="boardUpdateForm" method="GET" action="/board/${code_id}/${boardNum}/boardUpdate.do"> 
	   	<input type="hidden" name="boardNum" value="${board.boardNum}">
	   	<input type="hidden" name="boardComment" value="${board.boardComment}">
	   	<input type="hidden" name="boardTitle" value="${board.boardTitle}">   
	   	<input type="hidden" name="code_id" value="${board.code_id}">		
	</form> 
	
<!-- 	<form id="boardDeleteForm" class="boardDeleteForm" method="GET" action="/board/boardDeleteAction.do">  -->
<%-- 	   	<input type="hidden" name="boardNum" value="${board.boardNum}"> --%>
<%-- 	   	<input type="hidden" name="boardComment" value="${board.boardComment}"> --%>
<%-- 	   	<input type="hidden" name="boardTitle" value="${board.boardTitle}">   	 --%>
<!-- 	</form>  -->
	

	<p align="center">${sessionScope.USER_ID}님이 로그인</p>
	<table align="center">
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						${board.boardTitle}
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td>
						${board.boardComment}
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${board.USER_NAME}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/LoginBoardList.do">List</a>
				<a href="#" onclick="boardUpdateForm()">수정</a>
				<a href="#" id="delete">삭제</a>
			</td>
		</tr>
		
		
	</table>	
</body>
</html>