<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
</head>
<script src="/resources/js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	var $j = jQuery.noConflict();

	//**************************************************************
	//검색화면에서 검색 결과물의 페이징 번호 출력 소스 리턴
	//**************************************************************
	function getPagingNumber(
		totRowCnt               // 검색 결과 총 행 개수
		, selectPageNo_str         // 선택된 현재 페이지 번호
		, rowCntPerPage_str     // 페이지 당 출력행의 개수
		, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
		, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
	) {
		//--------------------------------------------------------------
		// name=nowPage을 가진 hidden 태그없으면 경고하고 중지하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		$j(document).ready(function( ){
			if( $j('[name=selectPageNo]').length==0 ){
				alert("name=nowPage 을 가진 hidden 태그가 있어야 가능함.');" );
			}
		});
		var arr = [];
		try{
			if( totRowCnt==0 ){	return ""; }	
			if( jsCodeAfterClick==null || jsCodeAfterClick.length==0){
				alert("getPagingNumber(~) 함수의 5번째 인자는 존재하는 함수명이 와야 합니다");
				return "";
			}			
			//--------------------------------------------------------------
			// 페이징 처리 관련 데이터 얻기
			//--------------------------------------------------------------
			if( selectPageNo_str==null || selectPageNo_str.length==0 ) { 
				selectPageNo_str="1";  // 선택한 현재 페이지 번호 저장
			} 
			if( rowCntPerPage_str==null || rowCntPerPage_str.length==0 ) { 
				rowCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
			}
			if( pageNoCntPerPage_str==null || pageNoCntPerPage_str.length==0 ) { 
				pageNoCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
			}
			//---
			var selectPageNo = parseInt(selectPageNo_str, 10);
			var rowCntPerPage = parseInt(rowCntPerPage_str,10);
			var pageNoCntPerPage = parseInt(pageNoCntPerPage_str,10);
			if( rowCntPerPage<=0 || pageNoCntPerPage<=0 ) { return; }
			//--------------------------------------------------------------
			//최대 페이지 번호 얻기
			//--------------------------------------------------------------
			var maxPageNo=Math.ceil( totRowCnt/rowCntPerPage );   
				if( maxPageNo<selectPageNo ) { selectPageNo = 1; }

			//--------------------------------------------------------------
			// 선택된 페이지번호에 따라 출력할 [시작 페이지 번호], [끝 페이지 번호] 얻기
			//--------------------------------------------------------------
			var startPageNo = Math.floor((selectPageNo-1)/pageNoCntPerPage)*pageNoCntPerPage+1;  // 시작 페이지 번호
			var endPageNo = startPageNo+pageNoCntPerPage-1;                                      // 끝 페이지 번호
				if( endPageNo>maxPageNo ) { endPageNo=maxPageNo; }
				/*//--------------------------------------------------------------
				// <참고>위 코딩은 아래 코딩으로 대체 가능
				//--------------------------------------------------------------
				var startPageNo = 1;
				var endPageNo = pageNoCntPerPage;
				while( true ){
					if( selectPageNo <= endPageNo ){ startPageNo = endPageNo - pageNoCntPerPage + 1; break; }
					endPageNo = endPageNo + pageNoCntPerPage;
				}*/

			//---
			var cursor = " style='cursor:pointer' ";
			//arr.push( "<table border=0 cellpadding=3 style='font-size:13'  align=center> <tr>" );
			//--------------------------------------------------------------
			// [처음] [이전] 출력하는 자바스크립트 소스 생성해 저장
			//--------------------------------------------------------------
			//arr.push( "<td align=right width=110> " );
			if( startPageNo>pageNoCntPerPage ) {
				arr.push( "<span "+cursor+" onclick=\"$j('[name=selectPageNo]').val('1');"
								+jsCodeAfterClick+";\">[처음]</span>" );
				arr.push( "<span "+cursor+" onclick=\"$j('[name=selectPageNo]').val('"
					+(startPageNo-1)+"');"+jsCodeAfterClick+";\">[이전]</span>   " );
			}
			//--------------------------------------------------------------
			// 페이지 번호 출력하는 자바스크립트 소스 생성해 저장
			//--------------------------------------------------------------
			//arr.push( "<td align=center>  " );
			for( var i=startPageNo ; i<=endPageNo; ++i ){
				if(i>maxPageNo) {break;}
				if(i==selectPageNo || maxPageNo==1 ) {
					arr.push( "<b>"+i +"</b> " );
				}else{
					arr.push( "<span "+cursor+" onclick=\"$j('[name=selectPageNo]').val('"
								+(i)+"');"+jsCodeAfterClick+";\">["+i+"]</span> " );
				}
			}
			//--------------------------------------------------------------
			// [다음] [마지막] 출력하는 자바스크립트 소스 생성해 저장
			//--------------------------------------------------------------
			//arr.push( "<td align=left width=110>  " );
			if( endPageNo<maxPageNo ) {
				arr.push( "   <span "+cursor+" onclick=\"$j('[name=selectPageNo]').val('"
							+(endPageNo+1)+"');"+jsCodeAfterClick+";\">[다음]</span>" );
				arr.push( "<span "+cursor+" onclick=\"$j('[name=selectPageNo]').val('"
							+(maxPageNo)+"');"+jsCodeAfterClick+";\">[마지막]</span>" );
			}
			//arr.push( "</table>" );
			return arr.join( "" );
		}catch(ex){
			alert("getPagingNumber(~) 메소드 호출 시 예외발생!");
			return "";
		}
	}

	//**************************************************************
	function printPagingNumber(
	//**************************************************************
		totRowCnt               // 검색 결과 총 행 개수
		, selectPageNo_str         // 선택된 현재 페이지 번호
		, rowCntPerPage_str     // 페이지 당 출력행의 개수
		, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
		, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
	) {
		document.write(
			getPagingNumber(
				totRowCnt               // 검색 결과 총 행 개수
				, selectPageNo_str         // 선택된 현재 페이지 번호
				, rowCntPerPage_str     // 페이지 당 출력행의 개수
				, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
				, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
			) 
		);
	}
</script>
<body>

</body>
</html>