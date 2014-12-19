package com.inspur.cams.sorg.base.domain.support;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import org.apache.commons.lang.RandomStringUtils;
import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.sorg.base.dao.ISomApplyDao;
import com.inspur.cams.sorg.base.dao.ISomDutyDao;
import com.inspur.cams.sorg.base.dao.ISomPeopleDao;
import com.inspur.cams.sorg.base.dao.ISomSessionDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.SomDutyDuties;

/**
 * 社会组织业务domain现实类
 * @author shgtch
 * @date 2011-8-12
 */
public class SomApplyDomain implements ISomApplyDomain {
	
	@Reference
	private ISomApplyDao somApplyDao;
	@Reference
	private ISomDutyDao somDutyDao;
	@Reference
	private ISomPeopleDao somPeopleDao;
	@Reference
	private ISomSessionDao somSessionDao;
	
	
	/**
	 * 查询社会组织业务
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somApplyDao.query(pset);
	}

	public DataSet queryHisChange(ParameterSet pset) {
		return somApplyDao.queryHisChange(pset);
	}
	
	/**
	 * 查询一条社会组织业务信息
	 * @param taskCode
	 * @return
	 */
	public SomApply getSomApply(String taskCode) {
		return somApplyDao.get(taskCode);
	}
	
	/**
	 * 增加社会组织业务
	 * @param somApply
	 */
	@Trans
	public void insert(SomApply somApply) {
		//1.区县代码SD 2.厅局代码MZ 3.收件来源 0：大厅 1：网办
		String elmSerialNoPrefix = "SDMZ0";
		Date dNow = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd");
		String dateStr = formatter.format(dNow);
		String elmSerialNo = elmSerialNoPrefix+dateStr;
		//按日流水最大号，最大号按日流水后，框架不会在前边补0，需要单独补0,按日流水必须要加前缀，YYYYMMDD,还要再去掉
		String elmSerialNoMax = MaxValueUtil.nextStringValue("MSupervisionSerialNO");
		elmSerialNoMax=elmSerialNoMax.substring(8,elmSerialNoMax.length());
		for(int i=elmSerialNoMax.length();i<4;i++){
			elmSerialNoMax="0"+elmSerialNoMax;
		}
		elmSerialNo+=elmSerialNoMax;
		somApply.setElmSerialNo(elmSerialNo);
		somApply.setElmPassword(RandomStringUtils.randomNumeric(4));
		somApply.setCreateTime(DateUtil.getTime());
		somApply.setCreateOrgan(BspUtil.getCorpOrgan().getOrganName());
		somApply.setCreatePerson(BspUtil.getEmpOrgan().getOrganName());
		//查询当前社会组织的最新届次（换届流程IF_FINISH为1的），并维护到APPLY表
		String meetingId = somSessionDao.getLastSessionInfo(somApply.getSorgId());
		somApply.setSessionId(meetingId);
		somApplyDao.insert(somApply);
	}
	
	/**
	 * 增加社会组织业务
	 * @param somApply
	 */
	@Trans
	public void insertOnline(SomApply somApply) {
		somApply.setCreateTime(DateUtil.getTime());
		somApply.setDataSource("ONLINE");
		somApplyDao.insert(somApply);
	}
	
	/**
	 * 更新社会组织业务
	 * @param somApply
	 */
	@Trans
	public void update(SomApply somApply) {
		somApplyDao.update(somApply);
	}
	
	/**
	 * 获取最后环节processID
	 */
	public String queryProcessId(String id) {
		return somApplyDao.queryProcessId(id);
	}
	
	/**
	 * 通过processId获取taskCode
	 */
	public SomApply queryTaskCodeByProcessId(String processId){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PROCESS_ID@=", processId);
		DataSet ds = somApplyDao.query(pset);
		if(ds.getCount() == 1){
			SomApply applyBean = (SomApply) ds.getRecord(0).toBean(SomApply.class);
			return applyBean;
		}else{
			return null;
		}
	}
	
	/**
	 * 通过processId获取photoId
	 */
	public String queryPhotoIdByProcessId(String processId){
		ParameterSet pset = new ParameterSet();
		SomApply applyBean = queryTaskCodeByProcessId(processId);
		if(applyBean != null){
			pset.setParameter("TASK_CODE@=", applyBean.getTaskCode());
			pset.setParameter("SORG_DUTIES@=", SomDutyDuties.SOM_LEGAL_PEOPLE);
			pset.setParameter("IF_SERVE@=", "1");
			pset.setParameter("REG_STATUS@=", "3");
			DataSet ds = somDutyDao.query(pset);
			if(ds.getCount() == 1){
				pset.clear();
				pset.setParameter("PEOPLE_ID@=", (String)(ds.getRecord(0).get("peopleId")));
				DataSet ds2 = somPeopleDao.query(pset);
				if(ds2.getCount()==1){
					return (String) ds2.getRecord(0).get("photoId");
				}
			}
		}
		return null;
	}
	
	/**
	 * 维护历史处理意见
	 */
	public void  dealHisOpinion(SomApply somApply){
		if (Activity.ACT_ACCEPT_CN.equals(somApply.getCurActivity())) {
			somApply.setAcceptOpinionId(somApply.getCurOpinionId());
			somApply.setAcceptOpinion(somApply.getCurOpinion());
			somApply.setAcceptOrganId(BspUtil.getCorpOrganId());
			somApply.setAcceptOrganName(BspUtil.getOrganName());
			somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
			somApply.setAcceptPeopleId(BspUtil.getEmpOrgan().getOrganId());
			somApply.setAcceptPeopleName(BspUtil.getEmpOrgan().getOrganName());
			somApply.setAcceptTime(DateUtil.getTime());
			}
		if (Activity.ACT_WATCH_CN.equals(somApply.getCurActivity())) {
			somApply.setProspectOpinionId(somApply.getCurOpinionId());
			somApply.setProspectOpinion(somApply.getCurOpinion());
			somApply.setProspectOrganId(BspUtil.getCorpOrganId());
			somApply.setProspectOrganName(BspUtil.getOrganName());
			somApply.setProspectDeptId(BspUtil.getDeptOrganId());
			somApply.setProspectDeptName(BspUtil.getDeptOrgan().getOrganName());
			somApply.setProspectPeopleId(BspUtil.getEmpOrgan().getOrganId());
			somApply.setProspectPeopleName(BspUtil.getEmpOrgan().getOrganName());
			}
		if (Activity.ACT_EXAM_CN.equals(somApply.getCurActivity())) {
			somApply.setExaminOpinionId(somApply.getCurOpinionId());
			somApply.setExaminOpinion(somApply.getCurOpinion());
			somApply.setExaminOrganId(BspUtil.getCorpOrganId());
			somApply.setExaminOrganName(BspUtil.getOrganName());
			somApply.setExaminDeptId(BspUtil.getDeptOrganId());
			somApply.setExaminDeptName(BspUtil.getDeptOrgan().getOrganName());
			somApply.setExaminPeopleId(BspUtil.getEmpOrgan().getOrganId());
			somApply.setExaminPeopleName(BspUtil.getEmpOrgan().getOrganName());
			somApply.setExaminTime(DateUtil.getTime());
			}
		if (Activity.ACT_CHECK_CN.equals(somApply.getCurActivity())) {
			somApply.setCheckOpinionId(somApply.getCurOpinionId());
			somApply.setCheckOpinion(somApply.getCurOpinion());
			somApply.setCheckOrganId(BspUtil.getCorpOrganId());
			somApply.setCheckOrganName(BspUtil.getOrganName());
			somApply.setCheckDeptId(BspUtil.getDeptOrganId());
			somApply.setCheckDeptName(BspUtil.getDeptOrgan().getOrganName());
			somApply.setCheckPeopleId(BspUtil.getEmpOrgan().getOrganId());
			somApply.setCheckPeopleName(BspUtil.getEmpOrgan().getOrganName());
			somApply.setCheckTime(DateUtil.getTime());
			}
		if (Activity.ACT_AUDIT_CN.equals(somApply.getCurActivity())) {
			somApply.setAuditOpinionId(somApply.getCurOpinionId());
			somApply.setAuditOpinion(somApply.getCurOpinion());
			somApply.setAuditOrganId(BspUtil.getCorpOrganId());
			somApply.setAuditOrganName(BspUtil.getOrganName());
			somApply.setAuditDeptId(BspUtil.getDeptOrganId());
			somApply.setAuditDeptName(BspUtil.getDeptOrgan().getOrganName());
			somApply.setAuditPeopleId(BspUtil.getEmpOrgan().getOrganId());
			somApply.setAuditPeopleName(BspUtil.getEmpOrgan().getOrganName());
			somApply.setAuditTime(DateUtil.getTime());
			}
		}

	/**
	 * 清空业务信息中的当前信息
	 * @param applyBean 业务信息
	 * @param activityName 当前环节名称
	 */
	public void emptySomApply(SomApply applyBean, String activityName) {
		applyBean.setCurActivity(activityName);
		applyBean.setCurOpinionId("");
		applyBean.setCurOpinion("");
		applyBean.setCurOrganId("");
		applyBean.setCurOrganName("");
		applyBean.setCurDeptId("");
		applyBean.setCurDeptName("");
		applyBean.setCurPeopleId("");
		applyBean.setCurPeopleName("");
	}
	
	/**
	 * 更新业务信息中的当前信息
	 * @param applyBean
	 */
	public void curSomApply(SomApply applyBean){
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurPeopleId(BspUtil.getEmpOrgan().getOrganId());
		applyBean.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());
	}
	
	/**
	 * 查询社会团体流程信息（带组织机构过滤）
	 * @return
	 */
	public DataSet querySorgApply(ParameterSet pset) {
		String organCode = BspUtil.getEmpOrgan().getOrganCode();
		pset.setParameter("ORGAN_CODE", organCode);
		return somApplyDao.querySorgApply(pset);
	}
	/**
	 * 查询带有社会组织信息的流程信息
	 * @return
	 */
	public DataSet queryOrgan(ParameterSet pset) {
		return somApplyDao.queryOrgan(pset);
	}
	/**
	 * 更新somApply的社会组织名称和类别字段
	 * @param somOrgan
	 */
	public void updateSomApplyInfo(SomOrgan somOrgan){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID", somOrgan.getSorgId());
		DataSet ds = query(pset);
		RecordSet records=ds.getRecordSet();
		Iterator<Record> applys= records.iterator();
		while(applys.hasNext()){
			SomApply somApply=(SomApply)applys.next().toBean(SomApply.class);
			somApply.setSorgName(somOrgan.getCnName());
			somApply.setSorgKind(somOrgan.getSorgKind());
			update(somApply);
		}
	}
	/**
	 * 如果环节是补齐补正，清空业务表的初审审核审批意见
	 * @param somApply
	 */
	public void emptyExamToAudit(SomApply somApply) {
		somApply.setExaminOpinionId("");
		somApply.setExaminOpinion("");
		somApply.setExaminOrganId("");
		somApply.setExaminOrganName("");
		somApply.setExaminDeptId("");
		somApply.setExaminDeptName("");
		somApply.setExaminPeopleId("");
		somApply.setExaminPeopleName("");
		somApply.setExaminTime("");
		somApply.setCheckOpinionId("");
		somApply.setCheckOpinion("");
		somApply.setCheckOrganId("");
		somApply.setCheckOrganName("");
		somApply.setCheckDeptId("");
		somApply.setCheckDeptName("");
		somApply.setCheckPeopleId("");
		somApply.setCheckPeopleName("");
		somApply.setCheckTime("");
		somApply.setAuditOpinionId("");
		somApply.setAuditOpinion("");
		somApply.setAuditOrganId("");
		somApply.setAuditOrganName("");
		somApply.setAuditDeptId("");
		somApply.setAuditDeptName("");
		somApply.setAuditPeopleId("");
		somApply.setAuditPeopleName("");
		somApply.setAuditTime("");
		somApply.setAcceptTime(DateUtil.getTime());
	}
}

