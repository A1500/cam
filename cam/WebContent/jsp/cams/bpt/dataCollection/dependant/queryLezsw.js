function queryLezsw(){
	var lezswCertificateId = document.getElementById("lezswCertificateId").value;
	if(lezswCertificateId!=''){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDependantCommand");
		command.setParameter("LEZSW_CERTIFICATE_ID", lezswCertificateId);
		command.execute("queryLezsw");
		
		if(command.getReturn("lezswName") !=undefined){
			var lezswName = command.getReturn("lezswName");
			document.getElementById("lezswName").value = lezswName;
		}
		
		if(command.getReturn("lezswSex") !=undefined){
			var lezswSex = command.getReturn("lezswSex");
			document.getElementById("lezswSex").value = lezswSex;
		}
		
		if(command.getReturn("lezswBirthday") !=undefined){
			var lezswBirthday = command.getReturn("lezswBirthday");
			document.getElementById("lezswBirthday").value = lezswBirthday;
		}
		
		if(command.getReturn("conscriptDate") !=undefined){
			var conscriptDate = command.getReturn("conscriptDate");
			document.getElementById("conscriptDate").value = conscriptDate;
		}
		
		if(command.getReturn("workUnit") !=undefined){
			var workUnit = command.getReturn("workUnit");
			document.getElementById("workUnit").value = workUnit;
		}
		
		if(command.getReturn("position") !=undefined){
			var position = command.getReturn("position");
			document.getElementById("position").value = position;
		}
		
		if(command.getReturn("deathDate") !=undefined){
			var deathDate = command.getReturn("deathDate");
			document.getElementById("deathDate").value = deathDate;
		}
		
		if(command.getReturn("deathAddress") !=undefined){
			var deathAddress = command.getReturn("deathAddress");
			document.getElementById("deathAddress").value = deathAddress;
		}
		
		if(command.getReturn("lezswApproveDate") !=undefined){
			var lezswApproveDate = command.getReturn("lezswApproveDate");
			document.getElementById("lezswApproveDate").value = lezswApproveDate;
		}
		
		if(command.getReturn("deathReason") !=undefined){
			var deathReason = command.getReturn("deathReason");
			document.getElementById("deathReason").value = deathReason;
		}
	}
}

