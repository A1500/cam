
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
	<head>
		<title>证书管理编辑页面</title>
		<next:ScriptManager/>
		<script>
			var taskCode='<%=request.getParameter("taskCode")%>';
			var method='<%=request.getParameter("method")%>';
			if(taskCode==null){
				taskCode=IdHelp.getUUID32();
			}
			var issuerPeople='<%=GetBspInfo.getBspInfo().getUserName()%>';
		</script>
		<script type="text/javascript" src="fitCertManagerEdit.js"></script>
		<script type="text/javascript" src="../certComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealCertQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealCert"></model:record>
	</model:dataset>
	<!-- 证件状态 -->
	<model:dataset id="certTypeDs" enumName="WEAL.CERT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="certStatusDs" enumName="WEAL.CERT_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="dsWin" cmd="com.inspur.cams.welfare.base.cmd.WealFitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitStatus"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
<next:AnchorLayout>
<next:Panel  title="证书管理编辑页面">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false"  class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
	   			<td  class="FieldLabel" style="width: 15%">企业名称:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="companyName"  title="企业名称"  field="companyName" onclick="queryFitList()" style="width:98%" /></td>
	   			
				<td  class="FieldLabel" style="width: 15%">编号:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="serialNum"  title="编号"  field="serialNum" style="width:98%" /></td>  
				 
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" style="width: 15%">单位性质:</td>
				<td class="FieldInput"  style="width: 18%">
				<select id="organType" field="organType" title="单位性质" style="width:98%">
					<option dataset="ecoDataSet"></option>
				</select></td> 
				
				<td  class="FieldLabel" style="width: 15%">法人代表:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="legalPeople"  title="法人代表"  field="legalPeople" style="width:98%" /> </td>
				
				<td  class="FieldLabel" style="width: 15%">认定日期:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="approveDate"  title="认定日期"  field="approveDate" style="width:98%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/> </td>
			</tr>
	   		<tr>	
				<td  class="FieldLabel" style="width: 15%">经营范围:</td>
				<td class="FieldInput"  style="width: 18%" colspan="5"><textarea rows="5"  cols="135" type="text" name="businessScope"  title="经营范围"  field="businessScope"  style="height: 50px; overflow-y: visible"></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">单位地址:</td>
				<td class="FieldInput"  style="width: 18%" colspan="3"><input type="text" name="companyAddress"  title="COMPANY_ADDRESS"  field="companyAddress"  style="width:99%"/> </td>
			
				<td  class="FieldLabel" style="width: 15%">场地面积(m²):</td>
				<td class="FieldInput"><input type="text" name="siteArea"  title="场地面积"  field="siteArea" style="width:98%" /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">业务类型:</td>
				<td class="FieldInput"  style="width: 18%">
				<select id="certType" field="certType" title="业务类型" style="width:98%">
					<option dataset="certTypeDs"></option>
				</select></td> 
				
				<td  class="FieldLabel" style="width: 15%">证件状态:</td>
				<td class="FieldInput"  style="width: 18%">
				<select id="certStatus" field="certStatus" title="证件状态" style="width:98%">
					<option dataset="certStatusDs"></option>
				</select></td> 
				
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">有效期始:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="startDate"  title="有效期始"  field="startDate" style="width:98%" readonly="readonly" format="Y-m-d" onblur="setEndDate(this.value)" onclick="WdatePicker()"/> </td>
			
				<td  class="FieldLabel" style="width: 15%">有效期止:</td>
				<td class="FieldInput"><input type="text" name="endDate"  title="有效期止"  field="endDate"  style="width:98%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/> </td>
			
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">发证机关:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="signOrgan"  title="发证机关"  field="signOrgan" style="width:98%" /> </td>
			
				<td  class="FieldLabel" style="width: 15%">发证日期:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="signDate"  title="发证日期"  field="signDate" style="width:98%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/></td> 
			
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">发证人:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="issuerPeople"  title="发证人"  field="issuerPeople" style="width:98%" /></td> 

				<td  class="FieldLabel" style="width: 15%">领证人:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="licensePeople"  title="领证人"  field="licensePeople" style="width:98%" /> </td>
			
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
	   		
	   		<tr style="display:none;">
				<td  class="FieldLabel" style="width: 15%">注销人:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="cancelPeople"  title="注销人"  field="cancelPeople"  style="width:98%"/> </td>
			
				<td  class="FieldLabel" style="width: 15%">注销日期:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="cancelTime"  title="注销日期"  field="cancelTime"  style="width:98%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/> </td>
				
				<td  class="FieldLabel" style="width: 15%">注销原因:</td>
				<td class="FieldInput"  style="width: 18%"><input type="text" name="cancelReason"  title="注销原因"  field="cancelReason" style="width:98%" /> </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:Panel>
<next:Window id="fitWin" title="选择要填写证书的企业" width="850" height="800" autoHeight="true" resizable="false" closeAction="hide" modal="true">
	<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" >
		<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
						class="GroupBoxTitle">查询条件 <img
						class="GroupBoxExpandButton"
						src="<%=SkinUtils.getImage(request,
										"groupbox_collapse.gif")%>"
						onclick="collapse(this)" /> </legend>
					<div>
						<form style="width: 95%; height: 100%;" class="L5form">
							<table  border="1" width="100%" >
								<tr >
									<td class="FieldLabel">编号:</td>
									<td class="FieldInput"><input type="text"  id="serialNumQuery" class="TextEditor" title="编号"  /></td>	
									<td class="FieldLabel">企业名称:</td>
									<td class="FieldInput"><input type="text"  id="companyNameQuery" class="TextEditor" title="企业名称"  /></td>	
									<td class="FieldLabel"><button onclick="query()">查 询</button></td>
								</tr>
								<tr>
									<td class="FieldLabel">法人代表:</td>
									<td class="FieldInput"><input type="text"  id="legalPeopleQuery" class="TextEditor" title="法人代表"  /></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>	
									<td class="FieldLabel"><button type="reset">重 置</button></td>
								</tr>
							</table>
						</form>
					</div>
		</fieldset>
		</next:Html>
	</next:Panel>
	
	<next:GridPanel id="editGridPanel" name="wealfitstatusGrid" width="98%" stripeRows="true" height="300" dataset="dsWin" autoScroll="true" title="企业列表">
		<next:TopBar>
			<next:ToolBarItem text="选择要填写证书的企业" ></next:ToolBarItem>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="save" handler="confirmWin"/>
			<next:ToolBarItem text="关闭" iconCls="return" handler="closeWin" />
		</next:TopBar>
		<next:Columns>
		    <next:RowNumberColumn width="30"/>
		    <next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="fitId" header="FIT_ID" field="fitId" width="90" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
		
			<next:Column id="taskCode" header="TASK_CODE" field="taskCode" width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="status" header="STATUS" field="status" width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="nextChagneCert" header="nextChagneCert" field="nextChagneCert " width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="applyYear" header="APPLY_YEAR" field="applyYear" width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="serialNumCol" header="编号" field="serialNum" width="150" >
				<next:TextField  />
			</next:Column>
		
			<next:Column id="companyNameCol" header="企业名称" field="companyName" width="150" >
				<next:TextField allowBlank="false" />
			</next:Column>
			
			<next:Column id="legalPeople" header="法人代表" field="legalPeople" width="90" >
				<next:TextField  />
			</next:Column>
			
			<next:Column id="address" header="注册地址" field="address" width="200" >
				<next:TextField  />
			</next:Column>
			
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="dsWin"/>
		</next:BottomBar>
	</next:GridPanel>
</next:Window>
<next:Window id="certTypeWin" closeAction="hide" title="选择证书类别" width="300"  modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="save" handler="confirmCertTypeWin"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeCertTypeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table>
				<tr>
					<td class="FieldLabel"><label>选择证件类型：</label></td>
					<td class="FieldInput"><select name="证件类型" id="certTypeSelect" >
						<option value='0' >正本</option>
						<option value='1' >副本</option>
					</select></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>
