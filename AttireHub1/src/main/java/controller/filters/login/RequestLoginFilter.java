package controller.filters.login;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RequestLoginFilter implements Filter {
	private ServletContext context;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		//stores params in iterations
		Enumeration<String> params = req.getParameterNames();
		while(params.hasMoreElements()) {
			String name = params.nextElement();
			String value = req.getParameter(name);
			this.context.log(req.getRemoteAddr() + "::Request Params::{"+name+"="+value +"}");//console print data
		}
		
		//stores cookies
		Cookie[] cookies = req.getCookies();
		if(cookies!=null) {
			for(Cookie cookie: cookies) {
				this.context.log(req.getRemoteAddr() + "::Cookies::{"+cookie.getName()+"="+cookie.getValue()+"}");//prints in console
			}
		}
		
		chain.doFilter(request, response);
		
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.context = filterConfig.getServletContext();
	}

}
