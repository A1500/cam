<%@ page contentType="text/xml; charset=utf-8"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="com.inspur.cams.marry.query.divorce.cmd.DivorcePeopleTypeQueryCmd"%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="java.util.*"%>
<%@ page import="org.loushang.sca.ScaComponentFactory"%>
	<!-- 离婚数据 -->
<%
	//行政区划
	String cityCode = request.getParameter("cityCode");

	DivorcePeopleTypeQueryCmd hsrqcmd = new DivorcePeopleTypeQueryCmd();
	//设置查询参数
	ParameterSet pset = new ParameterSet();
	pset.setParameter("xzqu", cityCode);
	DataSet ds = hsrqcmd.queryForGis(pset);
	Record rec = new Record();

	StringBuffer sb = new StringBuffer("");
	sb.append("<config>");
	for (int i = 0; i < ds.getCount(); i++) {
		rec = ds.getRecord(i);
		sb.append("<city>");
		sb.append("<code>" + ((String) rec.get("ITEM_CODE")).trim() + "</code>");//区划代码
		sb.append("<name>" + ((String) rec.get("ITEM_NAME")).trim()  + "</name>");//区划名称
		sb.append("<divorce_num>" + (rec.get("MARRY_NUM").toString().replaceAll(",","") == null ? 0 : rec.get("MARRY_NUM").toString().replaceAll(",","")) + "</divorce_num>");//具体数据值
		sb.append("</city>");
	}
	sb.append("</config>");
	out.println(sb.toString());
%>
