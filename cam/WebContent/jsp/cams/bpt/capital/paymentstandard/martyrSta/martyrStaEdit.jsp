<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.data.Record"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>老烈平反子女补助标准</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="../../../comm/bptComm.js"></script>
		<script type="text/javascript" src="martyrStaEdit.js"></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			var method = '<%=request.getParameter("method")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var organType = '<%=BspUtil.getOrganType()%>';
		</script>
		<script>
			var id;
			<%
				if(request.getParameter("id")!=null&&request.getParameter("id")!=""){
			%>
				 id = '<%=request.getParameter("id")%>';
			<%
				}
			%>
		</script>
	</head>
<body>

<model:datasets>
	<model:dataset id="queryDs" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalMarStaQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalRetMarSta"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel title="烈士子女补助标准列表"  width="100%" height="100%" border="true" autoScroll="true"	 id="martyrSta">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	    <next:ToolBarItem  iconCls="save" text="保存" id="save" handler="save"/>
	    <next:ToolBarItem iconCls="undo" text="返回" id="reset" handler="reset"/>
	</next:TopBar>
	<next:Html>
		<form id="MartyrStaForm" method="post" dataset="queryDs" onsubmit="return false"	style="padding: 5px;" class="L5form">
			<table border="1" width="98%">
				<tr>
					<td class="FieldLabel"  nowrap="nowrap">生效日期起：</td>
					<td class="FieldInput" ><input
					format="Y-m-d"  type="text" id="startDate"
					name="startDate"maxlength="10"style="width: 100px;" field="startDate"  onpropertychange="changeDateStyle(this)" 
					title="生效日期起"/><img id="startDateImg" src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  >
					<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%" nowrap>省标准（元/月）：</td>
					<td class="FieldInput" style="width:35%">
					<input type="text" id="proStaMon" name="proStaMon" field="proStaMon" maxlength="16" title="省标准（元）" /><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" >地方补贴（元/月）：</td>
					<td class="FieldInput" ><input name="localSubsidyMon" field="localSubsidyMon"
						title="地方补贴(元)" maxlength="16" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">备注：</td>
					<td class="FieldInput" ><textarea name="note" field="note" rows="3" maxlength="1000" title="备注" style="width: 90%"></textarea>
					</td>
				</tr>							
			</table>	
		</form>
	</next:Html>
</next:Panel>			
</body>
</html>
