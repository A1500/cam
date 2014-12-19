package com.inspur.cams.drel.surey.comm.domain.support;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.dicm.dao.IDicDetailsDao;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyDao;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfDao;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfHisDao;
import com.inspur.cams.drel.surey.comm.data.SamSurey;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;
import com.inspur.cams.drel.surey.comm.data.SamSureyWfHis;
import com.inspur.cams.drel.surey.comm.domain.ISamSureyDomain;
import com.inspur.cams.drel.surey.util.ActivityStatus;
import com.inspur.cams.drel.surey.util.SureyActivity;

public class SamSureyDomain implements ISamSureyDomain {
	@Reference
	ISamSureyDao samSureyDao;
	@Reference
	ISamSureyWfDao samSureyWfDao;
	@Reference
	ISamSureyWfHisDao samSureyWfHisDao;
	@Reference
	private IDicDetailsDao dicDetailsDao;

	public void outerCreate(SamSurey samSureyBean ,SamSureyWf samSureyWfBean) {
		//增加流程信息
		samSureyWfBean.setFlowId(IdHelp.getUUID32());
		samSureyWfBean.setSurveyId(samSureyBean.getSurveyId());
		samSureyWfBean.setSurveyType(samSureyBean.getSurveyType());
		samSureyWfBean.setApplyTitle(samSureyBean.getApplyTitle());
		samSureyWfBean.setCurActivity(SureyActivity.ACT_APPLICATION);
		samSureyWfBean.setCurStatus(ActivityStatus.TODO);
		samSureyWfBean.setCurActivitySt(DateUtil.getTime());
		//判断当前环节是区外部单位或市外部单位
		if(isCityLevel(samSureyBean.getApplyOrganArea())){
			samSureyWfBean.setNextActivity(SureyActivity.ACT_CITY_CHECK);
			samSureyWfBean.setNextActivityOrganName("经济核对中心");
		}else{
 
			samSureyWfBean.setNextActivity(SureyActivity.ACT_CHECK);
			samSureyWfBean.setNextActivityOrganName(getCenterName(samSureyWfBean.getCurActivityArea()));
		}
		samSureyWfBean.setNextActivityArea(samSureyWfBean.getCurActivityArea());
		samSureyWfBean.setNextActivityOrganType("A1");
		
		samSureyWfDao.insert(samSureyWfBean);
	}

/**
 * 区县外部单位提交核对人信息到区县经济核对中心
 * 判断：若是区县外部单位发送请求至区县的经济核对中心，市级外部单位发送请求到市经济核对中心
 */
public void outerSend(SamSureyWf bean, String userId, String userName) {
		//增加流程历史信息
		SamSureyWfHis hisBean = new SamSureyWfHis();
		hisBean.setHisId(IdHelp.getUUID32());
		hisBean.setFlowId(bean.getFlowId());
		hisBean.setActivity(bean.getCurActivity());
		hisBean.setActivityOrgan(bean.getCurActivityOrgan());
		hisBean.setActivityOrganName(bean.getCurActivityOrganName());
		hisBean.setActivityOrganArea(bean.getCurActivityArea());
		hisBean.setActivityOrganType(bean.getCurActivityOrganType());
		hisBean.setActivityPeople(userId);
		hisBean.setActivityPeopleName(userName);
		hisBean.setActivityDealTime(DateUtil.getTime());
		hisBean.setCurActivityEt(hisBean.getActivityDealTime());
		hisBean.setCurActivitySt(bean.getCurActivitySt());
		samSureyWfHisDao.insert(hisBean);
		//更新流程信息
		bean.setPreActivity(bean.getCurActivity());
		bean.setPreActivityOrgan(bean.getCurActivityOrgan());
		bean.setPreActivityOrganName(bean.getCurActivityOrganName());
		bean.setPreActivityArea(bean.getCurActivityArea());
		bean.setPreActivityOrganType(bean.getCurActivityOrganType());
		
		bean.setCurActivity(bean.getNextActivity());
		bean.setCurStatus(ActivityStatus.TODO);
		bean.setCurActivityOrgan(bean.getNextActivityOrgan());
		bean.setCurActivityOrganName(bean.getNextActivityOrganName());
		bean.setCurActivityArea(bean.getNextActivityArea());
		bean.setCurActivityOrganType(bean.getNextActivityOrganType());
		bean.setCurActivitySt(DateUtil.getTime());
		
		if(isCityLevel(bean.getCurActivityArea())){
			bean.setNextActivity(SureyActivity.ACT_BOROUGH_SEND);
			bean.setNextActivityOrganType("A1");
			bean.setNextActivityOrgan("");
			if(bean.getDomicileCode().equals(bean.getApanageCode())){
				bean.setNextActivityArea(bean.getDomicileCode());
				bean.setNextActivityOrganName(getCenterName(bean.getDomicileCode()));
			}else{
				bean.setNextActivityArea(bean.getDomicileCode()+","+bean.getApanageCode());
				bean.setNextActivityOrganName(getCenterName(bean.getDomicileCode())+","+getCenterName(bean.getApanageCode()));
			}
			bean.setOpinionCode("TR");
		}else{
			bean.setNextActivity("");
			bean.setNextActivityArea(bean.getDomicileCode());
			bean.setNextActivityOrgan("");
			bean.setNextActivityOrganName(getOrganName(bean.getDomicileCode()));
			bean.setNextActivityOrganType("");
		}
		
		bean.setIsFinish("0");
		
		samSureyWfDao.update(bean);//更新流程信息
   		ParameterSet pset = new ParameterSet();
		pset.setParameter("SURVEY_ID@=", bean.getSurveyId());
		DataSet ds = samSureyDao.query(pset);
		SamSurey samSurey = (SamSurey) ds.getRecord(0).toBean(SamSurey.class);
		samSurey.setSurveyOrganType(bean.getCurActivityOrganType());
		samSurey.setSurveyOrganArea(bean.getCurActivityArea());
		samSurey.setSurveyOrganName(bean.getCurActivityOrganName());
		samSureyDao.update(samSurey);
	}
	
	/**
	 * 拼装流程名称
	 * @param peopleName
	 * @param surveyType
	 * @return
	 */
	public String getApplyTitle(String peopleName,String surveyType){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("DIC_TYPE@=", "SURVEY_TYPE");
		pset.setParameter("CODE@=", surveyType);
		String name = (String) (dicDetailsDao.query(pset).getRecord(0).get("name"));
		return peopleName+"的"+name+"核对";
	}
	
	/**
	 * 判断是否为市级行政区划
	 * @param organArea
	 * @return
	 */
	public Boolean isCityLevel(String organArea){
		String endArea = organArea.substring(4);
		return endArea.equals("00000000");
	}
	
	/**
	 * 根据行政区划获取单位名称
	 * @param organArea
	 * @return
	 */
	public String getOrganName(String organArea){
		return samSureyWfDao.queryOrganNameByArea(organArea);
	}
	
	/**
	 * 根据经济核对中心名称
	 * @param organArea
	 * @return
	 */
	public String getCenterName(String organArea){
		return samSureyWfDao.queryCenterNameByArea(organArea);
	}

	public DataSet query(ParameterSet pset) {
	 
		return samSureyDao.query(pset);
	}
	 
}
