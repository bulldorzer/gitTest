<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
	
		function goLogin(){ //��ȿ��üũ�� DB��������

			var user_id = $j(".USER_ID").val();
			var user_pw = $j(".USER_PW").val();
			var login_param = $j(".inputLogindata").serialize();
			 
			if(user_id.split(" ").join("")==""){
				alert("���̵� �Է����ּ���");
				$j(".USER_ID").focus();
				return;
			}

			if(user_pw.split(" ").join("")==""){
				alert("��й�ȣ�� �Է����ּ���");
				$j(".USER_PW").focus();
				return;
			}

// 			alert(login_param);
			//������� �Ķ���Ͱ��� ����Ǿ� �Ѿ
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
							alert("�α��� ����! ���̵�, ��ȣ ���Է� �ٶ�!");
						}
					}
		 			,error : function (jqXHR, textStatus, errorThrown) {
						alert("���� ���� ����");
					}

				}); // ajax��
		} //goLogin��
		
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