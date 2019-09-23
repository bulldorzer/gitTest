<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
	
		function goLogin(){ //유효성체크후 DB연동과정

			var user_id = $j(".USER_ID").val();
			var user_pw = $j(".USER_PW").val();
			var login_param = $j(".inputLogindata").serialize();
			 
			if(user_id.split(" ").join("")==""){
				alert("아이디를 입력해주세요");
				$j(".USER_ID").focus();
				return;
			}

			if(user_pw.split(" ").join("")==""){
				alert("비밀번호를 입력해주세요");
				$j(".USER_PW").focus();
				return;
			}

// 			alert(login_param);
			//여기까지 파라미터값이 저장되어 넘어감
			$j.ajax({
				url:"/board/LoginViewAction.do"
		 			,type : "post"
		 			,data : login_param
					,success : function(data, textStatus, jqXHR) {
						alert(data);
						if(data.indexOf("Y")>=0){
							location.replace("/board/LoginBoardList.do");
						}
						else{
							alert("로그인 실패! 아이디, 암호 재입력 바람!");
						}
					}
		 			,error : function (jqXHR, textStatus, errorThrown) {
						alert("서버 접속 실패");
					}

				}); // ajax끝
		} //goLogin끝
		
	</script>
</head>
<body>
	<form name="inputLogindata" class="inputLogindata">
		<table align="center">
			<tr>
				<td>
					<table border="1"  >
						<tr>
							<td width="100" height="30" align="center">ID </td>
							<td><input type="text" name="USER_ID" class="USER_ID" maxlength="11"> </td>
						</tr>
						<tr>
							<td  height="30" align="center">PWD</td>
							<td><input type="password" name="USER_PW" class="USER_PW" maxlength="11"> </td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href='javascript:void(0);' onclick="goLogin();">Login</a> 
				</td>
			</tr>
			</table>
				
	</form>
	
</body>
</html>