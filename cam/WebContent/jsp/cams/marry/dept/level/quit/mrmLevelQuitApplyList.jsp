<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.marry.util.CheckStatus"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>等级评定</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="mrmLevelQuitApplyList.js"></script>
<script type="text/javascript">
var DJC_BC = '<%=CheckStatus.DJC_BC%>';
var DJC_SB = '<%=CheckStatus.DJC_SB%>';
var QX_TG = '<%=CheckStatus.QX_TG%>';
var QX_TH = '<%=CheckStatus.QX_TH%>';
var QX_WTG = '<%=CheckStatus.QX_WTG%>';
var DS_TG = '<%=CheckStatus.DS_TG%>';
var DS_WTG = '<%=CheckStatus.DS_WTG%>';
var DS_TH = '<%=CheckStatus.DS_TH%>';
var S_TG = '<%=CheckStatus.S_TG%>';
var S_WTG = '<%=CheckStatus.S_WTG%>';
var S_TH = '<%=CheckStatus.S_TH%>';
var B_TG = '<%=CheckStatus.B_TG%>';
var B_WTG = '<%=CheckStatus.B_WTG%>';
var B_TH = '<%=CheckStatus.B_TH%>';
//查询条件面板打开合并函数
function collapse(element){
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
		fieldsetParent.getElementsByTagName("div")[0].style.display="none";
		element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
		element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
		element.expand =true;
	}
}
</script>

</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true" 
	sortField="APPLY_TIME" sortDirection="desc">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<model:dataset id="applyQueryDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
		</model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
</model:datasets>

<next:Panel width="100%" height="100%">
	<next:Panel border="0">	
		<next:Html><center>		
			<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
				<legend class="GroupBoxTitle">
					查询条件 <img class="GroupBoxExpandButton"
						src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
						onclick="collapse(this)" />
				</legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="0" width="100%">
							<tr>
							 	<td class="FieldLabel" style="width:10%">当前处理单位</td>
				                <td class="FieldInput" style="width:20%"><input id="curOrganName" style="width:80%"/></td>
				                <td class="FieldLabel" style="width:10%">审核状态</td>
				                <td class="FieldInput" style="width:20%">
				                	<select id="checkStatus" style="width:80%">
				                		<option value="">请选择...</option>
				                		<option value="00,22">未提交</option>
				                		<option value="11,21,31,32,41,42,52">在审</option>
				                		<option value="20,30,40,50">未通过</option>
				                		<option value="51">办结</option>
				                	</select>
				                </td>
				                <td class="FieldButton" style="width:10%">
				                	<button onclick="query()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button>
				                </td>
							</tr>
						</table>
					</form>
				</div>
			</fieldset>
		</center></next:Html>
	</next:Panel>
	<next:GridPanel id="gridPanel" title="等级评定取消申报列表" dataset="applyDataSet" stripeRows="true" notSelectFirstRow="true" height="100%">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add"  text="新增" handler="newApply"/>	
			<next:ToolBarItem iconCls="detail"  text="办理" handler="handle"/>
			<next:ToolBarItem iconCls="remove"  text="删除" handler="deleteApply"/>
			<next:ToolBarItem iconCls="print"  text="打印" handler="printApply"/>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn/>
		    <next:Column header="申请取消单位" field="organName" width="200" renderer="renderOrganName"></next:Column>
		    <next:Column header="取消等级" field="applyLevel" width="120" dataset="evaluLevelDataSet"></next:Column>
			<next:Column header="申报时间" field="applyTime" width="150" ></next:Column>
			<next:Column header="当前处理单位" field="curOrganName" width="200" ></next:Column>						
			<next:Column header="审核状态" field="checkStatus" width="100" renderer="renderCheckStatus"></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="applyDataSet" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
			
</body>
</html>