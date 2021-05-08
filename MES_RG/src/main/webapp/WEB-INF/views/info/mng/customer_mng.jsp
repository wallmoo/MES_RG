<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title> <%=pageTitle %> </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="/res/bootstrap/css/modal-order-sheet.css">
  
	<jsp:include page="/common/header_inc" flush="true"> 
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
    	#customer_nm{
    		height: 30px !important;
    	}
    	#land{
    		height: 30px !important;
    	}
    	#customer_code{
    		height: 30px !important;
    	}
    	
	</style>
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1012" />
		<jsp:param name="selected_menu_cd" value="1019" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        고객사 관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">고객사 관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
				<!-- Progress Bar 
				 	<div id="hiddenDivLoading" style="visibility:hidden">
					다중 코드 입력 창 iframe 
					    <iframe id="iframeLoading" frameborder="0" style="z-index:-1; position:absolute; visibility:hidden"></iframe>
 					        <div id='load_List'><img src='/img/loading.gif' /></div>
						
 					</div> -->
					<!-- Progress Bar -->

					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						   	<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							<button type="button" id="btn_search" class="btn btn-warning btn-sm" onclick="orderSheet();">발주서</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertCustomer();">등록</button>
					     	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="updateCustomer();">수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteCustomer();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>Business</label>
									 <select id="business" name="business" class="form-control" style="height: 30px;" >
									 	<option value="ALL" selected="selected">전체</option> 
									 	<option value="business1">business1</option>
									 	<option value="business2">business2</option>
									 	<option value="business3">business3</option>
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>메인 고객사</label>
									 <select id="customer_integration" name="customer_integration" class="form-control" style="height: 30px;" ></select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>고객사명</label> 
									 <input type="combo" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="고객사명" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="고객사명" -->
<!-- 										maxlength="15" onkeypress="if(event.keyCode==13) {loadList(); return false;}"  > -->
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>사업장</label>
									 <input type="combo" id="land" name="land" class="form-control input-sm" placeholder="사업장" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="land" name="land" class="form-control input-sm" placeholder="사업장" -->
<!-- 										maxlength="3" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
									
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>고객사코드</label> 
									<input type="combo" id="customer_code" name="customer_code" class="form-control input-sm" placeholder="고객사코드" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									<input type="text" id="customer_code" name="customer_code" class="form-control input-sm" placeholder="고객사코드" -->
<!-- 										maxlength="10" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
								</div>
							</div>
							
							
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 620px;"></div> 
							</div>
							
						</div>
					</div>
				</div>
				<!-- <div id="grid_list" style="width: 100%; height: 620px;"></div> -->
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<input type="hidden" id="fg_check_yn" name="fg_check_yn" value="N">
					
					<div class="row">
						<div class="form-group" style="margin-bottom: 5px;">
							<label for="" class="col-sm-3 control-label">Business</label>
							<div class="col-sm-7">
								<select class="form-control input-sm" id="m_business" name="m_business" >
								</select>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
						
							<div class="col-sm-10 text-right" ><span style="color: #EA2E2A;">* 찾는 메인 고객사가 없으면</span></div> <!-- style="height: 30px;"  -->
							<div class="col-sm-2 text-right" ></div>
							<label for="" class="col-sm-3 control-label">메인 고객사</label>
							<div class="col-sm-5" style="padding-right: 0px;">
								<select class="form-control input-sm" id="m_customer_integration" name="m_customer_integration" >
								 </select>
							</div>
							
							<div class="col-md-2 text-center">
								<div class="box-tools">
									<span id="btn_dcode_add" class="btn btn-success btn-sm" style="margin-right: 20px; width: 100%;"><!-- 60px; --> 
										<i class="glyphicon glyphicon-plus"></i> 
									</span>
					       	   	 </div>
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사코드</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right" id="m_customer_code" maxlength="100">
							</div>
							<div class="col-sm-3">
			                  	<button type="button" id="btn_check" class="btn btn-primary btn-sm">고객사코드 중복체크</button>
			                  </div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_customer_nm" maxlength="150">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_business_reg_num" maxlength="200">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업장</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_land" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_address" value="" maxlength="100">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telf" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telfx" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_email_address" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveCustomer();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- modal_dcode -->
<div class="modal fade" id="modal_dcode" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_code_title">메인 고객사 간편 등록</h4> <!-- System Code Management -->
        </div>
        <div class="modal-body" id="modal_code_body">
          <div class="box box-warning box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">Code information</h3><!-- Detail -->
              <div class="box-tools pull-right">
	              <button type="button" id="btn_dcode_save" class="btn btn-success btn-sm">Save</button><!-- Code_ -->
<!-- 	              <button type="button" id="btn_dcode_del" class="btn btn-danger btn-sm">Code_Delete</button> -->
              </div>
            </div>

            <form id="frm_dcode" name="frm_dcode" class="form-horizontal">
            	<input type="hidden" id="d_cmd" name="cmd">
            	<input type="hidden" id="d_code_use_yn" name="code_use_yn" />
              <div class="box-body">
                <div class="form-group hidden">
                  <label for="master_code" class="col-sm-3 control-label">Master_Code</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_master_code" name="master_code" class="form-control" placeholder="Code ID" readonly="readonly">
                  </div>
                </div>
                <!-- <div class="form-group">
                  <label for="detail_code" class="col-sm-3 control-label">Detail_Code</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_detail_code" name="detail_code" class="form-control" placeholder="Code ID" readonly="readonly">
                  </div>
                </div> -->
                <div class="form-group">
                  <label for="code_nm" class="col-sm-3 control-label">Code_Nm</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_code_nm" name="code_nm" class="form-control" placeholder="Code Name" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_nm_en" class="col-sm-3 control-label">Code_Nm_En</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_code_nm_en" name="code_nm_en" class="form-control" placeholder="Code Name(Eng)" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_dscr" class="col-sm-3 control-label">Code_Description</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_code_dscr" name="code_dscr" class="form-control" placeholder="Code Description" maxlength="100">
                  </div>
                </div>
                <div class="form-group hidden">
                  <label for="code_order" class="col-sm-3 control-label">Code_Display</label>
                  <div class="col-sm-9">
                    <input type="number" id="d_code_order" name="code_order" class="form-control" placeholder="출력순서" maxlength="100" oninput="maxLengthCheck(this);">
                  </div>
                </div>
                <div class="form-group hidden">
                  <label for="rdo_dcode_use_yn" class="col-sm-3 control-label">Use_Yn</label>
                  <div class="col-sm-9">
                  	<label>
		                  <input type="radio" name="rdo_dcode_use_yn" class="flat-red" value="Y" checked> Use
		                </label>
		                <label>
		                  <input type="radio" name="rdo_dcode_use_yn" class="flat-red" value="N" > No Use
		                </label>
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter1_val" class="col-sm-3 control-label">Expand Filed01</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_filter1_val" name="filter1_val" class="form-control" placeholder="Expand Filed01" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter2_val" class="col-sm-3 control-label">Expand Filed02</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_filter2_val" name="filter2_val" class="form-control" placeholder="Expand Filed02" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter3_val" class="col-sm-3 control-label">Expand Filed03</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_filter3_val" name="filter3_val" class="form-control" placeholder="Expand Filed03" maxlength="100">
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

<!-- modal_end -->


<!-- modal orderSheet -->
<div class="modal fade" id="modal_order_sheet" data-backdrop="static">
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
                    <td>㈜리얼게인</td>
                  </tr>
                  <tr>
                    <th>사업자등록번호</th>
                    <td>112-81-533395</td>
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
  
  
  
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->

<script type="text/javascript">
	var startValue_combo = "";
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	comboValue_land = new Array;
	
	$(function($) {
// 		fnBusiness('');
// 	 	fnBusiness('m_');

		fnCdD('business', 'MC1012');
		fnCdD('m_business', 'MC1012');

		fnCdD('m_customer_integration', 'MC1017');
		fnCdD('customer_integration', 'MC1017');
		
	 	fnLoadCommonOption(); 	 
	 	fnLoadCustomerGrid();
	 	
	})
	
	function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		
		$('#request_date_range').daterangepicker({
			opens: 'right', 
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
		});
	}
	
	
	$("#m_customer_code").change(function(){
		$("#fg_check_yn").val("N");
	});
	
	$("#business").change(function(){
		loadList();
	});
	
	$("#customer_integration").change(function(){
		loadList();
	});
	
	function fnLoadCustomerGrid(){
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
				{ field:'business_code', caption:'Business Code', size:'10%', style:'text-align:center', hidden: true}, 
				{ field:'business_nm', caption:'Business', size:'10%', style:'text-align:center', sortable: true }, 
				
				{ field:'customer_integration_code', caption:'메인고객사 Code', size:'10%', style:'text-align:center', hidden: true}, 
				{ field:'customer_integration_nm', caption:'메인고객사', size:'10%', style:'text-align:center', sortable: true }, 
				
				{ field:'customer_code', caption:'고객사코드', size:'8%', style:'text-align:center', sortable: true }, 
				{ field:'customer_nm', caption:'고객사명', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'land', caption:'사업장', size:'7%', style:'text-align:center', sortable: true}, 
				{ field:'address', caption:'주소', size:'17%', style:'text-align:center', sortable: true},
				{ field:'telf', caption:'전화번호', size:'7%', style:'text-align:center', sortable: true}, 
				{ field:'telfx', caption:'팩스', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'email_address', caption:'이메일', size:'8%', style:'text-align:center', sortable: true},
				{ field:'business_reg_num', caption:'사업자번호', size:'7%', style:'text-align:center', sortable: true},
				{ field:'creator_nm', caption:'등록자', size:'4%', style:'text-align:center', sortable: true},
				{ field:'updater_nm', caption:'수정자', size:'4%', style:'text-align:center', sortable: true},
				{ field:'creator', caption:'등록자', size:'4%', style:'text-align:center', sortable: true, hidden:true},
				{ field:'updater', caption:'수정자', size:'4%', style:'text-align:center', sortable: true, hidden:true}
				], 
			sortData: [{field: 'customer_code', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	
	function loadList() {
		var page_url = "/info/customer/selectCustomer";
		var postData = "customer_code=" + encodeURIComponent($("#customer_code").val())
			 + "&customer_nm=" + encodeURIComponent($("#customer_nm").val());
		
		if( $("#business option:selected").val() != "ALL") {
			postData += "&business_code=" + encodeURIComponent($("#business option:selected").val());
			postData += "&business_codeT=" + "";
			if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
				postData +=  encodeURIComponent("MD1282");	
			} 
			
		} else {
			postData += "&business_code=" + encodeURIComponent("");
		}
		
		if( $("#customer_integration option:selected").val() != "ALL") {
			postData += "&customer_integration_code=" + encodeURIComponent($("#customer_integration option:selected").val());
		} else {
			postData += "&customer_integration_code=" + encodeURIComponent("");
		}
		
			postData += "&land=" + encodeURIComponent($("#land").val());
		
	
		w2ui['grid_list'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
// 					console.log("startValue_combo = " + startValue_combo);
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
// 						if (startValue_combo == "") {
							comboValue_nm.push(row.customer_nm ? row.customer_nm+'' : '');
							comboValue_cd.push(row.customer_code ? row.customer_code+'' : '');
							comboValue_land.push(row.land ? row.land+'' : '');
// 						}
					});
					w2ui['grid_list'].records = rowArr;
// 					if (startValue_combo != "") {
// 						console.log(":>");
		                // specifying an onOpen handler instead is equivalent to specifying an onBeforeOpen handler, which would make this code execute too early and hence not deliver.
// 						$("#customer_code").w2field().refresh();		                
// 						$("#customer_code").w2field().clear();
//  						//$("#customer_code").w2field().w2render('field');
// 						$("#customer_code").w2field().set({ id:'Status Update', text:'Status Update' });	// force change

// 					}
					
					// Drop List
					$('#customer_code').w2field('combo', { items: _.uniq(comboValue_cd, false), match : 'contains' });
					$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm, false), match : 'contains' });
					$('#land').w2field('combo', { items: _.uniq(comboValue_land, false), match : 'contains' });
					/*
					// http://w2ui.com/web/docs/1.5/form/fields-enum ( Multi Select )
					$('#customer_nm').w2field('customer_nm', {
				        items: comboValue_nm,
				        openOnFocus: true,
				        max: 2 // max 값이 2이면 값을 두개만 입력 가능하다.
				    });
					*/
					
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {
				startValue_combo = ":)";
			}
		});
		
	}

	// 실패
	 /* $('#customer_nm').w2field('combo', {	
	    url: '/info/customer/selectCustomer2', 
	    renderItem: function (item) {
	    	console.log("item - render");
	    	//console.log(item);
	        return item.customer_nm;
	    },
	    renderDrop: function (item) {
	    	console.log("item - renderDrop");
	    	//console.log(item);
	        return item.customer_nm;
	    },
	    compare: function (item, search) {
	    	console.log("item - search");
	    	//console.log(item);
	    	
	        var customer_nm = search;
	        
	        var match = false;
	        var re1 = new RegExp(customer_nm, 'i');
	            if ( re1.test(item.customer_nm) ) match = true;
	      
	        return match;
	    },
	    onSearch: function (event) {
	    	console.log("event - onSearch");
	    	console.log(event);
	    }, 
	    onNew: function (event) {
	        console.log('++ New Item: Do not forget to submit it to the server too', event);
	        $.extend(event.item, { customer_nm : event.item.text });
	    }
	});  */

	function fnCdD(val, val2){
		console.log("fnCdD("+val+")");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/codeDetail/selectCdD";
		var postData = "master_code=" + encodeURIComponent(val2);
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    dataType: 'json', 
		    async : false, // 다 끝나고 다음 처리 해!
		    success:function(data, textStatus, jqXHR){
//	 	    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
		    		rowArr = data.rows;
		    		
		    		var sub = val.substr(0,2);
		    		
		    		//  if(valsub != "m_")
		    		if(sub.indexOf("m_") == -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						if( val == "business" && row.detail_code == "MD1282" ) {
							
						} else {
							$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						}
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		 			if( val == "business" ) {
		 				$("#"+val+" option:eq(1)").prop("selected", true);	
		 			}
		 			
		    	} 
		    	
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    }
		});
		
	}
	
	/* function fnBusiness(val){
		console.log("fnBusiness("+val+")");
		
		initOptions($('#'+val+'business')); // select 박스 초기화
		
		var strUrl = "/info/codeDetail/selectCdD";
		var postData = "master_code=" + encodeURIComponent("MC1012");
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    dataType: 'json', 
		    async : false, // 다 끝나고 다음 처리 해!
		    success:function(data, textStatus, jqXHR){
		    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length>0 ) { // 1
		    		rowArr = data.rows;
		    		
		    		if(val != "m_")
		    			$("#"+val+"business" ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val+"business" ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					});
					
		 			$("#"+val+"business option:eq(0)").prop("selected", true);	 			
					
		    	} else if(data.status == "200" && (data.rows).length==0 ) {
		    		initOptions($('#'+val+'business')); // select 박스 초기화
		    		
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    }
		});
	} */
	
	// modal_dcode 모달
	$( "#btn_dcode_add" ).on('click', function(e) {
// 		if(e.target.id == "btn_dcode_add"){
			$("form").each(function() {  
				if(this.name == "frm_dcode") {
		        	this.reset();
		        	$("#d_code_order").val("9999");
		        	$("#d_master_code").val("MC1017");
		        }  
     		});
			
			$("#btn_dcode_del").prop("disabled", true);
			$("#d_cmd").val("insert.detail_code");
			
			$("#modal_dcode").modal('show');
// 		}
	});
	
	

	$( "#btn_dcode_save" ).on('click', function(e) {
		e.preventDefault();
// 		if(e.target.id == "btn_dcode_save"){
			if($.trim($("#d_code_nm").val()).length == 0 || $.trim($("#d_code_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Code)", "코드명을 입력하세요.(영문코드포함)");
				return;
			}
			
			if($.trim($("#d_code_order").val()).length != 4) {
				fnMessageModalAlert("Notification(Code)", "코드출력순서를 4자리를 입력하세요.");
				return;
			}
			
			$("#d_code_use_yn").val($(':radio[name="rdo_dcode_use_yn"]:checked').val());
			fnSaveCode("frm_dcode");
// 		}
	});	
	

	function fnSaveCode(frm_name){
	  var postData = $("#"+frm_name).serializeArray();
	  var formURL = "/backend/code/save_code";
	  
	  $.ajax({
	      url : formURL,
	      type: "POST",
	      data : postData,
	      success:function(data, textStatus, jqXHR){
	      	if(data.status == "200") {
	      		fnMessageModalAlert("Notification(Code)", "입력하신 코드를 저장하였습니다.");
	      		
      			/* var grid = $("#grid_mcode");
      			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
      			fnSearchDetailCodeGrid(selected_master_code); */
      			
      			fnCdD('m_customer_integration', 'MC1017');
      			fnCdD('customer_integration', 'MC1017');
      			
      			$("#modal_dcode").modal('hide');
	      		
	      	} else {
	      		fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");	
	      	}
	      },
	      error: function(jqXHR, textStatus, errorThrown){
	        fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");	
	      }
	  });
	}
	
	$( "#btn_check" ).on('click', function(e) {
		e.preventDefault();
		if($.trim($("#m_customer_code").val()).length == 0) {
			fnMessageModalAlert("알림", "고객사코드를 입력하세요.");
			return;
		}
		
		/* if($.trim($("#m_member_id").val()).length < 3) {
			fnMessageModalAlert("Notification(Organ)", "고객사코드는 3자리이상을 입력하세요.");
			return;
		} */
		fnCheckCustomer();
	});
	
	function fnCheckCustomer(){
		var customer_code = $("#m_customer_code").val();
		var postData = "customer_code="+encodeURIComponent(customer_code);
	  var formURL = "/info/customer/checkCustomer";
	  
	  $.ajax({
	      url : formURL,
	      type: "POST",
	      data : postData,
	      success:function(data, textStatus, jqXHR){
	      	if(data.status == "200") {
	      		if(data.cnt > 0) {
	      			$("#fg_check_yn").val("N");
	      			fnMessageModalAlert("알림", "입력하신 고객사 코드는 사용할 수 없습니다.(이미 사용중)");
	      		} else {
	      			$("#fg_check_yn").val("Y");
	      			fnMessageModalAlert("알림", "입력하신 고객사 코드는 사용할 수 있습니다.");
	      		}
	      	} else {
	      		fnMessageModalAlert("알림", "입력하신 고객사 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
	      	}
	      },
	      error: function(jqXHR, textStatus, errorThrown){
	        fnMessageModalAlert("알림", "입력하신 고객사 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
	      }
	  });
	}
	
	// modal 띄우기 
	function orderSheet() {
		console.log('orderSheet()');
	
		/* $("#modal_info > .input-sm").val(''); */
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('리얼게인 발주서');
 		$("#m_customer_code").attr('disabled',false);
 		$("#btn_check").show();
 		$("#fg_check_yn").val("N");
 		
 		$("#m_customer_code").val('');
		$("#m_customer_nm").val('');
		$("#m_address").val('');
		$("#m_land").val('');
		$("#m_telf").val('');
		$("#m_telfx").val('');
		$("#m_email_address").val('');
		$("#m_business_reg_num").val('');

		$("#m_business option:eq(0)").prop("selected", true);	 			
		$("#m_customer_integration option:eq(0)").prop("selected", true);	 			
		
		$("#modal_order_sheet").modal('show');
	
	}
	
	
	function insertCustomer() {
		console.log('insertCustomer()');
	
		/* $("#modal_info > .input-sm").val(''); */
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('등록');
 		$("#m_customer_code").attr('disabled',false);
 		$("#btn_check").show();
 		$("#fg_check_yn").val("N");
 		
 		$("#m_customer_code").val('');
		$("#m_customer_nm").val('');
		$("#m_address").val('');
		$("#m_land").val('');
		$("#m_telf").val('');
		$("#m_telfx").val('');
		$("#m_email_address").val('');
		$("#m_business_reg_num").val('');

		$("#m_business option:eq(0)").prop("selected", true);	 			
		$("#m_customer_integration option:eq(0)").prop("selected", true);	 			
		
		$("#modal_info").modal('show');
	
	}
	
	function updateCustomer() {
		console.log('updateCustomer()');
		
		/* $("#modal_info > .input-sm").val(''); */
		
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			var data = w2ui.grid_list.get(key[0]);
			$("#m_customer_code").attr('disabled',true);
			
			$("#btn_check").hide();
			$("#fg_check_yn").val("Y");
			
			$("#m_customer_code").val(data.customer_code);
			$("#m_customer_nm").val(data.customer_nm);
			$("#m_address").val(data.address);
			$("#m_land").val(data.land);
			$("#m_telf").val(data.telf);
			$("#m_telfx").val(data.telfx);
			$("#m_email_address").val(data.email_address);
			$("#m_business_reg_num").val(data.business_reg_num);
			$("#m_business").val(data.business_code).prop("selected", true);
			$("#m_customer_integration").val(data.customer_integration_code).prop("selected", true);
			
		
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveCustomer() {
		console.log('saveCustomer()');
		
		var customer_code = $("#m_customer_code").val();
		var customer_nm = $("#m_customer_nm").val();
		var address = $("#m_address").val();
		var land = $("#m_land").val();
		var telf = $("#m_telf").val();
		var telfx = $("#m_telfx").val();
		var email_address = $("#m_email_address").val();
		var business_reg_num = $("#m_business_reg_num").val();
		var business_code = $("#m_business option:selected").val();
		var business_nm = $("#m_business option:selected").text();
		
		
		var customer_integration_code = $("#m_customer_integration option:selected").val();
		var customer_integration_nm = $("#m_customer_integration option:selected").text();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
		} else if (key.length == 1){
			flag = "U";
		}

// 		if(flag=="I" && !chkSubmit($("#m_customer_code"), "고객사코드를")) return;

		if($("#fg_check_yn").val() == "N") {
			fnMessageModalAlert("알림", "고객사코드 중복체크를 확인하세요.");
			return;
		} else if(flag=="I" && !chkSubmit($("#m_customer_code"), "고객사코드를")) return;
		
		if(/* flag=="I" && */ !chkSubmit($("#m_customer_nm"), "고객사명을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_land"), "사업장을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_address"), "주소를")) return; 
		
// 		if(flag=="I" && !chkSubmit($("#m_telf"), "전화번호를")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_telfx"), "팩스를")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_email_address"), "이메일을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_business_reg_num"), "사업자번호를")) return;
		
		// var flag = nullToBlank(customer_code)==''?"I":"U";
		console.log("flag = " + flag);
		
		console.log( "customer_code = " + $("#m_customer_code").val() );
		console.log( "customer_nm = " +$("#m_customer_nm").val() );
		console.log( "address = " +$("#m_address").val() );
		console.log( "land = " +$("#m_land").val() );
		console.log( "telf = " +$("#m_telf").val() );
		console.log( "telfx = " +$("#m_telfx").val() );
		console.log( "email_address = " +$("#m_email_address").val() );
		console.log( "business_reg_num = " +$("#m_business_reg_num").val() );
		console.log( "business code = " +$("#m_business option:selected").val() );
		console.log( "business name = " +$("#m_business option:selected").text() );
		
		console.log( "customer_integration code = " +$("#m_customer_integration option:selected").val() );
		console.log( "customer_integration name = " +$("#m_customer_integration option:selected").text() );
		
		$("#modal_info").modal('hide');
		
		var strUrl = "/info/customer/saveCustomer";
		var postData = "flag=" + flag
			+ "&customer_code=" + encodeURIComponent(customer_code)
			+ "&customer_nm=" + encodeURIComponent(customer_nm)
			+ "&business_code=" + encodeURIComponent(business_code)
			+ "&business_nm=" + encodeURIComponent(business_nm)
			+ "&customer_integration_code=" + encodeURIComponent(customer_integration_code)
			+ "&customer_integration_nm=" + encodeURIComponent(customer_integration_nm)
			+ "&land=" + encodeURIComponent(land)
			+ "&address=" + encodeURIComponent(address)
			+ "&telf=" + encodeURIComponent(telf)
			+ "&telfx=" + encodeURIComponent(telfx)
			+ "&email_address=" + encodeURIComponent(email_address)
			+ "&business_reg_num=" + encodeURIComponent(business_reg_num);
				 
		// escape(
		
		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	loadList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
		    }
		});
	}
	
	function deleteCustomer() {
		console.log('deleteCustomer()');
	
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {
 
			var data = w2ui.grid_list.get(key[0]);
			var code = data.customer_code;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/customer/deleteCustomer";
					var postData = "customer_code=" + code;
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		console.log(data);
						 		loadList();
						    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
						 	}
						 },
						 error: function(jqXHR, textStatus, errorThrown){
						    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
						 },
						 complete: function() {
						 }
					});
					
				}
			});
		} 
	}
	
	//엑셀 1024
	function excelFileDownload()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;

		var fileName = '고객사 관리.xlsx';
		var sheetTitle = '고객사 관리';
		var sheetName = '고객사 관리';
		
		var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
		var is_rownum = true;
		
		if(gridCols != null && gridCols.length > 0){
			for(var i=0; i<gridCols.length; i++){
	 			if(!gridCols[i].hidden){
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width==undefined?"10":(gridCols[i].width).replace('px','')) + ",";
	 			}
			}
			param_col_name = param_col_name.substr(0, param_col_name.length -1);
			param_col_id = param_col_id.substr(0, param_col_id.length -1);
			param_col_align = param_col_align.substr(0, param_col_align.length -1);
			param_col_width = param_col_width.substr(0, param_col_width.length -1);
		}


		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name="+encodeURIComponent(fileName);
			export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
			export_data += "&sheet_name="+encodeURIComponent(sheetName);
			export_data += "&header_col_names="+encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
			export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));
		
		$.ajax({
		  url:export_url,
		  data:export_data,
		  type:'POST',
		  dataType: 'json',
		  success: function( data ) {
		  	if(data.status == 200) {
		  		var file_path = data.file_path;
		  		var file_name = data.file_name;
		  		var protocol = jQuery(location).attr('protocol');
	  			var host = jQuery(location).attr('host');
	  			var link_url = "/file/attach_download";
	  			link_url += "?file_path="+encodeURIComponent(file_path);
	  			link_url += "&file_name="+encodeURIComponent(file_name);
	  			
	  			$(location).attr('href', link_url);
		  	}
		  },
			complete: function () {}
		});
	}
	
	// 미 입력시
	function chkSubmit(item, msg){
		if(item.val().replace(/\s/g,"")==""){
			fnMessageModalAlert("알림", msg+ " 입력해 주세요.");
			item.val("");
			item.focus();
			return false;
		} else {
			return true;
		}
	}
	
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
//		    .append('<option value="All">-----</option>')
	    .val();
	}
	
</script>

</body>
</html>