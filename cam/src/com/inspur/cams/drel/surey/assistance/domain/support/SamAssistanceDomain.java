package com.inspur.cams.drel.surey.assistance.domain.support;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleDao;
import com.inspur.cams.drel.esurey.data.SamEsureyPeople;
import com.inspur.cams.drel.surey.assistance.domain.ISamAssistanceDomain;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyDao;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfDao;
import com.inspur.cams.drel.surey.comm.data.SamSurey;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;
import com.inspur.cams.drel.surey.comm.domain.ISamSureyDomain;

public class SamAssistanceDomain implements ISamAssistanceDomain {
	@Reference
	ISamSureyDao samSureyDao;
	@Reference
	ISamEsureyPeopleDao samEsureyPeopleDao;
	@Reference
	ISamSureyWfDao samSureyWfDao;
	@Reference
	private ISamSureyDomain samSureyDomain;

	public void insertSurey(SamSureyWf samSureyWfBean) {
		// 增加业务信息
		SamSurey samSureyBean = new SamSurey();
		String surveyId = IdHelp.getUUID32();
		samSureyBean.setSurveyId(surveyId);
		String assistanceType = samSureyWfBean.getAssistanceType();
		String surveyType = "";
		if (assistanceType.equals("01") || assistanceType.equals("02")) {
			surveyType = "02";
		}
		if (assistanceType.equals("03")) {
			surveyType = "03";
		}
		samSureyBean.setSurveyType(surveyType);
		samSureyBean.setAssistanceType(assistanceType);
		samSureyBean.setApplyTitle(samSureyDomain.getApplyTitle(samSureyWfBean
				.getName(), surveyType));
		samSureyBean.setApplyOrgan(samSureyWfBean.getCurActivityOrgan());
		samSureyBean
				.setApplyOrganName(samSureyWfBean.getCurActivityOrganName());
		samSureyBean
				.setApplyOrganType(samSureyWfBean.getCurActivityOrganType());
		samSureyBean.setApplyOrganArea(samSureyWfBean.getCurActivityArea());
		samSureyBean.setApplyDate(DateUtil.getDay());
		samSureyBean.setSurveyDate(DateUtil.getDay());
		samSureyDao.insert(samSureyBean);
		// 增加业务从表信息
		SamEsureyPeople peopleBean = new SamEsureyPeople();
		peopleBean.setPeopleId(IdHelp.getUUID32());
		peopleBean.setSurveyId(surveyId);
		peopleBean.setDomicileCode(samSureyWfBean.getDomicileCode());
		peopleBean.setApanageCode(samSureyWfBean.getApanageCode());
		peopleBean.setIdCard(samSureyWfBean.getIdCard());
		peopleBean.setName(samSureyWfBean.getName());
		samEsureyPeopleDao.insert(peopleBean);
		// 外部单位创建流程
		samSureyDomain.outerCreate(samSureyBean, samSureyWfBean);
	}

	public void deleteSurey(Record[] records) {
		for (int i = 0; i < records.length; i++) {
			String surveyId = (String) records[i].get("SURVEY_ID");
			String peopleId = (String) records[i].get("PEOPLE_ID");
			String flowId = (String) records[i].get("FLOW_ID");
			// 删除业务信息
			samSureyDao.delete(surveyId);
			// 删除业务从表信息
			samEsureyPeopleDao.delete(peopleId);
			// 删除流程信息
			samSureyWfDao.delete(flowId);
		}
	}

	public void updateSurey(SamSureyWf dataBean, Map<String, String> map) {
		String assistanceType = dataBean.getAssistanceType();
		String surveyType = "";
		if (assistanceType.equals("01") || assistanceType.equals("02")) {
			surveyType = "02";
		}
		if (assistanceType.equals("03")) {
			surveyType = "03";
		}
		// 更新业务信息
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SURVEY_ID@=", dataBean.getSurveyId());
		SamSurey sureyBean = (SamSurey) samSureyDao.query(pset).getRecord(0)
				.toBean(SamSurey.class);
		sureyBean.setSurveyType(surveyType);
		sureyBean.setAssistanceType(assistanceType);
		sureyBean.setApplyTitle(samSureyDomain.getApplyTitle(
				dataBean.getName(), surveyType));
		samSureyDao.update(sureyBean);
		// 更新业务从表信息
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", map.get("peopleId"));
		SamEsureyPeople peopleBean = (SamEsureyPeople) samEsureyPeopleDao
				.query(pset).getRecord(0).toBean(SamEsureyPeople.class);
		peopleBean.setDomicileCode(dataBean.getDomicileCode());
		peopleBean.setApanageCode(dataBean.getApanageCode());
		peopleBean.setName(dataBean.getName());
		peopleBean.setIdCard(dataBean.getIdCard());
		samEsureyPeopleDao.update(peopleBean);
		// 更新流程信息
		pset.clear();
		pset.setParameter("FLOW_ID@=", dataBean.getFlowId());
		SamSureyWf wfBean = (SamSureyWf) samSureyWfDao.query(pset).getRecord(0)
				.toBean(SamSureyWf.class);
		;
		wfBean.setSurveyType(surveyType);
		wfBean.setAssistanceType(assistanceType);
		wfBean.setApplyTitle(samSureyDomain.getApplyTitle(dataBean.getName(),
				surveyType));
		wfBean.setName(dataBean.getName());
		wfBean.setIdCard(dataBean.getIdCard());
		wfBean.setDomicileCode(dataBean.getDomicileCode());
		wfBean.setApanageCode(dataBean.getApanageCode());
		samSureyWfDao.update(wfBean);
	}

	public void sendSurey(List<String> list, String userId, String userName) {
		for (int i = 0; i < list.size(); i++) {
			String flowId = list.get(i);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("FLOW_ID@=", flowId);
			DataSet ds = samSureyWfDao.query(pset);
			SamSureyWf bean = (SamSureyWf) ds.getRecord(0).toBean(
					SamSureyWf.class);
			samSureyDomain.outerSend(bean, userId, userName);
		}
	}
}
