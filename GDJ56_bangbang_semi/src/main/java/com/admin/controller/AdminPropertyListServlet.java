package com.admin.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.model.service.AdminService;
import com.google.gson.Gson;

/**
 * Servlet implementation class AdminPropertyListServlet
 */
@WebServlet("/admin/propertyList.bb")
public class AdminPropertyListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPropertyListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		int cPage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			cPage = 1;
		}
		int numPerpage;
		try {
			numPerpage = Integer.parseInt(request.getParameter("numPerpage"));
		} catch (NumberFormatException e) {
			numPerpage = 15;
		}
		
		String query = "";
		if(searchType.equals("PROPERTY_NO")||searchType.equals("BROKER_NO")||searchType.equals("HIDING")) {
			query += " WHERE P." + searchType + " LIKE '%" + searchKeyword + "%' ";
		}
		query += " ORDER BY P.ENROLL_DATE DESC) RR) WHERE RNUM BETWEEN ";
		query += ((cPage-1)*numPerpage + 1) + " AND " + (cPage*numPerpage);
		
		List list = AdminService.getAdminService().searchPropertyList(query);
		
		Map<Integer, Integer> propertyReportCount = AdminService.getAdminService().searchPropertyReportCount();
		list.add(propertyReportCount);
		
		String totalQuery = "";
		if(searchType.equals("PROPERTY_NO")||searchType.equals("BROKER_NO")||searchType.equals("HIDING")) {
			totalQuery += " WHERE " + searchType + " LIKE '%" + searchKeyword + "%' ";
		}
		int totalData = AdminService.getAdminService().searchPropertyListCount(totalQuery);
		//System.out.println(totalData);
		
		//pageBar html????????? ????????? ??? ?????? ?????? ??????
		String pageBar = "";
		
		int pageBarSize = 5;
		//2. ??? ???????????? -> ceil ?????? ????????? ????????? ????????? ??????
		int totalPage = (int)Math.ceil((double)totalData/numPerpage);
		//3. ????????? ?????? ??????
		int pageNo = (cPage-1)/pageBarSize*pageBarSize + 1;
		int pageEnd = pageNo + pageBarSize - 1;
		
		//html?????? ????????????
		if(pageNo==1) {
			pageBar += "<span>[??????] </span>";
		} else {
			pageBar += "<a class='pageBarTag' href='javascript:void(0);'>[??????] </a>";
		}
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(cPage==pageNo) {
				pageBar += "<span class='pageBarTag'>"+pageNo+" </span>";
			} else { 
				pageBar += "<a class='pageBarTag' href='javascript:void(0);'>"+pageNo+" </a>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar += "<span class='pageBarTag'> [??????]</span>";
		} else {
			pageBar += "<a class='pageBarTag' href='javascript:void(0);'> [??????]</a>";
		}
		
		list.add(pageBar);
		
		response.setContentType("application/json;charset=utf-8");
		Gson g = new Gson();
		g.toJson(list, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
