package com.inspur.cams.sorg.jxcheck.somjxcheck.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.dao.jdbc.ComExtUserDao;
import com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivity;
import com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivityDao;
import com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.SomJxChangeCircs;
import com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.SomJxChangeCircsDao;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao.SomJxCheckAccountingPeople;
import com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao.SomJxCheckAccountingPeopleDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.SomJxCheckAuditOpinion;
import com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.SomJxCheckAuditOpinionDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheet;
import com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheetDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivity;
import com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivityDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlow;
import com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlowDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao.SomJxCheckChangesDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluate;
import com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluateDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditure;
import com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditureDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao.SomJxCheckFacingDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinance;
import com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinanceDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.SomJxCheckInMarket;
import com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.SomJxCheckInMarketDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeeting;
import com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeetingDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrg;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao.SomJxCheckInterProject;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao.SomJxCheckInterProjectDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajor;
import com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajorDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckParty;
import com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckPartyDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.SomJxCheckPunnish;
import com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.SomJxCheckPunnishDao;
import com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.SomJxCheckSupervisorOpin;
import com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.SomJxCheckSupervisorOpinDao;
import com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.SomJxCheckSystems;
import com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.SomJxCheckSystemsDao;
import com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetail;
import com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetailDao;
import com.inspur.cams.sorg.jxcheck.somjxcontribute.dao.SomJxContribute;
import com.inspur.cams.sorg.jxcheck.somjxcontribute.dao.SomJxContributeDao;
import com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeeting;
import com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeetingDao;
import com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.SomJxDiscriplineIntegrity;
import com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.SomJxDiscriplineIntegrityDao;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeopleDao;
import com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonation;
import com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonationDao;
import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetail;
import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao;
import com.inspur.cams.sorg.jxcheck.somjxoffice.dao.SomJxOfficeDao;
import com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasic;
import com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasicDao;
import com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFunds;
import com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFundsDao;
import com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOversee;
import com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOverseeDao;
import com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeople;
import com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeopleDao;
import com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamation;
import com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamationDao;
import com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrgan;
import com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrganDao;
import com.inspur.sdmz.comm.util.IdHelp;

/**
 * @title:SomJxCheckCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckCommand extends BaseAjaxCommand{
	//江西财务情况
	private SomJxCheckFinanceDao somJxCheckFinancedao = (SomJxCheckFinanceDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinanceDao");
	//江西资产负债表
	private SomJxCheckBalanceSheetDao somJxCheckBalanceSheetDao = (SomJxCheckBalanceSheetDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheetDao");
	//江西业务活动表
	private SomJxCheckBusinessActivityDao somJxCheckBusinessActivityDao = (SomJxCheckBusinessActivityDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivityDao");
	//江西现金流量表
	private SomJxCheckCashFlowDao somJxCheckCashFlowDao = (SomJxCheckCashFlowDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlowDao");
	//江西自律与诚信建设情况
	private SomJxDiscriplineIntegrityDao somJxDiscriplineIntegrityDao = (SomJxDiscriplineIntegrityDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.SomJxDiscriplineIntegrityDao");	
	//江西监事意见
	private SomJxCheckSupervisorOpinDao somJxCheckSupervisorOpinDao = (SomJxCheckSupervisorOpinDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.SomJxCheckSupervisorOpinDao");	
	// 江西社会组织年检信息
	private SomJxCheckDao somJxCheckDao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
	//江西会员和机构设置情况
	private SomJxVipOrganDao somJxVipOrganDao = (SomJxVipOrganDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrganDao");
	//江西人员情况
	private SomJxPeopleDao somJxPeopleDao = (SomJxPeopleDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeopleDao");
	//江西活动情况
	private SomJxActivityDao somJxActivityDao = (SomJxActivityDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivityDao");
	//江西评比达标表彰活动情况
	private SomJxCheckInMarketDao somJxCheckInMarketDao = (SomJxCheckInMarketDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.SomJxCheckInMarketDao");
	//江西党建情况
	private SomJxCheckPartyDao somJxCheckPartyDao = (SomJxCheckPartyDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckPartyDao");
	//江西变更情况
	private SomJxCheckChangesDao somJxCheckChangesDao = (SomJxCheckChangesDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao.SomJxCheckChangesDao");
	//江西评内设机构情况
	private SomJxOfficeDao somJxOfficeDao = (SomJxOfficeDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxoffice.dao.SomJxOfficeDao");
	//江西年度审计意见
	private SomJxCheckAuditOpinionDao somJxCheckAuditOpinionDao = (SomJxCheckAuditOpinionDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.SomJxCheckAuditOpinionDao");
	//江西理事会成员、监事和工作人员情况
	private SomJxFundPeopleDao somJxFundPeopleDao = (SomJxFundPeopleDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeopleDao");
	//江西信息公布情况
	private SomJxProclamationDao somJxProclamationDao = (SomJxProclamationDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamationDao");
	//江西涉外合作项目
	private SomJxCheckInterProjectDao somJxCheckInterProjectDao = (SomJxCheckInterProjectDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao.SomJxCheckInterProjectDao");
	//基金会
	private SomJxCheckFacingDao somJxCheckFacingDao=(SomJxCheckFacingDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao.SomJxCheckFacingDao");
	private SomJxCheckSystemsDao somJxCheckSystemsDao=(SomJxCheckSystemsDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.SomJxCheckSystemsDao");
	private SomJxChangeCircsDao somJxChangeCircsDao=(SomJxChangeCircsDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.SomJxChangeCircsDao");
	private SomJxCheckAccountingPeopleDao somJxCheckAccountingPeopleDao=(SomJxCheckAccountingPeopleDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao.SomJxCheckAccountingPeopleDao");
	private SomJxOrganBasicDao somJxOrganBasicDao=(SomJxOrganBasicDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasicDao");
	private SomJxOrganFundsDao somJxOrganFundsDao = (SomJxOrganFundsDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFundsDao");
	//国际会议Dao
	private SomJxCheckInterMeetingDao meetingDao = (SomJxCheckInterMeetingDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeetingDao");
	//国际组织Dao
	private SomJxCheckInterOrgDao orgDao = (SomJxCheckInterOrgDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao");
	private SomJxCommonwealDetailDao commonwealDetailDao = (SomJxCommonwealDetailDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetailDao");
	//江西接受监督管理的情况
	private SomJxOverseeDao somJxOverseeDao = (SomJxOverseeDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOverseeDao");
	//江西评估情况
	private SomJxCheckEvaluateDao somJxCheckEvaluateDao = (SomJxCheckEvaluateDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluateDao");
	//江西行政处罚情况
	private SomJxCheckPunnishDao somJxCheckPunnishDao = (SomJxCheckPunnishDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.SomJxCheckPunnishDao");
	//江西接受捐赠、公开募捐情况
	private SomJxContributeDao somJxContributeDao = (SomJxContributeDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcontribute.dao.SomJxContributeDao");
	//江西公益支出情况
	private SomJxCheckExpenditureDao somJxCheckExpenditureDao = (SomJxCheckExpenditureDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditureDao");
	//江西理事会召开情况 
	private SomJxCouncilMeetingDao somJxCouncilMeetingDao = (SomJxCouncilMeetingDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeetingDao");
	//江西大额捐赠收入情况
	private SomJxLargeDonationDao somJxLargeDonationDao = (SomJxLargeDonationDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonationDao");
	//江西重大公益项目收支明细表
	private SomJxMajorDetailDao somJxMajorDetailDao = (SomJxMajorDetailDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao");
	//江西重大公益项目大额支付对象
	private SomJxCheckMajorDao somJxCheckMajorDao = (SomJxCheckMajorDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajorDao");
	//社会组织外网用户
	private ComExtUserDao comExtUserDao = (ComExtUserDao)DaoFactory.getDao("com.inspur.cams.comm.extuser.dao.jdbc.ComExtUserDao");

	
	public void queryLastYearCheckResult(){
		String returnValue = "";
		ParameterSet pset = getParameterSet();
		String checkYear = (String) pset.getParameter("checkYear");
		String fillPeopleId = (String) pset.getParameter("fillPeopleId");
		pset.clear();
		pset.setParameter("FILL_PEOPLE_ID", fillPeopleId);
		pset.setParameter("CHECK_YEAR", checkYear);
		pset.setParameter("STATUS", "8");
		DataSet jxDs = somJxCheckDao.query(pset);
		if(jxDs!=null && jxDs.getCount()==1){
			//年检结果
			String value = (String) jxDs.getRecord(0).get("checkResult");
			if(value !=null && !("".equals(value))){
				if("0".endsWith(value)){
					returnValue = "不合格";
				}
				if("1".endsWith(value)){
					returnValue = "合格";
				}
				if("2".endsWith(value)){
					returnValue = "基本合格";
				}
				if("3".endsWith(value)){
					returnValue = "待处理";
				}
				if("4".endsWith(value)){
					returnValue = "一年未年检";
				}
				if("5".endsWith(value)){
					returnValue = "两年未年检";
				}
			}
			//年检结果描述
			value = (String) jxDs.getRecord(0).get("checkResultDesc");
			if(value !=null && !("".equals(value))){
				returnValue=returnValue+";"+value;
			}
		}
		if("".endsWith(returnValue)){
			pset.clear();
			pset.setParameter("USER_ID", fillPeopleId);
			DataSet ds = comExtUserDao.queryExtUser(pset);
			if(ds!=null && ds.getCount()==1){
				String value = (String) ds.getRecord(0).get("note");
				if(value !=null && !("".equals(value))){
					if("0".endsWith(value)){
						returnValue = "不合格";
					}
					if("1".endsWith(value)){
						returnValue = "合格";
					}
					if("2".endsWith(value)){
						returnValue = "基本合格";
					}
					if("3".endsWith(value)){
						returnValue = "一年未年检";
					}
					if("4".endsWith(value)){
						returnValue = "两年未年检";
					}
				}
			}
		}
		this.setReturn("lastYearCheckResult", returnValue);
	}
	/**
	 * 插入一条未填报的年检信息
	 */
	@Trans
	public void insertNoCheck(){
		ParameterSet pset = getParameterSet();
		SomJxCheck bean = new SomJxCheck();
		bean.setTaskCode(IdHelp.getUUID32());
		bean.setCnName((String)pset.getParameter("cnName"));
		bean.setSorgType((String)pset.getParameter("sorgType"));
		bean.setCheckYear((String)pset.getParameter("checkYear"));
		bean.setCheckResult((String)pset.getParameter("checkResult"));
		bean.setCheckResultDesc((String)pset.getParameter("checkResultDesc"));
		bean.setFillPeopleId((String)pset.getParameter("fillPeopleId"));
		bean.setFillPeopleName((String)pset.getParameter("fillPeopleName"));
		bean.setFillPeopleArea((String)pset.getParameter("fillPeopleArea"));
		bean.setStatus("8");
		bean.setCurrentActivity("1");
		somJxCheckDao.insert(bean);
	}
//##########################################         社团               ################################################
	@Trans
	public void savePage1(){
		Record checkRecord = (Record) getParameter("checkRecord");
		String taskCode = (String)getParameter("taskCode");
		SomJxCheck somjxCheck=(SomJxCheck)checkRecord.toBean(SomJxCheck.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxCheckDao.query(pset);
		if(ds.getCount() == 0){
			somJxCheckDao.insert(somjxCheck);
		}else if(ds.getCount() == 1){
			somJxCheckDao.update(somjxCheck);
		}
	}
	@Trans
	public void savePage3(){
		String taskCode = (String)getParameter("taskCode");
		Record checkRecord = (Record) getParameter("checkRecord");
		SomJxCheck somjxCheck=(SomJxCheck)checkRecord.toBean(SomJxCheck.class);
		somJxCheckDao.update(somjxCheck);
		Record somJxVipOrganRecord = (Record) getParameter("somJxVipOrganRecord");
		SomJxVipOrgan somJxVipOrgan=(SomJxVipOrgan)somJxVipOrganRecord.toBean(SomJxVipOrgan.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxVipOrganDao.query(pset);
		if(ds.getCount() == 0){
			somJxVipOrgan.setTaskCode(taskCode);
			somJxVipOrgan.setId(IdHelp.getUUID32());
			somJxVipOrganDao.insert(somJxVipOrgan);
		}else if(ds.getCount() == 1){
			somJxVipOrganDao.update(somJxVipOrgan);
		}
	}
	@Trans
	public void savePage4(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxPeopleRecord = (Record) getParameter("somJxPeopleRecord");
		SomJxPeople somJxPeople=(SomJxPeople)somJxPeopleRecord.toBean(SomJxPeople.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxPeopleDao.query(pset);
		if(ds.getCount() == 0){
			somJxPeople.setTaskCode(taskCode);
			somJxPeople.setId(IdHelp.getUUID32());
			somJxPeopleDao.insert(somJxPeople);
		}else if(ds.getCount() == 1){
			somJxPeopleDao.update(somJxPeople);
		}
	}
	@Trans
	public void savePage5(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxActivityRecord = (Record) getParameter("somJxActivityRecord");
		Record[] somJxCheckInMarketRecords = (Record[]) getParameter("somJxCheckInMarketRecords");
		SomJxActivity somJxActivity=(SomJxActivity)somJxActivityRecord.toBean(SomJxActivity.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxActivityDao.query(pset);
		if(ds.getCount() == 0){
			somJxActivity.setTaskCode(taskCode);
			somJxActivity.setId(IdHelp.getUUID32());
			somJxActivityDao.insert(somJxActivity);
		}else if(ds.getCount() == 1){
			somJxActivityDao.update(somJxActivity);
		}
		somJxCheckInMarketDao.deleteByTaskCode(taskCode);
		if(somJxCheckInMarketRecords != null){
			for(int i=0;i<somJxCheckInMarketRecords.length;i++){
				SomJxCheckInMarket somJxCheckInMarket = (SomJxCheckInMarket)somJxCheckInMarketRecords[i].toBean(SomJxCheckInMarket.class);
				somJxCheckInMarket.setTaskCode(taskCode);
				somJxCheckInMarket.setId(IdHelp.getUUID32());
				somJxCheckInMarketDao.insert(somJxCheckInMarket);
			}
		}
	}
	@Trans
	public void savePage6(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxCheckPartyRecord = (Record) getParameter("somJxCheckPartyRecord");
		SomJxCheckParty somJxCheckParty=(SomJxCheckParty)somJxCheckPartyRecord.toBean(SomJxCheckParty.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxCheckPartyDao.query(pset);
		if(ds.getCount() == 0){
			somJxCheckParty.setTaskCode(taskCode);
			somJxCheckParty.setId(IdHelp.getUUID32());
			somJxCheckPartyDao.insert(somJxCheckParty);
		}else if(ds.getCount() == 1){
			somJxCheckPartyDao.update(somJxCheckParty);
		}
	}
	@Trans
	public void savePage7(){
		Record JxCheckFinanceRecord = (Record) getParameter("JxCheckFinanceRecord");
		String taskCode = (String)getParameter("taskCode");
		if(JxCheckFinanceRecord!=null){
			SomJxCheckFinance bean = (SomJxCheckFinance) JxCheckFinanceRecord.toBean(SomJxCheckFinance.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckFinancedao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckFinancedao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckFinancedao.update(bean);
			}
		}
	}
	@Trans
	public void savePage8(){
		Record JxCheckBalanceSheetRecord = (Record) getParameter("JxCheckBalanceSheetRecord");
		String taskCode = (String)getParameter("taskCode");
		if(JxCheckBalanceSheetRecord!=null){
			SomJxCheckBalanceSheet bean = (SomJxCheckBalanceSheet) JxCheckBalanceSheetRecord.toBean(SomJxCheckBalanceSheet.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckBalanceSheetDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckBalanceSheetDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckBalanceSheetDao.update(bean);
			}
		}
	}
	@Trans
	public void savePage9(){
		Record businessActivityRecord = (Record) getParameter("businessActivityRecord");
		String taskCode = (String)getParameter("taskCode");
		if(businessActivityRecord!=null){
			SomJxCheckBusinessActivity bean = (SomJxCheckBusinessActivity) businessActivityRecord.toBean(SomJxCheckBusinessActivity.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckBusinessActivityDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckBusinessActivityDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckBusinessActivityDao.update(bean);
			}
		}
	}
	@Trans
	public void savePage10(){
		Record cashFlowRecord = (Record) getParameter("cashFlowRecord");
		String taskCode = (String)getParameter("taskCode");
		if(cashFlowRecord!=null){
			SomJxCheckCashFlow bean = (SomJxCheckCashFlow) cashFlowRecord.toBean(SomJxCheckCashFlow.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckCashFlowDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckCashFlowDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckCashFlowDao.update(bean);
			}
		}
	}
	@Trans
	public void savePage11(){
		Record jxCheckRecord = (Record) getParameter("jxCheckRecord");
		String taskCode = (String)getParameter("taskCode");
		if(jxCheckRecord!=null){
			SomJxCheck bean = (SomJxCheck) jxCheckRecord.toBean(SomJxCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setTaskCode(taskCode);
				bean.setStatus("0");
				bean.setCurrentActivity("0");
				somJxCheckDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setTaskCode(taskCode);
				bean.setStatus((String)ds.getRecord(0).get("status"));
				bean.setCurrentActivity((String)ds.getRecord(0).get("currentActivity"));
				somJxCheckDao.update(bean);
			}
		}
	}
//##########################################         民非               ################################################

	@Trans
	public void savePageM3(){
		Record jxCheckRecord = (Record) getParameter("jxCheckRecord");
		String taskCode = (String)getParameter("taskCode");
		if(jxCheckRecord!=null){
			SomJxCheck bean = (SomJxCheck) jxCheckRecord.toBean(SomJxCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setTaskCode(taskCode);
				bean.setStatus("0");
				bean.setCurrentActivity("0");
				somJxCheckDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setTaskCode(taskCode);
				bean.setStatus((String)ds.getRecord(0).get("status"));
				bean.setCurrentActivity((String)ds.getRecord(0).get("currentActivity"));
				bean.setReportDate((String)ds.getRecord(0).get("reportDate"));
				bean.setCheckYear((String)ds.getRecord(0).get("checkYear"));
				bean.setCnName((String)ds.getRecord(0).get("cnName"));
				bean.setSorgType((String)ds.getRecord(0).get("sorgType"));
				bean.setFillPeopleName((String)ds.getRecord(0).get("fillPeopleName"));
				bean.setFillPeopleId((String)ds.getRecord(0).get("fillPeopleId"));
				bean.setFillPeopleArea((String)ds.getRecord(0).get("fillPeopleArea"));
				somJxCheckDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageM4(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxPeopleRecord = (Record) getParameter("somJxPeopleRecord");
		SomJxPeople somJxPeople=(SomJxPeople)somJxPeopleRecord.toBean(SomJxPeople.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxPeopleDao.query(pset);
		if(ds.getCount() == 0){
			somJxPeople.setTaskCode(taskCode);
			somJxPeople.setId(IdHelp.getUUID32());
			somJxPeopleDao.insert(somJxPeople);
		}else if(ds.getCount() == 1){
			somJxPeopleDao.update(somJxPeople);
		}
	}
	@Trans
	public void savePageM5(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxVipOrganRecord = (Record) getParameter("somJxVipOrganRecord");
		Record somJxActivityRecord = (Record) getParameter("somJxActivityRecord");
		Record somJxDiscriplineIntegrityRecord = (Record) getParameter("somJxDiscriplineIntegrityRecord");
		SomJxVipOrgan somJxVipOrgan=(SomJxVipOrgan)somJxVipOrganRecord.toBean(SomJxVipOrgan.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxVipOrganDao.query(pset);
		if(ds.getCount() == 0){
			somJxVipOrgan.setTaskCode(taskCode);
			somJxVipOrgan.setId(IdHelp.getUUID32());
			somJxVipOrganDao.insert(somJxVipOrgan);
		}else if(ds.getCount() == 1){
			somJxVipOrganDao.update(somJxVipOrgan);
		}
		SomJxActivity somJxActivity=(SomJxActivity)somJxActivityRecord.toBean(SomJxActivity.class);
		pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		ds = somJxActivityDao.query(pset);
		if(ds.getCount() == 0){
			somJxActivity.setTaskCode(taskCode);
			somJxActivity.setId(IdHelp.getUUID32());
			somJxActivityDao.insert(somJxActivity);
		}else if(ds.getCount() == 1){
			somJxActivityDao.update(somJxActivity);
		}
		SomJxDiscriplineIntegrity somJxDiscriplineIntegrity=(SomJxDiscriplineIntegrity)somJxDiscriplineIntegrityRecord.toBean(SomJxDiscriplineIntegrity.class);
		pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		ds = somJxDiscriplineIntegrityDao.query(pset);
		if(ds.getCount() == 0){
			somJxDiscriplineIntegrity.setTaskCode(taskCode);
			somJxDiscriplineIntegrity.setId(IdHelp.getUUID32());
			somJxDiscriplineIntegrityDao.insert(somJxDiscriplineIntegrity);
		}else if(ds.getCount() == 1){
			somJxDiscriplineIntegrityDao.update(somJxDiscriplineIntegrity);
		}
	}
	@Trans
	public void savePageM6(){
		Record supervisorOpinRecord = (Record) getParameter("supervisorOpinRecord");
		String taskCode = (String)getParameter("taskCode");
		if(supervisorOpinRecord!=null){
			SomJxCheckSupervisorOpin bean = (SomJxCheckSupervisorOpin) supervisorOpinRecord.toBean(SomJxCheckSupervisorOpin.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckSupervisorOpinDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckSupervisorOpinDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckSupervisorOpinDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageM7(){
		Record JxCheckFinanceRecord = (Record) getParameter("JxCheckFinanceRecord");
		String taskCode = (String)getParameter("taskCode");
		if(JxCheckFinanceRecord!=null){
			SomJxCheckFinance bean = (SomJxCheckFinance) JxCheckFinanceRecord.toBean(SomJxCheckFinance.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckFinancedao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckFinancedao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckFinancedao.update(bean);
			}
		}
		
		Record checkRecord = (Record) getParameter("checkRecord");
		SomJxCheck somjxCheck=(SomJxCheck)checkRecord.toBean(SomJxCheck.class);
		somJxCheckDao.update(somjxCheck);
		
	}
//##########################################         基金会               ################################################	
	@Trans
	public void savePageJ1(){
		Record checkRecord = (Record) getParameter("checkRecord");
		Record somJxPeopleRecord = (Record) getParameter("somJxPeopleRecord");
		String taskCode = (String)getParameter("taskCode");
		SomJxCheck somjxCheck=(SomJxCheck)checkRecord.toBean(SomJxCheck.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxCheckDao.query(pset);
		if(ds.getCount() == 0){
			somJxCheckDao.insert(somjxCheck);
		}else if(ds.getCount() == 1){
			somJxCheckDao.update(somjxCheck);
		}
		SomJxPeople somJxPeople=(SomJxPeople)somJxPeopleRecord.toBean(SomJxPeople.class);
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("TASK_CODE", taskCode);
		DataSet ds2 = somJxPeopleDao.query(pset2);
		if(ds2.getCount() == 0){
			somJxPeople.setTaskCode(taskCode);
			somJxPeople.setId(IdHelp.getUUID32());
			somJxPeopleDao.insert(somJxPeople);
		}else if(ds2.getCount() == 1){
			somJxPeopleDao.update(somJxPeople);
		}
	}
	
	@Trans
	public void savePageJ3(){
		Record checkRecord = (Record) getParameter("checkRecord");
		String taskCode = (String)getParameter("taskCode");
		SomJxCouncilMeeting somjxCheck=(SomJxCouncilMeeting)checkRecord.toBean(SomJxCouncilMeeting.class);
		
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		pset.setParameter("SEQ", "1");
		DataSet ds = somJxCouncilMeetingDao.query(pset);
		if(ds.getCount() == 0){
			somjxCheck.setId(IdHelp.getUUID32());
			somJxCouncilMeetingDao.insert(somjxCheck);
		}else if(ds.getCount() == 1){
			somJxCouncilMeetingDao.update(somjxCheck);
		}
		Record checkRecord1 = (Record) getParameter("checkRecord1");
		SomJxCouncilMeeting somjxCheck1=(SomJxCouncilMeeting)checkRecord1.toBean(SomJxCouncilMeeting.class);
		
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("TASK_CODE", taskCode);
		pset1.setParameter("SEQ", "2");
		DataSet ds1 = somJxCouncilMeetingDao.query(pset1);
		if(ds1.getCount() == 0){
			somjxCheck1.setId(IdHelp.getUUID32());
			somJxCouncilMeetingDao.insert(somjxCheck1);
		}else if(ds1.getCount() == 1){
			somJxCouncilMeetingDao.update(somjxCheck1);
		}
	}
	@Trans
	public void savePageJ4(){
		Record[] fundPeopleRecords = (Record[]) getParameter("fundPeopleRecords");
		String taskCode = (String)getParameter("taskCode");
		
		somJxFundPeopleDao.deleteByTaskCode(taskCode,"1");
		somJxFundPeopleDao.deleteByTaskCode(taskCode,"2");
		if(fundPeopleRecords!=null && fundPeopleRecords.length>0){
			for (int i = 0; i < fundPeopleRecords.length; i++) {
				SomJxFundPeople bean = (SomJxFundPeople) fundPeopleRecords[i].toBean(SomJxFundPeople.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxFundPeopleDao.insert(bean);
			}
		}
		
	}
	
	@Trans
	public void savePageJ5(){
		Record[] fundPeopleRecords = (Record[]) getParameter("fundPeopleRecords");
		String taskCode = (String)getParameter("taskCode");
		
		somJxFundPeopleDao.deleteByTaskCode(taskCode,"3");
		if(fundPeopleRecords!=null && fundPeopleRecords.length>0){
			for (int i = 0; i < fundPeopleRecords.length; i++) {
				SomJxFundPeople bean = (SomJxFundPeople) fundPeopleRecords[i].toBean(SomJxFundPeople.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxFundPeopleDao.insert(bean);
			}
		}
		
	}
	@Trans
	public void savePageJ7(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxOrganBasicDataSet = (Record) getParameter("somJxOrganBasicDataSet");
		SomJxOrganBasic somJxOrganBasic=(SomJxOrganBasic)somJxOrganBasicDataSet.toBean(SomJxOrganBasic.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxOrganBasicDao.query(pset);
		if(ds.getCount() == 0){
			somJxOrganBasic.setTaskCode(taskCode);
			somJxOrganBasic.setId(IdHelp.getUUID32());
			somJxOrganBasicDao.insert(somJxOrganBasic);
		}else if(ds.getCount() == 1){
			somJxOrganBasicDao.update(somJxOrganBasic);
		}
	}
	@Trans
	public void savePageJ8(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somJxOrganFundsDao.deleteByTaskCodeAndOrganType(taskCode,"1");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomJxOrganFunds somJxOrganFunds = (SomJxOrganFunds)somJxOrganFundsDataSet[i].toBean(SomJxOrganFunds.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somJxOrganFundsDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ9(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somJxOrganFundsDao.deleteByTaskCodeAndOrganType(taskCode,"2");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomJxOrganFunds somJxOrganFunds = (SomJxOrganFunds)somJxOrganFundsDataSet[i].toBean(SomJxOrganFunds.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somJxOrganFundsDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ10(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somJxOrganFundsDao.deleteByTaskCodeAndOrganType(taskCode,"3");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomJxOrganFunds somJxOrganFunds = (SomJxOrganFunds)somJxOrganFundsDataSet[i].toBean(SomJxOrganFunds.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somJxOrganFundsDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ11(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somJxOrganFundsDao.deleteByTaskCodeAndOrganType(taskCode,"4");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomJxOrganFunds somJxOrganFunds = (SomJxOrganFunds)somJxOrganFundsDataSet[i].toBean(SomJxOrganFunds.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somJxOrganFundsDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ12(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somJxOrganFundsDao.deleteByTaskCodeAndOrganType(taskCode,"5");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomJxOrganFunds somJxOrganFunds = (SomJxOrganFunds)somJxOrganFundsDataSet[i].toBean(SomJxOrganFunds.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somJxOrganFundsDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ13(){
		Record somJxContributeRecord = (Record) getParameter("somJxContributeRecord");
		Record somJxContributeRecord1 = (Record) getParameter("somJxContributeRecord1");
		Record somJxCheckExpenditureRecord = (Record) getParameter("somJxCheckExpenditureRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxContributeRecord!=null){
			SomJxContribute bean = (SomJxContribute) somJxContributeRecord.toBean(SomJxContribute.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			pset.setParameter("IF_OPEN", "0");
			DataSet ds = somJxContributeDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxContributeDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setIfOpen((String)ds.getRecord(0).get("ifOpen"));
				somJxContributeDao.update(bean);
			}
		}
		if(somJxContributeRecord1!=null){
			SomJxContribute bean = (SomJxContribute) somJxContributeRecord1.toBean(SomJxContribute.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			pset.setParameter("IF_OPEN", "1");
			DataSet ds = somJxContributeDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxContributeDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setIfOpen((String)ds.getRecord(0).get("ifOpen"));
				somJxContributeDao.update(bean);
			}
		}
		if(somJxCheckExpenditureRecord!=null){
			SomJxCheckExpenditure bean = (SomJxCheckExpenditure) somJxCheckExpenditureRecord.toBean(SomJxCheckExpenditure.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckExpenditureDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckExpenditureDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckExpenditureDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageJ14(){
		Record somJxContributeRecord = (Record) getParameter("somJxContributeRecord");
		Record somJxCheckExpenditureRecord = (Record) getParameter("somJxCheckExpenditureRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxContributeRecord!=null){
			SomJxContribute bean = (SomJxContribute) somJxContributeRecord.toBean(SomJxContribute.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			pset.setParameter("IF_OPEN", "2");
			DataSet ds = somJxContributeDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxContributeDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setIfOpen((String)ds.getRecord(0).get("ifOpen"));
				somJxContributeDao.update(bean);
			}
		}
		if(somJxCheckExpenditureRecord!=null){
			SomJxCheckExpenditure bean = (SomJxCheckExpenditure) somJxCheckExpenditureRecord.toBean(SomJxCheckExpenditure.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckExpenditureDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckExpenditureDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckExpenditureDao.update(bean);
			}
		}
		
	}
	@Trans
	public void savePageJ15(){
		Record somJxCheckExpenditureRecord = (Record) getParameter("somJxCheckExpenditureRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckExpenditureRecord!=null){
			SomJxCheckExpenditure bean = (SomJxCheckExpenditure) somJxCheckExpenditureRecord.toBean(SomJxCheckExpenditure.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckExpenditureDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckExpenditureDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckExpenditureDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageJ16(){
		Record[] somJxLargeDonationRecords = (Record[]) getParameter("somJxLargeDonationRecords");
		String taskCode=(String) getParameter("taskCode");
		somJxLargeDonationDao.deleteByTaskCode(taskCode);
		if(somJxLargeDonationRecords!=null){
			for (int i = 0; i < somJxLargeDonationRecords.length; i++) {
				SomJxLargeDonation  somJxLargeDonationBean=(SomJxLargeDonation)somJxLargeDonationRecords[i].toBean(SomJxLargeDonation.class);
				 somJxLargeDonationBean.setId(IdHelp.getUUID32());
				 somJxLargeDonationBean.setTaskCode(taskCode);
				 somJxLargeDonationDao.insert(somJxLargeDonationBean);				
			}
		}
	}
	@Trans
	public void savePageJ17(){
		Record[] records = (Record[]) getParameter("records");
		String taskCode=(String) getParameter("taskCode");
		commonwealDetailDao.deleteByTaskCode(taskCode);
		if(records!=null){
			for (int i = 0; i < records.length; i++) {
				SomJxCommonwealDetail  record = (SomJxCommonwealDetail) records[i].toBean(SomJxCommonwealDetail.class)	;
				record.setId(IdHelp.getUUID32());
				record.setTaskCode(taskCode);
				commonwealDetailDao.insert(record);
			}
		}
	}
	@Trans
	public void savePageJ18(){
		Record[] somJxMajorDetailRecords = (Record[]) getParameter("somJxMajorDetailRecords");
		String taskCode = (String)getParameter("taskCode");		
		somJxMajorDetailDao.deleteByTaskCode(taskCode);
		if(somJxMajorDetailRecords!=null && somJxMajorDetailRecords.length>0){
			for (int i = 0; i < somJxMajorDetailRecords.length; i++) {
				SomJxMajorDetail bean = (SomJxMajorDetail) somJxMajorDetailRecords[i].toBean(SomJxMajorDetail.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxMajorDetailDao.insert(bean);
			}
		}
	}
	
	@Trans
	public void savePageJ19(){
		Record[] somJxCheckMajorRecords = (Record[]) getParameter("somJxCheckMajorRecords");
		String taskCode = (String)getParameter("taskCode");		
		somJxCheckMajorDao.deleteByTaskCode(taskCode);
		if(somJxCheckMajorRecords!=null && somJxCheckMajorRecords.length>0){
			for (int i = 0; i < somJxCheckMajorRecords.length; i++) {
				SomJxCheckMajor bean = (SomJxCheckMajor) somJxCheckMajorRecords[i].toBean(SomJxCheckMajor.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckMajorDao.insert(bean);
			}
		}
	}
	@Trans
	public void savePageJ20(){
		Record jxCheckRecord = (Record) getParameter("jxCheckRecord");
		String taskCode = (String)getParameter("taskCode");
		if(jxCheckRecord!=null){
			SomJxCheck bean = (SomJxCheck) jxCheckRecord.toBean(SomJxCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setTaskCode(taskCode);
				bean.setStatus("0");
				bean.setCurrentActivity("0");
				somJxCheckDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setTaskCode(taskCode);
				bean.setStatus((String)ds.getRecord(0).get("status"));
				bean.setCurrentActivity((String)ds.getRecord(0).get("currentActivity"));
				bean.setReportDate((String)ds.getRecord(0).get("reportDate"));
				bean.setCheckYear((String)ds.getRecord(0).get("checkYear"));
				bean.setCnName((String)ds.getRecord(0).get("cnName"));
				bean.setSorgType((String)ds.getRecord(0).get("sorgType"));
				bean.setFillPeopleName((String)ds.getRecord(0).get("fillPeopleName"));
				bean.setFillPeopleId((String)ds.getRecord(0).get("fillPeopleId"));
				bean.setFillPeopleArea((String)ds.getRecord(0).get("fillPeopleArea"));
				somJxCheckDao.update(bean);
			}
		}
	}	
	@Trans
	public void savePageJ21(){
		Record somJxCheckBalanceSheetRecord = (Record) getParameter("somJxCheckBalanceSheetRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckBalanceSheetRecord!=null){
			SomJxCheckBalanceSheet somJxCheckBalanceSheetBean = (SomJxCheckBalanceSheet) somJxCheckBalanceSheetRecord.toBean(SomJxCheckBalanceSheet.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckBalanceSheetDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckBalanceSheetBean.setId(IdHelp.getUUID32());
				somJxCheckBalanceSheetBean.setTaskCode(taskCode);
				somJxCheckBalanceSheetDao.insert(somJxCheckBalanceSheetBean);
			}
			if(ds.getCount()==1){
				somJxCheckBalanceSheetBean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckBalanceSheetBean.setTaskCode(taskCode);
				somJxCheckBalanceSheetDao.update(somJxCheckBalanceSheetBean);
			}
		}
	}
	@Trans
	public void savePageJ22(){
		Record somJxCheckBusinessActivityRecord = (Record) getParameter("somJxCheckBusinessActivityRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckBusinessActivityRecord!=null){
			SomJxCheckBusinessActivity somJxCheckBusinessActivityBean = (SomJxCheckBusinessActivity) somJxCheckBusinessActivityRecord.toBean(SomJxCheckBusinessActivity.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckBusinessActivityDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckBusinessActivityBean.setId(IdHelp.getUUID32());
				somJxCheckBusinessActivityBean.setTaskCode(taskCode);
				somJxCheckBusinessActivityDao.insert(somJxCheckBusinessActivityBean);
			}
			if(ds.getCount()==1){
				somJxCheckBusinessActivityBean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckBusinessActivityBean.setTaskCode(taskCode);
				somJxCheckBusinessActivityDao.update(somJxCheckBusinessActivityBean);
			}
		}
	}
	@Trans
	public void savePageJ23(){
		Record somJxCheckCashFlowRecord = (Record) getParameter("somJxCheckCashFlowRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckCashFlowRecord!=null){
			SomJxCheckCashFlow somJxCheckCashFlowRecordBean = (SomJxCheckCashFlow) somJxCheckCashFlowRecord.toBean(SomJxCheckCashFlow.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckCashFlowDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckCashFlowRecordBean.setId(IdHelp.getUUID32());
				somJxCheckCashFlowRecordBean.setTaskCode(taskCode);
				somJxCheckCashFlowDao.insert(somJxCheckCashFlowRecordBean);
			}
			if(ds.getCount()==1){
				somJxCheckCashFlowRecordBean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckCashFlowRecordBean.setTaskCode(taskCode);
				somJxCheckCashFlowDao.update(somJxCheckCashFlowRecordBean);
			}
		}
	}
	@Trans
	public void savePageJ24(){
		Record[] jxOverseeRecords = (Record[]) getParameter("jxOverseeRecords");
		Record jxCheckEvaluateRecord = (Record) getParameter("jxCheckEvaluateRecord");
		Record[] jxCheckPunnishRecords = (Record[]) getParameter("jxCheckPunnishRecords");
		String taskCode = (String)getParameter("taskCode");
		somJxOverseeDao.deleteByTaskCode(taskCode);
		if(jxOverseeRecords != null){
			for(int i=0;i<jxOverseeRecords.length;i++){
				SomJxOversee somJxOversee = (SomJxOversee)jxOverseeRecords[i].toBean(SomJxOversee.class);
				somJxOversee.setId(IdHelp.getUUID32());
				somJxOversee.setTaskCode(taskCode);
				somJxOverseeDao.insert(somJxOversee);
			}
		}
		if(jxCheckEvaluateRecord!=null){
			SomJxCheckEvaluate somJxCheckEvaluate = (SomJxCheckEvaluate) jxCheckEvaluateRecord.toBean(SomJxCheckEvaluate.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckEvaluateDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckEvaluate.setId(IdHelp.getUUID32());
				somJxCheckEvaluate.setTaskCode(taskCode);
				somJxCheckEvaluateDao.insert(somJxCheckEvaluate);
			}
			if(ds.getCount()==1){
				somJxCheckEvaluate.setId((String)ds.getRecord(0).get("id"));
				somJxCheckEvaluate.setTaskCode(taskCode);
				somJxCheckEvaluateDao.update(somJxCheckEvaluate);
			}
		}
		somJxCheckPunnishDao.deleteByTaskCode(taskCode);
		if(jxCheckPunnishRecords != null){
			for(int i=0;i<jxCheckPunnishRecords.length;i++){
				SomJxCheckPunnish somJxCheckPunnish = (SomJxCheckPunnish)jxCheckPunnishRecords[i].toBean(SomJxCheckPunnish.class);
				somJxCheckPunnish.setId(IdHelp.getUUID32());
				somJxCheckPunnish.setTaskCode(taskCode);
				somJxCheckPunnishDao.insert(somJxCheckPunnish);
			}
		}
	}
	@Trans
	public void savePageJ25(){
		Record auditOpinionRecord = (Record) getParameter("auditOpinionRecord");
		String taskCode = (String)getParameter("taskCode");
		if(auditOpinionRecord!=null){
			SomJxCheckAuditOpinion bean = (SomJxCheckAuditOpinion) auditOpinionRecord.toBean(SomJxCheckAuditOpinion.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somJxCheckAuditOpinionDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckAuditOpinionDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setTaskCode(taskCode);
				somJxCheckAuditOpinionDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageJ26(){
		Record[] somJxCheckSupervisorOpinRecords = (Record[]) getParameter("somJxCheckSupervisorOpinRecords");
		String taskCode = (String)getParameter("taskCode");
		somJxCheckSupervisorOpinDao.deleteByTaskCode(taskCode);
		if(somJxCheckSupervisorOpinRecords != null){
			for(int i=0;i<somJxCheckSupervisorOpinRecords.length;i++){
				SomJxCheckSupervisorOpin somJxCheckSupervisorOpinBean = (SomJxCheckSupervisorOpin)somJxCheckSupervisorOpinRecords[i].toBean(SomJxCheckSupervisorOpin.class);
				somJxCheckSupervisorOpinBean.setId(IdHelp.getUUID32());
				somJxCheckSupervisorOpinBean.setTaskCode(taskCode);
				somJxCheckSupervisorOpinDao.insert(somJxCheckSupervisorOpinBean);
			}
		}
	}
	@Trans
	public void savePageJ27(){
		Record somCheckRecord = (Record) getParameter("somCheckRecord");
		Record[] proclamationRecords = (Record[]) getParameter("proclamationRecords");
		String taskCode = (String)getParameter("taskCode");
		
		somJxProclamationDao.deleteByTaskCode(taskCode);
		if(proclamationRecords!=null && proclamationRecords.length>0){
			for (int i = 0; i < proclamationRecords.length; i++) {
				SomJxProclamation bean = (SomJxProclamation) proclamationRecords[i].toBean(SomJxProclamation.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxProclamationDao.insert(bean);
			}
		}
		SomJxCheck bean = (SomJxCheck) somCheckRecord.toBean(SomJxCheck.class);
		somJxCheckDao.update(bean);
		
	}
	@Trans
	public void savePageJ28(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxChangeCircsRecords = (Record[]) getParameter("somJxChangeCircsRecords");
		Record somJxCheckSystemsRecord = (Record) getParameter("somJxCheckSystemsRecord");		
		Record[] somJxCheckAccountingPeopleRecords = (Record[]) getParameter("somJxCheckAccountingPeopleRecords");
		
		somJxChangeCircsDao.deleteByTaskCode(taskCode);
		if(somJxChangeCircsRecords != null){
			for(int i=0;i<somJxChangeCircsRecords.length;i++){
				SomJxChangeCircs somJxChangeCircsBean = (SomJxChangeCircs)somJxChangeCircsRecords[i].toBean(SomJxChangeCircs.class);
				somJxChangeCircsBean.setId(IdHelp.getUUID32());
				somJxChangeCircsBean.setTaskCode(taskCode);
				somJxChangeCircsDao.insert(somJxChangeCircsBean);
			}
		}
		
		SomJxCheckSystems somJxCheckSystemsBean=(SomJxCheckSystems)somJxCheckSystemsRecord.toBean(SomJxCheckSystems.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somJxCheckSystemsDao.query(pset);
		if(ds.getCount() == 0){
			somJxCheckSystemsBean.setId(IdHelp.getUUID32());
			somJxCheckSystemsBean.setTaskCode(taskCode);
			somJxCheckSystemsDao.insert(somJxCheckSystemsBean);
		}else if(ds.getCount() == 1){
			somJxCheckSystemsBean.setId((String)ds.getRecord(0).get("id"));
			somJxCheckSystemsBean.setTaskCode(taskCode);
			somJxCheckSystemsDao.update(somJxCheckSystemsBean);
		}
		
		somJxCheckAccountingPeopleDao.deleteByTaskCode(taskCode);		
		if(somJxCheckAccountingPeopleRecords != null){
			for(int i=0;i<somJxCheckAccountingPeopleRecords.length;i++){
				SomJxCheckAccountingPeople somJxCheckAccountingPeopleBean = (SomJxCheckAccountingPeople)somJxCheckAccountingPeopleRecords[i].toBean(SomJxCheckAccountingPeople.class);
				somJxCheckAccountingPeopleBean.setId(IdHelp.getUUID32());
				somJxCheckAccountingPeopleBean.setTaskCode(taskCode);
				somJxCheckAccountingPeopleDao.insert(somJxCheckAccountingPeopleBean);
			}
		}
	}
	@Trans
	public void savePageJ29(){
		Record[] interProjectRecords = (Record[]) getParameter("interProjectRecords");
		Record[] checkInterMeetingRecords = (Record[]) getParameter("somCheckInterMeetingRecords");
		Record[] checkInterOrgRecords = (Record[]) getParameter("somCheckInterOrgRecords");
		String taskCode = (String)getParameter("taskCode");
		
		somJxCheckInterProjectDao.deleteByTaskCode(taskCode);
		if(interProjectRecords!=null && interProjectRecords.length>0){
			for (int i = 0; i < interProjectRecords.length; i++) {
				SomJxCheckInterProject bean = (SomJxCheckInterProject) interProjectRecords[i].toBean(SomJxCheckInterProject.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somJxCheckInterProjectDao.insert(bean);
			}
		}
		
		meetingDao.deleteByTaskCode(taskCode);
		if(checkInterMeetingRecords!=null){
			for (int i = 0; i < checkInterMeetingRecords.length; i++) {
				SomJxCheckInterMeeting  checkInterMeeting=(SomJxCheckInterMeeting)checkInterMeetingRecords[i].toBean(SomJxCheckInterMeeting.class);
				checkInterMeeting.setId(IdHelp.getUUID32());
				checkInterMeeting.setTaskCode(taskCode);
				meetingDao.insert(checkInterMeeting);				
			}
		}
		
		orgDao.deleteByTaskCode(taskCode);
		if(checkInterOrgRecords!=null){
			for (int i = 0; i < checkInterOrgRecords.length; i++) {
				SomJxCheckInterOrg  checkInterOrg=(SomJxCheckInterOrg)checkInterOrgRecords[i].toBean(SomJxCheckInterOrg.class);
				checkInterOrg.setId(IdHelp.getUUID32());
				checkInterOrg.setTaskCode(taskCode);
				orgDao.insert(checkInterOrg);				
			}
		}
	}
	/**
	 * 对打印按钮的控制
	 * 状态为校对通过的状态才可以打印
	 */
	@Trans
	public void printCheck(){
		String taskCode = (String)getParameter("taskCode");
		ParameterSet pset = new ParameterSet();
		pset.clear();
		pset.setParameter("TASK_CODE",taskCode);
		DataSet ds = somJxCheckDao.query(pset);
		if(ds.getCount() == 1){
			String status=(String)ds.getRecord(0).get("status");
			if("3".equals(status)){
				setReturn("flag", "Y");
			}else{
				setReturn("flag", "该年检信息未校对通过，无法打印！");
			}
		}else{
			setReturn("flag", "数据出错！");
		}
	}
}
