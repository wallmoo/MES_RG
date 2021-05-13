<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.SessionUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="/res/set/css/PDF.css">
	<script type = "text/javascript" src = "http://code.jquery.com/jquery-latest.min.js"></script>
	<script type = "text/javascript" src = "https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
	<script type = "text/javascript" src = "https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

	
  </head>

  <body>

  <!-- modal orderSheet -->
  <div class="modal fade" id="modal_order_sheet" data-backdrop="static">
    <div class="modal-dialog modal-md">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="modal_code_title">리얼게인 발주서</h4>
          <div class="box-tools">
            <button type="button" id="" class="btn btn-sm" onclick="print()">인쇄</button>
            <button type="button" id="" class="btn btn-warning btn-sm" data-dismiss="modal" onclick="window.close()">닫기</button>
          </div>
        </div>
        <div class="modal-body" id="modal-body" name="modal-body">
        <c:set var="today" value="<%=new java.util.Date()%>" />
        <c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy" /></c:set>
        <c:set var="month"><fmt:formatDate value="${today}" pattern="MM" /></c:set>
        <c:set var="day"><fmt:formatDate value="${today}" pattern="dd" /></c:set>
		<!-- 현재날짜 -->
          <!-- .order-sheet-table-wrap -->
          <div class="order-sheet-table-wrap">
            <h4>발 주 서</h4>
            <!-- 상단 테이블 -->
            <article class="top-table">
              <div class="top-cont tc-01">
                <table summary="발주서 공급자">
                  <colgroup>
                    <col width="6%" />
                    <col width="28%" />
                    <col width="38%" />
                    <col width="18%" />
                    <col width="10%" />
                  </colgroup>
                  <tbody>
                    <tr>
                      <th rowspan="6" class="top-title">공<br />급<br />자</th>
                      <th colspan="2" class="provider">${BASE.VDR_NM }</th>
                      <th class="text-left">귀중</th>
                      <td></td>
                    </tr>
                    <tr>
                      <th class="text-left">담당자 :</th>
                      <td>${BASE.MTL_ORD_REG_ID }</td>
                      <th class="text-left">귀하</th>
                      <td></td>
                    </tr>
                    <tr>
                      <th class="text-left">전화 :</th>
                      <td colspan="2">${BASE.VDR_TEL }</td>
                      <td></td>
                    </tr>
                    <tr>
                      <th rowspan="2" class="text-left">팩스 :</th>
                      <td colspan="2" rowspan="2">${BASE.VDR_FAX }</td>
                      <td></td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                    <tr>
                      <th class="text-left">메일 :</th>
                      <td colspan="2">
                        ${BASE.VDR_ML1 } , ${BASE.VDR_ML2 }, ${BASE.VDR_ML3 }
                      </td>
                      <td></td>
                    </tr>
                    <tr>
                    <td colspan="4">&nbsp;</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="top-cont tc-02">
                <table summary="발주서 공급 받는자">
                  <colgroup>
                    <col width="6%" />
                    <col width="28%" />
                    <col width="66%" />
                  </colgroup>
                  <tbody>
                    <tr>
                      <th id="b1" rowspan="6" class="top-title">
                        공<br />급<br />받<br />는<br />자
                      </th>
                      <th>회사명</th>
                      <td>${BASE.CST_NM }</td>
                    </tr>
                    <tr>
                      <th>사업자등록번호</th>
                      <td>${BASE.CST_NO }</td>
                    </tr>
                    <tr>
                      <th>대표자</th>
                      <td>${BASE.CST_CEO_NM }</td>
                    </tr>
                    <tr>
                      <th>주소</th>
                      <td>
                        ${BASE.CST_ADD }
                      </td>
                    </tr>
                    <tr>
                      <th>전화</th>
                      <td>${BASE.CST_TEL }</td>
                    </tr>
                    <tr>
                      <th>팩스</th>
                      <td>${BASE.CST_FAX }</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </article>
            <!-- / 상단 테이블 -->
            <table class="mid-table2" style="height:5% !important" border="1px;" frame="above">
  				<tr>
                  <th colspan="2" width="21.4%">프로젝트명</th>
                  <td colspan="3"  width="24.6%">${BASE.PJT_NM} </td>
                  <th colspan="2" width="18.5%">발주서번호</th>
                  <td colspan="3" >${BASE.ORD_IDX}</td>
                </tr>
             </table>
            <!-- 중간 테이블 -->
            <table class="mid-table"">
              <colgroup>
                <col width="3%" />
                <col width="18%" />
                <col width="18%" />
                <col width="5%" />
                <col width="5%" />
                <col width="11%" />
                <col width="11%" />
                <col width="10%" />
                <col width="11%" />
                <col width="5%" />
              </colgroup>
              <thead>
                <tr class="bl-none">
                  <th scope="col">순번</th>
                  <th scope="col">품목명</th>
                  <th scope="col">규격명</th>
                  <th scope="col">수량</th>
                  <th scope="col">단위</th>
                  <th scope="col">단가</th>
                  <th scope="col">공급가액</th>
                  <th scope="col">부가세</th>
                  <th scope="col">납기일</th>
                  <th scope="col">비고</th>
                </tr>
              </thead>
              <tbody class="bl-none">
              <c:set var="rnum" value="1" />
              <c:set var="csum" value="0" />
              <c:set var="vsum" value="0" />
	              <c:forEach var="ITEM" items="${DATALIST}">
	              	<c:set var="SUMS" value="${ITEM.MTL_PRICE * ITEM.ORD_DTL_QTY }" /> 
	                <c:set var="csum" value="${csum + SUMS }" /> 
	                <c:set var="VUMS" value="${SUMS * 0.1 }" />
	                <c:set var="vsum" value="${vsum + VUMS  }" /> 
	              
	                <tr>
	                  <td>${rnum }</td>
	                  <td>${ITEM.MTL_NM }</td>
	                  <td>${ITEM.MTL_STD }</td>
	                  <td>${ITEM.ORD_DTL_QTY }</td>
	                  <td>${ITEM.MTL_UNT }</td>
	                  <td class="text-right">
					    <fmt:formatNumber type="number" maxFractionDigits="3" value="${ITEM.MTL_PRICE}" />
					  </td>
	                  <td class="text-right">
	                  <fmt:formatNumber type="number" maxFractionDigits="3" value="${SUMS}" />
	                   </td>
	                  <td class="text-right">
	                  <fmt:formatNumber type="number" maxFractionDigits="3" value="${VUMS}" />
					</td>
	                  <td><fmt:formatDate value="${ITEM.MTL_ORD_DLV_DT}" pattern="yyyy.MM.dd" /></td>
	                  <td>${ITEM.MTL_BG}</td>
	                </tr>
	                <c:set var="rnum" value="${rnum +1 }" /> 

	               </c:forEach>
	               
	               <c:if test="${rnum <3}">
	   				<c:forEach var="i" begin="${rnum}" end="3">
		                <tr>
		                  <td>${rnum }</td>
		                  <td></td>
		                  <td></td>
		                  <td></td>
		                  <td></td>
		                  <td class="text-right"></td>
		                  <td class="text-right">-</td>
		                  <td class="text-right">-</td>
		                  <td></td>
		                  <td></td>
		                </tr>
	                </c:forEach>
	               </c:if>
	                
	                
	               <tfoot class="bl-none">
	                <tr>
	                  <td colspan="10"></td>
	                </tr>
	                <tr class="mid-total bg-none">
	                  <th colspan="2">공급가액</th>
	                  <td class="text-right">
	                  	<fmt:formatNumber type="number" maxFractionDigits="3" value="${csum}" />
	                  </td>
	                  <th colspan="2">부가세</th>
	                  <td colspan="2" class="text-right">
	                  	<fmt:formatNumber type="number" maxFractionDigits="3" value="${vsum}" />
	                  </td>
	                  <th>합계</th>
	                  <td colspan="2" class="text-right">
	                  	<fmt:formatNumber type="number" maxFractionDigits="3" value="${csum+vsum }" />
	                  </td>
	                </tr>
	              </tfoot>
              </tbody>
            </table>
            <!-- / 중간 테이블 -->
  
            <!-- 하단 테이블-->
            <table class="bot-table">
              <colgroup>
                <col width="15%" />
                <col width="85%" />
              </colgroup>
              <tfoot class="order-sheet-sign bl-none">
                <tr>
                  <td colspan="2">
                    위와 같이 발주하오니 계약요건을 준수하여 납품 바랍니다.
                  </td>
                </tr>
                <tr>
                  <td colspan="2">
                    <div class="sign-wrap">
                      <span class="comp-name">${BASE.CST_NM }</span>
                      <span class="date">
                      	${year }년 ${month }월 ${day }일
                      </span>
                    </div>
                  </td>
                </tr>
              </tfoot>
              <tbody>
                <tr>
                  <th>납품장소</th>
                  <td>${BASE.MTL_ORD_PLC}</td>
                </tr>
                <tr>
                  <th>기본계약</th>
                  <td class="text-left">
                    1. 본 주문서는 별도의 계약을 하지 않는 한 갑과 을의 물품매매
                    계약서로 하며 본 계약으로 이루어진 갑과 을의 채권은 제3자에게 양도
                    할 수없다.<br />
                    2. 납품물품은 규격서 및 도면에 일치하는 물품이어야 하며 당사의
                    검사기준에 합격한 물품 이어야 한다.<br />
                    3. 물품의 납품은 반드시 당사자가 지정한 장소 및 지정한 일시 이내에
                    납품되어야하며 납기 일이 경과한 경우는 지체보상금을 지체 1일당
                    발주금액의 0.5%의 금액을 공제한다.<br />
                    4.발주후 3일 이내에 이의 신청을 하지아니하면 계약의 효력이
                    지속되며 기타사항은 일반상거래 관례에 따른다.<br />
                    5. 대금지급 : 당사와 협의 기준에 따름
                  </td>
                </tr>
                <tr>
                  <th>협조 사항</th>
                  <td class="text-left">
                    상기 발주서의 내용을 충분히 이해하며 각 품목의 제조사 성적서(C to
                    C등)가 발행가능하다면 원본제출이 원칙이나, 사본제출시 성적서 내에
                    공금자의 원본대조 필 직인, 회사명, 담당자명, 전화번호 명기
                    바랍니다. 또한 제출된 성적서에 대한 발주자의 진위여부 회신 요청시
                    이행을 약속합니다.
                  </td>
                </tr>
              </tbody>
            </table>
            <!-- /하단 테이블-->
          </div>
          <!-- /.order-sheet-table-wrap -->
        </div>
      </div>
    </div>
  </div>
  <!-- / modal orderSheet -->

<script>
  // modal 띄우기 
	function insertAccount() {
		console.log('orderSheet()');
	
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('리얼게인 발주서');

    $("#VDR_NM").val('');
		$("#VDR_CEO_NM").val('');
		$("#VDR_ADD").val('');
		$("#VDR_TEL").val('');
		$("#VDR_FAX").val('');
		$("#VDR_ML1").val('');
		$("#VDR_ML2").val('');
		$("#VDR_ML3").val('');
		$("#VDR_HP").val('');
		$("#VDR_NO").val('');

		$("#modal_order_sheet").modal('show');
	}
	function print() {
		//modal-body
		
		var sw=screen.width;
	    var sh=screen.height;
	    var w=800;//팝업창 가로길이
	    var h=600;//세로길이
	    var xpos=(sw-w)/2; //화면에 띄울 위치
	    var ypos=(sh-h)/2; //중앙에 띄웁니다.
	 
	    var pHeader="<!DOCTYPE html><html lang='ko'><head><meta charset='UTF-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0' /><link rel='stylesheet' href='/res/set/css/PDF.css'></head><body>";
	    var pgetContent=document.getElementById("modal-body").innerHTML + "<br>";
	     //innerHTML을 이용하여 Div로 묶어준 부분을 가져옵니다.
	    var pFooter="</body></html>";
	    pContent=pHeader + pgetContent + pFooter; 
	      
	    pWin=window.open("","print","width=" + w +",height="+ h +",top=" + ypos + ",left="+ xpos +",status=yes,scrollbars=yes"); //동적인 새창을 띄웁니다.
	    pWin.document.open(); //팝업창 오픈
	    pWin.document.write(pContent); //새롭게 만든 html소스를 씁니다.
	    pWin.document.close(); //클로즈
	    setTimeout(function(){
		    pWin.print(); //윈도우 인쇄 창 띄우고
		    pWin.close(); //인쇄가 되던가 취소가 되면 팝업창을 닫습니다.
	    },300);

		};
</script>

  </body>
</html>
