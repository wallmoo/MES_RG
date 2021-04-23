package kr.co.passcombine.set.controller;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.passcombine.set.util.StringUtil;
import kr.co.passcombine.set.svc.SYDrwFileService;
import kr.co.passcombine.set.svc.SYMenuService;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.vo.SYDrwFileInfoVo;
import kr.co.passcombine.set.vo.SYMenuVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/common")
public class CommonController {
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	@Resource(name = "setMenuService")
	SYMenuService syMenuService;
	
	@Resource(name = "setDrwFileService")
	SYDrwFileService sYDrwFileService;
	
	@RequestMapping(value = "/header_inc", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView headerInclude(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		// logger.debug("CommonController.headerInclude() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("common/header_inc");
		return modelAndView;
	}
	
	@RequestMapping(value = "/top_menu_inc", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView topMenuInc(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		// logger.debug("CommonController.topMenuInc() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("common/top_menu_inc");
		modelAndView.addObject("fb_div", request.getParameter("fb_div"));
		return modelAndView;
	}
	
	@RequestMapping(value = "/sidebar_menu_inc", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView sidebarMenuInc(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		// logger.debug("CommonController.sidebarMenuInc() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("common/sidebar_menu_inc");
		try {
			String menu_div = request.getParameter("menu_div");
			String selected_menu_cd = request.getParameter("selected_menu_cd");
			String selected_menu_p_cd = request.getParameter("selected_menu_p_cd");
			
			SYMenuVo menuVo = new SYMenuVo();
			menuVo.setMenu_div(menu_div);
			menuVo.setMenu_use_yn("Y");
			menuVo.setRole_cd(SessionUtil.getRoleCd(request));
			List<SYMenuVo> listMenu = syMenuService.selectMenuAcl(menuVo);
			
			modelAndView.addObject("listMenu", listMenu);
			modelAndView.addObject("menu_div", menu_div);
			modelAndView.addObject("selected_menu_cd", selected_menu_cd);
			modelAndView.addObject("selected_menu_p_cd", selected_menu_p_cd);
		} catch(Exception e){
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	@RequestMapping(value = "/sidebar_rview_inc", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView sidebarRviewInc(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		// logger.debug("CommonController.sidebarRviewInc() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("common/sidebar_rview_inc");
		return modelAndView;
	}
	
	@RequestMapping(value = "/footer_inc", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView footerInc(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		// logger.debug("CommonController.footerInc() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("common/footer_inc");
		return modelAndView;
	}
	
	@RequestMapping(value = "/pdf_viewer", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView pdfViewer(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		// logger.debug("CommonController.pdfViewer() is called.");
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("file_path", request.getParameter("file_path"));
		modelAndView.setViewName("common/pdf_viewer");
		return modelAndView;
	}
	
	@Inject
	private FileSystemResource fsResource;
	
	@RequestMapping(value = "/product_pdfViewer", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView product_pdfViewer(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		// logger.debug("CommonController.pdfViewer() is called.");
		String item_code = request.getParameter("item_code");
		
		SYDrwFileInfoVo dVo = new SYDrwFileInfoVo();

		dVo.setItem_code(item_code);
		List<SYDrwFileInfoVo> listCode = sYDrwFileService.selectDrwFile(dVo);
		
		ModelAndView modelAndView = new ModelAndView();
		if(listCode.size() > 0)
		{
			String file_path = listCode.get(0).getPdf_file_path();
			String url = StringUtil.replace(request.getRequestURL(), request.getRequestURI(), "");

			System.out.println("file_path :: " + url + "/doc/" + file_path);

			modelAndView.addObject("file_path", url + "/doc/" + file_path);
			modelAndView.setViewName("common/pdf_viewer");


		}else
		{
			modelAndView.addObject("file_path", "" + "/doc/" + "");
			modelAndView.setViewName("common/pdf_viewer");
		}

		return modelAndView;
	}
}
