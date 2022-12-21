package com.bangbang.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.broker.model.vo.Broker;
import com.user.model.vo.User;

/**
 * Servlet Filter implementation class NotBrokerCheckFilter
 */
@WebFilter(urlPatterns = {
		"/property/propertyInfo/fakeReport.bb"
})
public class NotBrokerCheckFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public NotBrokerCheckFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpSession session = ((HttpServletRequest)request).getSession(false);
		
		User loginUser = (User)session.getAttribute("loginUser");
		Broker loginBroker = (Broker)session.getAttribute("loginBroker");
		
		if(loginUser != null && loginBroker == null && loginUser.getUserLevel()=='C') {
			chain.doFilter(request, response);
		} else {
			request.setAttribute("msg", "접근할 권한이 없습니다 (¬_¬)");		
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}