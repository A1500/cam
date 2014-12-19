<%@page import="org.loushang.live.engine.util.StringUtil"%>
<%@page import="org.loushang.live.engine.util.PropertyUtil"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<%@page import="org.loushang.live.common.deliverymode.DeliveryModeDao"%>
<%@page import="org.loushang.live.common.deliverymode.IDeliveryModeDao"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	//使用Loushang5提供的工具类获取dao
	IDeliveryModeDao deliveryModeDao = (IDeliveryModeDao) DaoFactory
	.getDao(DeliveryModeDao.class);
	String menuItems = PropertyUtil.getInstance().get("menuitems");
	List mList = StringUtil.split(menuItems , ",");
	StringBuilder idsJson = new StringBuilder("["); 
	StringBuilder textJson = new StringBuilder("["); 
	for(int i=0; i<mList.size(); i++){
		String dmode = mList.get(i).toString();
		idsJson.append("'" + dmode + "',");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("DELIVERY_MODE" , dmode);
		DataSet ds = deliveryModeDao.getDeliveryMode(pset); 
		String text = ds.getCount()==1 ? ds.getRecord(0).get("deliveryName").toString() : "";
		textJson.append("'"+ text + "',");
	}
	if(mList.size() != 0){
		idsJson.setCharAt(idsJson.length()-1 , ']');
		textJson.setCharAt(textJson.length()-1 , ']');
		idsJson.insert(0 , "{ids:");
		textJson.insert(0 , "text:");
		idsJson.append(',');
		idsJson.append(textJson);
		idsJson.append('}');
		out.append("<script type=\"text/javascript\">");
		out.append("var MenuItems=" + idsJson +";");
		out.append("</script>");
	}else{
		out.append("<script type=\"text/javascript\">");
		out.append("var MenuItems={ids:[],text:[]};");
		out.append("</script>");
	}
%>