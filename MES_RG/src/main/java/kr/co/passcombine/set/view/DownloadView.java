package kr.co.passcombine.set.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {
	
	public DownloadView(){
		this.setContentType("applicaiton/download;charset=utf-8");
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String file_name = model.get("file_name").toString();
		File file = new File(model.get("file_path").toString());
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		
		String[] invalidName = {"\\\\","/",":","[*]","[?]","\"","<",">","[|]","[,]","[(]","[)]"};
		for(int i=0;i<invalidName.length;i++)
			file_name = file_name.replaceAll(invalidName[i], "_");
		
		String fileName = java.net.URLEncoder.encode(file_name, "UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
		}
		out.flush();
	}
}
