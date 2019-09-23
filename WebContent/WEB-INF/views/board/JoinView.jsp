<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">


// 		중복확인 실행함수
		function checkId(){

			var user_id = $j(".USER_ID").val();
			var user_id_patton = /\w{5,8}/;

			$j("[name='checkId_chk']").val("checked");
			
			if(user_id.split(" ").join("")==""){
				alert("only English and Number length ID 5~8 [Write ID]");
				$j(".USER_ID").focus();
				return;
			}

			if(user_id_patton.test(user_id)==false){
				alert("only English and number length 5~8");
				$j(".USER_ID").val("");
				$j(".USER_ID").focus();
				return;
			}
			
			
			$j.ajax({
				url : "/board/checkId.do",
				type : "POST",
				data : $j(".join").serialize(),
			 	success: function(data, textStatus, jqXHR)
				    {
				 		if(data.indexOf("N")>=0){
							alert("nice ID")
							
						}
						else{
							alert("already existing ID");
							$j(".USER_ID").focus();
						}
				    },
			    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("서버 접속실패");
				    }
			});
			
		}

		//유효성체크 하는곳 join버튼 클릭시 실행되는 함수
		function CheckJoin(){

// 			아이디와 아이디패턴
			var user_id = $j(".USER_ID").val();
			var user_id_patton = /\w{5,}/;

// 			중복확인 확인여부
			var checkId_chk = $j("[name='checkId_chk']").val();
			
// 			비밀번호와 비밀번호 패턴
			var user_pw = $j(".USER_PW").val();
			var user_pw_patton = /\w{5,}/;
			
// 			비밀번호확인
			var user_pw_check = $j(".USER_PW_Check").val();
			
// 			이름과 이름 패턴
			var user_name = $j(".USER_NAME").val();
			var user_name_patton = /^[a-zA-Z\s]+$/;
			
// 			핸드폰 두번째칸 세번째칸 과 패턴
			var user_phone2 = $j(".USER_PHONE2").val();
			var user_phone2_patton = /^[0-9]{3,4}$/;
			var user_phone3 = $j(".USER_PHONE3").val();
			var user_phone2_patton = /^[0-9]{3,4}$/;
			
// 			주소와 주소패턴
			var user_addr1 = $j(".USER_ADDR1").val();
			var user_addr1_patton = /\w+/;
			var user_addr2 = $j(".USER_ADDR2").val();
			var user_addr2_patton = /\w+/;
			
			
			
// 			아이디 유효성체크
			if(user_id.split(" ").join("")==""){
				alert("input id");
				$j(".USER_ID").focus();
				return;
			}

// 			아이디 패턴검사 (5~8 영문과 숫자로만)
			if(user_id_patton.test(user_id)==false){
				alert("only English and number length 5~8");
				$j(".USER_ID").val("");
				$j(".USER_ID").focus();
				return;
			}

// 			아이디 중복체크 확인
			if(checkId_chk != "checked" ){
				alert("ID CHECK Button Click Please");
				return;
			}

// 			비밀번호 유효성체크
			if(user_pw.split(" ").join("")==""){
				alert("input pwd");
				$j(".USER_PW").focus();
				return;
			}

			else if (user_pw_patton.test(user_pw)==false){
				alert("only English and number length 5~8");
				$j(".USER_PW").focus();
				return;
			}

// 			비밀번호와 비밀번호확인 비밀번호가 다를때 알림
			if(user_pw!=user_pw_check){
				alert("pw != pw_check");
				$j(".USER_PW_Check").val("");
				$j(".USER_PW_Check").focus();
				return;
			}

// 			이름 입력 유효성체크
			if(user_name.split(" ").join("")==""){
				alert("Write your sexy name !");
				$j(".USER_NAME").focus();
				return;
			}

			else if (user_name_patton.test(user_name)==false){
				alert("only English");
				$j(".USER_NAME").val("");
				$j(".USER_NAME").focus();
				return;
			}

// 			연락처 유효성 체크
			if(user_phone2.split(" ").join("")=="" || user_phone3.split(" ").join("")=="" ){
				alert("give me phone number?");
				

				if(user_phone2.split(" ").join("")==""){
					$j(".USER_PHONE2").focus();
					return;
				}
				else if (user_phone2_patton.test(user_phone2)==false){
					alert("only number 3~4");
					$j(".USER_PHONE2").focus();
					return;
				}
				
				if(user_phone3.split(" ").join("")==""){
					$j(".USER_PHONE3").focus();
					return;
				}

				else if (user_phone3_patton.test(user_phone3)==false){
					alert("only number 3~4");
					$j(".USER_PHONE3").focus();
					return;
				}
				
			}

			

			$j.ajax({
				url : "/board/join.do",
				type : "POST",
				data : $j(".join").serialize(),
			 	success: function(data, textStatus, jqXHR)
				    {
				 		if(data.indexOf("Y")>=0){
							alert("Complete Join")
							location.replace("/board/boardList.do");
						}
						else{
							alert("Server problem Admin call");
							
						}
				    },
			    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("not interface Server");
				    }
			});
	}//CheckJoin END

	
	</script>
	</head>
	
	<!-- 뷰에서 나오는 구간 회원가입 테이블 -->
	<body>
		<form name="join" class="join">
			<table align="center">
				<tr >
					<td><a href="/board/boardList.do">List</a></td>
				</tr>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>id</td>
								<td>
								<input type="text" name="USER_ID" class="USER_ID" size="11"  maxlength="11" onKeydown="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');">&nbsp;
								<input type="button" value="checkId" onclick="checkId();">
								<input type="hidden" name="checkId_chk" value="Unchecked"></td>
							</tr>
							<tr>
								<td>pw</td>
								<td>
								<input type="password" name="USER_PW" class="USER_PW" value="12345" size="11" maxlength="11" onKeydown="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');">
								</td>
							</tr>
							<tr>
								<td>pw check</td>
								<td><input type="password" name="USER_PW_Check" class="USER_PW_Check" value="12345" maxlength="11" size="11"></td>
							</tr>
							<tr>
								<td>name</td>
								<td><input type="text" name="USER_NAME" class="USER_NAME" size="11" maxlength="11" onKeydown="this.value=this.value.replace(/[^a-zA-Z]/g,'');"></td>
							</tr>
							<tr>
								<td>phone</td>
								<td> 
									<select name="USER_PHONE1" class="USER_PHONE1">
										<c:forEach items="${USER_PHONE1}" var="USER_PHONE1">
											<option value="${USER_PHONE1.code_id}">${USER_PHONE1.code_name}</option>
										</c:forEach>
									</select>
										-<input type="text" name="USER_PHONE2" class="USER_PHONE2" size="4" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
										-<input type="text" name="USER_PHONE3" class="USER_PHONE3" size="4" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
								</td>
							</tr>
							<tr>
								<td>postNo</td>
								<td><input type="text" name="POSTNO" class="POSTNO" size="11" maxlength="11"></td>
							</tr>
							<tr>
								<td>address</td>
								<td><input type="text" name="ADDRESS" class="ADDRESS" size="11" maxlength="11"></td>
							</tr>
							<tr>
								<td>company</td>
								<td><input type="text" name="USER_COMPANY" class="USER_COMPANY" size="11" maxlength="11"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="right"><input type="button" name="join" class="join" value="join" onclick="CheckJoin();"></td>
				</tr>
				
			</table>
		</form>
	</body>
</html>