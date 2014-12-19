<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>企业年检查询列表</title>
		<next:ScriptManager/>
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
		 	 
			//当前区划		
			var areaCode = '<%= BspUtil.getCorpOrgan().getOrganCode()%>';
			
			function init() {
				var year=new Date().getYear();
				document.getElementById("nextYear").value=year;
				ds.setParameter("WEAL_UNIT_STATUS.STATUS@=","1");//加载状态正常
				ds.setParameter("WEAL_UNIT_STATUS.MORG_AREA@=",areaCode);
				ds.setParameter("WEAL_UNIT_STATUS.NEXT_CHECK@=",year);
				ds.load();
			};
			function getParam(ElementId)
			{
				var value=document.getElementById(ElementId).value;
				if(value=="") value=undefined;
				return value;
			}
			function query(){
				if(document.getElementById("nextYear").value==""){
					L5.Msg.alert('提示',"请填写待换证年度!");
					return false;
				}
				ds.setParameter("WEAL_UNIT_STATUS.STATUS@=","1");//加载状态正常
				ds.setParameter("WEAL_UNIT_STATUS.SERIAL_NUM@=",getParam("serialNum"));		
				ds.setParameter("WEAL_UNIT_STATUS.COMPANY_NAME@like",getParam("companyName"));		
				ds.setParameter("WEAL_UNIT_STATUS.LEGAL_PEOPLE@like",getParam("legalPeople"));
				ds.setParameter("WEAL_UNIT_STATUS.NEXT_CHECK@=",getParam("nextYear"));		
				ds.setParameter("WEAL_UNIT_STATUS.MORG_AREA@=",areaCode);
				ds.load();
			}
			function insert(){
				var editGrid=L5.getCmp('editGridPanel');
				var selected=editGrid.getSelectionModel().getSelections();
				if(selected.length!=1){
					L5.Msg.alert('提示',"请选择一条记录进行年检数据填报!");
					return false;
				}
				var data = new L5.Map();
				data.put("method","INSERT");
				data.put("serialNum",selected[0].get('serialNum'));
				var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply1Add.jsp';
				var text = '年检信息采集';
				L5.forward(url,text,data);
			}
			function detail(){
				var editGrid=L5.getCmp('editGridPanel');
				var selected=editGrid.getSelectionModel().getSelections();
				if(selected.length!=1){
					L5.Msg.alert('提示',"请选择一条记录查看!");
					return false;
				}
				var win=L5.getCmp('win_detail');
				win.show();
				detailDs.setParameter("FIT_ID@=",selected[0].get('fitId'));
				detailDs.load();			
			}
			function closeWin(){
				var win=L5.getCmp('win_detail');
				win.hide();
			}
			function returnBack(){
				history.go(-1);
			}
			function queryPreYear(){
				if(document.getElementById("nextYear").value==""){
					L5.Msg.alert('提示',"请填写待换证年度!");
					return false;
				}
				document.getElementById("nextYear").value=getParam("nextYear")*1-1;
				ds.setParameter("WEAL_UNIT_STATUS.STATUS@=","1");//加载状态正常
				ds.setParameter("WEAL_UNIT_STATUS.SERIAL_NUM@=",getParam("serialNum"));		
				ds.setParameter("WEAL_UNIT_STATUS.COMPANY_NAME@=",getParam("companyName"));	
				ds.setParameter("WEAL_UNIT_STATUS.LEGAL_PEOPLE@=",getParam("legalPeople"));
				ds.setParameter("WEAL_UNIT_STATUS.NEXT_CHECK@=",getParam("nextYear"));		
				ds.setParameter("WEAL_UNIT_STATUS.MORG_AREA@=",areaCode);
				ds.load();
			}
			function queryNextYear(){
				if(document.getElementById("nextYear").value==""){
					L5.Msg.alert('提示',"请填写待换证年度!");
					return false;
				}
				document.getElementById("nextYear").value=getParam("nextYear")*1+1;
				ds.setParameter("WEAL_UNIT_STATUS.STATUS@=","1");//加载状态正常
				ds.setParameter("WEAL_UNIT_STATUS.SERIAL_NUM@=",getParam("serialNum"));		
				ds.setParameter("WEAL_UNIT_STATUS.COMPANY_NAME@=",getParam("companyName"));	
				ds.setParameter("WEAL_UNIT_STATUS.LEGAL_PEOPLE@=",getParam("legalPeople"));
				ds.setParameter("WEAL_UNIT_STATUS.NEXT_CHECK@=",getParam("nextYear"));		
				ds.setParameter("WEAL_UNIT_STATUS.MORG_AREA@=",areaCode);
				ds.load();
			}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
	</model:dataset>
	<model:dataset id="detailDs" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
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
								<td class="FieldLabel">编号:</td>
								<td class="FieldInput"><input type="text"  id="serialNum" class="TextEditor" title="编号"  /></td>	
								<td class="FieldLabel">企业名称:</td>
								<td class="FieldInput"><input type="text"  id="companyName" class="TextEditor" title="企业名称"  /></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button></td>
							</tr>
							<tr>
								<td class="FieldLabel">法人代表:</td>
								<td class="FieldInput"><input type="text"  id="legalPeople" class="TextEditor" title="法人代表"  /></td>
								<td class="FieldLabel">待年检年度</td>
								<td class="FieldInput"><input type="text"  id="nextYear" class="TextEditor" title="待年检年度"  /><font color="red">*</font>
								<a href="#"><label id="mylabel1" style="cursor: hand;"  onclick="queryPreYear()" />上一年度</label></a>&nbsp;&nbsp;
								<a href="#"><label id="mylabel2" style="cursor: hand;"  onclick="queryNextYear()" />下一年度</label></a></td>	
								<td class="FieldLabel"><button type="reset">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="wealunitstatusGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="企业年检查询列表">
	<next:TopBar>
		<next:ToolBarItem text="请选择一个需要年检的企业进行年检信息的填报" ></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="信息填报" iconCls="add" handler="insert" />
		<next:ToolBarItem text="查看详细" iconCls="detail" handler="detail"  />
		<next:ToolBarItem text="返回" iconCls="return" handler="returnBack"  />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="unitId" header="UNIT_ID" field="unitId" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="taskCode" header="TASK_CODE" field="taskCode" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="status" header="STATUS" field="status" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="applyYear" header="APPLY_YEAR" field="applyYear" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="serialNum" header="编号" field="serialNum" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="companyName" header="企业名称" field="companyName" width="150" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="legalPeople" header="法人代表" field="legalPeople" width="90" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="address" header="注册地址" field="address" width="200" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="nextCheck" header="待年检年度" field="nextCheck" width="90" >
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
<next:Window id="win_detail" title="企业详细信息"  width="800" height="400" closeAction="hide" modal="true">
	<next:Panel >
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="关闭窗口" handler="closeWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form id="editForm"   dataset="detailDs" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="1"  width="98%" >
		   		<tr>
					<td  class="FieldLabel" style="width:15%">企业名称</td>
					<td class="FieldInput" style="width:18%"><label field="companyName" /> </td>
				
					<td  class="FieldLabel" style="width:15%">下一次年检年度</td>
					<td class="FieldInput" style="width:18%"><label field="nextCheck" /> </td>
					
					<td  class="FieldLabel" style="width:15%">通讯地址</td>
					<td class="FieldInput" style="width:18%"><label field="address" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" style="width:15%">邮编</td>
					<td class="FieldInput" style="width:18%"><label field="postCode" /> </td>
				
					<td  class="FieldLabel" style="width:15%">经办人</td>
					<td class="FieldInput" style="width:18%"><label field="agentPeople" /> </td>
					
					<td  class="FieldLabel" style="width:15%">经办人联系电话</td>
					<td class="FieldInput" style="width:18%"><label field="agentPhone" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" style="width:15%">经办人邮箱</td>
					<td class="FieldInput" style="width:18%"><label field="agentEmail" /> </td>
							
					<td  class="FieldLabel" style="width:15%">网站地址</td>
					<td class="FieldInput" style="width:18%"><label field="webAddress" /> </td>
					
					<td  class="FieldLabel" style="width:15%">经济性质（代码）</td>
					<td class="FieldInput" style="width:18%"><label field="economicNatureCode" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" style="width:15%">经济性质（名称）</td>
					<td class="FieldInput" style="width:18%"><label field="economicNatureName" /> </td>
				
					<td  class="FieldLabel" style="width:15%">组织机构代码</td>
					<td class="FieldInput" style="width:18%"><label field="organCode" /> </td>
				
					<td  class="FieldLabel" style="width:15%">营业执照编号</td>
					<td class="FieldInput" style="width:18%"><label field="licenseCode" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" style="width:15%">税务登记编号</td>
					<td class="FieldInput" style="width:18%"><label field="registrationCode" /> </td>
					
					<td class="FieldLabel" style="width:18%"><label  /> </td>
					<td class="FieldInput" style="width:18%"><label  /> </td>
					<td class="FieldLabel" style="width:18%"><label  /> </td>
					<td class="FieldInput" style="width:18%"><label  /> </td>
				
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%">经营范围-主管</td>
					<td class="FieldInput" style="width:18%"><label field="firstScope" /> </td>
					
					<td  class="FieldLabel" style="width:15%">经营范围-兼营</td>
					<td class="FieldInput" style="width:18%"><label field="secondScope" /> </td>
					
					<td  class="FieldLabel" style="width:15%">注册资金(万元)</td>
					<td class="FieldInput" style="width:18%"><label field="regFund" /> </td>
				</tr>
				
				<tr>
					<td  class="FieldLabel" style="width:15%">申请理由</td>
					<td class="FieldInput" style="width:18%"><label field="reason" /> </td>
					
					<td  class="FieldLabel" style="width:15%">批准时间</td>
					<td class="FieldInput" style="width:18%"><label field="approveDate" /> </td>
					
					<td  class="FieldLabel" style="width:15%">发证机关</td>
					<td class="FieldInput" style="width:18%"><label field="issuelOrgan" /> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%">发证日期</td>
					<td class="FieldInput" style="width:18%"><label field="issuelDate" /> </td>
					
					<td  class="FieldLabel" style="width:15%">登记管理机关名称</td>
					<td class="FieldInput" style="width:18%"><label field="morgName" /> </td>
					
					<td  class="FieldLabel" style="width:15%">等级管理机关行政区划</td>
					<td class="FieldInput" style="width:18%"><label field="morgArea" /> </td>
				</tr>
			</table>
			</form>
	   </next:Html>
	</next:Panel>
</next:Window>
</body>
</html>
