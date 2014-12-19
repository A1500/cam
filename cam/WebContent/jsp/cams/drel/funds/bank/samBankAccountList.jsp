<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>银行账户信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samBankAccountList.js"></script>
		<script type="text/javascript" src="bankAccountImport.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
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
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
			var assistanceType = '<%=request.getParameter("assistanceType")%>';
			var rootPath='<%=SkinUtils.getRootUrl(request)%>';
		</script>
	</head>
<body>
<model:datasets>
	<!-- 基础信息_家庭信息 -->
	<model:dataset id="baseinfoFamilyListDS" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" method="querySamBankList">
	</model:dataset>
	<!-- 银行账户信息 -->
	<model:dataset id="bankAccountDS" cmd="com.inspur.cams.drel.sam.cmd.SamBankAccountQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamBankAccount">
			<model:field name="bank" type="string" rule="require" />
			<model:field name="accountName" type="string" rule="require|length{25}" />
			<model:field name="accountNumber" type="string" rule="require|length{40}" />
		</model:record>
	</model:dataset>
	<!-- 开户银行 -->
	<model:dataset id="bankDataset" autoLoad="true" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="filterSql" value=' flag=1 '></model:param>
		</model:params>
	</model:dataset>
	<!-- 主要致贫原因 -->
	<model:dataset id="provertyCause" enumName="SAM_CITY_PROVERTY_CAUSE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
						    	<td class="FieldLabel" nowrap="nowrap" width="100">地区</td>
						        <td class="FieldInput">
						        	<input type="text" id="domicileName" name="domicileName" style="width:175px"
										readonly="readonly" /><img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
										style="cursor: hand" onclick="func_ForDomicileSelect()"/>
									<input type="text" id="domicileCode" name="domicileCode" style="display: none"/>
						        </td>
						    	<td class="FieldLabel" nowrap="nowrap" width="100">户主姓名</td>
						        <td class="FieldInput">
						        	<input type="text" name="qFamilyName" id="qFamilyName"/>
						        </td>
								<td class="FieldButton">
									<button id="queryId" onclick="query()" >查 询</button>
								</td>
							</tr>
							<tr >
						        <td class="FieldLabel" nowrap="nowrap" >身份证号</td>
						        <td class="FieldInput">
						        	<input type="text" name="qFamilyCardNo" id="qFamilyCardNo" style="width:175px"/>
						        </td>
						    	<td class="FieldLabel" nowrap="nowrap" width="100">账户状态</td>
						        <td class="FieldInput">
						        	<select name="账户状态" id="bankStat" >
						        		<option value="">请选择……</option>
										<option value="1">正常</option>
										<option value="0">未采集</option>
										<option value="2">须更新</option>
									</select>
						        </td>
								<td class="FieldButton">
									<button onclick="resetQuery()">重 置</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="sambankaccountGrid" width="100%" stripeRows="true" height="100%" dataset="baseinfoFamilyListDS">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="银行账户维护信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="维护银行账户" iconCls="edit" handler="insert"/>
		<next:ToolBarItem text="导入银行账户" iconCls="upload" handler="accountImport"/>
		<next:ToolBarItem text="下载银行账户模版" iconCls="edit" handler="onLoad"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn header="序号" width="40" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column  header="家庭ID" field="FAMILY_ID" width="100" align="center" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column  header="乡镇" field="TOWN" width="100" align="center" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column  header="村" field="VILLAGE" width="100" align="center" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column  header="地区" field="DOMICILE_NAME" width="100" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="户主姓名" field="FAMILY_NAME" width="80"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="身份证号" field="FAMILY_CARD_NO" width="135"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="低保证号" field="CARD_NO" width="130" align="center">
			<next:TextField />
		</next:Column>
		<next:Column  header="起始保障年月" field="BEGIN_DATE" width="100" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="开户银行" field="BANK" width="110" align="center" >
			<next:TextField />
		</next:Column>
		<next:Column header="账户名称" field="ACCOUNT_NAME" width="90" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="银行账号" field="ACCOUNT_NUMBER" width="200" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="账号状态" field="ACCOUNT_STATUS" width="100" align="center" renderer="statusHref">
			<next:TextField />
		</next:Column>
		<next:Column header="救助类型" field="ASSISTANCE_TYPE" width="100" hidden="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="baseinfoFamilyListDS"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>

<!-- 维护银行账户信息 -->
<next:Window id="bankAccountWin" title="维护银行账户信息" closeAction="hide" height="155" width="745" modal="true">
	<next:Panel width="99%" height="100%" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" id="saveId" text="保存" handler="save" />
			<next:ToolBarItem iconCls="return" text="返回" handler="back"/>
		</next:TopBar>
		<next:Html>
			<fieldset>
				<form method="post"  dataset="bankAccountDS" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel">姓名:</td>
							<td class="FieldInput">
								<label id="familyName" />
							</td>
							<td class="FieldLabel" >身份证号:</td>
							<td class="FieldInput" >
								<label id="familyCardNo" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" >开户银行:</td>
							<td class="FieldInput" >
								<select name="开户银行" field="bank" >
									<option dataset="bankDataset"></option>
								</select><font color="red">*</font>
							</td>
							<td class="FieldLabel" >账户名称:</td>
							<td class="FieldInput" >
								<input type="text" name="账户名称" field="accountName" maxlength="25"/><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">银行账号:</td>
							<td class="FieldInput" colspan="5">
								<input type="text" name="银行账号" field="accountNumber" style="width: 229" maxlength="40"/><font color="red">*</font>
							</td>
						</tr>
					</table>
				</form>
			</fieldset>
		</next:Html>
	</next:Panel>
</next:Window>

<next:Window id="importExcelWin" closeAction="hide" title="导入Excel" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="确定" handler="click_import"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="关闭" handler="click_close"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator" />
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" style="width:20%">文件所在目录：</td>
				<td class="FieldInput" style="width:80%">
					<input class="file" type="file" id="excelFile" name="excelFile" style="width: 95%; height: 40"/>
				</td>
			</tr>
		</table>
		</form>
		<div style="position:relative;left:15px;color:red;font-size=11;width:550">
			备注：只能导入规定格式的EXCEL文件（可以通过【下载银行账户模板】功能进行下载），文件大小不能超过1M！<br/>
		</div>
	</next:Html>
</next:Window>