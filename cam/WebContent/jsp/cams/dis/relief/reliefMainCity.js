function init() {
	reliefInfoDs.setParameter("organCode", organCode);
	reliefInfoDs.setParameter("workflowStatus", '2,3,5,6,9,E');
	reliefInfoDs.load();
	
	reliefInfoColumnDs.setParameter("organCode", organCode);
	reliefInfoColumnDs.setParameter("workflowStatus", '2,3,5,6,9,E');
	reliefInfoColumnDs.load();
}
