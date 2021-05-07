package kr.co.passcombine.set.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.Assert;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {
	public DownloadView() {
		setContentType("application/octet-stream");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Assert.notNull(model, "model is null");
		Object o = model.get("download");
		Assert.notNull(o, "download file is empty");
		response.setContentType(getContentType());
		response.setHeader("Content-Transfer-Encoding", "binary");
		OutputStream out = response.getOutputStream();
		String fileName = null;
		InputStream is = null;
		File file = null;

		@SuppressWarnings("unchecked")
		HashMap<String, Object> map = (HashMap<String, Object>) model.get("download");
		file = (File) map.get("download");
		is = new FileInputStream(file);
		response.setContentLength((int) file.length());
		fileName = (String) model.get("fileName");
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\";");
		try {
			FileCopyUtils.copy(is, out);
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException ex) {
				}
			}
		}
		out.flush();
	}

}
