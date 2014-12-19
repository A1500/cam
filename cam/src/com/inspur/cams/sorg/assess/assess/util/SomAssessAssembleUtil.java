package com.inspur.cams.sorg.assess.assess.util;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.assess.assess.dao.ISomAssessDao;
import com.inspur.cams.sorg.assess.assess.data.SomAssessAssemble;

public class SomAssessAssembleUtil  extends BaseQueryCommand {
	
	ISomAssessDao dao = (ISomAssessDao) DaoFactory
	.getDao("com.inspur.cams.sorg.assess.assess.dao.SomAssessDao");
	
	public  List<SomAssessAssemble> getTreeData(String assessType,String taskCode){
			dao.initTreeData(assessType,taskCode);
		 return dao.getAllTreeData(assessType, taskCode, "0");
	 }
}
