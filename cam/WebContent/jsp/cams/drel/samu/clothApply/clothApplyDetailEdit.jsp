
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>服装发放</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="clothApplyDetailEdit.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
        <script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
	        var organId = '<%=BspUtil.getCorpOrganId()%>';
		    var applyType='<%=request.getParameter("applyType")%>';	 
		    var gerocomiumId='<%=request.getParameter("GEROCOMIUM_ID")%>';	
		    var clothDate='<%=request.getParameter("CLOTH_DATE")%>';	
		    var clothType='<%=request.getParameter("CLOTH_TYPE")%>';
		    var clothNum='<%=request.getParameter("CLOTH_NUM")%>';	
		     
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';   
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
     
	<!--零花钱发放确认状态 -->
	<model:dataset id="pocketStatusDS" enumName="SAM_POCKET_STATUS" autoLoad="true" global="true"></model:dataset>
	
    <model:dataset id="samGeroKeptPersonDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonQueryCmd"method="queryInsertPerson" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroKeptPerson"/>
	</model:dataset> 
	<!-- 业务信息表 -->
	<model:dataset id="pocketApplyDetailDs" cmd="com.inspur.cams.drel.samu.cmd.SamGeroApplyQueryCmd" method="queryClothDetail" global="true">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroApply">
			<model:field name="PERSON_NAME"/>
			<model:field name="PERSON_ID"/>
			<model:field name="APPLY_ID"/>
			<model:field name="ID_CARD"/>
			<model:field name="GEROCOMIUM_ID"/>
			<model:field name="IN_ROOM"/>
			<model:field name="IN_BED"/>
			<model:field name="CLOTH_DATE"/>
			<model:field name="CLOTH_NUM"/>
			<model:field name="CLOTH_TYPE"/>
		</model:record>
	</model:dataset>
   	<!-- 业务信息表 -->
	<model:dataset id="pocketApplyDs" cmd="com.inspur.cams.drel.samu.cmd.SamGeroApplyQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroApply"></model:record>
	</model:dataset>
</model:datasets>  
<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
		<fieldset>
			<legend>查询条件
				<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" />
			</legend>
			<div>
				<form class="L5form" id="queryForm">
					<table width="100%" >
					    <tr>
					        <td class="FieldLabel" nowrap="nowrap" width="18%">姓名</td>
					        <td class="FieldInput" width="15%">
					        	<input type="text" name="personName" id="personNameQuery" style="width:80%"/>
					        </td>
					        <td class="FieldLabel" nowrap="nowrap" width="18%">身份证号码</td>
					        <td class="FieldInput" width="15%">
					        	<input type="text" name="idCard" id="idCardQuery" style="width:80%"/>
					        </td>
					        <td class="FieldButton" width="8%">
								<button onclick="query()" id="queryBtn">查 询</button>
							</td>
					        
					    </tr>
					    <tr>
					     	<td class="FieldLabel" nowrap="nowrap" width="18%">房间</td>
					        <td class="FieldInput" width="15%">
					        	<input type="text" name="inRoom" id="inRoomQuery" style="width:80%"/>
					        </td>
					         <td class="FieldLabel" nowrap="nowrap" width="18%">床位</td>
					        <td class="FieldInput" width="15%">
					        	<input type="text" name="inBed" id="inBedQuery" style="width:80%"/>
					        </td>
					    	<td nowrap="nowrap" class="FieldButton" width="8%">
								<button type="reset">重 置</button>
						    </td>
					     </tr>
					</table>
				</form>
			</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="editGridPanel" name="samreleasedetailGrid" width="100%" stripeRows="true" height="400"  
	notSelectFirstRow="true" clickToSelectedForChkSM="true" dataset="pocketApplyDetailDs">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="add" text="增加" handler="insert"/>
        <next:ToolBarItem iconCls="save" text="确定" handler="conf"/>
        <next:ToolBarItem iconCls="disable" text="返回" handler="returnBack"/>
        <next:ToolBarItem iconCls="remove" text="删除" handler="delPocketDetail" id="delButton"/>
    </next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
       
		<next:Column id="personName" header="姓名" field="PERSON_NAME" width="90"   align="center">
			
		</next:Column>
		<next:Column id="idCard" header="身份证号码" field="ID_CARD" width="150"  align="center" >
			
		</next:Column>
		<next:Column id="inRoom" header="房间" field="IN_ROOM" width="90"  align="right">
			
		</next:Column>
        <next:Column id="inBed" header="床位" field="IN_BED" width="90"  align="right">
           
        </next:Column>
        <next:Column id="clothDate" header="发放时间" field="CLOTH_DATE" width="90"   align="right">
        </next:Column>
		<next:Column id="clothNum" header="发放套数(套)" field="CLOTH_NUM" width="90"    align="right">
            <next:NumberField></next:NumberField>
        </next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="pocketApplyDetailDs"/>
	</next:BottomBar>
	
</next:EditGridPanel>
</body>

<next:Window id="applyDetailWin" title="增加发放人员信息" closeAction="hide"  width="740" modal="true">
    <next:EditGridPanel id="insertDetail" width="100%" stripeRows="true" height="400"  
	notSelectFirstRow="true" clickToSelectedForChkSM="true" dataset="samGeroKeptPersonDataSet">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="save" text="确定" handler="saveInsert" ></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" text="关闭" handler="closeInsertWin"></next:ToolBarItem>
    </next:TopBar>
    <next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
       
		<next:Column header="姓名" field="PERSON_NAME" width="90"   align="center">
			
		</next:Column>
		<next:Column  header="身份证号码" field="ID_CARD" width="150"  align="center" >
			
		</next:Column>
		<next:Column header="房间" field="IN_ROOM" width="90"  align="right">
			
		</next:Column>
        <next:Column header="床位" field="IN_BED" width="90"   align="right">
           
        </next:Column>
       
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samGeroKeptPersonDataSet" />
	</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</html>
