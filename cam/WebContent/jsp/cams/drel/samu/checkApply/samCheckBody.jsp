<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>五保对象查体信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samCheckBody.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
		<%
			String organCode=BspUtil.getCorpOrgan().getOrganCode();//用于行政区划过滤
			if(organCode.endsWith("0000000000")){//省370000000000
				organCode= organCode.substring(0,2);
			} else if (organCode.endsWith("00000000")){//市370100000000
				organCode=  organCode.substring(0,4);
			} else if (organCode.endsWith("000000")){//县370104000000
				organCode=  organCode.substring(0,6);
			} else if (organCode.endsWith("000")){//乡370104003000
				organCode=  organCode.substring(0,9);
			}
	    %>
	     var organCode='<%=organCode%>';
		var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
</head>
<body>
<model:datasets>
	<!-- 查体名册列表 -->	
	<model:dataset id="samListDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroApplyQueryCmd" method="queryList" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroApply"/>
	<model:record>
		<model:field name="GEROCOMIUM_ID"/>
		<model:field name="GEROCOMIUM_NAME"/>
		<model:field name="TOTALNUM"/>
		<model:field name="JK_NUM"/>
		<model:field name="YB_NUM"/>
		<model:field name="ZB_NUM"/>
		<model:field name="CHECK_DATE"/>
		<model:field name="CHECK_RESULT"/>
	</model:record>
	</model:dataset>
	<!-- 用于检查敬老院是否有供养对象 -->
	<model:dataset id="samGeroKeptPersonDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonQueryCmd" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroKeptPerson"/>
	</model:dataset>
	<!-- 敬老院下拉框选项 -->
	<model:dataset id="samGeroDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_GEROCOMIUM_INFO'></model:param>
			<model:param name="value" value='GEROCOMIUM_ID'></model:param>
			<model:param name="text" value='GEROCOMIUM_NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="samGeroApplyDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroApplyQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroApply"/>
	</model:dataset>
	<!-- yes or no -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="checkResultDataset" enumName="SAM_SAMU_HEALTH" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%">敬老院名称</td>
					<td class="FieldInput" style="width:18%"><input type="text" id="gerocomiumNameQuery" style="width:80%"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForGeroSelect()" /> <input
						type="text" id="gerocomiumIdQuery" name="gerocomiumIdQuery" 
						style="display: none" /></td>
					<td class="FieldLabel" style="width: 15%">查体时间：</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="名称" id="checkDateQuery" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"
						maxlength="50" style="width: 80%" /></td>	
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="samListDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="登记名册" iconCls="add" handler="insertList" id="inserButton"/>
		<next:ToolBarItem text="维护名册" iconCls="edit" handler="editDetail" id="editButton"/>
		<next:ToolBarItem text="删除名册" iconCls="delete" handler="deleteList" id="delButton"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="GEROCOMIUM_NAME" header="敬老院名称" width="15%" align="center"  sortable="false"/>
		<next:Column field="CHECK_DATE" header="查体时间"  sortable="false" width="10%" align="center" renderer="detailRender"/>
		<next:Column field="TOTALNUM" header="总人数"  sortable="false" align="center"/>
		<next:Column field="JK_NUM" header="健康或良好"  sortable="false" align="center"/>
		<next:Column field="YB_NUM" header="一般或较弱"  sortable="false" align="center"/>
		<next:Column field="ZB_NUM" header="重病"  sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samListDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id="addListWin" title="登记名册" closeAction="hide"  width="580" modal="true">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="save" text="确定" handler="saveList" ></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" text="关闭" handler="closeListWin"></next:ToolBarItem>
    </next:TopBar>
    <next:Html>
        <form  id="formList" method="post" 
				onsubmit="return false" class="L5form">
            <table width='100%'>
                <tr>
                    <td class="FieldLabel" id="valueLabel" style="width:100;">敬老院</td>
                    <td class="FieldInput" style="width:35%"><select
					id="gerocomiumName" field="gerocomiumName" name="敬老院" title="敬老院" style="width:85%" onchange="checkGero()" >
					<option dataset="samGeroDataSet"></option>
					</select></td>                  
                    <td class="FieldLabel"  style="width:100;">查体日期</td>
                    <td class="FieldInput" style="width:35%;">
                        <input type="text" name="查体日期" id="checkDate"  format="Y-m-d" onclick="LoushangDate(this)" style="width:85%" readonly="readonly"/>
                        <font color=red>*</font>
                    </td>
                 </tr>
                 <tr>
                     <td class="FieldLabel"  style="width:100;">主要查体结果</td>
                    <td class="FieldInput" style="width:35%;"><select
					id="checkResult" name="查体结果" title="查体结果"
					style="width: 85%">
					<option dataset="checkResultDataset"></option>
					</select> <font color=red>*</font></td>      
                </tr>
            </table>
        </form>
   </next:Html>
</next:Window>
</body>
</html>