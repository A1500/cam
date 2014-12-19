<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>选择经济核对范围</title>
		<script type="text/javascript">
			var jtids='<%=request.getParameter("id")%>';
		</script>
		<next:ScriptManager/>
		<script type="text/javascript" src="esurveyInfoCheckIssue.js"></script>
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
		</script>
	</head>
<body>
<model:datasets>
</model:datasets>

<next:Panel id="mainPanel" name="mainPanel" height="100%" bodyStyle="padding:0px">
	<next:Defaults>
		{bodyStyle:'padding:0px;'}
	</next:Defaults>

	<next:ColumnLayout>
		<next:Panel width="380" height="100%" title="->  已选择家庭的基本信息">
			<next:GridPanel id="sbjtxxGridPanel" name="sbjtxxGridPanel" width="100%" height="79%" notSelectFirstRow="true" 
				stripeRows="true" dataset="declareFamilyInfoDataset">	
				
				<next:TopBar>
					<next:ToolBarItem text="家庭基本信息列表:"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="详细"/>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
					<next:ToolBarItem symbol="-"></next:ToolBarItem>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
				</next:TopBar>
				
				<next:Columns>
				    <next:RowNumberColumn width="20"/>
					
					<next:Column id="hzxm" header="户主姓名"  field="hzxm" width="60">
						<next:TextField  />
					</next:Column>
					<next:Column id="jtrksl" header="家庭人口数量"  field="jtrksl"  width="80" >
						<next:TextField  />
					</next:Column>
					<next:Column id="jtxz" header="家庭性质"  field="jtxz" width="60" >
						<next:TextField  />
					</next:Column>
					<next:Column id="jzlx" header="救助类型"  field="jzlx" width="60">
						<next:TextField  />
					</next:Column>
					<next:Column id="hjxzqh" header="户籍行政区划"  field="hjxzqh"  width="85">
						<next:TextField  />
					</next:Column>
				</next:Columns>
			</next:GridPanel>
			
			<next:Panel width="100%" height="100%">
				<next:Html>
					<span id="jtxxDetails"></span>
				</next:Html>
			</next:Panel>
		</next:Panel>
		
		<next:Panel columnWidth="1" height="100%" title="家庭成员经济核对">
			<next:EditGridPanel id="jtcyxxGridPanel" name="jtcyxxGridPanel" width="100%" height="100%" notSelectFirstRow="true" 
				stripeRows="true" autoScroll="true" dataset="declareFamilyMemberInfoDataset"
				title="->  您的位置 : 根据家庭成员选择经济核对单位">	
				
				<next:TopBar>
					<next:ToolBarItem text="家庭成员基本信息列表:"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="详细"/>
					<next:ToolBarItem iconCls="save" text="进行核对分发" handler="checkIssue"/>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
					<next:ToolBarItem symbol="-"></next:ToolBarItem>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
				</next:TopBar>
				
				<next:Columns>
				    <next:RowNumberColumn width="20" locked="true"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
		
					<next:Column id="hzxm" header="户主姓名"  field="hzxm" width="60" editable="false" locked="true">
						<next:TextField />
					</next:Column>
					<next:Column id="cyxm" header="成员姓名"  field="cyxm" width="60" editable="false" locked="true">
						<next:TextField />
					</next:Column>
					<next:Column id="hzgx" header="户主关系"  field="hzgx" width="60" editable="false" locked="true">
						<next:TextField />
					</next:Column>
					<next:Column header="人力资源和社会保障" field="deptRlText" width="130">
						<next:TriggerField id="select_dept_rl" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_rl" readOnly="true" />
					</next:Column>
					<next:Column header="房管" field="deptFgText" width="115">
						<next:TriggerField id="select_dept_fg" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_fg" readOnly="true" />
					</next:Column>
					<next:Column header="工商" field="deptGsText" width="115">
						<next:TriggerField id="select_dept_gs" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_gs" readOnly="true" />
					</next:Column>
					<next:Column header="公安（车管）" field="deptGaText" width="115">
						<next:TriggerField id="select_dept_ga" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_ga" readOnly="true" />
					</next:Column>
					<next:Column header="国税" field="deptGshText" width="115">
						<next:TriggerField id="select_dept_gsh" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_gsh" readOnly="true" />
					</next:Column>
					<next:Column header="地税" field="deptDsText" width="115">
						<next:TriggerField id="select_dept_ds" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_ds" readOnly="true" />
					</next:Column>
					<next:Column header="公积金" field="deptGjjText" width="115">
						<next:TriggerField id="select_dept_gjj" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_gjj" readOnly="true" />
					</next:Column>
					<next:Column header="人民银行" field="deptRmyhText" width="115">
						<next:TriggerField id="select_dept_rmyh" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_rmyh" readOnly="true" />
					</next:Column>
					<next:Column header="证监" field="deptZjText" width="115">
						<next:TriggerField id="select_dept_zj" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_zj" readOnly="true" />
					</next:Column>
					<next:Column header="保监" field="deptBjText" width="115">
						<next:TriggerField id="select_dept_bj" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onSelect_dept_bj" readOnly="true" />
					</next:Column>
				</next:Columns>
				
			</next:EditGridPanel>
		</next:Panel>
	</next:ColumnLayout>
</next:Panel>

<next:Panel id="subPanel" name="subPanel" height="100%" hidden="true" title="申报家庭成员经济核对详细情况">
	<next:Html>
		<table dataset="declareFamilyMemberInfoDataset" style="border-collapse:collapse;font-size: 13px;" bgColor="#DAE9F3" 
			width="100%" border="1"   >
			<tr height="50">
                <td rowspan="2" align="center" style="font-size: 15px;" width="80px">
                    户主姓名
                </td>
                <td rowspan="2" align="center" style="font-size: 15px;" width="80px">
                    成员姓名
                </td>
                <td rowspan="2" align="center" style="font-size: 15px;" width="80px">
                    户主关系
                </td>
                <td colspan="10" align="center" style="font-size: 15px;">
                    外部核对单位
                </td>
            </tr>
            <tr height="50">
                <td align="center" style="font-size: 14px;">
           		  人力资源和社会保障
                </td>
                <td align="center" style="font-size: 14px;">
           		  房管
                </td>
                <td align="center" style="font-size: 14px;">
           		  工商
                </td>
                <td align="center" style="font-size: 14px;">
           		  公安（车管）
                </td>
                <td align="center" style="font-size: 14px;">
           		  国税
                </td>
                <td align="center" style="font-size: 14px;">
           		  地税
                </td>
                <td align="center" style="font-size: 14px;">
           		  公积金
                </td>
                <td align="center" style="font-size: 14px;">
           		  人民银行
                </td>
                <td align="center" style="font-size: 14px;">
           		  证监
                </td>
                <td align="center" style="font-size: 14px;">
           		  保监
                </td>
            </tr>
            
            <tr repeat="true" align="center" bgcolor="FFFFFF" height="30">
              	<td align="center">
              		<label type="text" field="hzxm" style="font-weight: bold;"/>
              	</td>
              	<td align="center">
              		<label type="text" field="cyxm"/>
              	</td>
              	<td align="center">
              		<label type="text" field="hzgx"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptRlText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptFgText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptGsText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptGaText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptGshText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptDsText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptGjjText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptRmyhText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptZjText"/>
              	</td>
              	<td align="center">
              		<label type="text" field="deptBjText"/>
              	</td>
            </tr>
		</table>
	</next:Html>
	<next:Buttons>
		<next:ToolButton text="完成并返回" handler="returnQuery"></next:ToolButton>
	</next:Buttons>
</next:Panel>

</body>
</html>

<!--选择人力-->
<next:GridHelpWindow id="help_select_rl" dataset="dicRlDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择房管-->
<next:GridHelpWindow id="help_select_fg" dataset="dicFgDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择工商-->
<next:GridHelpWindow id="help_select_gs" dataset="dicGsDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择公安-->
<next:GridHelpWindow id="help_select_ga" dataset="dicGaDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择国税-->
<next:GridHelpWindow id="help_select_gsh" dataset="dicGshDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择地税-->
<next:GridHelpWindow id="help_select_ds" dataset="dicDsDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择公积金-->
<next:GridHelpWindow id="help_select_gjj" dataset="dicGjjDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择人民银行-->
<next:GridHelpWindow id="help_select_rmyh" dataset="dicRmyhDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择证监-->
<next:GridHelpWindow id="help_select_zj" dataset="dicZjDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>

<!--选择保监-->
<next:GridHelpWindow id="help_select_bj" dataset="dicBjDs">
	<next:GridHelpColumns>
		<next:GridHelpColumn header="单位代码" sortable="true" field="value" />
		<next:GridHelpColumn header="单位名称" sortable="true" field="text" />
	</next:GridHelpColumns>
	
	<next:TextHelpField>
		<next:QueryHelpField header="单位代码" field="value"></next:QueryHelpField>
		<next:QueryHelpField header="单位名称" field="text"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>
