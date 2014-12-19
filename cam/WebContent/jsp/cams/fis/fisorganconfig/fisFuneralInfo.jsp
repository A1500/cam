<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>


<html>
<head>
<title>殡仪馆名称</title>
<next:ScriptManager/>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="fisFuneralInfo.js"></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
    var fisFuneralCodeRec='<%=request.getParameter("fisFuneralCodeRec")%>'; 
</script>
</head>
<body>
  <model:datasets>
	<model:dataset id="FuneralInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganManageQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisFuneralOrganManage"/>
	</model:dataset>
  </model:datasets>

<next:Panel width="100%" border="0">
  <next:Html>
  <fieldset style="overflow:visible;" class="GroupBox">
  <legend class="GroupBoxTitle" dataset="FuneralInfoDs">查询条件</legend>
        <form class="L5form">
          <table border="1" width="100%">
            <tr>
              <td class="FieldLabel" width="25%">殡仪馆名称</td>
              <td class="FieldInput" style="width:30%">
                <input id="funeralName" type="text"></input>
              </td> 
              <td class="FieldButton" >
              <button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
              <button type="reset" onclick="init()">重置</button>
              </td>
            </tr>
          </table>
        </form>
  </fieldset>
  </next:Html>
</next:Panel>
	
<next:Panel width="100%" border="0">
<next:EditGridPanel id="grid" dataset="FuneralInfoDs" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="select"  text="选择" handler="select"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="unitId" header="殡仪馆编号" hidden="true" width="10%" sortable="true"/>
		<next:Column field="unitName" header="殡仪馆名称" width="55%" sortable="true" align="left"/>
	</next:Columns>
	
	<next:BottomBar>
		<next:PagingToolBar dataset="FuneralInfoDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</body>
</html>