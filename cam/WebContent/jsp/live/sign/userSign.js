/**
 * 初始化
 * @return
 */
function init() {
	var child=L5.getCmp('sysPanel');
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("SYS_SIGN","0");
	ds.load(true);
	if(ds.getCount()==0)
		ds.newRecord();
	//L5.QuickTips.init();//?
	}
/**
 * 点击保存按钮时触发，执行保存操作
 * @return
 */
function clickSave(){
	 var i=0;	
	 var osSign=document.getElementById("usSign");
	 var ofSign=document.getElementById("ufSign");
	 var ostat=document.getElementById("statselect");
	 var sSign=osSign.value;//获取input中的值
	 var fSign=ofSign.value;	
	 var stat=ostat.value;
	 if(!afterWarn(osSign)){	
		 document.getElementById(osSign.id+"test").innerHTML="必填项";
		 i=i+1;
	 }else{
		 i=i;
	 }
    if(!afterWarn(ofSign)){ 
   	 document.getElementById(ofSign.id+"test").innerHTML="必填项"; 
   	 i=i+1;
	 }else{
		 i=i;
	 }
    if(!afterWarn(ostat)){    	
   	 document.getElementById(ostat.id+"test").innerHTML="必填项";
   	 i=i+1;
	 }else{
		 i=i;
	 }
    if(i!=0){
   	 return false;
    }
 
  
		 var command=new L5.Command("org.loushang.live.sign.cmd.SignSaveCmd");//声明cmd对象，调用后台的方法进行操作
		 command.setParameter("sSign",sSign);//设定数据，在后台可以获取
		 command.setParameter("fSign",fSign);
		 command.setParameter("stat",stat);
		 command.setParameter("sysSign","0");	 
		 command.execute("updateSign");//执行updateSign方法
		 if (!command.error) {	
			 var retval = command.getReturn("result");
			 if(""!=retval){
			    	L5.Msg.alert('提示',retval);
			    	return false;
			    }else{
				 		ds.load(true);
				 		return true;
				}								  			 		
		  }else{
				L5.Msg.alert('提示',command.error);
		 }	
}
/**
 * 
 * @param e
 * @return
 */
function warn(e)
{
	document.getElementById(e.id+"test").innerHTML="*";
}
/**
 * 当失去焦点时提示
 * @param e
 * @return
 */
function afterWarn(e){
	if(e.value==""||e.value==null){
	document.getElementById(e.id+"test").innerHTML="必填项";
	return false;
	}else{
		return true;
	}
}
