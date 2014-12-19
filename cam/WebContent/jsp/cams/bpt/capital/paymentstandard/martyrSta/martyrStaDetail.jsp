<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>老烈平反子女补助标准列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
		<script type="text/javascript" src="martyrStaDetail.js"></script>
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
			var startDate = '<%=request.getParameter("startDate")%>';
			var organCode = '<%=request.getParameter("organCode")%>';
			var ID;
			<%
				if(request.getParameter("ID")!=null&&request.getParameter("ID")!=""){
			%>
				 ID = '<%=request.getParameter("ID")%>';
			<%
				}
			%>
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalMarStaQueryCommand" method="execute" global="true" pageSize="500">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalRetMarSta">
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel title="烈士子女补助标准列表"  name="bptcapitalmarstaGrid" width="100%" height="95%"  id="editGridPanel" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	    <next:ToolBarItem iconCls="undo" text="返回" id="reset" handler="reset"/>
	</next:TopBar>
	<next:Html>
		<form id="MartyrStaForm" class="L5form" method="post" dataset="ds" onsubmit="return false"	style="padding: 5px;" >
			<table border="1" width="98%">
				<tr>
					<td class="FieldLabel"  nowrap="nowrap"style="width: 20%">生效日期起：</td>
					<td class="FieldInput" style="width: 80%"><label title="生效日期起"
						name="startDate" field="startDate" align="center" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"  nowrap="nowrap">生效日期止：</td>
					<td class="FieldInput"><label title="生效日期止"
						name="endDate" field="endDate" align="center" />
					</td>				
				</tr>
				<tr>
					<td class="FieldLabel"  nowrap>省标准（元/月）：</td>	
					<td class="FieldInput" ><label title="省标准（元）"
						name="proStaMon" field="proStaMon" align="center" />
					</td>	
				</tr>
				<tr>			
					<td class="FieldLabel" >地方补贴（元/月）：</td>
					<td class="FieldInput"><label title="地方补贴（元）"
						name="localSubsidyMon" field="localSubsidyMon" align="center" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">备注：</td>
					<td class="FieldInput"><label title="备注"
						name="note" field="note" align="center" />
					</td>
				</tr>							
			</table>	
		</form>
	</next:Html>
</next:Panel>	



</body>
</html>
