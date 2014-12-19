package com.inspur.cams.sorg.assess.assess.domain;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.assess.assess.dao.ISomAssessDao;
import com.inspur.cams.sorg.assess.assess.data.SomAssess;
import com.inspur.cams.sorg.assess.assessscore.dao.ISomAssessScoreDao;
import com.inspur.cams.sorg.assess.assessscore.data.SomAssessScore;

/**
 * @title:SomAssessTypeDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class SomAssessDomain implements ISomAssessDomain {

	 ISomAssessDao dao = (ISomAssessDao) DaoFactory
		.getDao("com.inspur.cams.sorg.assess.assess.dao.SomAssessDao");
	 ISomAssessScoreDao scoreDao = (ISomAssessScoreDao) DaoFactory
		.getDao("com.inspur.cams.sorg.assess.assessscore.dao.SomAssessScoreDao");
	 

	public void delete(List<String> list) {
		String[] somassessIds = list.toArray(new String[list.size()]);
		if (list != null && !list.isEmpty()) {
			dao.batchDelete(somassessIds);
			
		}

	}
	
	public void saveScore(Map<Object,Object> map){
		List<SomAssessScore> list = new ArrayList<SomAssessScore>();
		String[] addIds = (String[])map.get("addIds");
		String assessType = (String)map.get("assessType");
		String taskCode = (String)map.get("taskCode");
		int score = 0;
		for(int i = 0;i<addIds.length;i++){
			String[] addIdsSplit = addIds[i].split(";");
			String addId = addIds[i].split(";")[0];
			String addValue = "";
			if(addIdsSplit.length>1){
				addValue = addIds[i].split(";")[1];
			}
			SomAssessScore somAssessScore = new SomAssessScore();
			somAssessScore.setId(IdHelp.getUUID32());
			somAssessScore.setConfigId(addId);
			somAssessScore.setAssessMakeScore(addValue);
			somAssessScore.setTaskCode(taskCode);
			somAssessScore.setAssessType(assessType);
			list.add(somAssessScore);
			//计算总分数
			if(addValue != ""){
				score += Integer.parseInt(addValue);
			}
		}
		//更新任务表的分数
		ParameterSet arg0 = new ParameterSet();
		arg0.setParameter("TASK_CODE", taskCode);
		DataSet assessDataSet = dao.query(arg0);
		if ((assessDataSet != null) && (assessDataSet.getCount() > 0)){
			Record assessRecord = assessDataSet.getRecord(0);
			assessRecord.set("SCORE", score+"");
			dao.update((SomAssess)assessDataSet.toListBean(SomAssess.class).get(0));
		}
		scoreDao.batchInsert(list);
	}
	
	public void updateScore(Map<Object,Object> map){
		List<SomAssessScore> list = new ArrayList<SomAssessScore>();
		String[] addIds = (String[])map.get("addIds");
		String assessType = (String)map.get("assessType");
		String taskCode = (String)map.get("taskCode");
		int score = 0;
		for(int i = 0;i<addIds.length;i++){
			String[] addIdsSplit = addIds[i].split(";");
			String addId = addIds[i].split(";")[0];
			String addValue = "";
			if(addIdsSplit.length>1){
				addValue = addIds[i].split(";")[1];
			}
			SomAssessScore somAssessScore = new SomAssessScore();
			somAssessScore.setId(IdHelp.getUUID32());
			somAssessScore.setConfigId(addId);
			somAssessScore.setAssessMakeScore(addValue);
			somAssessScore.setTaskCode(taskCode);
			somAssessScore.setAssessType(assessType);
			list.add(somAssessScore);
			//计算总分数
			if(addValue != ""){
				score += Integer.parseInt(addValue);
			}
		}
		//更新任务表的分数
		ParameterSet arg0 = new ParameterSet();
		arg0.setParameter("TASK_CODE", taskCode);
		DataSet assessDataSet = dao.query(arg0);
		if ((assessDataSet != null) && (assessDataSet.getCount() > 0)){
			Record assessRecord = assessDataSet.getRecord(0);
			assessRecord.set("SCORE", score+"");
			dao.update((SomAssess)assessDataSet.toListBean(SomAssess.class).get(0));
		}
		scoreDao.deleteByTaskCode(taskCode);
		scoreDao.batchInsert(list);
	}

	public DataSet querySomAssess(ParameterSet pset) {
		return dao.query(pset);
	}
	

	public void batchDelete(String[] delIds) {
		dao.batchDelete(delIds);
	}

}