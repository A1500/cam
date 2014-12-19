<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>新增馆墓一体</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="fisOrganTypeConfig.js"></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var configId='<%=IdHelp.getUUID32()%>';
	var time = '<%= DateUtil.getTime()%>';
	var configIdOld='<%=request.getParameter("configId")%>';
</script>
</head>
<body>
	<model:datasets>
		<model:dataset id="fisOrganTypeConfig" cmd="com.inspur.cams.fis.base.cmd.FisOrganTypeConfigQueryCmd"  global="true" pageSize="10">
		    <model:record fromBean="com.inspur.cams.fis.base.data.FisOrganTypeConfig"></model:record>
		</model:dataset>
	</model:datasets>
	<next:TabPanel id="tab1" activeTab="0" width="100%"  height="100%">
	<next:TopBar>
	
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveCemeFuneralInfo"/>
		<next:ToolBarItem iconCls="return" text="返回" handler="click_back"/>
	</next:TopBar>
			<next:Tabs>
					<next:Panel title="新增馆墓一体" width="100%" autoScroll="true">
							  <next:Html>
										<form id="form1" method="post" dataset="fisOrganTypeConfig" onsubmit="return false" class="L5form">
										   <fieldset>
											<table border="1" width="100%" >
													 <tr>
													        <td rowspan="2" class="FieldLabel" width="20%">殡仪馆信息</td> 
															<td class="FieldLabel" width="20%" >殡仪馆编号</td>
															<td class="FieldInput"><label type="text" readonly="readonly" id="funeralOrgan" field="funeralOrgan"></label>&nbsp;&nbsp;&nbsp;
															 <div id="img"><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
											style="cursor: hand" onclick="getFuneralInfo()" title="列表选择" id="FuneralSelect"/></div>
															</td>
													 </tr>
													 <tr>				
															<td class="FieldLabel" width="20%">殡仪馆名称</td>
															<td class="FieldInput" ><label type="text" readonly="readonly" id="funeralOrganName" field="funeralOrganName"></label></td>							
													 </tr>
											</table>
											</fieldset>
										</form>
										
										<form id="form1" method="post" dataset="fisOrganTypeConfig" onsubmit="return false" class="L5form">
										 <fieldset>
											<table border="1" width="100%" >
													 <tr>
													    <td rowspan="2" class="FieldLabel" width="20%">公墓信息</td>
													    <td class="FieldLabel" width="20%">公墓编号</td>
													    <td class="FieldInput"><label type="text" readonly="readonly" id="cemeteryOrgan" field="cemeteryOrgan"></label>&nbsp;&nbsp;&nbsp;
															 <div id="img"><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
											style="cursor: hand" onclick="getCemeInfo()" title="列表选择" id="CemeSelect"/></div></td>
													 </tr>
													 <tr>   
													    <td class="FieldLabel" width="20%">公墓名称</td>
													    <td class="FieldInput"><label type="text" id="cemeteryOrganName" field="cemeteryOrganName"></label></td>
													 </tr>
											</table>
										</fieldset>
										</form>
							 </next:Html>
					</next:Panel>
			</next:Tabs>
	</next:TabPanel>

</body>
</html>