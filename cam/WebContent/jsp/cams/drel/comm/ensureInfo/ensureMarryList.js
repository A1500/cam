function init(){
	ensureToClientDataSet.load();
}

function query(){
	ensureToClientDataSet.setParameter("familyName",document.getElementById("familyName").value+"%");
	ensureToClientDataSet.setParameter("isMarry",document.getElementById("isMarry").value);
	ensureToClientDataSet.load();
}
