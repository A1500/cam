package com.inspur.cams.sorg.penalty.penalty.domain.support;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao;
import com.inspur.cams.sorg.check.somcheck.data.SomCheck;
import com.inspur.cams.sorg.penalty.base.dao.ISomPenaltyApplyDao;
import com.inspur.cams.sorg.penalty.base.data.SomPenalty;
import com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply;
import com.inspur.cams.sorg.penalty.base.domain.ISomPenaltyBaseDomain;
import com.inspur.cams.sorg.penalty.penalty.domain.ISomPenaltyApplyDomain;
import com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail;
import com.inspur.cams.sorg.restrict.domain.ISomRestrictPeopleDetailDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomDutyDuties;

/**
 * 行政处罚domain
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public class SomPenaltyApplyDomain implements ISomPenaltyApplyDomain {
	@Reference
	private ISomPenaltyApplyDao somPenaltyApplyDao;
	@Reference
	private ISomPenaltyBaseDomain somPenaltyBaseDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;	
	@Reference
	private ISomDutyDomain somDutyDomain;	
	@Reference
	private ISomRestrictPeopleDetailDomain somRestrictPeopleDetailDomain;	
	@Reference
	private ISomApplyDomain somApplyDomain;	
	
	private SomCheckDao somCheckDao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");

	public static final String PROC_DEF_UNIQUE_ID = "8ac78b71345faa9001345fba9ab00001";
	public static final String START_ACT_DEF_ID = "act1";

	public DataSet query(ParameterSet pset) {
		return somPenaltyApplyDao.query(pset);
	}

	/**
	 * 新增
	 * 
	 * @param somPenaltyApply
	 */
	public void create(SomPenaltyApply somPenaltyApply) {
		insertAcceptInfo(somPenaltyApply);
		SomPenalty somPenalty = somPenaltyApply.getSomPenalty();
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getDeptStruId());
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().create(
				somPenalty.getTaskCode(),
				somPenalty.getSorgName() + "的社会组织行政处罚");
		String processId = (String) map.get("processId");
		somPenaltyApply.setId(processId);
		somPenaltyApplyDao.insert(somPenaltyApply);
	}

	/**
	 * 新增并提交
	 * 
	 * @param somPenaltyApply
	 */
	public void createSubmit(SomPenaltyApply somPenaltyApply) {
		insertAcceptInfo(somPenaltyApply);
		SomPenalty somPenalty = somPenaltyApply.getSomPenalty();
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getDeptStruId());
		context.put("OPINIONID", somPenaltyApply.getCurOpinionId());
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().createAndSend(
				somPenalty.getTaskCode(),
				somPenalty.getSorgName() + "的社会组织行政处罚", context);
		String processId = (String) map.get("processId");
		somPenaltyApply.setId(processId);
		List actList = (List) map.get("actList");
		if (actList != null) {
			Map actMap = (Map) actList.get(0);
			String actDefName = (String) actMap.get("actDefName");
			somPenaltyApply.setCurActivity(actDefName);
		} else {
			somPenaltyApply.setCurActivity("");
			somPenalty.setCaseStatus("0");
			somPenaltyBaseDomain.update(somPenalty);
		}
		emptySomPenaltyApply(somPenaltyApply, somPenaltyApply.getCurActivity());
		somPenaltyApplyDao.insert(somPenaltyApply);
	}

	/**
	 * 新增受理登记信息
	 * 
	 * @param somPenaltyApply
	 */
	private void insertAcceptInfo(SomPenaltyApply somPenaltyApply) {
		SomPenalty somPenalty = somPenaltyApply.getSomPenalty();
		somPenalty.setTaskCode(IdHelp.getUUID30());
		somPenalty.setCaseCodeYear(DateUtil.getYear());
		somPenalty.setPenaltyType(ApplyType.SOM_PENALTY);
		somPenalty.setCaseStatus("1");
		somPenalty.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somPenalty.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somPenalty.setAcceptDate(DateUtil.getDay());
		somPenalty.setAcceptPeopleId(BspUtil.getEmpOrgan().getOrganId());
		somPenalty.setAcceptPeopleName(BspUtil.getEmpOrgan().getOrganName());
		somPenaltyBaseDomain.insert(somPenalty);
		somPenaltyApply.setTaskCode(somPenalty.getTaskCode());
		somPenaltyApply.setCurActivity(Activity.PENALTYACT_ACCEPT_CN);
		curSomPenaltyApply(somPenaltyApply);
		somPenaltyApply.setAcceptOpinionId(somPenaltyApply.getCurOpinionId());
		somPenaltyApply.setAcceptOpinion(somPenaltyApply.getCurOpinion());
		somPenaltyApply.setAcceptOrganId(somPenaltyApply.getCurOrganId());
		somPenaltyApply.setAcceptOrganName(somPenaltyApply.getCurOrganName());
		somPenaltyApply.setAcceptDeptId(somPenaltyApply.getCurDeptId());
		somPenaltyApply.setAcceptDeptName(somPenaltyApply.getCurDeptName());
		somPenaltyApply.setAcceptPeopleId(somPenaltyApply.getCurPeopleId());
		somPenaltyApply.setAcceptPeopleName(somPenaltyApply.getCurPeopleName());
		somPenaltyApply.setAcceptTime(DateUtil.getTime());
	}

	/**
	 * 保存
	 * 
	 * @param somPenaltyApply
	 */
	public void save(SomPenaltyApply somPenaltyApply) {
		SomPenalty somPenalty = somPenaltyApply.getSomPenalty();
		curSomPenaltyApply(somPenaltyApply);
		if (Activity.PENALTYACT_REG_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setRegOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setRegOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setRegOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setRegOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setRegDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setRegDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setRegPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setRegPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setRegTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_REG_CHECK_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setRegCheckOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setRegCheckOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setRegCheckOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setRegCheckOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setRegCheckDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setRegCheckDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setRegCheckPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setRegCheckPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setRegCheckTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_REG_AUDIT_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenalty.setRegDate(DateUtil.getDay());
			somPenaltyApply.setRegAuditOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setRegAuditOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setRegAuditOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setRegAuditOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setRegAuditDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setRegAuditDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setRegAuditPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setRegAuditPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setRegAuditTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_INV_END_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setInvAcceptOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setInvAcceptOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setInvAcceptOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setInvAcceptOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setInvAcceptDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setInvAcceptDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setInvAcceptPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setInvAcceptPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setInvAcceptTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_INV_END_CHECK_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setInvCheckOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setInvCheckOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setInvCheckOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setInvCheckOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setInvCheckDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setInvCheckDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setInvCheckPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setInvCheckPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setInvCheckTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_INV_END_AUDIT_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setInvAuditOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setInvAuditOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setInvAuditOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setInvAuditOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setInvAuditDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setInvAuditDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setInvAuditPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setInvAuditPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setInvAuditTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_PENALTY_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setPenaltyOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setPenaltyOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setPenaltyOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setPenaltyOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setPenaltyDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setPenaltyDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setPenaltyPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setPenaltyPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setPenaltyTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_PENALTY_CHECK_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setPenaltyCheckOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setPenaltyCheckOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setPenaltyCheckOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setPenaltyCheckOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setPenaltyCheckDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setPenaltyCheckDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setPenaltyCheckPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setPenaltyCheckPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setPenaltyCheckTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_PENALTY_AUDIT_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setPenaltyAuditOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setPenaltyAuditOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setPenaltyAuditOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setPenaltyAuditOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setPenaltyAuditDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setPenaltyAuditDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setPenaltyAuditPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setPenaltyAuditPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setPenaltyAuditTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_PENALTY_INFORM_CN.equals(somPenaltyApply.getCurActivity())) {
			if("5".equals(somPenalty.getPenaltyInformType())){//撤销登记
				//根据taskCode删除受限人员明细
				ParameterSet pset=new ParameterSet();
				pset.setParameter("TASK_CODE", somPenaltyApply.getTaskCode());
				somRestrictPeopleDetailDomain.deleteByTaskCode(pset);
				pset=new ParameterSet();
				String sorgCode=somPenalty.getSorgCode();
				String sorgType=somPenalty.getSorgType();
				pset.setParameter("SORG_CODE", sorgCode);
				pset.setParameter("SORG_TYPE", sorgType);
				DataSet dset=somOrganDomain.query(pset);
				if(dset==null||dset.getCount()<1){
					return;
				}
				//撤销somOrgan
				SomOrgan somOrgan=(SomOrgan) dset.getRecord(0).toBean(SomOrgan.class);
				String sorgId=somOrgan.getSorgId();
				somOrgan.setSorgStatus("52");//撤销
				somOrganDomain.update(somOrgan);				
				dset=somDutyDomain.queryCurDuty(somOrgan.getSorgId());
				if(dset==null||dset.getCount()<1){
					return;
				}
				List<SomRestrictPeopleDetail> somRestrictPeopleDetailList=new ArrayList<SomRestrictPeopleDetail>();
				SomDuty legalPeople=new SomDuty();//法定代表人
				for (int i = 0; i < dset.getCount(); i++) {
					SomDuty somDuty=(SomDuty) dset.getRecord(i).toBean(SomDuty.class);
					if (SomDutyDuties.SOM_LEGAL_PEOPLE.equals(somDuty.getSorgDuties())) {
						legalPeople=somDuty;
						continue;
					}
					SomRestrictPeopleDetail somRestrictPeopleDetail=new SomRestrictPeopleDetail();
					somRestrictPeopleDetail.setPeopleId(somDuty.getPeopleId());
					somRestrictPeopleDetail.setName(somDuty.getName());
					somRestrictPeopleDetail.setIdCard(somDuty.getIdCard());
					somRestrictPeopleDetail.setIfValid("1");//是否有效
					somRestrictPeopleDetail.setTaskCode(somPenalty.getTaskCode());
					somRestrictPeopleDetail.setIfLegal("0");//是否法定代表人
					somRestrictPeopleDetail.setSourceType("0");//0:行政处罚;1:取缔非法社会组织
					somRestrictPeopleDetail.setSorgCode(somPenalty.getSorgCode());
					somRestrictPeopleDetailList.add(somRestrictPeopleDetail);
				}
				if(legalPeople.getName()!=null){
					for (int i = 0; i < somRestrictPeopleDetailList.size(); i++) {
						SomRestrictPeopleDetail bean=somRestrictPeopleDetailList.get(i);
						if(bean.getPeopleId().equals(legalPeople.getPeopleId())){
							bean.setIfLegal("1");//是否法定代表人
							bean.setIfLimit("1");//多个社会组织中任职，只要有一个为法定代表人，则为1
						}
					}
				}
				//保存受限:添加/更新受限人员，添加受限人员明细
				somRestrictPeopleDetailDomain.addRestrict(somRestrictPeopleDetailList);
				
				//保存somApply
				SomApply somApply=new SomApply();
				pset=new ParameterSet();
				pset.setParameter("TASK_CODE", somPenaltyApply.getTaskCode());
				dset=somApplyDomain.query(pset);
				if(dset.getCount()>0){
					somApply=(SomApply) dset.getRecord(0).toBean(SomApply.class);
					somApply.setAuditOrganId(BspUtil.getCorpOrganId());
					somApply.setAuditOrganName(BspUtil.getOrganName());
					somApply.setAuditDeptId(BspUtil.getDeptOrganId());
					somApply.setAuditDeptName(BspUtil.getDeptOrgan().getOrganName());
					somApply.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
					somApply.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
					somApply.setAuditTime(DateUtil.getTime());
					somApplyDomain.update(somApply);
				}else{
					somApply.setTaskCode(somPenaltyApply.getTaskCode());
					somApply.setSorgId(sorgId);
					somApply.setApplyType(ApplyType.SOM_CLOSE);
					somApply.setSorgType(sorgType);
					somApply.setSorgKind(somOrgan.getSorgKind());
					somApply.setSorgName(somOrgan.getCnName());
					somApply.setIfFinish("1");
					somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
					somApply.setAuditOrganId(BspUtil.getCorpOrganId());
					somApply.setAuditOrganName(BspUtil.getOrganName());
					somApply.setAuditDeptId(BspUtil.getDeptOrganId());
					somApply.setAuditDeptName(BspUtil.getDeptOrgan().getOrganName());
					somApply.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
					somApply.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
					somApply.setAuditTime(DateUtil.getTime());
					somApplyDomain.insert(somApply);
				}
			}
			if("4".equals(somPenalty.getPenaltyInformType())){//限期停止活动
				ParameterSet pset=new ParameterSet();
				String sorgCode=somPenalty.getSorgCode();
				String sorgType=somPenalty.getSorgType();
				pset.setParameter("SORG_CODE", sorgCode);
				pset.setParameter("SORG_TYPE", sorgType);
				DataSet dset=somOrganDomain.query(pset);
				if(dset==null||dset.getCount()<1){
					return;
				}
				//somOrgan限期停止活动
				SomOrgan somOrgan=(SomOrgan) dset.getRecord(0).toBean(SomOrgan.class);
				String sorgId=somOrgan.getSorgId();
				somOrgan.setSorgStatus("51");//限期停止活动
				somOrganDomain.update(somOrgan);				
				//保存somApply
				SomApply somApply=new SomApply();
				pset=new ParameterSet();
				pset.setParameter("TASK_CODE", somPenaltyApply.getTaskCode());
				dset=somApplyDomain.query(pset);
				if(dset.getCount()>0){
					somApply=(SomApply) dset.getRecord(0).toBean(SomApply.class);
					somApply.setAuditOrganId(BspUtil.getCorpOrganId());
					somApply.setAuditOrganName(BspUtil.getOrganName());
					somApply.setAuditDeptId(BspUtil.getDeptOrganId());
					somApply.setAuditDeptName(BspUtil.getDeptOrgan().getOrganName());
					somApply.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
					somApply.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
					somApply.setAuditTime(DateUtil.getTime());
					somApplyDomain.update(somApply);
				}else{
					somApply.setTaskCode(somPenaltyApply.getTaskCode());
					somApply.setSorgId(sorgId);
					somApply.setApplyType(ApplyType.SOM_LIMIT_PERIOD);
					somApply.setSorgType(sorgType);
					somApply.setSorgKind(somOrgan.getSorgKind());
					somApply.setSorgName(somOrgan.getCnName());
					somApply.setIfFinish("1");
					somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
					somApply.setAuditOrganId(BspUtil.getCorpOrganId());
					somApply.setAuditOrganName(BspUtil.getOrganName());
					somApply.setAuditDeptId(BspUtil.getDeptOrganId());
					somApply.setAuditDeptName(BspUtil.getDeptOrgan().getOrganName());
					somApply.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
					somApply.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
					somApply.setAuditTime(DateUtil.getTime());
					somApplyDomain.insert(somApply);
				}
			}
		}else if (Activity.PENALTYACT_FINAL_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setFinalOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setFinalOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setFinalOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setFinalOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setFinalDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setFinalDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setFinalPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setFinalPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setFinalTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_FINAL_CHECK_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenaltyApply.setFinalCheckOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setFinalCheckOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setFinalCheckOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setFinalCheckOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setFinalCheckDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setFinalCheckDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setFinalCheckPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setFinalCheckPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setFinalCheckTime(DateUtil.getTime());
		} else if (Activity.PENALTYACT_FINAL_AUDIT_CN.equals(somPenaltyApply.getCurActivity())) {
			somPenalty.setFinalDate(DateUtil.getDay());
			somPenaltyApply.setFinalAuditOpinionId(somPenaltyApply.getCurOpinionId());
			somPenaltyApply.setFinalAuditOpinion(somPenaltyApply.getCurOpinion());
			somPenaltyApply.setFinalAuditOrganId(somPenaltyApply.getCurOrganId());
			somPenaltyApply.setFinalAuditOrganName(somPenaltyApply.getCurOrganName());
			somPenaltyApply.setFinalAuditDeptId(somPenaltyApply.getCurDeptId());
			somPenaltyApply.setFinalAuditDeptName(somPenaltyApply.getCurDeptName());
			somPenaltyApply.setFinalAuditPeopleId(somPenaltyApply.getCurPeopleId());
			somPenaltyApply.setFinalAuditPeopleName(somPenaltyApply.getCurPeopleName());
			somPenaltyApply.setFinalAuditTime(DateUtil.getTime());
		}
		somPenaltyBaseDomain.update(somPenalty);
		somPenaltyApplyDao.update(somPenaltyApply);
	}

	/**
	 * 提交
	 * 
	 * @param somPenaltyApply
	 */
	public void submit(SomPenaltyApply somPenaltyApply) {
		save(somPenaltyApply);
		SomPenalty somPenalty = somPenaltyApply.getSomPenalty();
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getDeptStruId());
		context.put("OPINIONID", somPenaltyApply.getCurOpinionId());
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		List actList = (List) map.get("actList");
		if (actList != null) {
			Map actMap = (Map) actList.get(0);
			String actDefName = (String) actMap.get("actDefName");
			somPenaltyApply.setCurActivity(actDefName);
		} else {
			somPenaltyApply.setCurActivity("");
			somPenalty.setCaseStatus("0");
			somPenaltyBaseDomain.update(somPenalty);
		}
		emptySomPenaltyApply(somPenaltyApply, somPenaltyApply.getCurActivity());
		somPenaltyApplyDao.update(somPenaltyApply);
	}

	/**
	 * 设置当前环节信息
	 * 
	 * @param somPenaltyApply
	 */
	private void curSomPenaltyApply(SomPenaltyApply somPenaltyApply) {
		somPenaltyApply.setCurOrganId(BspUtil.getCorpOrganId());
		somPenaltyApply.setCurOrganName(BspUtil.getOrganName());
		somPenaltyApply.setCurDeptId(BspUtil.getDeptOrganId());
		somPenaltyApply.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		somPenaltyApply.setCurPeopleId(BspUtil.getEmpOrgan().getOrganId());
		somPenaltyApply.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());
	}

	/**
	 * 清空当前环节信息
	 * 
	 * @param somPenaltyApply
	 * @param activity
	 */
	private void emptySomPenaltyApply(SomPenaltyApply somPenaltyApply,
			String activity) {
		somPenaltyApply.setCurActivity(activity);
		somPenaltyApply.setCurOpinionId("");
		somPenaltyApply.setCurOpinion("");
		somPenaltyApply.setCurOrganId("");
		somPenaltyApply.setCurOrganName("");
		somPenaltyApply.setCurDeptId("");
		somPenaltyApply.setCurDeptName("");
		somPenaltyApply.setCurPeopleId("");
		somPenaltyApply.setCurPeopleName("");
	}
	
	/**
	 * 年检不合格的保存到行政执法的数据保存时调用此方法
	 */
	public void createAndUpdateCheck(SomPenaltyApply somPenaltyApply,Map map) {
		String checkTaskCode = (String)map.get("checkTaskCode");
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE", checkTaskCode);
		DataSet ds = somCheckDao.query(pset);
		if(ds.getCount() == 1){
			SomCheck somCheck = (SomCheck)ds.getRecord(0).toBean(SomCheck.class);
			somCheck.setIfPenalty("1");
			somCheck.setPenaltyTime(DateUtil.getTime());
			somCheck.setPenaltyPeople(BspUtil.getEmpOrgan().getOrganName());
			somCheck.setPenaltyOrgan(BspUtil.getOrganName());
			somCheckDao.update(somCheck);
		}
		create(somPenaltyApply);
	}
	/**
	 * 年检不合格的提交到行政执法的数据提交时调用此方法
	 */
	public void createSubmitAndUpdateCheck(SomPenaltyApply somPenaltyApply,Map map) {
		String checkTaskCode = (String)map.get("checkTaskCode");
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE", checkTaskCode);
		DataSet ds = somCheckDao.query(pset);
		if(ds.getCount() == 1){
			SomCheck somCheck = (SomCheck)ds.getRecord(0).toBean(SomCheck.class);
			somCheck.setIfPenalty("1");
			somCheck.setPenaltyTime(DateUtil.getTime());
			somCheck.setPenaltyPeople(BspUtil.getEmpOrgan().getOrganName());
			somCheck.setPenaltyOrgan(BspUtil.getOrganName());
			somCheckDao.update(somCheck);
		}
		createSubmit(somPenaltyApply);
	}
}
