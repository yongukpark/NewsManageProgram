<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, myBean.*, java.util.*"%>

<!DOCTYPE html>
<!-- news에 관련된 정보를 db로 저장시키는 코드 -->
<%
NewsDB ndb = null;
News news = null;
try {

	ndb = new NewsDB();
	news = new News();

	news.setFirst(request.getParameter("first"));
	news.setSecond(request.getParameter("second"));
	news.setCode(Integer.parseInt(request.getParameter("code")));
	news.setStatus(request.getParameter("status"));
	news.setReportDay(request.getParameter("reportDay"));
	news.setReporterName(request.getParameter("reporterName"));
	news.setReporterEmail(request.getParameter("reporterEmail"));
	news.setTitle(request.getParameter("title"));
	news.setContent1(request.getParameter("content1"));
	news.setContent2(request.getParameter("content2"));
	news.setContent3(request.getParameter("content3"));
	news.setLastUpdate();

	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	Collection<Part> parts = request.getParts();
	MyMultiPart multipart = new MyMultiPart(parts, realFolder);

	news.setThumbnail(multipart.getSavedFileName("thumbnail"));
	if (multipart.getMyPart("image1") != null) {
		news.setImage1(multipart.getSavedFileName("image1"));
	}
	if (multipart.getMyPart("image2") != null) {
		news.setImage2(multipart.getSavedFileName("image2"));
	}
	if (multipart.getMyPart("image3") != null) {
		news.setImage3(multipart.getSavedFileName("image3"));
	}
	ndb.update(news);

	ndb.close();
} catch (SQLException e) {
	out.print(e);
	return;
}
response.sendRedirect("index.jsp");
%>