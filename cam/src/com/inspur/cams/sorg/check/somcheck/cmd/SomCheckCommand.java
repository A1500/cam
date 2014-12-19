package com.inspur.cams.sorg.check.somcheck.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.dao.jdbc.ComExtUserDao;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.check.balancesheet.dao.SomCheckBalanceSheetDao;
import com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet;
import com.inspur.cams.sorg.check.businessactivity.dao.SomCheckBusinessActivityDao;
import com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity;
import com.inspur.cams.sorg.check.checkcashflow.dao.SomCheckCashFlowDao;
import com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow;
import com.inspur.cams.sorg.check.checkchanges.dao.SomCheckChangesDao;
import com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges;
import com.inspur.cams.sorg.check.checkcouncil.dao.SomCheckCouncilDao;
import com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil;
import com.inspur.cams.sorg.check.checkdonatedetail.dao.SomCheckDonateDetailDao;
import com.inspur.cams.sorg.check.checkdonatedetail.data.SomCheckDonateDetail;
import com.inspur.cams.sorg.check.checkdues.dao.SomCheckDuesDao;
import com.inspur.cams.sorg.check.checkdues.data.SomCheckDues;
import com.inspur.cams.sorg.check.checkevent.dao.SomCheckEventDao;
import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.check.checkintermeeting.dao.SomCheckInterMeetingDao;
import com.inspur.cams.sorg.check.checkintermeeting.data.SomCheckInterMeeting;
import com.inspur.cams.sorg.check.checkinterorg.dao.SomCheckInterOrgDao;
import com.inspur.cams.sorg.check.checkinterorg.data.SomCheckInterOrg;
import com.inspur.cams.sorg.check.checkinterproject.dao.SomCheckInterProjectDao;
import com.inspur.cams.sorg.check.checkinterproject.data.SomCheckInterProject;
import com.inspur.cams.sorg.check.checkintervisit.dao.SomCheckInterVisitDao;
import com.inspur.cams.sorg.check.checkintervisit.data.SomCheckInterVisit;
import com.inspur.cams.sorg.check.checkmeetingelection.dao.SomCheckMeetingElectionDao;
import com.inspur.cams.sorg.check.checkmeetingelection.data.SomCheckMeetingElection;
import com.inspur.cams.sorg.check.checkorgchange.dao.SomCheckOrgChangeDao;
import com.inspur.cams.sorg.check.checkorgchange.data.SomCheckOrgChange;
import com.inspur.cams.sorg.check.checkorgdetail.dao.SomCheckOrgDetailDao;
import com.inspur.cams.sorg.check.checkorgdetail.data.SomCheckOrgDetail;
import com.inspur.cams.sorg.check.checkpublication.dao.SomCheckPublicationDao;
import com.inspur.cams.sorg.check.checkpublication.data.SomCheckPublication;
import com.inspur.cams.sorg.check.checkpublicbenefit.dao.SomCheckPublicBenefitDao;
import com.inspur.cams.sorg.check.checkpublicbenefit.data.SomCheckPublicBenefit;
import com.inspur.cams.sorg.check.checksuborgan.dao.SomCheckSuborganDao;
import com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan;
import com.inspur.cams.sorg.check.checksystems.dao.SomCheckSystemsDao;
import com.inspur.cams.sorg.check.checksystems.data.SomCheckSystems;
import com.inspur.cams.sorg.check.checkworker.dao.SomCheckWorkerDao;
import com.inspur.cams.sorg.check.checkworker.data.SomCheckWorker;
import com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao;
import com.inspur.cams.sorg.check.somcheck.data.SomCheck;
import com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeople;
import com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeopleDao;
import com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinion;
import com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinionDao;
import com.inspur.cams.sorg.check.somcheckchangecircs.dao.SomCheckChangeCircs;
import com.inspur.cams.sorg.check.somcheckchangecircs.dao.SomCheckChangeCircsDao;
import com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeeting;
import com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeetingDao;
import com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMember;
import com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMemberDao;
import com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluate;
import com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluateDao;
import com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditure;
import com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditureDao;
import com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonation;
import com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonationDao;
import com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajor;
import com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajorDao;
import com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetail;
import com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetailDao;
import com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckParty;
import com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckPartyDao;
import com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnish;
import com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnishDao;
import com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinion;
import com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinionDao;
import com.inspur.cams.sorg.check.somcontribute.dao.SomContribute;
import com.inspur.cams.sorg.check.somcontribute.dao.SomContributeDao;
import com.inspur.cams.sorg.check.somoversee.dao.SomOversee;
import com.inspur.cams.sorg.check.somoversee.dao.SomOverseeDao;
import com.inspur.cams.sorg.check.somproclamation.dao.SomProclamation;
import com.inspur.cams.sorg.check.somproclamation.dao.SomProclamationDao;
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
import com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluate;
import com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluateDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditure;
import com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditureDao;
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
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeopleDao;
import com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonation;
import com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonationDao;
import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetail;
import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao;
import com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasic;
import com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasicDao;
import com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFunds;
import com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFundsDao;
import com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOversee;
import com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOverseeDao;
import com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamation;
import com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamationDao;

/**
 * @title:SomCheckCommand
 * @description:
 * @author:
 * @since:2011-12-21
 * @version:1.0
*/
public class SomCheckCommand extends BaseAjaxCommand{
	//理事会情况 第1页
	private SomCheckCouncilDao somCheckCouncilDao = (SomCheckCouncilDao) DaoFactory .getDao("com.inspur.cams.sorg.check.checkcouncil.dao.SomCheckCouncilDao");
	// 第1、第13、第18、19页
	private SomCheckDao dao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");
	
	//资产负债表 第5页
	private SomCheckBalanceSheetDao somCheckBalanceSheetDao = (SomCheckBalanceSheetDao) DaoFactory
	.getDao("com.inspur.cams.sorg.check.balancesheet.dao.SomCheckBalanceSheetDao");
	
	//业务活动表 第6页
	private SomCheckBusinessActivityDao somCheckBusinessActivityDao = (SomCheckBusinessActivityDao) DaoFactory
	.getDao("com.inspur.cams.sorg.check.businessactivity.dao.SomCheckBusinessActivityDao");
	//工作人员情况 第2页
	private SomCheckWorkerDao somCheckWorkerDao = (SomCheckWorkerDao) DaoFactory .getDao("com.inspur.cams.sorg.check.checkworker.dao.SomCheckWorkerDao");
	//机构设置情况 第2、第9、10、11、12页
	private SomCheckOrgDetailDao somCheckOrgDetailDao = (SomCheckOrgDetailDao) DaoFactory .getDao("com.inspur.cams.sorg.check.checkorgdetail.dao.SomCheckOrgDetailDao");
	//举办刊物情况 第2页
	private SomCheckPublicationDao somCheckPublicationDao = (SomCheckPublicationDao) DaoFactory .getDao("com.inspur.cams.sorg.check.checkpublication.dao.SomCheckPublicationDao");
	//会费情况 第2页
	private SomCheckDuesDao somCheckDuesDao = (SomCheckDuesDao) DaoFactory .getDao("com.inspur.cams.sorg.check.checkdues.dao.SomCheckDuesDao");
	//变更情况 第3页
	private SomCheckChangesDao somCheckChangesDao = (SomCheckChangesDao) DaoFactory .getDao("com.inspur.cams.sorg.check.checkchanges.dao.SomCheckChangesDao");
	//本年度会议及换届情况 第3页
	private SomCheckMeetingElectionDao somCheckMeetingElectionDao = (SomCheckMeetingElectionDao) DaoFactory .getDao("com.inspur.cams.sorg.check.checkmeetingelection.dao.SomCheckMeetingElectionDao");
	//内部制度建设情况 第4页
	private SomCheckSystemsDao somCheckSystemsDao = (SomCheckSystemsDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checksystems.dao.SomCheckSystemsDao");
	//现金流量表 第7、8页
	private SomCheckCashFlowDao somCheckCashFlowDao = (SomCheckCashFlowDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkcashflow.dao.SomCheckCashFlowDao");
	//分支、代表、办事、专项基金管理机构情况 第9、10、11、12页
	private SomCheckSuborganDao somCheckSuborganDao = (SomCheckSuborganDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checksuborgan.dao.SomCheckSuborganDao");
	//本年度举办研讨、展览、培训、评比达标表彰等活动的情况 第14页
	private SomCheckEventDao somCheckEventDao = (SomCheckEventDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkevent.dao.SomCheckEventDao");
	//接受捐赠资助情况和使用情况 第15页
	private SomCheckDonateDetailDao somCheckDonateDetailDao = (SomCheckDonateDetailDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkdonatedetail.dao.SomCheckDonateDetailDao");
	//国际合作项目 第16页
	private SomCheckInterProjectDao somCheckInterProjectDao = (SomCheckInterProjectDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkinterproject.dao.SomCheckInterProjectDao");
	//参加国际会议 第16页
	private SomCheckInterMeetingDao somCheckInterMeetingDao = (SomCheckInterMeetingDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkintermeeting.dao.SomCheckInterMeetingDao");
	//参加国际组织page17
	private SomCheckInterOrgDao somCheckInterOrgDao = (SomCheckInterOrgDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkinterorg.dao.SomCheckInterOrgDao");
	//组团出国（境）访问page17
	private SomCheckInterVisitDao somCheckInterVisitDao = (SomCheckInterVisitDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkintervisit.dao.SomCheckInterVisitDao");
	//机构增减情况
	private SomCheckOrgChangeDao somCheckOrgChangeDao = (SomCheckOrgChangeDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkorgchange.dao.SomCheckOrgChangeDao");
	//公益活动情况
	private SomCheckPublicBenefitDao somCheckPublicBenefitDao = (SomCheckPublicBenefitDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkpublicbenefit.dao.SomCheckPublicBenefitDao");

	//TODO
	
	private SomCheckCouncilMeetingDao somCheckCouncilMeetingDao=(SomCheckCouncilMeetingDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeetingDao");

	private SomCheckCouncilMemberDao somCheckCouncilMemberDao=(SomCheckCouncilMemberDao)DaoFactory.getDao("com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMemberDao");
	
	private SomCheckPartyDao somCheckPartyDao=(SomCheckPartyDao)DaoFactory.getDao("com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckPartyDao");
	
	private SomContributeDao somContributeDao=(SomContributeDao)DaoFactory.getDao("com.inspur.cams.sorg.check.somcontribute.dao.SomContributeDao");
	
	private SomCheckExpenditureDao somCheckExpenditureDao=(SomCheckExpenditureDao)DaoFactory.getDao("com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditureDao");
	
	private SomCheckLargeDonationDao somCheckLargeDonationDao=(SomCheckLargeDonationDao)DaoFactory.getDao("com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonationDao");
	
	private SomCheckMajorDetailDao somCheckMajorDetailDao=(SomCheckMajorDetailDao)DaoFactory.getDao
		("com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetailDao");
	
	private SomCheckMajorDao somCheckMajorDao=(SomCheckMajorDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajorDao");
	
	private SomOverseeDao somOverseeDao=(SomOverseeDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somoversee.dao.SomOverseeDao");
	
	private SomCheckEvaluateDao somCheckEvaluateDao=(SomCheckEvaluateDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluateDao");
	
	private SomCheckPunnishDao somCheckPunnishDao=(SomCheckPunnishDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnishDao");
	
	private SomCheckAuditOpinionDao somCheckAuditOpinionDao=(SomCheckAuditOpinionDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinionDao");
	
	
	private SomCheckSupervisorOpinionDao somCheckSupervisorOpinionDao=(SomCheckSupervisorOpinionDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinionDao");
	
	private SomProclamationDao somProclamationDao=(SomProclamationDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somproclamation.dao.SomProclamationDao");
	
	
	private SomCheckAccountingPeopleDao somCheckAccountingPeopleDao=(SomCheckAccountingPeopleDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeopleDao");
	
	
	private SomCheckChangeCircsDao somCheckChangeCircsDao=(SomCheckChangeCircsDao)DaoFactory.getDao
	("com.inspur.cams.sorg.check.somcheckchangecircs.dao.SomCheckChangeCircsDao");
	
	//	//江西资产负债表
//	private SomJxCheckBalanceSheetDao somJxCheckBalanceSheetDao = (SomJxCheckBalanceSheetDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheetDao");
//	//江西业务活动表
//	private SomJxCheckBusinessActivityDao somJxCheckBusinessActivityDao = (SomJxCheckBusinessActivityDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivityDao");
//	//江西现金流量表
//	private SomJxCheckCashFlowDao somJxCheckCashFlowDao = (SomJxCheckCashFlowDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlowDao");
//	//江西监事意见
//	private SomJxCheckSupervisorOpinDao somJxCheckSupervisorOpinDao = (SomJxCheckSupervisorOpinDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.SomJxCheckSupervisorOpinDao");	
//	// 江西社会组织年检信息
//	private SomJxCheckDao somJxCheckDao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
//	//江西年度审计意见
//	private SomJxCheckAuditOpinionDao somJxCheckAuditOpinionDao = (SomJxCheckAuditOpinionDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.SomJxCheckAuditOpinionDao");
//	//江西理事会成员、监事和工作人员情况
//	private SomJxFundPeopleDao somJxFundPeopleDao = (SomJxFundPeopleDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeopleDao");
//	//江西信息公布情况
//	private SomJxProclamationDao somJxProclamationDao = (SomJxProclamationDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamationDao");
//	//江西涉外合作项目
//	private SomJxCheckInterProjectDao somJxCheckInterProjectDao = (SomJxCheckInterProjectDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao.SomJxCheckInterProjectDao");
//	//基金会
//	private SomJxCheckSystemsDao somJxCheckSystemsDao=(SomJxCheckSystemsDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.SomJxCheckSystemsDao");
//	private SomJxChangeCircsDao somJxChangeCircsDao=(SomJxChangeCircsDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.SomJxChangeCircsDao");
//	private SomJxCheckAccountingPeopleDao somJxCheckAccountingPeopleDao=(SomJxCheckAccountingPeopleDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao.SomJxCheckAccountingPeopleDao");
//	private SomJxOrganBasicDao somJxOrganBasicDao=(SomJxOrganBasicDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasicDao");
//	private SomJxOrganFundsDao somJxOrganFundsDao = (SomJxOrganFundsDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFundsDao");
//	//国际会议Dao
//	private SomJxCheckInterMeetingDao meetingDao = (SomJxCheckInterMeetingDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeetingDao");
//	//国际组织Dao
//	private SomJxCheckInterOrgDao orgDao = (SomJxCheckInterOrgDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao");
//	private SomJxCommonwealDetailDao commonwealDetailDao = (SomJxCommonwealDetailDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetailDao");
//	//江西接受监督管理的情况
//	private SomJxOverseeDao somJxOverseeDao = (SomJxOverseeDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOverseeDao");
//	//江西评估情况
//	private SomJxCheckEvaluateDao somJxCheckEvaluateDao = (SomJxCheckEvaluateDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluateDao");
//	//江西行政处罚情况
//	private SomJxCheckPunnishDao somJxCheckPunnishDao = (SomJxCheckPunnishDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.SomJxCheckPunnishDao");
//	//江西接受捐赠、公开募捐情况
//	private SomJxContributeDao somJxContributeDao = (SomJxContributeDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcontribute.dao.SomJxContributeDao");
//	//江西公益支出情况
//	private SomJxCheckExpenditureDao somJxCheckExpenditureDao = (SomJxCheckExpenditureDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditureDao");
//	//江西理事会召开情况 
//	private SomJxCouncilMeetingDao somJxCouncilMeetingDao = (SomJxCouncilMeetingDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao.SomJxCouncilMeetingDao");
//	//江西大额捐赠收入情况
//	private SomJxLargeDonationDao somJxLargeDonationDao = (SomJxLargeDonationDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonationDao");
//	//江西重大公益项目收支明细表
//	private SomJxMajorDetailDao somJxMajorDetailDao = (SomJxMajorDetailDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao");
//	//江西重大公益项目大额支付对象
//	private SomJxCheckMajorDao somJxCheckMajorDao = (SomJxCheckMajorDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajorDao");
//	//江西党建情况
//	private SomJxCheckPartyDao somJxCheckPartyDao = (SomJxCheckPartyDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckPartyDao");
	//社会组织外网用户
	private ComExtUserDao comExtUserDao = (ComExtUserDao)DaoFactory.getDao("com.inspur.cams.comm.extuser.dao.jdbc.ComExtUserDao");

	public void queryLastYearCheckResult(){
		String returnValue = "";
		ParameterSet pset = getParameterSet();
		String batchYear = (String) pset.getParameter("batchYear");
		String fillPeopleId = (String) pset.getParameter("fillPeopleId");
		pset.clear();
		pset.setParameter("FILL_PEOPLE_ID", fillPeopleId);
		pset.setParameter("BATCH_YEAR", batchYear);
		pset.setParameter("STATUS", "8");
		DataSet dset = dao.query(pset);
		if(dset!=null && dset.getCount()==1){
			//年检结果
			String value = (String) dset.getRecord(0).get("checkResult");
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
			value = (String) dset.getRecord(0).get("checkResultDesc");
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
	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheck dataBean=(SomCheck)record.toBean(SomCheck.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheck dataBean=(SomCheck)record.toBean(SomCheck.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheck> list = new ArrayList<SomCheck>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheck dataBean = (SomCheck) records[i].toBean(SomCheck.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	
	@Trans
	public void savePage1() {
		Record checkRecord = (Record) getParameter("checkRecord");
		Record checkCouncilRecord = (Record) getParameter("checkCouncilRecord");
		String taskCode = (String)getParameter("taskCode");
		if(checkRecord!=null){
			SomCheck dataBean=(SomCheck)checkRecord.toBean(SomCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = dao.query(pset);
			if(ds==null || ds.getCount() == 0){
				dataBean.setTaskCode(taskCode);
				dataBean.setStatus("0");
				dao.insert(dataBean);
			}else if(ds.getCount()==1){
				dataBean.setTaskCode(taskCode);
				dataBean.setStatus("0");
				dao.update(dataBean);
			}
		}
		if(checkCouncilRecord!=null){
			SomCheckCouncil checkCouncilDataBean=(SomCheckCouncil)checkCouncilRecord.toBean(SomCheckCouncil.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckCouncilDao.query(pset);
			if(ds==null || ds.getCount() == 0){
				checkCouncilDataBean.setId(IdHelp.getUUID32());
				checkCouncilDataBean.setTaskCode(taskCode);
				somCheckCouncilDao.insert(checkCouncilDataBean);
			}else if(ds.getCount()==1){
				checkCouncilDataBean.setId((String)ds.getRecord(0).get("id"));
				somCheckCouncilDao.update(checkCouncilDataBean);
			}
		}
	}
	
	@Trans
	public void savePage2() {
		Record checkWorkerRecord = (Record) getParameter("checkWorkerRecord");
		Record checkOrgDetailRecord = (Record) getParameter("checkOrgDetailRecord");
		Record checkPublicationRecord = (Record) getParameter("checkPublicationRecord");
		Record checkDuesRecord = (Record) getParameter("checkDuesRecord");
		String taskCode = (String) getParameter("taskCode");
		if(checkWorkerRecord!=null){
			SomCheckWorker checkWorkerBean=(SomCheckWorker)checkWorkerRecord.toBean(SomCheckWorker.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckWorkerDao.query(pset);
			if(ds==null || ds.getCount()==0){
				checkWorkerBean.setId(IdHelp.getUUID32());
				somCheckWorkerDao.insert(checkWorkerBean);
			}if(ds.getCount()==1){
				checkWorkerBean.setId((String)ds.getRecord(0).get("id"));
				somCheckWorkerDao.update(checkWorkerBean);
			}
		}
		if(checkOrgDetailRecord!=null){
			SomCheckOrgDetail checkOrgDetailBean=(SomCheckOrgDetail)checkOrgDetailRecord.toBean(SomCheckOrgDetail.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckOrgDetailDao.query(pset);
			if(ds==null || ds.getCount()==0){
				checkOrgDetailBean.setId(IdHelp.getUUID32());
				somCheckOrgDetailDao.insert(checkOrgDetailBean);
			}if(ds.getCount()==1){
				checkOrgDetailBean.setId((String)ds.getRecord(0).get("id"));
				somCheckOrgDetailDao.update(checkOrgDetailBean);
			}
		}
		if(checkPublicationRecord!=null){
			SomCheckPublication checkPublicationBean=(SomCheckPublication)checkPublicationRecord.toBean(SomCheckPublication.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckPublicationDao.query(pset);
			if(ds==null || ds.getCount()==0){
				checkPublicationBean.setId(IdHelp.getUUID32());
				somCheckPublicationDao.insert(checkPublicationBean);
			}if(ds.getCount()==1){
				checkPublicationBean.setId((String)ds.getRecord(0).get("id"));
				somCheckPublicationDao.update(checkPublicationBean);
			}
		}
		if(checkDuesRecord!=null){
			SomCheckDues checkDuesBean=(SomCheckDues)checkDuesRecord.toBean(SomCheckDues.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckDuesDao.query(pset);
			if(ds==null || ds.getCount()==0){
				checkDuesBean.setId(IdHelp.getUUID32());
				somCheckDuesDao.insert(checkDuesBean);
			}if(ds.getCount()==1){
				checkDuesBean.setId((String)ds.getRecord(0).get("id"));
				somCheckDuesDao.update(checkDuesBean);
			}
		}
	}
	
	@Trans
	public void savePage3() {
		Record[] checkChangesRecords = (Record[]) getParameter("checkChangesRecords");
		Record checkMeetingElectionRecord = (Record) getParameter("checkMeetingElectionRecord");
		String taskCode = (String) getParameter("taskCode");
		somCheckChangesDao.deleteByTaskCode(taskCode);
		if(checkChangesRecords != null){
			for (int i = 0; i < checkChangesRecords.length; i++) {
				SomCheckChanges changeBean = (SomCheckChanges) checkChangesRecords[i].toBean(SomCheckChanges.class);
				changeBean.setId(IdHelp.getUUID32());
				somCheckChangesDao.insert(changeBean);
			}
		}
		if(checkMeetingElectionRecord!=null){
			SomCheckMeetingElection checkMeetingElectionBean = (SomCheckMeetingElection) checkMeetingElectionRecord.toBean(SomCheckMeetingElection.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckMeetingElectionDao.query(pset);
			if(ds==null || ds.getCount()==0){
				checkMeetingElectionBean.setId(IdHelp.getUUID32());
				somCheckMeetingElectionDao.insert(checkMeetingElectionBean);
			}if(ds.getCount()==1){
				checkMeetingElectionBean.setId((String)ds.getRecord(0).get("id"));
				somCheckMeetingElectionDao.update(checkMeetingElectionBean);
			}
		}
	}
	
	@Trans
	public void savePage4() {
		Record checkSystemsRecord = (Record) getParameter("checkSystemsRecord");
		String taskCode=(String) getParameter("taskCode");
		if(checkSystemsRecord!=null){
			SomCheckSystems checkSystemsBean=(SomCheckSystems)checkSystemsRecord.toBean(SomCheckSystems.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckSystemsDao.query(pset);
			if(ds==null||ds.getCount()<1){
				checkSystemsBean.setId(IdHelp.getUUID32());
				checkSystemsBean.setTaskCode(taskCode);
				somCheckSystemsDao.insert(checkSystemsBean);				
			}else{
				checkSystemsBean.setId((String)ds.getRecord(0).get("id"));
				somCheckSystemsDao.update(checkSystemsBean);
			}
		}
	}
	
	@Trans
	public void savePage5() {
		String taskCode = (String)getParameter("taskCode");
		Record somCheckBalanceSheetRecord = (Record) getParameter("somCheckBalanceSheetRecord");
		SomCheckBalanceSheet dataBean=(SomCheckBalanceSheet)somCheckBalanceSheetRecord.toBean(SomCheckBalanceSheet.class);
		dataBean.setTaskCode(taskCode);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=",taskCode);
		DataSet ds = somCheckBalanceSheetDao.query(pset);
		if(ds.getCount()==0){
			dataBean.setId(IdHelp.getUUID32());
			somCheckBalanceSheetDao.insert(dataBean);
		}else{
			dataBean.setId((String)ds.getRecord(0).get("id"));
			somCheckBalanceSheetDao.update(dataBean);
		}
	}
	
	@Trans
	public void savePage6() {
		String taskCode = (String)getParameter("taskCode");
		Record record = (Record) getParameter("record");
		SomCheckBusinessActivity dataBean=(SomCheckBusinessActivity)record.toBean(SomCheckBusinessActivity.class);
		dataBean.setTaskCode(taskCode);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=",taskCode);
		DataSet ds = somCheckBusinessActivityDao.query(pset);
		if(ds.getCount()==0){
			dataBean.setId(IdHelp.getUUID32());
			somCheckBusinessActivityDao.insert(dataBean);
		}else{
			dataBean.setId((String)ds.getRecord(0).get("id"));
			somCheckBusinessActivityDao.update(dataBean);
		}
	}
	
	@Trans
	public void savePage7() {
		Record checkCashFlowRecord = (Record) getParameter("checkCashFlowRecord");
		String taskCode=(String) getParameter("taskCode");
		if(checkCashFlowRecord!=null){
			SomCheckCashFlow checkCashFlowBean=(SomCheckCashFlow)checkCashFlowRecord.toBean(SomCheckCashFlow.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckCashFlowDao.query(pset);
			if(ds==null||ds.getCount()<1){
				checkCashFlowBean.setId(IdHelp.getUUID32());
				checkCashFlowBean.setTaskCode(taskCode);
				somCheckCashFlowDao.insert(checkCashFlowBean);				
			}else{
				checkCashFlowBean.setId((String)ds.getRecord(0).get("id"));
				somCheckCashFlowDao.update(checkCashFlowBean);
			}
		}
	}
	
	@Trans
	public void savePage8() {
		Record checkCashFlowRecord = (Record) getParameter("checkCashFlowRecord");
		String taskCode=(String) getParameter("taskCode");
		if(checkCashFlowRecord!=null){
			SomCheckCashFlow checkCashFlowBean=(SomCheckCashFlow)checkCashFlowRecord.toBean(SomCheckCashFlow.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckCashFlowDao.query(pset);
			if(ds==null||ds.getCount()<1){
				checkCashFlowBean.setId(IdHelp.getUUID32());
				checkCashFlowBean.setTaskCode(taskCode);
				somCheckCashFlowDao.insert(checkCashFlowBean);				
			}else{
				checkCashFlowBean.setId((String)ds.getRecord(0).get("id"));
				somCheckCashFlowDao.update(checkCashFlowBean);
			}
		}
	}
	

	@Trans
	public void savePage9() {
		Record[] checkSuborganRecords = (Record[]) getParameter("checkSuborganRecords");
		Record checkOrgDetailRecord = (Record) getParameter("checkOrgDetailRecord");
		String taskCode=(String) getParameter("taskCode");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"F");//分支机构
		if(checkSuborganRecords!=null){
			for (int i = 0; i < checkSuborganRecords.length; i++) {
				SomCheckSuborgan checkSuborganBean=(SomCheckSuborgan)checkSuborganRecords[i].toBean(SomCheckSuborgan.class);
				checkSuborganBean.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(checkSuborganBean);				
			}
		}
		if(checkOrgDetailRecord!=null){
			SomCheckOrgDetail checkOrgDetailBean=(SomCheckOrgDetail)checkOrgDetailRecord.toBean(SomCheckOrgDetail.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckOrgDetailDao.query(pset);
			if(ds==null||ds.getCount()<1){
				checkOrgDetailBean.setId(IdHelp.getUUID32());
				somCheckOrgDetailDao.insert(checkOrgDetailBean);				
			}else{
				checkOrgDetailBean.setId((String)ds.getRecord(0).get("id"));
				somCheckOrgDetailDao.update(checkOrgDetailBean);
			}
		}
	}
	

	@Trans
	public void savePage10() {
		Record[] checkSuborganRecords = (Record[]) getParameter("checkSuborganRecords");
		Record checkOrgDetailRecord = (Record) getParameter("checkOrgDetailRecord");
		String taskCode=(String) getParameter("taskCode");
		
		somCheckSuborganDao.deleteByTaskCode(taskCode,"D");//代表机构
		if(checkSuborganRecords!=null){
			for (int i = 0; i < checkSuborganRecords.length; i++) {
				SomCheckSuborgan checkSuborganBean=(SomCheckSuborgan)checkSuborganRecords[i].toBean(SomCheckSuborgan.class);
				checkSuborganBean.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(checkSuborganBean);				
			}
		}
		if(checkOrgDetailRecord!=null){
			SomCheckOrgDetail checkOrgDetailBean=(SomCheckOrgDetail)checkOrgDetailRecord.toBean(SomCheckOrgDetail.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckOrgDetailDao.query(pset);
			if(ds==null||ds.getCount()<1){
				checkOrgDetailBean.setId(IdHelp.getUUID32());
				somCheckOrgDetailDao.insert(checkOrgDetailBean);				
			}else{
				checkOrgDetailBean.setId((String)ds.getRecord(0).get("id"));
				somCheckOrgDetailDao.update(checkOrgDetailBean);
			}
		}
	}

	@Trans
	public void savePage11() {
		Record[] checkSuborganRecords = (Record[]) getParameter("checkSuborganRecords");
		Record checkOrgDetailRecord = (Record) getParameter("checkOrgDetailRecord");
		String taskCode=(String) getParameter("taskCode");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"B");//办事机构
		if(checkSuborganRecords!=null){
			for (int i = 0; i < checkSuborganRecords.length; i++) {
				SomCheckSuborgan checkSuborganBean=(SomCheckSuborgan)checkSuborganRecords[i].toBean(SomCheckSuborgan.class);
				checkSuborganBean.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(checkSuborganBean);				
			}
		}
		if(checkOrgDetailRecord!=null){
			SomCheckOrgDetail checkOrgDetailBean=(SomCheckOrgDetail)checkOrgDetailRecord.toBean(SomCheckOrgDetail.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckOrgDetailDao.query(pset);
			if(ds==null||ds.getCount()<1){
				checkOrgDetailBean.setId(IdHelp.getUUID32());
				somCheckOrgDetailDao.insert(checkOrgDetailBean);				
			}else{
				checkOrgDetailBean.setId((String)ds.getRecord(0).get("id"));
				somCheckOrgDetailDao.update(checkOrgDetailBean);
			}
		}
	}

	@Trans
	public void savePage12() {
		Record[] checkSuborganRecords = (Record[]) getParameter("checkSuborganRecords");
		Record checkOrgDetailRecord = (Record) getParameter("checkOrgDetailRecord");
		String taskCode=(String) getParameter("taskCode");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"Z");//专项基金管理机构
		if(checkSuborganRecords!=null){
			for (int i = 0; i < checkSuborganRecords.length; i++) {
				SomCheckSuborgan checkSuborganBean=(SomCheckSuborgan)checkSuborganRecords[i].toBean(SomCheckSuborgan.class);
				checkSuborganBean.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(checkSuborganBean);				
			}
		}
		if(checkOrgDetailRecord!=null){
			SomCheckOrgDetail checkOrgDetailBean=(SomCheckOrgDetail)checkOrgDetailRecord.toBean(SomCheckOrgDetail.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckOrgDetailDao.query(pset);
			if(ds==null||ds.getCount()<1){
				checkOrgDetailBean.setId(IdHelp.getUUID32());
				somCheckOrgDetailDao.insert(checkOrgDetailBean);				
			}else{
				checkOrgDetailBean.setId((String)ds.getRecord(0).get("id"));
				somCheckOrgDetailDao.update(checkOrgDetailBean);
			}
		}
	}

	@Trans
	public void savePage13() {
		Record checkRecord = (Record) getParameter("checkRecord");
		String taskCode = (String) getParameter("taskCode");
		if(checkRecord!=null){
			SomCheck dataBean = (SomCheck) checkRecord.toBean(SomCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = dao.query(pset);
			if(ds!=null&&ds.getCount()==1){
				dao.update(dataBean);
			}
		}
	}
	
	@Trans
	public void savePage14() {
		Record[] checkEventRecords = (Record[]) getParameter("checkEventRecords");
		String taskCode = (String) getParameter("taskCode");
		somCheckEventDao.deleteByTaskCode(taskCode);
		if(checkEventRecords != null){
			for (int i = 0; i < checkEventRecords.length; i++) {
				SomCheckEvent eventBean = (SomCheckEvent) checkEventRecords[i].toBean(SomCheckEvent.class);
				eventBean.setId(IdHelp.getUUID32());
				somCheckEventDao.insert(eventBean);
			}
		}
	}
	
	@Trans
	public void savePage15() {
		Record checkDonateDetailRecord = (Record) getParameter("checkDonateDetailRecord");
		String taskCode = (String) getParameter("taskCode");
		if(checkDonateDetailRecord!=null){
			SomCheckDonateDetail checkDonateDetailBean = (SomCheckDonateDetail) checkDonateDetailRecord.toBean(SomCheckDonateDetail.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckDonateDetailDao.query(pset);
			if(ds==null || ds.getCount()==0){
				checkDonateDetailBean.setId(IdHelp.getUUID32());
				somCheckDonateDetailDao.insert(checkDonateDetailBean);
			}if(ds.getCount()==1){
				checkDonateDetailBean.setId((String)ds.getRecord(0).get("id"));
				somCheckDonateDetailDao.update(checkDonateDetailBean);
			}
		}
	}
	
	@Trans
	public void savePage16() {
		Record[] checkInterProjectRecords = (Record[]) getParameter("checkInterProjectRecords");
		Record[] checkInterMeetingRecords = (Record[]) getParameter("checkInterMeetingRecords");
		String taskCode = (String) getParameter("taskCode");
		somCheckInterProjectDao.deleteByTaskCode(taskCode);
		if(checkInterProjectRecords != null){
			for (int i = 0; i < checkInterProjectRecords.length; i++) {
				SomCheckInterProject bean = (SomCheckInterProject) checkInterProjectRecords[i].toBean(SomCheckInterProject.class);
				bean.setId(IdHelp.getUUID32());
				somCheckInterProjectDao.insert(bean);
			}
		}
		somCheckInterMeetingDao.deleteByTaskCode(taskCode);
		if(checkInterMeetingRecords != null){
			for (int i = 0; i < checkInterMeetingRecords.length; i++) {
				SomCheckInterMeeting bean = (SomCheckInterMeeting) checkInterMeetingRecords[i].toBean(SomCheckInterMeeting.class);
				bean.setId(IdHelp.getUUID32());
				somCheckInterMeetingDao.insert(bean);
			}
		}
	}

	@Trans
	public void savePage17(){
		Record[] somCheckInterVisits = (Record[]) getParameter("somCheckInterVisit");
		String taskCode = (String) getParameter("taskCode");
		somCheckInterVisitDao.deleteByTaskCode(taskCode);
		if(somCheckInterVisits!=null){
			for(int i=0;i<somCheckInterVisits.length;i++){
				SomCheckInterVisit dataBean = (SomCheckInterVisit) somCheckInterVisits[i].toBean(SomCheckInterVisit.class);
				dataBean.setId(IdHelp.getUUID32());
				somCheckInterVisitDao.insert(dataBean);
			}
		}
		Record[] somCheckInterOrgs = (Record[]) getParameter("somCheckInterOrg");
		somCheckInterOrgDao.deleteByTaskCode(taskCode);
		if(somCheckInterOrgs!=null){
			for(int i=0;i<somCheckInterOrgs.length;i++){
				SomCheckInterOrg dataBean = (SomCheckInterOrg) somCheckInterOrgs[i].toBean(SomCheckInterOrg.class);
				dataBean.setId(IdHelp.getUUID32());
				somCheckInterOrgDao.insert(dataBean);
				
			}
		}
	}
	
	@Trans
	public void savePage18() {
		Record checkRecord = (Record) getParameter("checkRecord");
		String taskCode = (String) getParameter("taskCode");
		if(checkRecord!=null){
			SomCheck dataBean = (SomCheck) checkRecord.toBean(SomCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = dao.query(pset);
			if(ds!=null&&ds.getCount()==1){
				dao.update(dataBean);
			}
		}
	}
	
	@Trans
	public void savePage19() {
		Record checkRecord = (Record) getParameter("checkRecord");
		String taskCode = (String) getParameter("taskCode");
		if(checkRecord!=null){
			SomCheck dataBean = (SomCheck) checkRecord.toBean(SomCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = dao.query(pset);
			if(ds!=null&&ds.getCount()==1){
				dao.update(dataBean);
			}
		}
	}

	//##########################################         民非               ################################################
	@Trans
	public void savePageM3() {
		String taskCode = (String)getParameter("taskCode");
		Record somCheckRecord = (Record) getParameter("somCheckRecord");
		Record somCheckWorkerRecord = (Record) getParameter("somCheckWorkerRecord");
		Record[] somCheckSuborganRecords = (Record[]) getParameter("somCheckSuborganRecords");
		Record[] somCheckChangesRecords = (Record[]) getParameter("somCheckChangesRecords");
		String pageNum = (String)getParameter("pageNum");//通过页码来确定是否对变更记录进行删除
		ParameterSet pset = new ParameterSet();
		DataSet ds;
		if(somCheckRecord!=null){
			SomCheck somCheckBean=(SomCheck)somCheckRecord.toBean(SomCheck.class);
			pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			ds = dao.query(pset);
			if(ds.getCount() == 0){
				dao.insert(somCheckBean);
			}else if(ds.getCount() == 1){
				dao.update(somCheckBean);
			}
		}
		if(somCheckWorkerRecord!=null){
			SomCheckWorker somCheckWorkerBean=(SomCheckWorker)somCheckWorkerRecord.toBean(SomCheckWorker.class);
			pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			ds = somCheckWorkerDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somCheckWorkerBean.setId(IdHelp.getUUID32());
				somCheckWorkerBean.setTaskCode(taskCode);
				somCheckWorkerDao.insert(somCheckWorkerBean);
			}if(ds.getCount()==1){
				somCheckWorkerBean.setId((String)ds.getRecord(0).get("id"));
				somCheckWorkerBean.setTaskCode(taskCode);
				somCheckWorkerDao.update(somCheckWorkerBean);
			}
		}
		somCheckSuborganDao.deleteByTaskCode(taskCode,"Z");//内设机构
		if(somCheckSuborganRecords!=null){
			for (int i = 0; i < somCheckSuborganRecords.length; i++) {
				SomCheckSuborgan somCheckSuborganBean=(SomCheckSuborgan)somCheckSuborganRecords[i].toBean(SomCheckSuborgan.class);
				somCheckSuborganBean.setId(IdHelp.getUUID32());
				somCheckSuborganBean.setTaskCode(taskCode);
				somCheckSuborganDao.insert(somCheckSuborganBean);				
			}
		}
		if("4".equals(pageNum)){
			somCheckChangesDao.deleteByTaskCode(taskCode);
			if(somCheckChangesRecords != null){
				for (int i = 0; i < somCheckChangesRecords.length; i++) {
					SomCheckChanges somCheckChangesBean = (SomCheckChanges) somCheckChangesRecords[i].toBean(SomCheckChanges.class);
					somCheckChangesBean.setId(IdHelp.getUUID32());
					somCheckChangesBean.setTaskCode(taskCode);
					somCheckChangesDao.insert(somCheckChangesBean);
				}
			}		
		}
	}
	@Trans
	public void savePageM4() {
		String taskCode = (String)getParameter("taskCode");
		Record[] somCheckOrgChangeRecords = (Record[]) getParameter("somCheckOrgChangeRecords");
		Record[] somCheckPublicBenefitRecords = (Record[]) getParameter("somCheckPublicBenefitRecords");
		
		somCheckOrgChangeDao.deleteByTaskCode(taskCode);
		if(somCheckOrgChangeRecords!=null){
			for (int i = 0; i < somCheckOrgChangeRecords.length; i++) {
				SomCheckOrgChange somCheckOrgChangeBean=(SomCheckOrgChange)somCheckOrgChangeRecords[i].toBean(SomCheckOrgChange.class);
				somCheckOrgChangeBean.setId(IdHelp.getUUID32());
				somCheckOrgChangeBean.setTaskCode(taskCode);
				somCheckOrgChangeDao.insert(somCheckOrgChangeBean);				
			}
		}
		
		somCheckPublicBenefitDao.deleteByTaskCode(taskCode);
		if(somCheckPublicBenefitRecords != null){
			for (int i = 0; i < somCheckPublicBenefitRecords.length; i++) {
				SomCheckPublicBenefit somCheckPublicBenefitBean = (SomCheckPublicBenefit) somCheckPublicBenefitRecords[i].toBean(SomCheckPublicBenefit.class);
				somCheckPublicBenefitBean.setId(IdHelp.getUUID32());
				somCheckPublicBenefitBean.setTaskCode(taskCode);
				somCheckPublicBenefitDao.insert(somCheckPublicBenefitBean);
			}
		}		
	}
	@Trans
	public void savePageM5() {
		String taskCode = (String)getParameter("taskCode");
		Record somCheckBalanceSheetRecord = (Record) getParameter("somCheckBalanceSheetRecord");
		SomCheckBalanceSheet dataBean=(SomCheckBalanceSheet)somCheckBalanceSheetRecord.toBean(SomCheckBalanceSheet.class);
		dataBean.setTaskCode(taskCode);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=",taskCode);
		DataSet ds = somCheckBalanceSheetDao.query(pset);
		if(ds.getCount()==0){
			dataBean.setId(IdHelp.getUUID32());
			dataBean.setTaskCode(taskCode);
			somCheckBalanceSheetDao.insert(dataBean);
		}else{
			dataBean.setId((String)ds.getRecord(0).get("id"));
			dataBean.setTaskCode(taskCode);
			somCheckBalanceSheetDao.update(dataBean);
		}
	}
	

	//##########################################         基金会               ################################################	
	@Trans
	public void savePageJ3(){
		Record checkRecord = (Record) getParameter("checkRecord");
		String taskCode = (String)getParameter("taskCode");
		SomCheckCouncilMeeting somjxCheck=(SomCheckCouncilMeeting)checkRecord.toBean(SomCheckCouncilMeeting.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		pset.setParameter("SEQ", "1");
		DataSet ds = somCheckCouncilMeetingDao.query(pset);
		if(ds.getCount() == 0){
			somjxCheck.setId(IdHelp.getUUID32());
			somCheckCouncilMeetingDao.insert(somjxCheck);
		}else if(ds.getCount() == 1){
			somCheckCouncilMeetingDao.update(somjxCheck);
		}
		Record checkRecord1 = (Record) getParameter("checkRecord1");
		SomCheckCouncilMeeting somjxCheck1=(SomCheckCouncilMeeting)checkRecord1.toBean(SomCheckCouncilMeeting.class);
		
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("TASK_CODE", taskCode);
		pset1.setParameter("SEQ", "2");
		DataSet ds1 = somCheckCouncilMeetingDao.query(pset1);
		if(ds1.getCount() == 0){
			somjxCheck1.setId(IdHelp.getUUID32());
			somCheckCouncilMeetingDao.insert(somjxCheck1);
		}else if(ds1.getCount() == 1){
			somCheckCouncilMeetingDao.update(somjxCheck1);
		}
	}
	@Trans
	public void savePageJ4(){
		Record[] fundPeopleRecords = (Record[]) getParameter("fundPeopleRecords");
		String taskCode = (String)getParameter("taskCode");
		somCheckCouncilMemberDao.deleteByTaskCode(taskCode,"1");
		somCheckCouncilMemberDao.deleteByTaskCode(taskCode,"2");
		if(fundPeopleRecords!=null && fundPeopleRecords.length>0){
			for (int i = 0; i < fundPeopleRecords.length; i++) {
				SomCheckCouncilMember bean = (SomCheckCouncilMember) fundPeopleRecords[i].toBean(SomCheckCouncilMember.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckCouncilMemberDao.insert(bean);
			}
		}
		
	}
	
	@Trans
	public void savePageJ5(){
		Record[] fundPeopleRecords = (Record[]) getParameter("fundPeopleRecords");
		String taskCode = (String)getParameter("taskCode");
		
		somCheckCouncilMemberDao.deleteByTaskCode(taskCode,"3");
		if(fundPeopleRecords!=null && fundPeopleRecords.length>0){
			for (int i = 0; i < fundPeopleRecords.length; i++) {
				SomCheckCouncilMember bean = (SomCheckCouncilMember) fundPeopleRecords[i].toBean(SomCheckCouncilMember.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckCouncilMemberDao.insert(bean);
			}
		}
		
	}
	@Trans
	public void savePageJ6(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxCheckPartyRecord = (Record) getParameter("somJxCheckPartyRecord");
		SomCheckParty somJxCheckParty=(SomCheckParty)somJxCheckPartyRecord.toBean(SomCheckParty.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somCheckPartyDao.query(pset);
		if(ds.getCount() == 0){
			somJxCheckParty.setTaskCode(taskCode);
			somJxCheckParty.setId(IdHelp.getUUID32());
			somCheckPartyDao.insert(somJxCheckParty);
		}else if(ds.getCount() == 1){
			somCheckPartyDao.update(somJxCheckParty);
		}
	}
	@Trans
	public void savePageJ7(){
		String taskCode = (String)getParameter("taskCode");
		Record somJxOrganBasicDataSet = (Record) getParameter("somJxOrganBasicDataSet");
		SomCheckOrgDetail somJxOrganBasic=(SomCheckOrgDetail)somJxOrganBasicDataSet.toBean(SomCheckOrgDetail.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somCheckOrgDetailDao.query(pset);
		if(ds.getCount() == 0){
			somJxOrganBasic.setTaskCode(taskCode);
			somJxOrganBasic.setId(IdHelp.getUUID32());
			somCheckOrgDetailDao.insert(somJxOrganBasic);
		}else if(ds.getCount() == 1){
			somCheckOrgDetailDao.update(somJxOrganBasic);
		}
	}
	@Trans
	public void savePageJ8(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"1");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomCheckSuborgan somJxOrganFunds = (SomCheckSuborgan)somJxOrganFundsDataSet[i].toBean(SomCheckSuborgan.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ9(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"2");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomCheckSuborgan somJxOrganFunds = (SomCheckSuborgan)somJxOrganFundsDataSet[i].toBean(SomCheckSuborgan.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ10(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"3");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomCheckSuborgan somJxOrganFunds = (SomCheckSuborgan)somJxOrganFundsDataSet[i].toBean(SomCheckSuborgan.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ11(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"4");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomCheckSuborgan somJxOrganFunds = (SomCheckSuborgan)somJxOrganFundsDataSet[i].toBean(SomCheckSuborgan.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(somJxOrganFunds);
			}
		}
	}
	@Trans
	public void savePageJ12(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxOrganFundsDataSet = (Record[]) getParameter("somJxOrganFundsDataSet");
		somCheckSuborganDao.deleteByTaskCode(taskCode,"5");
		if(somJxOrganFundsDataSet != null){
			for(int i=0;i<somJxOrganFundsDataSet.length;i++){
				SomCheckSuborgan somJxOrganFunds = (SomCheckSuborgan)somJxOrganFundsDataSet[i].toBean(SomCheckSuborgan.class);
				somJxOrganFunds.setTaskCode(taskCode);
				somJxOrganFunds.setId(IdHelp.getUUID32());
				somCheckSuborganDao.insert(somJxOrganFunds);
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
			SomContribute bean = (SomContribute) somJxContributeRecord.toBean(SomContribute.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE",taskCode);
			pset.setParameter("IF_OPEN","0");
			DataSet ds = somContributeDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somContributeDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setIfOpen((String)ds.getRecord(0).get("ifOpen"));
				somContributeDao.update(bean);
			}
		}
		if(somJxContributeRecord1!=null){
			SomContribute bean = (SomContribute) somJxContributeRecord1.toBean(SomContribute.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE",taskCode);
			pset.setParameter("IF_OPEN", "1");
			DataSet ds = somContributeDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somContributeDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setIfOpen((String)ds.getRecord(0).get("ifOpen"));
				somContributeDao.update(bean);
			}
		}
		if(somJxCheckExpenditureRecord!=null){
			SomCheckExpenditure bean = (SomCheckExpenditure) somJxCheckExpenditureRecord.toBean(SomCheckExpenditure.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckExpenditureDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckExpenditureDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somCheckExpenditureDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageJ14(){
		Record somJxContributeRecord = (Record) getParameter("somJxContributeRecord");
		Record somJxCheckExpenditureRecord = (Record) getParameter("somJxCheckExpenditureRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxContributeRecord!=null){
			SomContribute bean = (SomContribute) somJxContributeRecord.toBean(SomContribute.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			pset.setParameter("IF_OPEN", "2");
			DataSet ds = somContributeDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somContributeDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setIfOpen((String)ds.getRecord(0).get("ifOpen"));
				somContributeDao.update(bean);
			}
		}
		if(somJxCheckExpenditureRecord!=null){
			SomCheckExpenditure bean = (SomCheckExpenditure) somJxCheckExpenditureRecord.toBean(SomCheckExpenditure.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckExpenditureDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckExpenditureDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somCheckExpenditureDao.update(bean);
			}
		}
		
	}
	@Trans
	public void savePageJ15(){
		Record somJxCheckExpenditureRecord = (Record) getParameter("somJxCheckExpenditureRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckExpenditureRecord!=null){
			SomCheckExpenditure bean = (SomCheckExpenditure) somJxCheckExpenditureRecord.toBean(SomCheckExpenditure.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE",taskCode);
			DataSet ds = somCheckExpenditureDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckExpenditureDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				somCheckExpenditureDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageJ16(){
		Record[] somJxLargeDonationRecords = (Record[]) getParameter("somJxLargeDonationRecords");
		String taskCode=(String) getParameter("taskCode");
		somCheckLargeDonationDao.deleteByTaskCode(taskCode);
		if(somJxLargeDonationRecords!=null){
			for (int i = 0; i < somJxLargeDonationRecords.length; i++) {
				SomCheckLargeDonation  somJxLargeDonationBean=(SomCheckLargeDonation)somJxLargeDonationRecords[i].toBean(SomCheckLargeDonation.class);
				 somJxLargeDonationBean.setId(IdHelp.getUUID32());
				 somJxLargeDonationBean.setTaskCode(taskCode);
				 somCheckLargeDonationDao.insert(somJxLargeDonationBean);				
			}
		}
	}
	@Trans
	public void savePageJ17(){
		Record[] records = (Record[]) getParameter("records");
		String taskCode=(String) getParameter("taskCode");
		somCheckPublicBenefitDao.deleteByTaskCode(taskCode);
		if(records!=null){
			for (int i = 0; i < records.length; i++) {
				SomCheckPublicBenefit  record = (SomCheckPublicBenefit) records[i].toBean(SomCheckPublicBenefit.class)	;
				record.setId(IdHelp.getUUID32());
				record.setTaskCode(taskCode);
				somCheckPublicBenefitDao.insert(record);
			}
		}
	}
	@Trans
	public void savePageJ18(){
		Record[] somJxMajorDetailRecords = (Record[]) getParameter("somJxMajorDetailRecords");
		String taskCode = (String)getParameter("taskCode");		
		somCheckMajorDetailDao.deleteByTaskCode(taskCode);
		if(somJxMajorDetailRecords!=null && somJxMajorDetailRecords.length>0){
			for (int i = 0; i < somJxMajorDetailRecords.length; i++) {
				SomCheckMajorDetail bean = (SomCheckMajorDetail) somJxMajorDetailRecords[i].toBean(SomCheckMajorDetail.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckMajorDetailDao.insert(bean);
			}
		}
	}
	
	@Trans
	public void savePageJ19(){
		Record[] somJxCheckMajorRecords = (Record[]) getParameter("somJxCheckMajorRecords");
		String taskCode = (String)getParameter("taskCode");		
		somCheckMajorDao.deleteByTaskCode(taskCode);
		if(somJxCheckMajorRecords!=null && somJxCheckMajorRecords.length>0){
			for (int i = 0; i < somJxCheckMajorRecords.length; i++) {
				SomCheckMajor bean = (SomCheckMajor) somJxCheckMajorRecords[i].toBean(SomCheckMajor.class);
				bean.setMajorId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckMajorDao.insert(bean);
			}
		}
	}
	@Trans
	public void savePageJ20(){
		Record jxCheckRecord = (Record) getParameter("jxCheckRecord");
		String taskCode = (String)getParameter("taskCode");
		if(jxCheckRecord!=null){
			SomCheck bean = (SomCheck) jxCheckRecord.toBean(SomCheck.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE",taskCode);
			DataSet ds = dao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setTaskCode(taskCode);
				bean.setStatus("0");
				bean.setCurrentActivity("0");
				dao.insert(bean);
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
				dao.update(bean);
			}
		}
	}	
	@Trans
	public void savePageJ21(){
		Record somJxCheckBalanceSheetRecord = (Record) getParameter("somJxCheckBalanceSheetRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckBalanceSheetRecord!=null){
			SomCheckBalanceSheet somJxCheckBalanceSheetBean = (SomCheckBalanceSheet) somJxCheckBalanceSheetRecord.toBean(SomCheckBalanceSheet.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckBalanceSheetDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckBalanceSheetBean.setId(IdHelp.getUUID32());
				somJxCheckBalanceSheetBean.setTaskCode(taskCode);
				somCheckBalanceSheetDao.insert(somJxCheckBalanceSheetBean);
			}
			if(ds.getCount()==1){
				somJxCheckBalanceSheetBean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckBalanceSheetBean.setTaskCode(taskCode);
				somCheckBalanceSheetDao.update(somJxCheckBalanceSheetBean);
			}
		}
	}
	@Trans
	public void savePageJ22(){
		Record somJxCheckBusinessActivityRecord = (Record) getParameter("somJxCheckBusinessActivityRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckBusinessActivityRecord!=null){
			SomCheckBusinessActivity somJxCheckBusinessActivityBean = (SomCheckBusinessActivity) somJxCheckBusinessActivityRecord.toBean(SomCheckBusinessActivity.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE",taskCode);
			DataSet ds = somCheckBusinessActivityDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckBusinessActivityBean.setId(IdHelp.getUUID32());
				somJxCheckBusinessActivityBean.setTaskCode(taskCode);
				somCheckBusinessActivityDao.insert(somJxCheckBusinessActivityBean);
			}
			if(ds.getCount()==1){
				somJxCheckBusinessActivityBean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckBusinessActivityBean.setTaskCode(taskCode);
				somCheckBusinessActivityDao.update(somJxCheckBusinessActivityBean);
			}
		}
	}
	@Trans
	public void savePageJ23(){
		Record somJxCheckCashFlowRecord = (Record) getParameter("somJxCheckCashFlowRecord");
		String taskCode = (String)getParameter("taskCode");
		if(somJxCheckCashFlowRecord!=null){
			SomCheckCashFlow somJxCheckCashFlowRecordBean = (SomCheckCashFlow) somJxCheckCashFlowRecord.toBean(SomCheckCashFlow.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckCashFlowDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckCashFlowRecordBean.setId(IdHelp.getUUID32());
				somJxCheckCashFlowRecordBean.setTaskCode(taskCode);
				somCheckCashFlowDao.insert(somJxCheckCashFlowRecordBean);
			}
			if(ds.getCount()==1){
				somJxCheckCashFlowRecordBean.setId((String)ds.getRecord(0).get("id"));
				somJxCheckCashFlowRecordBean.setTaskCode(taskCode);
				somCheckCashFlowDao.update(somJxCheckCashFlowRecordBean);
			}
		}
	}
	@Trans
	public void savePageJ24(){
		Record[] jxOverseeRecords = (Record[]) getParameter("jxOverseeRecords");
		Record jxCheckEvaluateRecord = (Record) getParameter("jxCheckEvaluateRecord");
		Record[] jxCheckPunnishRecords = (Record[]) getParameter("jxCheckPunnishRecords");
		String taskCode = (String)getParameter("taskCode");
		somOverseeDao.deleteByTaskCode(taskCode);
		if(jxOverseeRecords != null){
			for(int i=0;i<jxOverseeRecords.length;i++){
				SomOversee somJxOversee = (SomOversee)jxOverseeRecords[i].toBean(SomOversee.class);
				somJxOversee.setId(IdHelp.getUUID32());
				somJxOversee.setTaskCode(taskCode);
				somOverseeDao.insert(somJxOversee);
			}
		}
		if(jxCheckEvaluateRecord!=null){
			SomCheckEvaluate somJxCheckEvaluate = (SomCheckEvaluate) jxCheckEvaluateRecord.toBean(SomCheckEvaluate.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckEvaluateDao.query(pset);
			if(ds==null || ds.getCount()==0){
				somJxCheckEvaluate.setId(IdHelp.getUUID32());
				somJxCheckEvaluate.setTaskCode(taskCode);
				somCheckEvaluateDao.insert(somJxCheckEvaluate);
			}
			if(ds.getCount()==1){
				somJxCheckEvaluate.setId((String)ds.getRecord(0).get("id"));
				somJxCheckEvaluate.setTaskCode(taskCode);
				somCheckEvaluateDao.update(somJxCheckEvaluate);
			}
		}
		somCheckPunnishDao.deleteByTaskCode(taskCode);
		if(jxCheckPunnishRecords != null){
			for(int i=0;i<jxCheckPunnishRecords.length;i++){
				SomCheckPunnish somJxCheckPunnish = (SomCheckPunnish)jxCheckPunnishRecords[i].toBean(SomCheckPunnish.class);
				somJxCheckPunnish.setId(IdHelp.getUUID32());
				somJxCheckPunnish.setTaskCode(taskCode);
				somCheckPunnishDao.insert(somJxCheckPunnish);
			}
		}
	}
	@Trans
	public void savePageJ25(){
		Record auditOpinionRecord = (Record) getParameter("auditOpinionRecord");
		String taskCode = (String)getParameter("taskCode");
		if(auditOpinionRecord!=null){
			SomCheckAuditOpinion bean = (SomCheckAuditOpinion) auditOpinionRecord.toBean(SomCheckAuditOpinion.class);
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", taskCode);
			DataSet ds = somCheckAuditOpinionDao.query(pset);
			if(ds==null || ds.getCount()==0){
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckAuditOpinionDao.insert(bean);
			}
			if(ds.getCount()==1){
				bean.setId((String)ds.getRecord(0).get("id"));
				bean.setTaskCode(taskCode);
				somCheckAuditOpinionDao.update(bean);
			}
		}
	}
	@Trans
	public void savePageJ26(){
		Record[] somJxCheckSupervisorOpinRecords = (Record[]) getParameter("somJxCheckSupervisorOpinRecords");
		String taskCode = (String)getParameter("taskCode");
		somCheckSupervisorOpinionDao.deleteByTaskCode(taskCode);
		if(somJxCheckSupervisorOpinRecords != null){
			for(int i=0;i<somJxCheckSupervisorOpinRecords.length;i++){
				SomCheckSupervisorOpinion somJxCheckSupervisorOpinBean = (SomCheckSupervisorOpinion)somJxCheckSupervisorOpinRecords[i].toBean(SomCheckSupervisorOpinion.class);
				somJxCheckSupervisorOpinBean.setId(IdHelp.getUUID32());
				somJxCheckSupervisorOpinBean.setTaskCode(taskCode);
				somCheckSupervisorOpinionDao.insert(somJxCheckSupervisorOpinBean);
			}
		}
	}
	@Trans
	public void savePageJ27(){
		Record somCheckRecord = (Record) getParameter("somCheckRecord");
		Record[] proclamationRecords = (Record[]) getParameter("proclamationRecords");
		String taskCode = (String)getParameter("taskCode");
		somProclamationDao.deleteByTaskCode(taskCode);
		if(proclamationRecords!=null && proclamationRecords.length>0){
			for (int i = 0; i < proclamationRecords.length; i++) {
				SomProclamation bean = (SomProclamation) proclamationRecords[i].toBean(SomProclamation.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somProclamationDao.insert(bean);
			}
		}
		SomCheck bean = (SomCheck) somCheckRecord.toBean(SomCheck.class);
		dao.update(bean);
		
	}
	@Trans
	public void savePageJ28(){
		String taskCode = (String)getParameter("taskCode");
		Record[] somJxChangeCircsRecords = (Record[]) getParameter("somJxChangeCircsRecords");
		Record somJxCheckSystemsRecord = (Record) getParameter("somJxCheckSystemsRecord");		
		Record[] somJxCheckAccountingPeopleRecords = (Record[]) getParameter("somJxCheckAccountingPeopleRecords");
		
		somCheckChangeCircsDao.deleteByTaskCode(taskCode);
		if(somJxChangeCircsRecords != null){
			for(int i=0;i<somJxChangeCircsRecords.length;i++){
				SomCheckChangeCircs somJxChangeCircsBean = (SomCheckChangeCircs)somJxChangeCircsRecords[i].toBean(SomCheckChangeCircs.class);
				somJxChangeCircsBean.setId(IdHelp.getUUID32());
				somJxChangeCircsBean.setTaskCode(taskCode);
				somCheckChangeCircsDao.insert(somJxChangeCircsBean);
			}
		}
		
		SomCheckSystems somJxCheckSystemsBean=(SomCheckSystems)somJxCheckSystemsRecord.toBean(SomCheckSystems.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = somCheckSystemsDao.query(pset);
		if(ds.getCount() == 0){
			somJxCheckSystemsBean.setId(IdHelp.getUUID32());
			somJxCheckSystemsBean.setTaskCode(taskCode);
			somCheckSystemsDao.insert(somJxCheckSystemsBean);
		}else if(ds.getCount() == 1){
			somJxCheckSystemsBean.setId((String)ds.getRecord(0).get("id"));
			somJxCheckSystemsBean.setTaskCode(taskCode);
			somCheckSystemsDao.update(somJxCheckSystemsBean);
		}
		
		somCheckAccountingPeopleDao.deleteByTaskCode(taskCode);		
		if(somJxCheckAccountingPeopleRecords != null){
			for(int i=0;i<somJxCheckAccountingPeopleRecords.length;i++){
				SomCheckAccountingPeople somJxCheckAccountingPeopleBean = (SomCheckAccountingPeople)somJxCheckAccountingPeopleRecords[i].toBean(SomCheckAccountingPeople.class);
				somJxCheckAccountingPeopleBean.setId(IdHelp.getUUID32());
				somJxCheckAccountingPeopleBean.setTaskCode(taskCode);
				somCheckAccountingPeopleDao.insert(somJxCheckAccountingPeopleBean);
			}
		}
	}
	@Trans
	public void savePageJ29(){
		Record[] interProjectRecords = (Record[]) getParameter("interProjectRecords");
		Record[] checkInterMeetingRecords = (Record[]) getParameter("somCheckInterMeetingRecords");
		Record[] checkInterOrgRecords = (Record[]) getParameter("somCheckInterOrgRecords");
		String taskCode = (String)getParameter("taskCode");
		
		somCheckInterProjectDao.deleteByTaskCode(taskCode);
		if(interProjectRecords!=null && interProjectRecords.length>0){
			for (int i = 0; i < interProjectRecords.length; i++) {
				SomCheckInterProject bean = (SomCheckInterProject) interProjectRecords[i].toBean(SomCheckInterProject.class);
				bean.setId(IdHelp.getUUID32());
				bean.setTaskCode(taskCode);
				somCheckInterProjectDao.insert(bean);
			}
		}
		
		somCheckInterMeetingDao.deleteByTaskCode(taskCode);
		if(checkInterMeetingRecords!=null){
			for (int i = 0; i < checkInterMeetingRecords.length; i++) {
				SomCheckInterMeeting  checkInterMeeting=(SomCheckInterMeeting)checkInterMeetingRecords[i].toBean(SomCheckInterMeeting.class);
				checkInterMeeting.setId(IdHelp.getUUID32());
				checkInterMeeting.setTaskCode(taskCode);
				somCheckInterMeetingDao.insert(checkInterMeeting);				
			}
		}
		
		somCheckInterOrgDao.deleteByTaskCode(taskCode);
		if(checkInterOrgRecords!=null){
			for (int i = 0; i < checkInterOrgRecords.length; i++) {
				SomCheckInterOrg  checkInterOrg=(SomCheckInterOrg)checkInterOrgRecords[i].toBean(SomCheckInterOrg.class);
				checkInterOrg.setId(IdHelp.getUUID32());
				checkInterOrg.setTaskCode(taskCode);
				somCheckInterOrgDao.insert(checkInterOrg);				
			}
		}
	}
}
