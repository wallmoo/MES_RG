<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="kr.co.passcombine.set.vo.*" %>
<% 
String selected_menu_cd = (String) request.getAttribute("selected_menu_cd");
String selected_menu_p_cd = (String) request.getAttribute("selected_menu_p_cd");

String menu_div = (String) request.getAttribute("menu_div");
List<SYMenuVo> listMenu = (List<SYMenuVo>) request.getAttribute("listMenu");
// System.out.println("flow log : " + listMenu.size());

%>
<aside class="main-sidebar">
  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar">

<%if(menu_div != null && menu_div.equals("F")) {%>    
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu" data-widget="tree">
      <li class="header">MAIN NAVIGATION</li>
<%
	if(listMenu != null && listMenu.size() > 0) {
		int prev_menu_lvl = 1;
		String prev_menu_p_cd = "", css = "";
		StringBuffer sb = new StringBuffer();
  	for(int i=0; i<listMenu.size(); i++){
  		SYMenuVo mVo = listMenu.get(i);
  		
  		if(i!=0 && ( prev_menu_lvl > mVo.getLvl() || (mVo.getLvl()==1 && mVo.getCnt_child() == 0) || (prev_menu_lvl == mVo.getLvl() && !prev_menu_p_cd.equals(mVo.getMenu_p_cd())) )){
  			sb.append("	</ul>\n");
  			sb.append("</li>\n");
  		}
  		
  		if(mVo.getLvl() == 1) {
  			if(selected_menu_p_cd.equals(mVo.getMenu_cd())) css = "active";
    		else css = "";
  			
  			sb.append("<li class='"+css+" treeview'>\n");
  			sb.append("	<a href='"+(mVo.getMenu_path().equals("")?"#":mVo.getMenu_path())+"'>\n");
  			sb.append("	<i class='fa fa-"+(mVo.getMenu_icon().equals("")?"":mVo.getMenu_icon())+"'></i> <span>"+mVo.getMenu_nm()+"</span>\n");
  			if(mVo.getCnt_child() != 0) {
	  			sb.append("	<span class='pull-right-container'>\n");
	  			sb.append("	<i class='fa fa-angle-left pull-right'></i>\n");
	  			sb.append("	</span>\n");
  			}
  			sb.append("	</a>\n");
  			
  			sb.append("	<ul class='treeview-menu'>\n");
  		} else if(mVo.getLvl() == 2) {
  			if(selected_menu_cd.equals(mVo.getMenu_cd())) css = "active";
    		else css = "";
  			
				sb.append("<li class='"+css+"'><a href='"+(mVo.getMenu_path().equals("")?"#":mVo.getMenu_path())+"'><i class='fa fa-angle-right'></i> "+mVo.getMenu_nm()+"</a></li>\n");
  		}
  		
  		prev_menu_p_cd = mVo.getMenu_p_cd();
  		prev_menu_lvl = mVo.getLvl();
  	}
  	
  	// System.out.println("flow log : \n\n\n\n\n" + sb.toString());
  	out.print(sb.toString());
  }
%>
    </ul>
<%} else {%>
		<ul class="sidebar-menu" data-widget="tree">
      <li class="header">BACKEND NAVIGATION</li>
<%
	if(listMenu != null && listMenu.size() > 0) {
		int prev_menu_lvl = 1;
		String prev_menu_p_cd = "", css = "";
		StringBuffer sb = new StringBuffer();
  	for(int i=0; i<listMenu.size(); i++){
  		SYMenuVo mVo = listMenu.get(i);
  		
  		if(i!=0 && ( prev_menu_lvl > mVo.getLvl() || (mVo.getLvl()==1 && mVo.getCnt_child() == 0) || (prev_menu_lvl == mVo.getLvl() && !prev_menu_p_cd.equals(mVo.getMenu_p_cd())) )){
  			sb.append("	</ul>\n");
  			sb.append("</li>\n");
  		}
  		
  		if(mVo.getLvl() == 1) {
  			if(selected_menu_p_cd.equals(mVo.getMenu_cd())) css = "active";
    		else css = "";
  			
  			sb.append("<li class='"+css+" treeview'>\n");
  			sb.append("	<a href='"+(mVo.getMenu_path().equals("")?"#":mVo.getMenu_path())+"'>\n");
  			sb.append("	<i class='fa fa-"+(mVo.getMenu_icon().equals("")?"":mVo.getMenu_icon())+"'></i> <span>"+mVo.getMenu_nm()+"</span>\n");
  			if(mVo.getCnt_child() != 0) {
	  			sb.append("	<span class='pull-right-container'>\n");
	  			sb.append("	<i class='fa fa-angle-left pull-right'></i>\n");
	  			sb.append("	</span>\n");
  			}
  			sb.append("	</a>\n");
  			
  			sb.append("	<ul class='treeview-menu'>\n");
  		} else if(mVo.getLvl() == 2) {
  			if(selected_menu_cd.equals(mVo.getMenu_cd())) css = "active";
    		else css = "";
  			
				sb.append("<li class='"+css+"'><a href='"+(mVo.getMenu_path().equals("")?"#":mVo.getMenu_path())+"'><i class='fa fa-angle-right'></i> "+mVo.getMenu_nm()+"</a></li>\n");
  		}
  		
  		prev_menu_p_cd = mVo.getMenu_p_cd();
  		prev_menu_lvl = mVo.getLvl();
  	}
  	
  	out.print(sb.toString());
  }
%>
    </ul>
<%}%>
  </section>
</aside>