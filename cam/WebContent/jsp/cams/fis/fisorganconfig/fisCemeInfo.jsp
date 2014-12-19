<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>


<html>
<head>
<title>公墓名称</title>
<next:ScriptManager/>
<script type="text/javascript" src="fisCemeInfo.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
   var fisCemeCodeRec= '<%=request.getParameter("fisCemeCodeRec")%>';
</script>
</head>
<body>
  <model:datasets>
	<model:dataset id="CemeInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
  </model:datasets>
	
<next:Panel width="100%" border="0">
  <next:Html>
  <fieldset style="overflow:visible;" class="GroupBox">
  <legend class="GroupBoxTitle" dataset="CemeInfoDs">查询条件</legend>
        <form class="L5form">
          <table border="1" width="100%">
            <tr>
              <td class="FieldLabel" width="25%">公墓名称</td>
              <td class="FieldInput" style="width:30%">
                <input id="cemeteryName" type="text"></input>
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
<next:EditGridPanel id="grid" dataset="CemeInfoDs" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="select"  text="选择" handler="select"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="recordId" header="公墓记录编号" hidden="true" width="10%" sortable="true"/>
		<next:Column field="organId" header="公墓编号" hidden="true" width="10%" sortable="true"/>
		<next:Column field="name" header="公墓名称" width="55%" sortable="true" align="left"/>
	</next:Columns>
	
	<next:BottomBar>
		<next:PagingToolBar dataset="CemeInfoDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</body>
</html>