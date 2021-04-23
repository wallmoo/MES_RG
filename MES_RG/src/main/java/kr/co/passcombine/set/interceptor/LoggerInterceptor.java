package kr.co.passcombine.set.interceptor;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoggerInterceptor.class);
	
	@Override
	@SuppressWarnings("unchecked")
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("== Request Parameter Map : START =================================");
			logger.info("■ Request URL:" + request.getRequestURL().toString());
			Map<?, ?> m = request.getParameterMap();
			Set<?> s = m.entrySet();
			Iterator<?> it = s.iterator();
			while (it.hasNext()) {
				Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) it.next();
				String key = entry.getKey();
				String[] value = entry.getValue();
				logger.debug("◆ " + key + "=" +value[0].toString());
			}
			logger.debug("== Request Parameter Map : END ====================================");
		}
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (logger.isDebugEnabled()) {
		}
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
	}
}