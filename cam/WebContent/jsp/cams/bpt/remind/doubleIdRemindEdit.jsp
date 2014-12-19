<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>人员状态认证</title>
<next:ScriptManager />
<script type="text/javascript">

	var peopleId="<%=request.getParameter("peopleId")%>";
	var username="<%=request.getParameter("username")%>";
	var idCard="<%=request.getParameter("idCard")%>";
	var objectState="2";
	var objectTypes="<%=request.getParameter("objectTypes")%>";
	function init() {
		
	}
	function sure(){
		L5.MessageBox.confirm('确定', '确定要保持此人员状态并不再提示吗?', function(state) {
			if (state == "yes") {
				var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptNotRemindCommand");
				command.setParameter("peopleId", peopleId);
				command.execute("insertRemindDP");
				if (!command.error) {
					//L5.Msg.alert('提示','保存成功！');
					window.close();
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			} else {
					return false;
			}
		});
	}
	function changeRemind() {
		var remind = document.getElementById("remind").value;
		
		var otypef = document.getElementById("otypef");
		var otypes = document.getElementById("otypes");
		
		var surebut = document.getElementById("surebut");
		var compbut = document.getElementById("completeRemind");
		
		if(remind==0){
			otypef.style.display='';
			otypes.style.display='';
			surebut.style.display='none';
			compbut.style.display='';
			var type = document.getElementById("objectType");
			document.getElementById("objectType").options.length=0;
			document.getElementById("objectType").options.add(new Option("请选择...",""));
			var ots = objectTypes.split(",");
			for(var i=0;i<ots.length;i++) {
				switch (ots[i]){
					case "11" :
						document.getElementById("objectType").options.add(new Option("伤残人员","11")); 
						break;
					case "21":
						document.getElementById("objectType").options.add(new Option("三属人员","21")); 
						break;
					case "41":
						document.getElementById("objectType").options.add(new Option("在乡复员军人","41")); 
						break;
					case "42":
						document.getElementById("objectType").options.add(new Option("带病回乡军人","42")); 
						break;
					case "51":
						document.getElementById("objectType").options.add(new Option("参试人员","51")); 
						break;
					case "61":
						document.getElementById("objectType").options.add(new Option("参战人员","61")); 		
						break;
					case "81":
						document.getElementById("objectType").options.add(new Option("60岁老兵","81")); 
						break;
					case "B1":
						document.getElementById("objectType").options.add(new Option("老烈子女","B1")); 
						break;
				}	
					
			}
		}else if(remind==1){
			otypef.style.display='none';
			otypes.style.display='none';
			surebut.style.display='';
			compbut.style.display='none';
			L5.getCmp("stateChangeTabPanel").hide();
		}
		
	}
	function changeObject() {
		var  objectType =document.getElementById("objectType").value;
		if(objectType==''){
			L5.getCmp("stateChangeTabPanel").hide();
			return ;
		}
		L5.getCmp("stateChangeTabPanel").show();
		var url = '../peopleBasicInfo/stateChangeInsert.jsp?peopleId='+peopleId+'&username='+username+'&idCard='+idCard+'&objectState=2&objectType='+objectType;
		document.getElementById("instance").src=url;
		
	}
	/* function window.onbeforeunload() { 
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptNotRemindCommand");
		command.setParameter("peopleId", peopleId);
		command.execute("queryIsDP");
		var num = command.getReturn("num");
		if(num==0){
			return ;
		}
		if (!confirm('此人员还是双重身份待遇,是否下次继续提示认证?\r\r确认:继续提示认证\r\r取消:不再提示认证')) {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptNotRemindCommand");
			command.setParameter("peopleId", peopleId);
			command.execute("changeRemindDP");
		}
	}  */
	function completeRemind(){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptNotRemindCommand");
		command.setParameter("peopleId", peopleId);
		command.execute("queryIsDP");
		var num = command.getReturn("num");
		if(num==0){
			window.close();
			return ;
		}
		if (!confirm('此人员还享受双重身份待遇,是否完成认证?\r\r确定:结束认证并不再提示\r\r取消:继续认证')) {
			window.close();
			return ;
		}else{
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptNotRemindCommand");
			command.setParameter("peopleId", peopleId);
			command.execute("changeRemindDP");
			
		}
	}
	
</script>

</head>
<body >
<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
	<next:Html>			
	<fieldset style="overflow: visible;" class="GroupBox">
		<div class="GroupBoxDiv" style="width: 100%;height: 100%;margin-top:10px;" >	
			<form onsubmit="return false;" class="L5form">				
				<table  border="1" width="100%">
					<TR>
						<td class="FieldLabel" width="18%" >是否保持此人的双重身份待遇并不再提示认证：</td>
		                 <td class="FieldInput"><select  id="remind"  title="业务类型"  onchange="changeRemind()">
		                 	<option value='1'>是</option>
		                 	<option value='0'>否</option>
		                 </select>
		                 </td>
			            <td class="FieldLabel" width="20%" nowrap="nowrap" id="otypef" style="display:none">请选择需要修改状态的人员类别：</td>
						<td class="FieldInput"  id="otypes" style="display:none">
							<select id="objectType" style="width:180px;" onchange="changeObject()">
						   		
   							</select>
				 		</td>
						<td class="FieldButton" width="15%" id="surebut">
						<button id="queryButton" onclick="sure()">确定</button>
						</td>
						</td>
						<td class="FieldButton" width="15%" id="completeRemind" style="display:none">
						<button id="queryButton" onclick="completeRemind()">完成认证</button>
						</td>
					</tr>
				</table>
			</form>		
		</div>
	</fieldset>
	</next:Html>
</next:Panel>		

<next:Panel autoHeight="true" autoWidth="true" autoScroll="false" hidden="true"
	id="stateChangeTabPanel">
	<next:Html>
		<iframe id="instance" src="../peopleBasicInfo/stateChangeInsert.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>
		&idCard=<%=request.getParameter("idCard")%>&objectState=<%=request.getParameter("objectState")%>&objectType=<%=request.getParameter("objectType")%>"
			frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
		</iframe>
	</next:Html>
</next:Panel>
</body>
</html>
