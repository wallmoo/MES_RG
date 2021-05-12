package kr.co.passcombine.set.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.URL;
import java.nio.charset.Charset;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

public class PdfPage {
// 실행 함수
	/*
	public static void PDFTEMP(MultipartHttpServletRequest request) {
// PDF를 작성하는 html
		String data="";
		int recycle = 2; //나중에 목록에서 반복할횟수
		int Maxcycle= 3; //최대출력할열
		
		String html = 
				  "<html>" + "<head></head>" + "<body>" 
				+ "<div class=\"order-sheet-table-wrap\">" + "<h4>발 주 서</h4>"
				+ "<article class=\"top-table\"><div class=\"top-cont tc-01\">  <table summary=\"발주서 공급자\"> <colgroup><col width=\"6%\" />"
				+ "<col width=\"28%\" /><col width=\"38%\" /><col width=\"18%\" /><col width=\"10%\" /> </colgroup> <tbody><tr> "
				+ "<th rowspan=\"6\" class=\"top-title\">공<br />급<br />자</th>  <th colspan=\"2\" class=\"provider\">"+dataString("공급자명")+"</th>"
				+ "<th class=\"text-left\">귀중</th>  <td></td></tr><tr>  <th class=\"text-left\">담당자 :</th>  <td>"+dataString("담당자명")+"</td>"
				+ "<th class=\"text-left\">귀하</th>  <td></td></tr><tr>  <th class=\"text-left\">전화 :</th>  <td colspan=\"2\">"+dataString("전화번호")+"</td>  <td></td></tr><tr> "
				+ "<th rowspan=\"2\" class=\"text-left\">팩스 :</th>  <td colspan=\"2\" rowspan=\"2\">"+ dataString("팩스번호")+"</td>  <td></td></tr><tr>  <td></td></tr><tr>"
				+ "<th class=\"text-left\">메일 :</th>  <td colspan=\"2\"> <a href=\"#\">"+dataString("메일주소")+"</a>  </td>  <td></td></tr> </tbody>  </table>"
				+ "</div><div class=\"top-cont tc-02\">  <table summary=\"발주서 공급 받는자\"> <colgroup><col width=\"6%\" /><col width=\"28%\" /><col width=\"66%\" />"
				+ "</colgroup> <tbody><tr>  <th id=\"b1\" rowspan=\"6\" class=\"top-title\"> 공<br />급<br />받<br />는<br />자  </th>  <th>회사명</th>  <td>"+dataString("회사명")+"</td>"
				+ "</tr><tr>  <th>사업자등록번호</th>  <td>"+dataString("사업자등록번호")+"</td></tr><tr>  <th>대표자</th>  <td>"+dataString("대표자명")+"</td></tr><tr> "
				+ " <th>주소</th>  <td>"+dataString("주소admin") + "</td></tr><tr>  <th>전화</th>  <td>"+ dataString("전화번호")+"</td></tr><tr>"
				+ "<th>팩스</th>  <td>"+dataString("팩스주소pax")+"</td></tr> </tbody>  </table></div> </article> "
				+ "<table class=\"mid-table\"\"><colgroup>  <col width=\"3%\" />  <col width=\"18%\" />  <col width=\"18%\" />  <col width=\"5%\" />  <col width=\"5%\" />  <col width=\"11%\" />  <col width=\"11%\" />  <col width=\"10%\" />  <col width=\"11%\" />  <col width=\"5%\" /></colgroup>"
				+ "<thead>  <tr> <th colspan=\"2\">프로젝트명</th> <td colspan=\"3\" class=\"fc-red\">"+dataString("해당프로젝트명")+"</td> <th colspan=\"2\">발주서번호</th> <td colspan=\"3\" class=\"fc-red\">"+dataString("발주서번호" )+"</td>  </tr>  <tr class=\"bl-none\"> <th scope=\"col\">순번</th>"
				+ " <th scope=\"col\">품목명</th> <th scope=\"col\">규격명</th> <th scope=\"col\">수량</th> <th scope=\"col\">단위</th> <th scope=\"col\">단가</th> <th scope=\"col\">공급가액</th> <th scope=\"col\">부가세</th> <th scope=\"col\">납기일</th> <th scope=\"col\">비고</th>  </tr></thead><tfoot class=\"bl-none\"> "
				+ " <tr> <td colspan=\"10\"></td>  </tr>  <tr class=\"mid-total bg-none\"> <th colspan=\"2\">공급가액</th> <td class=\"text-right\">-</td> <th colspan=\"2\">부가세</th> <td colspan=\"2\" class=\"text-right\">-</td> <th>합계</th> <td colspan=\"2\" class=\"text-right\">-</td>  </tr></tfoot><tbody class=\"bl-none\"> ";
		for(int i =0; i<Maxcycle; i++) {
			if(recycle<i) {
				html +="<tr> <td>"+(i+1)+"</td> <td>"+dataString("품목")+"</td> <td>"+dataString("규격")+"</td> <td>"+dataString("수량")+"</td> <td>"+dataString("단위")+"</td> <td class=\"text-right\">"+dataString("단가")+"</td> <td class=\"text-right\">"+dataString("공급가액")+"</td>"
					 +"<td class=\"text-right\">"+dataString("부가세")+"</td> <td>"+dataString("납기일")+"</td> <td>"+dataString("비고")+"</td>  </tr> ";
			}else {
				html+=" <tr> <td>"+(i+1)+"</td> <td></td> <td></td> <td></td> <td></td> <td class=\"text-right\"></td> <td class=\"text-right\">-</td> <td class=\"text-right\">-</td> <td></td> <td></td>  </tr>";
			}
		}
			html+="</tbody> </table> "
					+ "<table class=\"bot-table\"><colgroup>  <col width=\"15%\" />  <col width=\"85%\" /></colgroup><tfoot class=\"order-sheet-sign bl-none\">  <tr> <td colspan=\"2\">위와 같이 발주하오니 계약요건을 준수하여 납품 바랍니다. </td>"
					+ "</tr>  <tr> <td colspan=\"2\"><div class=\"sign-wrap\">  <span class=\"comp-name\">"+dataString("회사명")+"</span> <span class=\"date\">"+dataString("날짜")+"</span></div> </td>  </tr></tfoot><tbody>"
					+ "  <tr> <th>납품장소</th> <td class=\"fc-red\">지정된 입고 장소의 기준정보에 등록된 주소</td>"
					+ "  </tr>  <tr> <th>기본계약</th> <td class=\"text-left\">1. 본 주문서는 별도의 계약을 하지 않는 한 갑과 을의 물품매매계약서로 하며 본 계약으로 이루어진 갑과 을의 채권은 제3자에게 양도할 수없다.<br />2. 납품물품은 규격서 및 도면에 일치하는 물품이어야 하며 당사의검사기준에 합격한 물품 이어야 한다.<br />3. 물품의 납품은 반드시 당사자가 지정한 장소 및 지정한 일시 이내에납품되어야하며 납기 일이 경과한 경우는 지체보상금을 지체 1일당발주금액의 0.5%의 금액을 공제한다.<br />4.발주후 3일 이내에 이의 신청을 하지아니하면 계약의 효력이지속되며 기타사항은 일반상거래 관례에 따른다.<br />5. 대금지급 : 당사와 협의 기준에 따름 </td>  </tr>  <tr> <th>협조 사항</th> <td class=\"text-left\">상기 발주서의 내용을 충분히 이해하며 각 품목의 제조사 성적서(C toC등)가 발행가능하다면 원본제출이 원칙이나, 사본제출시 성적서 내에공금자의 원본대조 필 직인, 회사명, 담당자명, 전화번호 명기바랍니다. 또한 제출된 성적서에 대한 발주자의 진위여부 회신 요청시이행을 약속합니다. </td>  </tr></tbody> </table>";
			html+="</div></body>"
				+ "</html>";
			InputStream inputStream = null;
	        OutputStream outputStream = null;

		String path = request.getRealPath("/upload/PDF");
		String name = "pdfs.pdf";
		String fileName="";
		String finallName = "";
		 try {
	          	File oldfile = new File(path, name);
	                if ( oldfile.exists()){
	                    for(int k=0; true; k++){
	                        //파일명 중복을 피하기 위한 일련 번호를 생성하여
	                        //파일명으로 조합
	                        oldfile = new File(path,"("+k+")"+name);
	                        //조합된 파일명이 존재하지 않는다면, 일련번호가
	                        //붙은 파일명 다시 생성
	                        if(!oldfile.exists()){ //존재하지 않는 경우
	                            fileName = "("+k+")"+name;
	                            break;
	                        }
	                    }
	                }else{
	                    fileName = name;
	                }
		 }finally{
			 finallName=path+"\\"+fileName;
	      }
		
		
		
		
		
// 파일 IO 스트림을 취득한다.
		try (FileOutputStream os = new FileOutputStream(finallName)) {
// Pdf형식의 document를 생성한다.
			Document document = new Document(PageSize.A4, 10, 10, 10, 10);
// PdfWriter를 취득한다.
			PdfWriter writer = PdfWriter.getInstance(document, os);
// document Open한다.
			document.open();
// css를 설정할 resolver 인스턴스 생성
			StyleAttrCSSResolver cssResolver = new StyleAttrCSSResolver();
// Css 파일 설정 (css1.css 파일 설정)
			try (FileInputStream cssStream = new FileInputStream(request.getRealPath("/res/set/css/PDF.css"))) {
				cssResolver.addCss(XMLWorkerHelper.getCSS(cssStream));
			}
// 폰트 설정
			XMLWorkerFontProvider font = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
// window 폰트 설정
			String fontPath = request.getRealPath("/res/admin_lte/css/font")+"\\malgun.ttf";
			font.register(fontPath, "MalgunGothic");
// 폰트 인스턴스를 생성한다.
			CssAppliersImpl cssAppliers = new CssAppliersImpl(font);
			BaseFont objBaseFont = BaseFont.createFont()
			
//htmlContext의 pipeline 생성. (폰트 인스턴스 생성)
			HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
			htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
// pdf의 pipeline 생성.
			PdfWriterPipeline pdfPipeline = new PdfWriterPipeline(document, writer);
// Html의pipeline을 생성 (html 태그, pdf의 pipeline설정)
			HtmlPipeline htmlPipeline = new HtmlPipeline(htmlContext, pdfPipeline);
// css의pipeline을 합친다.
			CssResolverPipeline cssResolverPipeline = new CssResolverPipeline(cssResolver, htmlPipeline);
//Work 생성 pipeline 연결
			XMLWorker worker = new XMLWorker(cssResolverPipeline, true);
//Xml 파서 생성(Html를 pdf로 변환)
			XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));
// 출력한다.
			try (StringReader strReader = new StringReader(html)) {
				xmlParser.parse(strReader);
			}
// document의 리소스 반환
			document.close();
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
	*/
	public static void PDFTEMP(MultipartHttpServletRequest request) {
// PDF를 작성하는 html
		String data="";
		int recycle = 2; //나중에 목록에서 반복할횟수
		int Maxcycle= 3; //최대출력할열
		
		String html = 
				"<div class=\"order-sheet-table-wrap\">" + "<h4>발 주 서</h4>"
				+ "<table class=\"top-table\"  border=\"0.1px\"><tr><td class=\"top-cont\" style=\"padding:0px 0px !important;\">  <table summary=\"발주서 공급자\" height=\"100%\" border='0.1px' frame=\"void\" > <colgroup><col width=\"6%\" />"
				+ "<col width=\"28%\" /><col width=\"38%\" /><col width=\"18%\" /><col width=\"10%\" /> </colgroup> <tbody><tr> "
				+ "<th rowspan=\"6\" class=\"top-title\">공<br />급<br />자</th>  <th colspan=\"2\" class=\"provider\">"+dataString("공급자명")+"</th>"
				+ "<th class=\"text-left\">귀중</th>  <td></td></tr><tr>  <th class=\"text-left\">담당자 :</th>  <td>"+dataString("담당자명")+"</td>"
				+ "<th class=\"text-left\">귀하</th>  <td></td></tr><tr>  <th class=\"text-left\">전화 :</th>  <td colspan=\"2\">"+dataString("전화번호")+"</td>  <td></td></tr><tr> "
				+ "<th rowspan=\"2\" class=\"text-left\">팩스 :</th>  <td colspan=\"2\" rowspan=\"2\">"+ dataString("팩스번호")+"</td>  <td></td></tr><tr>  <td></td></tr><tr>"
				+ "<th class=\"text-left\">메일 :</th>  <td colspan=\"2\"> <a href=\"#\">"+dataString("메일주소")+"</a>  </td>  <td></td></tr> <tr><td colspan=\"4\">우왕</td></tr> </tbody>  </table>"
				+ "</td><td class=\"top-cont\" style=\"padding:0px 0px !important;\">  <table summary=\"발주서 공급 받는자\"  border=\"0.01px\" frame=\"void\" > <colgroup><col width=\"6%\" /><col width=\"28%\" /><col width=\"66%\" />"
				+ "</colgroup> <tbody><tr>  <th id=\"b1\" rowspan=\"6\" class=\"top-title\"> 공<br />급<br />받<br />는<br />자  </th>  <th>회사명</th>  <td>"+dataString("회사명")+"</td>"
				+ "</tr><tr>  <th>사업자등록번호</th>  <td>"+dataString("사업자등록번호")+"</td></tr><tr>  <th>대표자</th>  <td>"+dataString("대표자명")+"</td></tr><tr> "
				+ " <th>주소</th>  <td>"+dataString("주소") + "</td></tr><tr>  <th>전화</th>  <td>"+ dataString("전화번호")+"</td></tr><tr>"
				+ "<th>팩스</th>  <td>"+dataString("팩스주소")+"</td></tr> </tbody>  </table></td> </tr></table> "
				+ "<table class=\"mid-table\"\"  border='0.2px'><colgroup>  <col width=\"3%\" />  <col width=\"18%\" />  <col width=\"18%\" />  <col width=\"5%\" />  <col width=\"5%\" />  <col width=\"11%\" />  <col width=\"11%\" />  <col width=\"10%\" />  <col width=\"11%\" />  <col width=\"5%\" /></colgroup>"
				+ "<thead>  <tr> <th colspan=\"2\">프로젝트명</th> <td colspan=\"3\" class=\"fc-red\">"+dataString("해당프로젝트명")+"</td> <th colspan=\"2\">발주서번호</th> <td colspan=\"3\" class=\"fc-red\">"+dataString("발주서번호" )+"</td>  </tr>  <tr class=\"bl-none\"> <th scope=\"col\">순번</th>"
				+ " <th scope=\"col\">품목명</th> <th scope=\"col\">규격명</th> <th scope=\"col\">수량</th> <th scope=\"col\">단위</th> <th scope=\"col\">단가</th> <th scope=\"col\">공급가액</th> <th scope=\"col\">부가세</th> <th scope=\"col\">납기일</th> <th scope=\"col\">비고</th>  </tr></thead><tfoot class=\"bl-none\"> "
				+ " <tr> <td colspan=\"10\"></td>  </tr>  <tr class=\"mid-total bg-none\"> <th colspan=\"2\">공급가액</th> <td class=\"text-right\">-</td> <th colspan=\"2\">부가세</th> <td colspan=\"2\" class=\"text-right\">-</td> <th>합계</th> <td colspan=\"2\" class=\"text-right\">-</td>  </tr></tfoot><tbody class=\"bl-none\"> ";
		for(int i =0; i<Maxcycle; i++) {
			if(recycle<i) {
				html +="<tr> <td>"+(i+1)+"</td> <td>"+dataString("품목")+"</td> <td>"+dataString("규격")+"</td> <td>"+dataString("수량")+"</td> <td>"+dataString("단위")+"</td> <td class=\"text-right\">"+dataString("단가")+"</td> <td class=\"text-right\">"+dataString("공급가액")+"</td>"
					 +"<td class=\"text-right\">"+dataString("부가세")+"</td> <td>"+dataString("납기일")+"</td> <td>"+dataString("비고")+"</td>  </tr> ";
			}else {
				html+=" <tr> <td>"+(i+1)+"</td> <td></td> <td></td> <td></td> <td></td> <td class=\"text-right\"></td> <td class=\"text-right\">-</td> <td class=\"text-right\">-</td> <td></td> <td></td>  </tr>";
			}
		}
			html+="</tbody> </table> "
					+ "<table class=\"bot-table\" border=\"0.01px\"><colgroup>  <col width=\"25%\" />  <col width=\"75%\" /></colgroup><tfoot class=\"order-sheet-sign bl-none\">  <tr> <td colspan=\"2\">위와 같이 발주하오니 계약요건을 준수하여 납품 바랍니다. </td>"
					+ "</tr>  <tr> <td colspan=\"2\"><div class=\"sign-wrap\">  <span class=\"comp-name\">"+dataString("회사명")+"</span> <span class=\"date\">"+dataString("날짜")+"</span></div> </td>  </tr></tfoot><tbody>"
					+ "  <tr> <th>납품장소</th> <td class=\"fc-red\">지정된 입고 장소의 기준정보에 등록된 주소</td>"
					+ "  </tr>  <tr> <th>기본계약</th> <td class=\"text-left\">1. 본 주문서는 별도의 계약을 하지 않는 한 갑과 을의 물품매매계약서로 하며 본 계약으로 이루어진 갑과 을의 채권은 제3자에게 양도할 수없다.<br />2. 납품물품은 규격서 및 도면에 일치하는 물품이어야 하며 당사의검사기준에 합격한 물품 이어야 한다.<br />3. 물품의 납품은 반드시 당사자가 지정한 장소 및 지정한 일시 이내에납품되어야하며 납기 일이 경과한 경우는 지체보상금을 지체 1일당발주금액의 0.5%의 금액을 공제한다.<br />4.발주후 3일 이내에 이의 신청을 하지아니하면 계약의 효력이지속되며 기타사항은 일반상거래 관례에 따른다.<br />5. 대금지급 : 당사와 협의 기준에 따름 </td>  </tr>  <tr> <th>협조 사항</th> <td class=\"text-left\">상기 발주서의 내용을 충분히 이해하며 각 품목의 제조사 성적서(C toC등)가 발행가능하다면 원본제출이 원칙이나, 사본제출시 성적서 내에공금자의 원본대조 필 직인, 회사명, 담당자명, 전화번호 명기바랍니다. 또한 제출된 성적서에 대한 발주자의 진위여부 회신 요청시이행을 약속합니다. </td>  </tr></tbody> </table>";
			html+="</div>";
			InputStream inputStream = null;
	        OutputStream outputStream = null;

		String path = request.getRealPath("/upload/PDF");
		String name = "pdfs.pdf";
		String fileName="";
		String finallName = "";
		 try {
	          	File oldfile = new File(path, name);
	                if ( oldfile.exists()){
	                    for(int k=0; true; k++){
	                        //파일명 중복을 피하기 위한 일련 번호를 생성하여
	                        //파일명으로 조합
	                        oldfile = new File(path,"("+k+")"+name);
	                        //조합된 파일명이 존재하지 않는다면, 일련번호가
	                        //붙은 파일명 다시 생성
	                        if(!oldfile.exists()){ //존재하지 않는 경우
	                            fileName = "("+k+")"+name;
	                            break;
	                        }
	                    }
	                }else{
	                    fileName = name;
	                }
		 }finally{
			 finallName=path+"\\"+fileName;
	      }	
		 
	
		 	String fontPath = request.getRealPath("/res/admin_lte/css/font/malgun.ttf");
		 	System.out.println(fontPath);
	        String cssPath = request.getRealPath("/res/set/css/PDF.css");
	        
	        /*
			// Document 생성
			Document document = new Document(PageSize.A4, 50, 50, 50, 50); // 용지 및 여백 설정
			     try {
			// PdfWriter 생성
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(finallName)); // 바로 다운로드.
			//PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
			writer.setInitialLeading(12.5f);
			 
			// Document 오픈
			document.open();
			XMLWorkerHelper helper = XMLWorkerHelper.getInstance();
			     
			// CSS
			CSSResolver cssResolver = new StyleAttrCSSResolver();
			CssFile cssFile = helper.getCSS(new FileInputStream(cssPath));
			cssResolver.addCss(cssFile);
			     
			// HTML, 폰트 설정
			XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
			fontProvider.register("fontPath", "MalgunGothic"); // MalgunGothic은 alias,
			CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
			 
			HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
			htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
			 
			// Pipelines
			PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
			HtmlPipeline htmls = new HtmlPipeline(htmlContext, pdf);
			CssResolverPipeline css = new CssResolverPipeline(cssResolver, htmls);
			 
			XMLWorker worker = new XMLWorker(css, true);
			XMLParser xmlParser = new XMLParser(worker, Charset.forName("EUC-KR"));
			
			//이미지 태그 안닫힌 태그들 찾아서 닫는 작업 진행
			StringReader strReader = new StringReader(html);
			xmlParser.parse(strReader);
			 
			document.close();
			     }catch (Exception e) {
			    	 System.out.println(e);
					// TODO: handle exception
				}*/
	        
	        
	        //용지 설정이 가능하다. 생략해도 무관
	        // Document document = new Document(PageSize.A4, 50, 50, 50, 50); 
	   	 	try {
	        Document document = new Document();
	        
	        //파일 확장자는 pdf

	        File pdfFile = new File(finallName);

	        //파일이 있으면 삭제(같은 이름으로 만들 때마다 새로 쓰기 위해서)
	            if (pdfFile.isFile()) {
	                pdfFile.delete();
	            }
	        
	            //pdf를 만들기 시작한다.
	        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(finallName));      
	        
	        document.open();

	        //폰트를 설정한다. 폰트 설정 누락시 한글이 안보이는 경우 발생
	        html = "<html><body style='font-family: MalgunGothic;'>" + html + "</body></html>";
	        
	        XMLWorkerHelper helper = XMLWorkerHelper.getInstance();
	        
	        //css파일
	        CSSResolver cssResolver = new StyleAttrCSSResolver();
	        CssFile cssFile = XMLWorkerHelper.getCSS(new FileInputStream(cssPath));
	        cssResolver.addCss(cssFile);
	        
	        XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
	        
	        //매우매우 중요!! 
	        //반드시 해당 폰트가 경로내에 있어야한다. 
	        //(폰트 존재하지 않을 시 pdf 생성 후 열리지 않는 에러 발생)
	        fontProvider.register(fontPath, "MalgunGothic"); //MalgunGothic은 font-family용 alias
	        CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
	            
	        HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
	        htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
	            
	        // html을 pdf로 변환시작
	        PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
	        HtmlPipeline htmls = new HtmlPipeline(htmlContext, pdf);
	        CssResolverPipeline css = new CssResolverPipeline(cssResolver, htmls);
	            
	        XMLWorker worker = new XMLWorker(css, true);
	        //캐릭터 셋 설정
	        XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));
	        
	        StringReader strReader = new StringReader(html);
	        
				xmlParser.parse(strReader);
		        document.close();
		        writer.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e);
			} catch (DocumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        

	        
	        //egov의 첨부파일 형태로 추가하기 위해서 MultipartFile을 만들어 준다. 
	             
	 System.out.println("ebd");
	}
	
	        
	
	
	
	
	public static String dataString(String datas) {
		//더미용 클래스. data안에 이것이 어디에쓰는 데이터인지 써주는용도
		return datas;
	}
	
	public void temp() {
		int recycle = 2; //나중에 목록에서 반복할횟수
		int Maxcycle= 3; //최대출력할열
		String html = 
				"<div class=\"order-sheet-table-wrap\">" + "<h4>발 주 서</h4>"
				+ "<article class=\"top-table\"><div class=\"top-cont tc-01\">  <table summary=\"발주서 공급자\"> <colgroup><col width=\"6%\" />"
				+ "<col width=\"28%\" /><col width=\"38%\" /><col width=\"18%\" /><col width=\"10%\" /> </colgroup> <tbody><tr> "
				+ "<th rowspan=\"6\" class=\"top-title\">공<br />급<br />자</th>  <th colspan=\"2\" class=\"provider\">"+dataString("공급자명")+"</th>"
				+ "<th class=\"text-left\">귀중</th>  <td></td></tr><tr>  <th class=\"text-left\">담당자 :</th>  <td>"+dataString("담당자명")+"</td>"
				+ "<th class=\"text-left\">귀하</th>  <td></td></tr><tr>  <th class=\"text-left\">전화 :</th>  <td colspan=\"2\">"+dataString("전화번호")+"</td>  <td></td></tr><tr> "
				+ "<th rowspan=\"2\" class=\"text-left\">팩스 :</th>  <td colspan=\"2\" rowspan=\"2\">"+ dataString("팩스번호")+"</td>  <td></td></tr><tr>  <td></td></tr><tr>"
				+ "<th class=\"text-left\">메일 :</th>  <td colspan=\"2\"> <a href=\"#\">"+dataString("메일주소")+"</a>  </td>  <td></td></tr> </tbody>  </table>"
				+ "</div><div class=\"top-cont tc-02\">  <table summary=\"발주서 공급 받는자\"> <colgroup><col width=\"6%\" /><col width=\"28%\" /><col width=\"66%\" />"
				+ "</colgroup> <tbody><tr>  <th id=\"b1\" rowspan=\"6\" class=\"top-title\"> 공<br />급<br />받<br />는<br />자  </th>  <th>회사명</th>  <td>"+dataString("회사명")+"</td>"
				+ "</tr><tr>  <th>사업자등록번호</th>  <td>"+dataString("사업자등록번호")+"</td></tr><tr>  <th>대표자</th>  <td>"+dataString("대표자명")+"</td></tr><tr> "
				+ " <th>주소</th>  <td>"+dataString("주소") + "</td></tr><tr>  <th>전화</th>  <td>"+ dataString("전화번호")+"</td></tr><tr>"
				+ "<th>팩스</th>  <td>"+dataString("팩스주소")+"</td></tr> </tbody>  </table></div> </article> "
				+ "<table class=\"mid-table\"\"><colgroup>  <col width=\"3%\" />  <col width=\"18%\" />  <col width=\"18%\" />  <col width=\"5%\" />  <col width=\"5%\" />  <col width=\"11%\" />  <col width=\"11%\" />  <col width=\"10%\" />  <col width=\"11%\" />  <col width=\"5%\" /></colgroup>"
				+ "<thead>  <tr> <th colspan=\"2\">프로젝트명</th> <td colspan=\"3\" class=\"fc-red\">"+dataString("해당프로젝트명")+"</td> <th colspan=\"2\">발주서번호</th> <td colspan=\"3\" class=\"fc-red\">"+dataString("발주서번호" )+"</td>  </tr>  <tr class=\"bl-none\"> <th scope=\"col\">순번</th>"
				+ " <th scope=\"col\">품목명</th> <th scope=\"col\">규격명</th> <th scope=\"col\">수량</th> <th scope=\"col\">단위</th> <th scope=\"col\">단가</th> <th scope=\"col\">공급가액</th> <th scope=\"col\">부가세</th> <th scope=\"col\">납기일</th> <th scope=\"col\">비고</th>  </tr></thead><tfoot class=\"bl-none\"> "
				+ " <tr> <td colspan=\"10\"></td>  </tr>  <tr class=\"mid-total bg-none\"> <th colspan=\"2\">공급가액</th> <td class=\"text-right\">-</td> <th colspan=\"2\">부가세</th> <td colspan=\"2\" class=\"text-right\">-</td> <th>합계</th> <td colspan=\"2\" class=\"text-right\">-</td>  </tr></tfoot><tbody class=\"bl-none\"> ";
		for(int i =0; i<Maxcycle; i++) {
			if(recycle<i) {
				html +="<tr> <td>"+(i+1)+"</td> <td>"+dataString("품목")+"</td> <td>"+dataString("규격")+"</td> <td>"+dataString("수량")+"</td> <td>"+dataString("단위")+"</td> <td class=\"text-right\">"+dataString("단가")+"</td> <td class=\"text-right\">"+dataString("공급가액")+"</td>"
					 +"<td class=\"text-right\">"+dataString("부가세")+"</td> <td>"+dataString("납기일")+"</td> <td>"+dataString("비고")+"</td>  </tr> ";
			}else {
				html+=" <tr> <td>"+(i+1)+"</td> <td></td> <td></td> <td></td> <td></td> <td class=\"text-right\"></td> <td class=\"text-right\">-</td> <td class=\"text-right\">-</td> <td></td> <td></td>  </tr>";
			}
		}
			html+="</tbody> </table> "
					+ "<table class=\"bot-table\"><colgroup>  <col width=\"15%\" />  <col width=\"85%\" /></colgroup><tfoot class=\"order-sheet-sign bl-none\">  <tr> <td colspan=\"2\">위와 같이 발주하오니 계약요건을 준수하여 납품 바랍니다. </td>"
					+ "</tr>  <tr> <td colspan=\"2\"><div class=\"sign-wrap\">  <span class=\"comp-name\">"+dataString("회사명ㄴㄴㄴ")+"</span> <span class=\"date\">"+dataString("날짜")+"</span></div> </td>  </tr></tfoot><tbody>"
					+ "  <tr> <th>납품장소</th> <td class=\"fc-red\">지정된 입고 장소의 기준정보에 등록된 주소</td>"
					+ "  </tr>  <tr> <th>기본계약</th> <td class=\"text-left\">1. 본 주문서는 별도의 계약을 하지 않는 한 갑과 을의 물품매매계약서로 하며 본 계약으로 이루어진 갑과 을의 채권은 제3자에게 양도할 수없다.<br />2. 납품물품은 규격서 및 도면에 일치하는 물품이어야 하며 당사의검사기준에 합격한 물품 이어야 한다.<br />3. 물품의 납품은 반드시 당사자가 지정한 장소 및 지정한 일시 이내에납품되어야하며 납기 일이 경과한 경우는 지체보상금을 지체 1일당발주금액의 0.5%의 금액을 공제한다.<br />4.발주후 3일 이내에 이의 신청을 하지아니하면 계약의 효력이지속되며 기타사항은 일반상거래 관례에 따른다.<br />5. 대금지급 : 당사와 협의 기준에 따름 </td>  </tr>  <tr> <th>협조 사항</th> <td class=\"text-left\">상기 발주서의 내용을 충분히 이해하며 각 품목의 제조사 성적서(C toC등)가 발행가능하다면 원본제출이 원칙이나, 사본제출시 성적서 내에공금자의 원본대조 필 직인, 회사명, 담당자명, 전화번호 명기바랍니다. 또한 제출된 성적서에 대한 발주자의 진위여부 회신 요청시이행을 약속합니다. </td>  </tr></tbody> </table>";
			html+="</div>";
	}
}
