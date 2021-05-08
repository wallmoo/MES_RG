<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.SessionUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script type = "text/javascript" src = "http://code.jquery.com/jquery-latest.min.js"></script>
<script type = "text/javascript" src = "https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type = "text/javascript" src = "https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

 
</head>
<body>
<div class="modal_fade" id="modal_fade" name="modal_fade" data-backdrop="static">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="modal_code_title">리얼게인 발주서</h4>
        <div class="box-tools">
          <button type="button" id="" class="btn btn-sm">인쇄</button>
          <button type="button" id="" class="btn btn-warning btn-sm" data-dismiss="modal">닫기</button>
        </div>
      </div>
      <div class="modal-body">
        <!-- .order-sheet-table-wrap -->
        <div class="order-sheet-table-wrap" id="order-sheet-table-wrap" name="order-sheet-table-wrap">
          <h4>발 주 서</h4>
          <!-- 상단 테이블 -->
          <article class="top-table">
            <div class="top-cont tc-01" height="100%">
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
                    <th rowspan="6" class="top-title"><br />공<br />급<br />자<br/>&nbsp<br/></th>
                    <th colspan="2" class="provider">세븐 파트너</th>
                    <th class="text-left">귀중</th>
                    <td></td>
                  </tr>
                  <tr>
                    <th class="text-left">담당자 :</th>
                    <td>이병동 상무</td>
                    <th class="text-left">귀하</th>
                    <td></td>
                  </tr>
                  <tr>
                    <th class="text-left">전화 :</th>
                    <td colspan="2">02-586-8470</td>
                    <td></td>
                  </tr>
                  <tr>
                    <th rowspan="2" class="text-left">팩스 :</th>
                    <td colspan="2" rowspan="2">02-586-8471</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <th class="text-left">메일 :</th>
                    <td colspan="2">
                      <a href="#">shkoo@7partners.co.kr</a>
                    </td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                </tbody>
              </table>
            </div>
            
            <div class="top-cont tc-01" width = "100%">
              <table>
                <tbody >
                  <tr>
                    <th rowspan="6" class="top-title">공<br />급<br />받<br/> 는<br/>자</th>
                    <th>회사명</th>
                    <td>㈜리얼게인</td>
                  </tr>
                  <tr>
                    <th width="28%">사업자등록번호</th>
                    <td width="66%">112-81-533395</td>
                  </tr>
                  <tr>
                    <th>대표자</th>
                    <td>박대영</td>
                  </tr>
                  <tr>
                    <th>주소</th>
                    <td>
                      서울시 성동구 성수이로10길 14 에이스 하이엔드 성수타워 1103호
                    </td>
                  </tr>
                  <tr>
                    <th>전화</th>
                    <td>02-885-4781</td>
                  </tr>
                  <tr>
                    <th>팩스</th>
                    <td>02-885-4782</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </article>
          <!-- / 상단 테이블 -->

          <!-- 중간 테이블 -->
          <table class="mid-table"">
              <colgroup>
                <col width=" 3%" />
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
            <tr>
              <th colspan="2">프로젝트명</th>
              <td colspan="3" class="fc-red">해당프로젝트명</td>
              <th colspan="2">발주서번호</th>
              <td colspan="3" class="fc-red">발주서번호</td>
            </tr>
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
          <tfoot class="bl-none">
            <tr>
              <td colspan="10"></td>
            </tr>
            <tr class="mid-total bg-none">
              <th colspan="2">공급가액</th>
              <td class="text-right">-</td>
              <th colspan="2">부가세</th>
              <td colspan="2" class="text-right">-</td>
              <th>합계</th>
              <td colspan="2" class="text-right">-</td>
            </tr>
          </tfoot>
          <tbody class="bl-none">
            <tr>
              <td>1</td>
              <td>품목</td>
              <td>규격</td>
              <td>1</td>
              <td>2</td>
              <td class="text-right">5000</td>
              <td class="text-right">-</td>
              <td class="text-right">-</td>
              <td>2020.01.03</td>
              <td>완료</td>
            </tr>
            <tr>
              <td>2</td>
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
            <tr>
              <td>3</td>
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
                    <span class="comp-name">㈜리얼게인</span>
                    <span class="date">2021년 4월 14일</span>
                  </div>
                </td>
              </tr>
            </tfoot>
            <tbody>
              <tr>
                <th>납품장소</th>
                <td class="fc-red">지정된 입고 장소의 기준정보에 등록된 주소</td>
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
        <!-- /.order-sheet-table-wrap -->
      <form id="frm" class="frm" name="frm">
        <input type="file" name="file" id="file" style="display:none;">
        <input type="hidden" name="item" id="item" value="${item_code}">
      </form>

      </body>
      
<script>
/*
  var files;
$(document).ready(function(){
      var pdf = new jsPDF('p', 'mm', 'a4'); // A4 size page of PDF
      var data1 = document.querySelector('#order-sheet-table-wrap');
      html2canvas(data1).then(canvas => {
        var imgWidth = 170;
        var imgHeight = canvas.height * imgWidth / canvas.width;
        var contentDataURL = canvas.toDataURL('image/png');
        console.log("convas is ");
        console.log(contentDataURL);
        var position = 0;
        pdf.addImage(contentDataURL, 'PNG', 10, 5, imgWidth, imgHeight);
        console.log("addd");
        var files=pdf.output('blob');
        var items = $("#item").val();

        let formData = new FormData();
        formData.append("files", files);
        formData.append("items",items)
        var strUrl = "/info/info/insertBOMExcel";
				strUrl = "/info/account/test";
        $.ajax({
          type: "POST",
          url: strUrl,
          data:  formData,
          processData: false,
          contentType: false,
          cache: false,
          timeout: 600000,
          success: function (data) {
            var path = data.CMM_FLE_SYS_NM;
            location.href="/info/pdfViewer?path="+encodeURI(path);
          },
          error: function (jqXHR, textStatus, errorThrown) {
            //fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
          },
          complete: function () {
          }
        });


        //pdf.save('checkingImage.pdf');
    
    });
    //var blob = dataURItoBlob(imgData);	
	
});

  function dataURItoBlob(dataURI) {
    var byteString = atob(dataURI.split(',')[1]);
    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]
    var ab = new ArrayBuffer(byteString.length);
    var ia = new Uint8Array(ab);
    for (var i = 0; i < byteString.length; i++) {
      ia[i] = byteString.charCodeAt(i);
    }

    var bb = new Blob([ab], { "type": mimeString });
    return bb;
  }
  */

function test(){
var test="";
 $.ajax({
          type: "POST",
          url: "/info/test",
          data:  {test, test
          },
          processData: false,
          contentType: false,
          cache: false,
          timeout: 600000,
          success: function (data) {
          },
          error: function (jqXHR, textStatus, errorThrown) {
            //fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
          },
          complete: function () {
          }
}
</script>

</html>