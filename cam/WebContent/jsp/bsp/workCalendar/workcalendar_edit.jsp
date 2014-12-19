<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="java.util.*"%>
<%@ page import="org.loushang.bsp.workCalendar.cmd.CalendarShow"%>
<%@ page import="org.loushang.next.web.utils.Base64"%>


<%
    String year_s =(String) request.getAttribute("year");
    String organId =(String) request.getAttribute("organId");
    String organName =(String) request.getAttribute("organName");
    String cur_year_s = (String)request.getAttribute("cur_year");
    String cur_month_s = (String)request.getAttribute("cur_month");
    String cur_day_s = (String)request.getAttribute("cur_day");
    List strHoliday = (List)request.getAttribute("strHoliday");
    int year = Integer.parseInt(year_s);
    int cur_year = Integer.parseInt(cur_year_s);
    int cur_month = Integer.parseInt(cur_month_s);
    int cur_day = Integer.parseInt(cur_day_s);
    int month=0;
    String s ="";
    CalendarShow calendarShow = new CalendarShow();
    organName=Base64.decodeURIParameter(organName);

%>


<html>
<head>
<title>机构日历</title>
<next:ScriptManager/>

</head>
<body>
<model:datasets>
</model:datasets>

<next:ViewPort>
<next:AnchorLayout>
<next:Panel >
	<next:TopBar>
		<next:ToolBarItem  text="年份："/>
		<next:ToolBarItem  text='<%=year_s%>' />
		<next:ToolBarItem  text="组织机构："/>
		<next:ToolBarItem  text='<%=organName%>' />
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
<next:TabPanel id="tabPanels">
<input type="hidden" name="year" value="<%=year_s%>">
<input type="hidden" name="organId" value="<%=organId%>">
<next:Tabs>

<next:Panel autoScroll="false" width="90%" title=" 一、二月  " >
		<next:Html>
				<table   width="100%" cellpadding="0"  >
			   		 <tr>
           				 <td  id="tdWorkArea" >
             				 <%
             				 	month = 0;
             				 	s = calendarShow.getShow(year, month,strHoliday, cur_year, cur_day,cur_month);
             				 	out.println(s);
             				 %>
            			</td>
       				 </tr>
				</table>
		</next:Html>
</next:Panel>
<next:Panel autoScroll="false" width="90%" title=" 三、四月 ">
	<next:Html>
			<table width="100%" cellpadding="0">
         		<tr>
            		<td id="tdWorkArea" >
              			<%
              				month = 2;
              				s = calendarShow.getShow(year, month,strHoliday, cur_year, cur_day,cur_month);
              				out.println(s);
              			%>
           			 </td>
       			 </tr>
			</table>
	</next:Html>
</next:Panel>
<next:Panel autoScroll="false" width="90%" title=" 五、六月  ">
	<next:Html>
			<table width="100%" cellpadding="0">
         		<tr>
            		<td id="tdWorkArea">
            		<%
            			month = 4;
            			s = calendarShow.getShow(year, month,strHoliday, cur_year, cur_day,cur_month);
            			out.println(s);
            		%>
           			 </td>
       			 </tr>
			</table>
	</next:Html>
</next:Panel>
<next:Panel autoScroll="false" width="90%" title=" 七、八月  ">
	<next:Html>
			<table width="100%" cellpadding="0" >
         		<tr>
            		<td id="tdWorkArea" >
            		<%
	            		month=6;
	                    s = calendarShow.getShow(year,month,strHoliday,cur_year,cur_day,cur_month);
	                    out.println(s);
            		%>
           			 </td>
       			 </tr>
			</table>
	</next:Html>
</next:Panel>
<next:Panel autoScroll="false" width="90%" title=" 九、十月  ">
	<next:Html>
			<table width="100%" cellpadding="0" >
         		<tr>
            		<td id="tdWorkArea" >
            		<%
	            		 month=8;
	                    s = calendarShow.getShow(year,month,strHoliday,cur_year,cur_day,cur_month);
	                    out.println(s);
            		%>
           			 </td>
       			 </tr>
			</table>
	</next:Html>
</next:Panel>
<next:Panel autoScroll="false" width="90%" title=" 十一、十二月  ">
	<next:Html>
			<table width="100%" cellpadding="0" >
         		<tr>
            		<td id="tdWorkArea" >
            		<%
	            		month=10;
	                    s = calendarShow.getShow(year,month,strHoliday,cur_year,cur_day,cur_month);
	                    out.println(s);
            		%>
           			 </td>
       			 </tr>
			</table>
	</next:Html>
</next:Panel>

</next:Tabs>
</next:TabPanel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
<script language="javascript">

function save(){

   var command=new L5.Command("org.loushang.bsp.workCalendar.cmd.WorkCalendarCmd");

   var tt=document.getElementsByName("NONEWORK");
	command.setParameter("year","<%=year_s%>");
	var NONEWORK="";
	for(var i=0;i<tt.length;i++){
		if(tt[i].checked){
			NONEWORK=NONEWORK+tt[i].value+",";
		}
	}
	command.setParameter("NONEWORK",NONEWORK);
	command.setParameter("organId","<%=organId%>");
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',command.error);
	}
}
function back(){
	var url="jsp/bsp/workCalendar/workcalendar_list.jsp";
	L5.forward(url);
}

</script>
