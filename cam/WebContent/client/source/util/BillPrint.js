/**
 * @constructor
 */
L5.util.BillPrint=function(){
	//do nothing
};

L5.util.BillPrint.savePosition=function(){
	var command=new L5.Command("org.loushang.next.web.cmd.billprint.BillPrintCmd");
	if(!window.billpos){
		return;
	}
	command.setParameter("template",window.printjsp);
	command.setParameter("positions",window.billpos);
	command.execute("savePosition");
	if (!command.error) {
      	alert("保存成功!");
	}else{
		alert(command.error);
	}	
};

L5.util.BillPrint.loadPosition=function(){
	var command=new L5.Command("org.loushang.next.web.cmd.billprint.BillPrintCmd");
	command.setParameter("template",window.printjsp);
	command.execute("loadPosition");
	window.billpos=command.getReturn("positions");
	for(name in window.billpos.map){
		var pos=window.billpos.map[name].split(',');		
		var ele=document.getElementById(name);
		if(ele){
			ele.style.top=pos[0];
			ele.style.left=pos[1];
		}
	}
};

L5.util.BillPrint.afterDrag=function(){
	var ele=this.getEl();
	if(!window.billpos){
		window.billpos=new L5.Map();
	}
	if(ele.offsetTop>0){
		window.billpos.map[ele.id]=""+ele.style.top+","+ele.style.left; 
	}else{
		window.billpos.map[ele.id]=undefined;
	}
};

L5.billprint=L5.util.BillPrint;//兼容