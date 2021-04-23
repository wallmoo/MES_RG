/*
condition :  pagination areaId is 'pagination'
variable---
page : current Page
cntRowPagination : pagination total count
totalPage : count of data page
 */
function pagination1(){
//	console.log('pagination1');
	var code = "";
	
	code += "	<nav>                                             ";
	code += "	  <ul class='pagination pagination-sm' style='margin: 10px 0px 10px 0px;'>                         ";
	code += "	    <li";
	if( page==1 ) 
		code += " class='disabled'";
	code += "> ";
	//First btn
	if( page==1 )
		code += "	      <a href='#' aria-label='First'>          ";
	else
		code += "	      <a href='javascript:loadList1(1)' aria-label='First'>          ";
	code += "	        <span aria-hidden='true'><i class='fa fa-angle-double-left'></i></span>   ";
	code += "	      </a>                                        ";
	code += "	    </li>                                         ";

	code += "	    <li";
	if( page==1 ) 
		code += " class='disabled'";
	code += "> ";
	
	//Previous btn
	var prePageNum = 1;
	if( page%cntRowPagination > 0 ){
		prePageNum = (parseInt(page/cntRowPagination)-1)*cntRowPagination+1;
		if( prePageNum<0 )
			prePageNum = 1;
	}else if( page%cntRowPagination == 0 ){
		prePageNum = (parseInt(page/cntRowPagination)-2)*cntRowPagination+6;
	}
	if( page==1 )
		code += "	      <a href='#' aria-label='Previous'>          ";
	else
		code += "	      <a href='javascript:loadList1("+prePageNum+")' aria-label='Previous'>          ";
	code += "	        <span aria-hidden='true'><i class='fa fa-angle-left'></i></span>   ";
	code += "	      </a>                                        ";
	code += "	    </li>                                         ";
	
	//pagination
	for(var i=1; i<=cntRowPagination; i++){
		var printNum = 0;
		if( page%cntRowPagination > 0 ){
			printNum = (parseInt(page/cntRowPagination)*cntRowPagination)+i;
		}
		else if( page%cntRowPagination == 0 ){
			printNum = (parseInt(page/cntRowPagination)-1)*cntRowPagination + i;
		}
		
//		console.warn(page, printNum, totalPage);
		if( printNum <= totalPage ){
			code += "	    <li";
			if( page==printNum )
				code += " class='active'";
			code += "><a href='javascript:loadList1(" + printNum + ")';>" + printNum + "</a></li>                    ";
		}
	}

	code += "	    <li";
	if( page==totalPage )
		code += " class='disabled'"
	code += ">                                          ";
	
	// Next button
	var nextPageNum = 1;
	if( page%cntRowPagination > 0 ){
		nextPageNum = ((parseInt(page/cntRowPagination)+1)*cntRowPagination)+1;
		if( nextPageNum>totalPage ){
			nextPageNum = totalPage;
		}
	}
	else if( page%cntRowPagination == 0 ){
		nextPageNum = parseInt(page/cntRowPagination)*cntRowPagination+1;
	}
	if( page==totalPage )
		code += "	      <a href='#' aria-label='Next'>              ";
	else
		code += "	      <a href='javascript:loadList1(" + nextPageNum + ")' aria-label='Next'>              ";
	code += "	        <span aria-hidden='true'><i class='fa fa-angle-right'></i></span>   ";
	code += "	      </a>                                        ";
	code += "	    </li>                                         ";
	// Last button
	code += "	    <li";
	if( page==totalPage )
		code += " class='disabled'"
	code += ">                                          ";
	
	if( page==totalPage )
		code += "	      <a href='#' aria-label='Last'>              ";
	else
		code += "	      <a href='javascript:loadList1(" + totalPage + ")' aria-label='Last'>              ";
	code += "	        <span aria-hidden='true'><i class='fa fa-angle-double-right'></i></span>   ";
	code += "	      </a>                                        ";
	code += "	    </li>                                         ";
	code += "	  </ul>                                           ";
	code += "	</nav>                                            ";
	
	$('#pagination1').html(code);
}
