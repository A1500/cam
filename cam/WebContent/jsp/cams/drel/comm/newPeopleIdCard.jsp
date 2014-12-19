<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>	
<!--生成身份代码-->
<next:Window id="newIdCardWin" closeAction="hide" title="生成身份代码" width="550" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmNewIdCardWin"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeNewIdCardWin"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%">姓名</td>
					<td class="FieldInput" style="width:30%">
						<input id="name_new" title='姓名' name='姓名' style="width:90%" maxlength="25"/>
					</td>
					<td class="FieldLabel" style="width:20%">性别</td>
					<td class="FieldInput" style="width:30%">
						<select id="sex_new" title='性别' name='性别' style="width:90%" >
							<option dataset='sexDataset'></option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:20%">出生日期</td>
					<td class="FieldInput" style="width:30%">
						<input id="birthday_new" title='出生日期' name='出生日期' style="width:90%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" />
					</td>
					<td class="FieldLabel" style="width:20%"></td>
					<td class="FieldInput" style="width:30%"></td>
				</tr>
			</table>
		</form>
   </next:Html>
</next:Window>		
<script type="text/javascript">
//生成身份代码
function newIdCard(){
	var win=L5.getCmp("newIdCardWin");
	win.show();
	$('name_new').value=baseinfoPeopleDataSet.get('name');
	$('sex_new').value='';	
	$('birthday_new').value='';
}
//确定
function confirmNewIdCardWin(){
	var peopleName=_$('name_new');
	var peopleSex=_$('sex_new');
	var peopleBirthday=_$('birthday_new');
	if(peopleName==''||peopleSex==''||peopleBirthday==''){
		L5.Msg.alert("提示","请输入完整的身份信息！");
		return;
	}
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamIdCardCmd");
	command.setParameter("sex",peopleSex);
	command.setParameter("birthday",peopleBirthday.substring(0,4)+peopleBirthday.substring(5,7)+peopleBirthday.substring(8));
	command.execute("getIdCard");
	var idCard=command.getReturn("idCard");
	if (!command.error) {
		L5.Msg.alert("提示","生成身份代码成功！",function(){
			var win = L5.getCmp("newIdCardWin");
			win.hide();
			baseinfoPeopleDataSet.set('name',peopleName);
			baseinfoPeopleDataSet.set('idCard',idCard);
			baseinfoPeopleDataSet.set('sex',peopleSex);
			baseinfoPeopleDataSet.set('birthday',peopleBirthday);
			$("age").innerHTML=getAgeByCode(idCard);
		});		
	}else{
		L5.Msg.alert('提示',"生成身份代码时出现错误！"+command.error);
	}
}
//关闭
function closeNewIdCardWin(){
	baseinfoPeopleDataSet.set('idCard','');
	var win = L5.getCmp("newIdCardWin");
	win.hide();
}
</script>