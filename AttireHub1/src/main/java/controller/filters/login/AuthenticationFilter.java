package controller.filters.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationFilter implements Filter {
	private ServletContext context;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	} 

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//type Casting
		HttpServletRequest req = (HttpServletRequest) request;
	    HttpServletResponse res = (HttpServletResponse) response;
	    String uri = req.getRequestURI();
	    this.context.log("Requested URL :: " + uri);
	    String user = "";
	    
	    //session creation
	    HttpSession session = req.getSession(false);
	    if(session != null && session.getAttribute("user") != null) {
	    	user = (String)session.getAttribute("user");
	    	if(user.endsWith("attirehub.com")) {
	    		//pages admin can access
	    		if(uri.endsWith("admin.jsp")||uri.endsWith("viewproducts.jsp")||uri.endsWith("vieworder.jsp")||uri.endsWith("updateproducts.jsp")||uri.endsWith("viewcustomers.jsp")||uri.endsWith("Servlet")) {
	    			chain.doFilter(request, response);//grant access
	    		}else {
		        	req.setAttribute("errorMessage","Login as customer to access this page."); 
					RequestDispatcher inc = request.getRequestDispatcher("/admin.jsp");
					inc.include(req, res);
	    		}
	    	}else{
	    		//pages that customers can visit
	    		if(uri.endsWith("admin.jsp")||uri.endsWith("viewproducts.jsp")||uri.endsWith("vieworder.jsp")||uri.endsWith("updateproducts.jsp")||uri.endsWith("viewcustomers.jsp")) {
		        	req.setAttribute("errorMessage","Only Admins Can access this page."); 
					RequestDispatcher inc = request.getRequestDispatcher("/index.jsp");
					inc.include(req, res);
	    		}else {
	    			chain.doFilter(request, response);//grant access
	    		}
	    	}
	    	
	    }else{
	    	//pages that can be accessed without logging in
	    	 if (uri.endsWith("index.jsp") || uri.endsWith("shop.jsp")||uri.endsWith("aboutus.jsp")||uri.endsWith("contactus.jsp")||uri.endsWith("styles.css")||uri.endsWith("js")||uri.endsWith("LoginServlet")||uri.endsWith("RegisterServlet")||uri.contains("images")||uri.contains("icons")||uri.contains("gifs") || uri.endsWith("AttireHub/")) {
	 	    	chain.doFilter(request, response); // allow access to pages without authentication
	 	    } else {
	        	res.sendRedirect(req.getContextPath()+"/index.jsp");
	 	    }
	    }
	   }
	    


	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.context = filterConfig.getServletContext();
		
	}

}
