
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.live.engine.persist.dao.EnvelopeDAO"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="java.io.PrintWriter"%>



<%
	EnvelopeDAO envelopeDao = (EnvelopeDAO)DaoFactory.getDao(EnvelopeDAO.class);
	DataSet ds = envelopeDao.getUnreadEnvelopes("R" , null);
	Integer count = (Integer)ds.getRecord(0).get("COUNT");	
	PrintWriter writer = response.getWriter();  
	writer.write(count.toString());
%>


