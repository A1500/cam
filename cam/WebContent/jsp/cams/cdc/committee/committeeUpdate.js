function init(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	ds.setParameter("USER_ID@=", userId);
	ds.load();
	ds.on('load',function(){
		$("repwd").value=$("pwd").value;
	});
}
function save(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	var comExtUser=ds.getCurrent();
	comExtUser.set("areaCode",_$("userId"));
	comExtUser.set("areaName",_$("userName"));
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
	command.setParameter("comExtUser", comExtUser);
	command.execute("update");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！");
		var url="jsp/cams/cdc/committee/committeeDetail.jsp?userId="+ds.getCurrent().get("userId");
		L5.forward(url);
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}