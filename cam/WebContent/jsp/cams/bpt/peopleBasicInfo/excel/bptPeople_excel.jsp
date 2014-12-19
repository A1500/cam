<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="com.inspur.cams.bpt.util.BptField"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
 	String fields = request.getParameter("fields");
	String f[]=fields.split(",");
	String[][] st = BptField.basepeople;
	String[][] s= new String[f.length][4];
	for(int i=0;i<f.length;i++){
		for(int j=0;j<st.length;j++){
			if(f[i].equals(st[j][3])){
				s[i]=st[j];
			}
		}
	}
	
	
%>

<Excel:tablelist filename="优抚人员基本信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="<%=s.length%>" align="center"><Excel:font size="12">优抚人员信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="<%=s.length%>" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
		<%
			for(int k=0;k<s.length;k++){
		%>
			<Excel:td  align="center" width="240" rowspan="2"><Excel:font size="13"><%=s[k][1]==null?"":s[k][1]%></Excel:font></Excel:td>
		<%
			}
		%>	
		</Excel:tr>
		<Excel:tr ></Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
		%>
		<Excel:tr border="1">
			<%
			
				for(int j=0;j<s.length;j++){
					
					if("".equals(s[j][2])){
						if("NATION".equals(s[j][0])){
			%>
							<Excel:td  align="center" width="240"><%=EnumUtil.findTextFromEnum("DIC_NATION","CODE","NAME",(String)record.get(s[j][0]))%></Excel:td>
			<% 			
						}else{
			%>
							<Excel:td  align="center" width="240"><%=record.get(s[j][0])==null?"":record.get(s[j][0])%></Excel:td>
			<%			
						}
					}else{
			%>
	            		<Excel:td align="center" width="240"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get(s[j][0])),s[j][2])%></Excel:td>
			<%
					}
				}
			%>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>