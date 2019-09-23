<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){

		$j(".pagingNumber").html(
				getPagingNumber(
					"${totalCnt}"               		 			// �˻� ��� �� �� ����
					,"${boardVo.selectPageNo}"   				// ���� �� ���� ������ ��ȣ
					,"${boardVo.rowCntPerPage}"  				// ������ �� ��� ���� ����
					,"10"                                           // ������ �� ���� �� ��������ȣ ����
					,"goPaging()"                                   // ������ ��ȣ Ŭ�� �� ���� �� �ڽ� �ڵ�
				)
			);
		
		$j('#searchCkAll').click(function(){
			var searchCkAll = $j('#searchCkAll');
			var searchCK = $j("[name=searchCK]");
			
				if($j('#searchCkAll').prop("checked")){
						$j("[name=searchCK]").prop("checked",true);
					} 
				
				else {
						$j("[name=searchCK]").prop("checked",false);
					}
			});

		$j("[name=searchCK]").click(function(){
			
			if ($j("[name=searchCK]:checked").length==4)
			{
				$j('#searchCkAll').prop("checked",true);
			}
			else {
				$j('#searchCkAll').prop("checked",false);
			}
		});
		
		
	});
	
	function goSearch(){
// 		alert($j("[name=boardSearchForm]").serialize());
		document.boardSearchForm.submit();
	}

	function goLoginboardWrite(){
		document.LoginboardWrite.submit();
	}
	function goPaging(){
		document.boardPaging.submit();
	}
	
</script>
<body>
	<form method="get" name="boardPaging" action="/board/LoginBoardList.do">
		<input type="hidden" name="selectPageNo">
	</form>
	<form method="get" name=boardSearchForm action="/board/boardList.do">
		<table  align="center">
			<tr>
				<td align="left">
					${sessionScope.USER_ID}���� �α����Ͽ����ϴ�.
				</td>
				<td align="left">
					<a href="/board/boardList.do">LogOut</a>&nbsp;&nbsp;&nbsp;&nbsp;  
				</td>
				<td align="right">
					total : ${totalCnt}
				</td>
				
			</tr>
			<tr>
				<td colspan="3">
					<table id="boardTable" border = "1">
						<tr>
							<td width="80" align="center">
								Type
							</td>
							<td width="40" align="center">
								No
							</td>
							<td width="300" align="center">
								Title
							</td>
						</tr>
						<c:forEach items="${boardList}" var="list">
							<tr>
								<td align="center">
									${list.boardType}
								</td>
								<td>
									${list.boardNum}
								</td>
								<td value="${list.code_id}">
									<a href = "/board/${list.code_id}/${list.boardNum}/LoginboardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
							</tr>	
						</c:forEach>
					</table>
				</td>
			</tr>
			<tr colspan="3">
				<td align="right">
					<a href ="#" onclick="goLoginboardWrite()">�۾���</a>
				</td>
			</tr>
			<tr>
					<td align="center">
						<span class="pagingNumber"></span>		
					</td>
			</tr>	
			<tr colspan="3">
				<td align="left">
					<input type="checkbox" name="searchCkAll" id="searchCkAll" value="">��ü
						<c:forEach items="${boardType}" var="boardType" varStatus="loopTagStatus">	
							<input type="checkbox" name="searchCK" id="searchCK" value = "${boardType.code_id}">${boardType.code_name}
						</c:forEach>
					<input type="button" value="��ȸ" onclick="goSearch();">
				</td>
			</tr>
		</table>
	</form>	
	<form name="LoginboardWrite" action="/board/LoginboardWrite.do">
		<input type="hidden" name="USER_NAME" value="${sessionScope.USER_NAME}">
	</form>
</body>
</html>