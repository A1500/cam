<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>行政区划撤销编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	<%
	String reqTime=DateUtil.getDay();
	String organCode=BspUtil.getCorpOrgan().getOrganCode();
	String organName=BspUtil.getCorpOrgan().getOrganName();
	String userName=GetBspInfo.getBspInfo().getUserName();
	String changeId = request.getParameter("changeId");
	if(changeId==null){
		changeId = IdHelp.getUUID32();
	}
	%>
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var changeId='<%=changeId%>';
	var batchId='<%=request.getParameter("batchId")%>';
	var reqTime='<%=reqTime%>';
	var organCode='<%=organCode%>';
	var organName='<%=organName%>';
	var userName='<%=userName%>';
</script>
<script type="text/javascript" src="dicCityDelete.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicCityChangeDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChange">
			<model:field name="remark" type="string" rule="require" />
			<model:field name="serialNum" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="dicCityDetailDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityDataTransQueryCmd" method="getUnder" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityDataTrans"/>
	</model:dataset>
	<!-- 代码级别 (区县)-->
	<model:dataset id="codeLeveDatasetQU" enumName="COMM.CODE.LEVE.QU" autoLoad="true" global="true"></model:dataset>
	<!-- 代码级别 (街道)-->
	<model:dataset id="codeLeveDatasetXIANG" enumName="COMM.CODE.LEVE.XIANG" autoLoad="true" global="true"></model:dataset>
	<!-- 迁移类型-->
	<model:dataset id="transTypeDataSet" enumName="COMM.TRANS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%"   autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="dicCityChangeDataSet" onsubmit="return false"  class="L5form">
<fieldset>
	<legend>行政区划撤销</legend>
	<table width="100%">
		<tr >
			<td class="FieldLabel" style="width:18%">待撤销区划名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="变更前区划名称" id="preChangeName" field="preChangeName" maxlength="50" style="width:90%" readonly />
			<img id="img" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
			<input type="hidden" name="xzxhjb" id="xzxhjbquery"/></td>
		</tr>
		<tr >
			<td class="FieldLabel" style="width:18%">待撤销区划代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="变更前区划代码" id="preChangeCode" field="preChangeCode" maxlength="12" style="width:90%" readonly/></td>
		</tr>
		<tr >
			<td class="FieldLabel" style="width:18%">待撤销上级区划代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="变更前上级区划代码" id="preUpsCode" field="preUpsCode" maxlength="12" style="width:90%" readonly/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">待撤销上级区划名称：</td>
			<td class="FieldInput" style="width:36%"><input  name="待删除上级区划名称" id="preUpsName" field="preUpsName" maxlength="50"  style="width:90%" readonly></input></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">序号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" onblur="_isNum(this.value)" name="序号" id="serialNum" field="serialNum" maxlength="4" /><font color="red">序号为1~9999(序号大小决定调整执行的先后顺序!!!)</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">变更说明：</td>
			<td class="FieldInput" style="width:36%"><textarea  onpropertychange="if(value.length>100) value=value.substr(0,100)" name="变更说明" id="remark" field="remark"  style="width:90%"></textarea><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldInput" colspan="2"><label style="height:10px"><font size="3" color="red">注：街道下有区划变更的请先通过变更代码（或名称）变更完再迁移数据！<br></label>
			</td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="detailGrid" dataset="dicCityDetailDataSet" width="100%" stripeRows="true" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="edit" id="edit" text="变更数据维护" handler="edit"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="TRANS_ID" header="数据迁移ID" width="10%" sortable="false" hidden="true"/>
		<next:Column field="CHANGE_ID" header="变更业务ID" width="10%" sortable="false" hidden="true"/>
		<next:Column field="ID" header="当前区划代码" width="10%" sortable="false"/>
		<next:Column field="NAME" header="当前区划名称" width="15%" sortable="false"/>
		<next:Column field="TRANS_TYPE" header="迁移类型" dataset="transTypeDataSet" width="10%"></next:Column>
		<next:Column field="POST_UPS_CODE" header="迁移后上级区划代码" width="10%" sortable="false"></next:Column>
		<next:Column field="POST_UPS_NAME" header="迁移后上级区划名称" width="10%" sortable="false"></next:Column>
		<next:Column field="POST_CHANGE_CODE" header="迁移后区划代码" width="10%" sortable="false"></next:Column>
		<next:Column field="POST_CHANGE_NAME" header="迁移后区划名称" width="10%" sortable="false"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dicCityDetailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id ="transWin" title="数据迁移" expandOnShow="false"
        resizable="true" closeAction="hide" width="500" height="300"
       closable="true" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="确定" iconCls="detail" handler="confirm"/>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="dicCityDetailDataSet"  onsubmit="return false"  class="L5form">
				<table border="1"  width="100%" >
			   		<tr>	
						<td  class="FieldLabel" style="width:30%">当前区划代码:</td>
						<td class="FieldInput" style="width:70%"><input id="changeCode" field="ID"  readonly style="width:90%"></input> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:30%">当前区划名称:</td>
						<td class="FieldInput" style="width:70%"><input id="changeName" field="NAME" readonly  style="width:90%"></input> </td>	
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:30%">迁移类型:</td>
						<td class="FieldInput" style="width:70%"><label id="changeType" field="TRANS_TYPE" dataset="transTypeDataSet" value="0"></label>
						</td>	
					</tr> 
					<tr>
						<td  class="FieldLabel" style="width:30%">迁移后上级区划代码:</td>
						<td class="FieldInput" style="width:70%"><input id="upsCode"  field="POST_UPS_CODE"  style="width:90%" readonly></input> 
						<img id="img1" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_Select1()" /></td>	
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:30%">迁移后上级区划名称:</td>
						<td class="FieldInput" style="width:70%"><input id="upsName" field="POST_UPS_NAME"  style="width:90%" readonly></input> </td>	
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:30%">迁移后区划代码:</td>
						<td class="FieldInput" style="width:70%"><input id="postCode" field="POST_CHANGE_CODE" readonly style="width:90%"></input>
						<img id="img2" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_Select2()" /></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:30%">迁移后区划名称:</td>
						<td class="FieldInput" style="width:70%"><input id="postName" field="POST_CHANGE_NAME"  readonly style="width:90%"></input> </td>	
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
</body>
</html>