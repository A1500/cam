
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>企业证书列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="fitCertManagerList.js"></script>
		<script language="javascript">
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
		</script>
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
	<!-- 证件信息 -->
	<model:dataset id="certDs" cmd="com.inspur.cams.welfare.base.cmd.WealCertQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealCert"></model:record>
	</model:dataset>
	<!-- 注销win dataset-->
	<model:dataset id="cancelDs" cmd="com.inspur.cams.welfare.base.cmd.WealCertQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealCert">
			<model:field name="cancelReason" type="string" rule="require" />	
			<model:field name="cancelPeople" type="string" rule="require" />
			<model:field name="cancelTime" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldLabel" style="width: 15%">编号:</td>
								<td class="FieldInput" style="width: 18%"><input type="text" style="width: 80%;" id="serialNumQuery" class="TextEditor" title="编号"  /></td>	
								<td class="FieldLabel" style="width: 15%">企业名称:</td>
								<td class="FieldInput" style="width: 18%"><input type="text" style="width: 80%;" id="companyNameQuery" class="TextEditor" title="企业名称"  /></td>	
								<td class="FieldLabel" style="width: 15%">法人代表:</td>
								<td class="FieldInput" style="width: 18%"><input type="text" style="width: 80%;" id="legalPeopleQuery" class="TextEditor" title="法人代表"  /></td>	
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">业务类型:</td>
								<td class="FieldInput" style="width: 18%"><select id="certTypeQuery" style="width: 80%;" title="业务类型" >
									<option dataset="certTypeDs"></option>
								</select></td>	
								<td class="FieldLabel" style="width: 15%">证件状态:</td>
								<td class="FieldInput" style="width: 18%"><select id="certStatusQuery" style="width: 80%;" title="证件状态">
									<option dataset="certStatusDs"></option>
								</select></td>	
								<td class="FieldLabel"></td>
								<td class="FieldInput"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="wealcertGrid" stripeRows="true" width="100%" height="100%" dataset="ds" title="企业证书列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="收缴注销" iconCls="disable" handler="cancelCert" />
		<next:ToolBarItem text="补录证书信息" iconCls="add" handler="addCert" />
		<next:ToolBarItem text="修改证书信息" iconCls="edit" handler="editCert"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="delCert"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="taskCode" header="TASK_CODE" field="taskCode" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="companyType" header="COMPANY_TYPE" field="companyType" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="fitId" header="假矫ID" field="fitId" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="serialNum" header="编号" field="serialNum" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="companyName" header="企业名称" field="companyName" width="160" renderer="detailHref">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="certStatus" header="证件状态" field="certStatus" width="90" dataset="certStatusDs">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="certType" header="业务类型" field="certType" width="90" dataset="certTypeDs">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="startDate" header="有效期始" field="startDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="endDate" header="有效期止" field="endDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="issuerPeople" header="发证人" field="issuerPeople" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="licensePeople" header="领证人" field="licensePeople" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="signOrgan" header="发证机关" field="signOrgan" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="signDate" header="发证日期" field="signDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="legalPeople" header="法人代表" field="legalPeople" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="organType" header="单位性质" field="organType" width="90" dataset="ecoDataSet">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="businessScope" header="经营范围" field="businessScope" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="siteArea" header="场地面积" field="siteArea" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="companyAddress" header="单位地址" field="companyAddress" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="morgName" header="登记管理机关名称" field="morgName" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="morgArea" header="登记管理机关行政区划" field="morgArea" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="cancelPeople" header="注销人" field="cancelPeople" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="cancelTime" header="注销时间" field="cancelTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="cancelReason" header="注销原因" field="cancelReason" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approveDate" header="认定时间" field="approveDate" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
<%-- 证书详细信息 --%>
<next:Window id="Cert" closeAction="hide" title="证书详细信息" width="700"
	height="480"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="假矫装配企业证书明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="重新打印证书" iconCls="add" handler="rePrint"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closewin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="certDs" onsubmit="return false"  class="L5form">
		<fieldset>
		<legend>基本信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
	   			<td  class="FieldLabel" style="width: 15%">企业名称:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="companyName"  title="企业名称"  field="companyName" style="width:98%" /></td>
	   			
				<td  class="FieldLabel" style="width: 15%">编号:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="serialNum"  title="编号"  field="serialNum" style="width:98%" /></td>  
				 
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" style="width: 15%">单位性质:</td>
				<td class="FieldInput"  style="width: 18%">
				<label id="organType" field="organType" title="单位性质" style="width:98%" dataset="ecoDataSet"></label></td> 
				
				<td  class="FieldLabel" style="width: 15%">法人代表:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="legalPeople"  title="法人代表"  field="legalPeople" style="width:98%" /> </td>
				
				<td  class="FieldLabel" style="width: 15%">认定日期:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="approveDate"  title="认定日期"  field="approveDate" style="width:98%" /> </td>
			</tr>
	   		<tr>	
				<td  class="FieldLabel" style="width: 15%">经营范围:</td>
				<td class="FieldInput"  style="width: 18%" colspan="5"><textarea rows="5"  cols="150" type="text" name="businessScope"  title="经营范围"  field="businessScope" disabled style="height: 50px; overflow-y: visible;"></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">场地面积:</td>
				<td class="FieldInput"><label type="text" name="siteArea"  title="场地面积"  field="siteArea" style="width:98%" /> </td>
				
				<td  class="FieldLabel" style="width: 15%">单位地址:</td>
				<td class="FieldInput"  style="width: 18%" colspan="3"><label type="text" name="companyAddress"  title="COMPANY_ADDRESS"  field="companyAddress"  style="width:98%"/> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">业务类型:</td>
				<td class="FieldInput"  style="width: 18%">
				<label id="certType" field="certType" title="业务类型" style="width:98%" dataset="certTypeDs"></label></td> 
				
				<td  class="FieldLabel" style="width: 15%">证件状态:</td>
				<td class="FieldInput"  style="width: 18%">
				<label id="certStatus" field="certStatus" title="证件状态" style="width:98%" dataset="certStatusDs"></label></td> 
				
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">有效期始:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="startDate"  title="有效期始"  field="startDate" style="width:98%" readonly="readonly" format="Y-m-d" onblur="setEndDate(this.value)" onclick="WdatePicker()"/> </td>
			
				<td  class="FieldLabel" style="width: 15%">有效期止:</td>
				<td class="FieldInput"><label type="text" name="endDate"  title="有效期止"  field="endDate"  style="width:98%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/> </td>
			
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">发证机关:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="signOrgan"  title="发证机关"  field="signOrgan" style="width:98%" /> </td>
			
				<td  class="FieldLabel" style="width: 15%">发证日期:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="signDate"  title="发证日期"  field="signDate" style="width:98%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/></td> 
			
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width: 15%">发证人:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="issuerPeople"  title="发证人"  field="issuerPeople" style="width:98%" /></td> 

				<td  class="FieldLabel" style="width: 15%">领证人:</td>
				<td class="FieldInput"  style="width: 18%"><label type="text" name="licensePeople"  title="领证人"  field="licensePeople" style="width:98%" /> </td>
			
				<td  class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput"  style="width: 18%"></td>
			</tr>
	   		
		</table>
		</fieldset>
		<fieldset id="cancelInfo" style="display:none;">
		<legend>收缴注销信息</legend>
			<table border="1"  width="100%">
		   		<tr>
		   			<td  class="FieldLabel" style="width: 15%">注销原因:</td>
					<td class="FieldInput"  style="width: 18%" colspan="3"><label type="text" name="cancelReason"  title="注销原因"  field="cancelReason" style="width:98%" /> </td>
					<td  class="FieldLabel" style="width: 15%"></td>
					<td class="FieldInput"  style="width: 18%"></td>
				</tr>
				<tr>	
					<td  class="FieldLabel" style="width: 15%">注销人:</td>
					<td class="FieldInput"  style="width: 18%"><label type="text" name="cancelPeople"  title="注销人"  field="cancelPeople"  style="width:98%"/> </td>
				
					<td  class="FieldLabel" style="width: 15%">注销日期:</td>
					<td class="FieldInput"  style="width: 18%"><label type="text" name="cancelTime"  title="注销日期"  field="cancelTime"  style="width:98%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/> </td>
					
					<td  class="FieldLabel" style="width: 15%"></td>
					<td class="FieldInput"  style="width: 18%"></td>
				</tr>
			</table>
		</fieldset>
		</form>
   </next:Html>
</next:Window>
<next:Window id="certTypeWin" closeAction="hide" title="选择证书类别" width="300"  modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="save" handler="confirmReCertTypeWin"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeReCertTypeWin"></next:ToolBarItem>
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
<next:Window id="cancelCertWin" closeAction="hide" title="收缴注销证书原因" width="480"  modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="save" handler="confirmCancelWin"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeCancelWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="cancelDs">
			<table>
				<tr>
					<td class="FieldLabel" style="width: 15%"><label>注销原因：</label></td>
					<td class="FieldInput" style="width: 18%" colspan="3"><textarea rows="5" type="text" name="cancelReason"  title="注销原因"  field="cancelReason" style="height: 50px;width:93%; overflow-y: visible;"></textarea><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%"><label>注销人：</label></td>
					<td class="FieldInput" style="width: 18%"><input type="text" name="cancelPeople"  title="注销人"  field="cancelPeople"  style="width:93%"/><font color="red">*</font></td>
					<td class="FieldLabel" style="width: 15%"><label>注销日期：</label></td>
					<td class="FieldInput" style="width: 18%"><input type="text" name="cancelTime"  title="注销日期"  field="cancelTime"  style="width:93%" readonly="readonly" format="Y-m-d" onclick="WdatePicker()"/><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>
				