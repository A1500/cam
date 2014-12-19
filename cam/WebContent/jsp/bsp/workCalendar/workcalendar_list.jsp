
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="org.loushang.bsp.organization.dao.OrganDao"%>
<%@ page import="org.loushang.bsp.organization.data.Organ"%>
<%
	String organId = GetBspInfo.getBspInfo(request).getCorporationOrganId();
	if(organId==null || organId.equals("")){
		organId="1";
	}
	String msg="",organName="";
	OrganDao organDao = new OrganDao();
	Organ organ=organDao.getOrgan(organId);
	if(organ==null){
		msg="当前登录用户未设置单位,不允许设置工作日历！";
	}else{
		organName=organ.getOrganName();
	}
%>
<html>
	<head>
		<title>机构日历</title>
		<next:ScriptManager/>
		<script>
			var organId='<%=organId%>';
			var organName='<%=organName%>';
			var msg='<%=msg%>';
			var nfst='<%=org.loushang.bsp.util.DateUtil.GetToday()%>';
			var nf=parseInt(nfst.substring(0,4))-10;
		</script>
		<script type="text/javascript" src="workcalendar_list.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="org.loushang.bsp.workCalendar.cmd.WorkCalendarQueryCmd" global="true" >
	<model:record>
			<model:field name="organName" mapping="organName" type="string"  rule="require"/>
			<model:field name="solarDate" mapping="solarDate" type="string"  rule="require" />
			<model:field name="organId" mapping="organId" type="string"  rule="require"/>
			<model:field name="note" mapping="note" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="nfds" global="true" >
		<model:record>
					<model:field name="value"  />
			<model:field name="text" />

		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:EditGridPanel id="editGridPanel" name="editGridPanel"  height="100%" anchor="100% 100%" dataset="ds" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加年份" iconCls="add"  handler="insert"/>
		<next:ToolBarItem text="日历设置" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="solarDate" header="年份" field="solarDate" width="100"  >
			<next:ComboBox dataset="nfds" editable="edityear"  mode="local" />
		</next:Column>
		<next:Column id="organName" header="机构名称" field="organName" width="200" >
			<next:TextField allowBlank="false"  editable="false"/>
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
</next:ViewPort>
</body>
</html>
